import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';

void saveDataUser({required LoginModel data}) {
  CacheDataHelper.setData(
    key: SharedPrefKey.keyAccessToken,
    value: data.accessToken,
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyRefreshToken,
    value: data.refreshToken,
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyUserName,
    value: data.username,
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyRole,
    value: data.role,
  );
  CacheDataHelper.setData(
    key: SharedPrefKey.keyUserId,
    value: data.userId,
  );

  CacheDataHelper.setData(
    key: SharedPrefKey.keyFullName,
    value: '${data.firstName} ${data.lastName}',
  );

  CacheDataHelper.setData(
    key: SharedPrefKey.keyBonusPoints,
    value: data.bonusPoints,
  );

  CacheDataHelper.setData(
    key: SharedPrefKey.keyProfilePicture,
    value: data.profilePicture,
  );
}

Future<void> clearUserData() async {
  await Future.wait([
    CacheDataHelper.removeData(key: SharedPrefKey.keyAccessToken),
    CacheDataHelper.removeData(key: SharedPrefKey.keyRefreshToken),
    CacheDataHelper.removeData(key: SharedPrefKey.keyUserName),
    CacheDataHelper.removeData(key: SharedPrefKey.keyRole),
    CacheDataHelper.removeData(key: SharedPrefKey.keyUserId),
    CacheDataHelper.removeData(key: SharedPrefKey.keyFullName),
    CacheDataHelper.removeData(key: SharedPrefKey.keyBonusPoints),
    CacheDataHelper.removeData(key: SharedPrefKey.keyProfilePicture),
  ]);
}

/// get the username from Cache Data Local
String getUsername() {
  final userName =
      CacheDataHelper.getData(key: SharedPrefKey.keyUserName) ?? '';
  return userName is String ? userName : '';
}

/// get the role from Cache Data Local
String getRole() {
  final role = CacheDataHelper.getData(key: SharedPrefKey.keyRole) ?? '';
  return role is String ? role : '';
}

/// get the userId from Cache Data Local
int getUserId() {
  final userId = CacheDataHelper.getData(key: SharedPrefKey.keyUserId);
  return userId is int ? userId : 0;
}

/// get the fullName from Cache Data Local
String getFullName() {
  final fullName =
      CacheDataHelper.getData(key: SharedPrefKey.keyFullName) ?? '';
  return fullName is String ? fullName : '';
}

/// get the profilePicture from Cache Data Local
String getProfilePicture() {
  final profilePicture =
      CacheDataHelper.getData(key: SharedPrefKey.keyProfilePicture) ?? '';
  return profilePicture is String ? profilePicture : '';
}

/// get the bonusPoints from Cache Data Local
int getBonusPoints() {
  final bonusPoints =
      CacheDataHelper.getData(key: SharedPrefKey.keyBonusPoints);
  return bonusPoints is int ? bonusPoints : 0;
}

/// get the accessToken from Cache Data Local
String getAccessToken() {
  final accessToken =
      CacheDataHelper.getData(key: SharedPrefKey.keyAccessToken) ?? '';
  return accessToken is String ? accessToken : '';
}

/// get the refreshToken from Cache Data Local
String getRefreshToken() {
  final refreshToken =
      CacheDataHelper.getData(key: SharedPrefKey.keyRefreshToken) ?? '';
  return refreshToken is String ? refreshToken : '';
}

/// get the isLogin from Cache Data Local
bool getIsLogin() {
  final isLogin =
      CacheDataHelper.getData(key: SharedPrefKey.keyIsLoggedIn) ?? false;
  if (isLogin is bool) {
    return isLogin;
  } else {
    return false;
  }
}

/// get the isFirstLaunch from Cache Data Local
bool getIsFirstLaunch() {
  final dynamic isFirstLaunch =
      CacheDataHelper.getData(key: SharedPrefKey.keyIsFirstLaunch) ?? true;
  if (isFirstLaunch is bool) {
    return isFirstLaunch;
  } else {
    return true;
  }
}

/// get the isDoctor from Cache Data Local
bool isDoctor = getRole() == 'doctor';

/// get the isPatient from Cache Data Local
bool isPatient = getRole() == 'patient';
