import 'dart:convert';
import 'dart:math';

enum AuthMethod { magicLink, oauthWeb }

class PendingAuthTransaction {
  const PendingAuthTransaction({
    required this.state,
    required this.createdAt,
    required this.method,
  });

  final String state;
  final DateTime createdAt;
  final AuthMethod method;

  static const _expiryMinutes = 60;

  bool get isExpired =>
      DateTime.now().difference(createdAt).inMinutes >= _expiryMinutes;

  Map<String, dynamic> toJson() => {
        'state': state,
        'createdAt': createdAt.toIso8601String(),
        'method': method.name,
      };

  factory PendingAuthTransaction.fromJson(Map<String, dynamic> json) {
    return PendingAuthTransaction(
      state: json['state'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      method: AuthMethod.values.firstWhere(
        (method) => method.name == json['method'],
        orElse: () => AuthMethod.magicLink,
      ),
    );
  }

  static PendingAuthTransaction? tryDecode(String? raw) {
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return PendingAuthTransaction.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  String encode() => jsonEncode(toJson());

  static String generateState() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}
