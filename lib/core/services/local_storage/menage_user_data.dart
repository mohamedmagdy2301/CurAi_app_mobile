import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';
import 'package:curai_app_mobile/features/home/data/datasources/home_local_data_source.dart';

void saveDataUser({required LoginModel data}) {
  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyAccessToken,
        value: data.accessToken,
      );
  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyRefreshToken,
        value: data.refreshToken,
      );
  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyUserName,
        value: data.username,
      );
  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyRole,
        value: data.role,
      );
  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyUserId,
        value: data.userId,
      );

  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyFullName,
        value: '${data.firstName} ${data.lastName}',
      );

  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyBonusPoints,
        value: data.bonusPoints,
      );

  di.sl<CacheDataManager>().setData(
        key: SharedPrefKey.keyProfilePicture,
        value: data.profilePicture,
      );
}

Future<void> clearUserData() async {
  await Future.wait([
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyAccessToken),
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyRefreshToken),
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyUserName),
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyRole),
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyUserId),
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyFullName),
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyBonusPoints),
    di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyProfilePicture),
  ]);
  clearCachHomeData();
}

void clearCachHomeData() {
  di.sl<HomeLocalDataSource>().clearPopularDoctorsCache();
  di.sl<HomeLocalDataSource>().clearSpecializationsCache();
  di.sl<HomeLocalDataSource>().clearTopDoctorsCache();
}

String getUsername() {
  final userName =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyUserName) ?? '';
  return userName is String ? userName : '';
}

/// get the role from Cache Data Local
String getRole() {
  final role =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyRole) ?? '';
  return role is String ? role : '';
}

/// get the userId from Cache Data Local
int getUserId() {
  final userId =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyUserId);
  return userId is int ? userId : 0;
}

/// get the fullName from Cache Data Local
String getFullName() {
  final fullName =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyFullName) ?? '';
  return fullName is String ? fullName : '';
}

/// get the profilePicture from Cache Data Local
String getProfilePicture() {
  final profilePicture =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyProfilePicture) ??
          '';
  return profilePicture is String ? profilePicture : '';
}

/// get the bonusPoints from Cache Data Local
int getBonusPoints() {
  final bonusPoints =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyBonusPoints);
  return bonusPoints is int ? bonusPoints : 0;
}

/// get the accessToken from Cache Data Local
String getAccessToken() {
  final accessToken =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyAccessToken) ??
          '';
  return accessToken is String ? accessToken : '';
}

/// get the refreshToken from Cache Data Local
String getRefreshToken() {
  final refreshToken =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyRefreshToken) ??
          '';
  return refreshToken is String ? refreshToken : '';
}

/// get the isLogin from Cache Data Local
bool getIsLogin() {
  final isLogin =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyIsLoggedIn) ??
          false;
  if (isLogin is bool) {
    return isLogin;
  } else {
    return false;
  }
}

/// get the isFirstLaunch from Cache Data Local
bool getIsFirstLaunch() {
  final dynamic isFirstLaunch =
      di.sl<CacheDataManager>().getData(key: SharedPrefKey.keyIsFirstLaunch) ??
          true;
  if (isFirstLaunch is bool) {
    return isFirstLaunch;
  } else {
    return true;
  }
}
