class AppLink{
  static const String server = "http://192.168.0.144/ersi/";

  ///auth////

  static const String signUp = '$server/auth/signup.php';
  static const String testView = '$server/test.php';

  static const String login = '$server/auth/login.php';
  // static const String verifyCode = '$server/auth/forgetpassword/verifycode.php';
  static const String verifySignCode = '$server/auth/verifycode.php';
  static const String forgetPassword = '$server/auth/forgetpassword/forgetpassword.php';
  static const String newPassword = '$server/auth/forgetpassword/newpassword.php';
  static const String verifyPassword = '$server/auth/forgetpassword/verfycodeforgetpassword.php';

//createproject//
  static const String createProject = '$server/createproject/createproject.php';
  

}