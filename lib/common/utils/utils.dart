import 'package:get_storage/get_storage.dart';

class Utils {
  static final GetStorage _box = GetStorage();

  /// Ma'lumotni olish
  static String _getString(String key) => _box.read(key) ?? '';

  /// Ma'lumotni saqlash
  static void _setString(String key, String value) => _box.write(key, value);

  /// Token bilan ishlash
  static String getToken() => _getString("token");

  static void setToken(String token) => _setString("token", token);

  /// Refresh token bilan ishlash
  static String getRefreshToken() => _getString("refreshToken");

  static void setRefreshToken(String token) =>
      _setString("refreshToken", token);

  /// User ID bilan ishlash
  static String getUserID() => _getString("userId");

  static void setUserId(String userId) => _setString("userId", userId);
}
