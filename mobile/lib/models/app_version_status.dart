enum AppUpdatePromptKind {
  none,
  optional,
  required,
  missingConfig,
}

class AppVersionStatus {
  const AppVersionStatus({
    required this.kind,
    required this.currentVersion,
    this.latestVersion,
    this.minimumVersion,
    this.storeUrl,
  });

  const AppVersionStatus.none({required String currentVersion})
      : this(
          kind: AppUpdatePromptKind.none,
          currentVersion: currentVersion,
        );

  final AppUpdatePromptKind kind;
  final String currentVersion;
  final String? latestVersion;
  final String? minimumVersion;
  final String? storeUrl;

  bool get shouldPrompt => kind != AppUpdatePromptKind.none;
  bool get isRequired => kind == AppUpdatePromptKind.required;

  String get signature =>
      '$kind|$currentVersion|${latestVersion ?? ''}|${minimumVersion ?? ''}|${storeUrl ?? ''}';
}
