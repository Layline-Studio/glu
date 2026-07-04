import 'package:flutter/foundation.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

import '../config/app_config.dart';

class AnalyticsService {
  final Posthog _posthog = Posthog();

  bool _configured = false;
  String? _identifiedUserId;

  bool get isEnabled => _configured;

  Future<void> configure(AppConfig config) async {
    if (_configured || !config.hasPosthog) {
      return;
    }

    final posthogConfig = PostHogConfig(config.posthogApiKey);
    posthogConfig.host = config.posthogHost;
    posthogConfig.debug = kDebugMode;
    posthogConfig.sendFeatureFlagEvents = false;
    posthogConfig.preloadFeatureFlags = false;
    posthogConfig.captureApplicationLifecycleEvents = false;
    posthogConfig.surveys = false;

    await _posthog.setup(posthogConfig);
    _configured = true;
    _log('configured', {'host': config.posthogHost});
  }

  Future<void> identify({
    required String userId,
    Map<String, dynamic>? userProperties,
    Map<String, dynamic>? userPropertiesSetOnce,
  }) async {
    if (!_configured || userId.isEmpty) {
      return;
    }

    final properties = _sanitizeMap(userProperties);
    final propertiesSetOnce = _sanitizeMap(userPropertiesSetOnce);
    final shouldIdentify = _identifiedUserId != userId ||
        properties.isNotEmpty ||
        propertiesSetOnce.isNotEmpty;

    if (!shouldIdentify) {
      return;
    }

    await _posthog.identify(
      userId: userId,
      userProperties: properties.isEmpty ? null : properties,
      userPropertiesSetOnce:
          propertiesSetOnce.isEmpty ? null : propertiesSetOnce,
    );
    _identifiedUserId = userId;
    _log('identify', {'user_id': userId});
  }

  Future<void> setUserProperties({
    Map<String, dynamic>? userProperties,
    Map<String, dynamic>? userPropertiesSetOnce,
  }) async {
    if (!_configured) {
      return;
    }

    final properties = _sanitizeMap(userProperties);
    final propertiesSetOnce = _sanitizeMap(userPropertiesSetOnce);
    if (properties.isEmpty && propertiesSetOnce.isEmpty) {
      return;
    }

    await _posthog.setPersonProperties(
      userPropertiesToSet: properties.isEmpty ? null : properties,
      userPropertiesToSetOnce:
          propertiesSetOnce.isEmpty ? null : propertiesSetOnce,
    );
    _log('set_user_properties', {
      'property_count': properties.length + propertiesSetOnce.length,
    });
  }

  Future<void> capture({
    required String eventName,
    Map<String, dynamic>? properties,
  }) async {
    if (!_configured) {
      return;
    }

    final sanitizedProperties = _sanitizeMap(properties);
    await _posthog.capture(
      eventName: eventName,
      properties: sanitizedProperties.isEmpty ? null : sanitizedProperties,
    );
    _log(eventName, sanitizedProperties);
  }

  Future<void> screen({
    required String screenName,
    Map<String, dynamic>? properties,
  }) async {
    if (!_configured) {
      return;
    }

    final sanitizedProperties = _sanitizeMap(properties);
    await _posthog.screen(
      screenName: screenName,
      properties: sanitizedProperties.isEmpty ? null : sanitizedProperties,
    );
    _log('screen:$screenName', sanitizedProperties);
  }

  Future<void> reset() async {
    if (!_configured) {
      _identifiedUserId = null;
      return;
    }

    await _posthog.reset();
    _identifiedUserId = null;
    _log('reset', const {});
  }

  Map<String, Object> _sanitizeMap(Map<String, dynamic>? input) {
    if (input == null || input.isEmpty) {
      return const {};
    }

    final output = <String, Object>{};
    input.forEach((key, value) {
      final sanitized = _sanitizeValue(value);
      if (sanitized != null) {
        output[key] = sanitized;
      }
    });
    return output;
  }

  Object? _sanitizeValue(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is String || value is num || value is bool) {
      return value;
    }
    if (value is DateTime) {
      return value.toUtc().toIso8601String();
    }
    if (value is Enum) {
      return value.name;
    }
    if (value is Iterable) {
      return value
          .map(_sanitizeValue)
          .whereType<Object>()
          .toList(growable: false);
    }
    if (value is Map) {
      final nested = <String, Object>{};
      value.forEach((nestedKey, nestedValue) {
        if (nestedKey is! String) {
          return;
        }
        final sanitized = _sanitizeValue(nestedValue);
        if (sanitized != null) {
          nested[nestedKey] = sanitized;
        }
      });
      return nested;
    }
    return value.toString();
  }

  void _log(String eventName, Map<String, Object> properties) {
    if (!kDebugMode) {
      return;
    }
    debugPrint(
      '[analytics] $eventName${properties.isEmpty ? '' : ' $properties'}',
    );
  }
}
