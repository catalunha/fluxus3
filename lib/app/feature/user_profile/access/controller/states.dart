enum AccessStatus { admin, sec, prof, fin, none }

extension StringToAccessStatus on String {
  AccessStatus get toAccessStatus {
    return switch (this) {
      'admin' => AccessStatus.admin,
      'sec' => AccessStatus.sec,
      'prof' => AccessStatus.prof,
      'fin' => AccessStatus.fin,
      _ => AccessStatus.none,
    };
  }
}

enum UserProfileAccessSaveStatus { initial, loading, success, error }
