import 'package:flutter/foundation.dart';

class CookiePreferences {
  bool acceptedAll = false;
  bool acceptedEssential = false;
  bool analyticsEnabled = false;
  DateTime? acceptedAt;

  CookiePreferences({
    this.acceptedAll = false,
    this.acceptedEssential = false,
    this.analyticsEnabled = false,
    this.acceptedAt,
  });

  factory CookiePreferences.fromJson(Map<String, dynamic> json) {
    return CookiePreferences(
      acceptedAll: json['acceptedAll'] ?? false,
      acceptedEssential: json['acceptedEssential'] ?? false,
      analyticsEnabled: json['analyticsEnabled'] ?? false,
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.parse(json['acceptedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'acceptedAll': acceptedAll,
        'acceptedEssential': acceptedEssential,
        'analyticsEnabled': analyticsEnabled,
        'acceptedAt': acceptedAt?.toIso8601String(),
      };

  bool get hasMadeChoice => acceptedAll || acceptedEssential;
}

class CookiePreferencesService extends ChangeNotifier {
  static final CookiePreferencesService _instance =
      CookiePreferencesService._internal();

  factory CookiePreferencesService() {
    return _instance;
  }

  CookiePreferencesService._internal();

  CookiePreferences _preferences = CookiePreferences();

  CookiePreferences get preferences => _preferences;

  void acceptAll() {
    _preferences = CookiePreferences(
      acceptedAll: true,
      acceptedEssential: true,
      analyticsEnabled: true,
      acceptedAt: DateTime.now(),
    );
    notifyListeners();
    _saveToDom();
  }

  void acceptEssential() {
    _preferences = CookiePreferences(
      acceptedAll: false,
      acceptedEssential: true,
      analyticsEnabled: false,
      acceptedAt: DateTime.now(),
    );
    notifyListeners();
    _saveToDom();
  }

  void setAnalyticsEnabled(bool enabled) {
    _preferences = CookiePreferences(
      acceptedAll: _preferences.acceptedAll,
      acceptedEssential: _preferences.acceptedEssential,
      analyticsEnabled: enabled,
      acceptedAt: _preferences.acceptedAt,
    );
    notifyListeners();
    _saveToDom();
  }

  void reset() {
    _preferences = CookiePreferences();
    notifyListeners();
    _clearFromDom();
  }

  void _saveToDom() {
    // This is a placeholder - in a real app, you'd use shared_preferences
    // or dart:html to store this in localStorage
  }

  void _clearFromDom() {
    // This is a placeholder - in a real app, you'd use shared_preferences
    // or dart:html to clear from localStorage
  }
}
