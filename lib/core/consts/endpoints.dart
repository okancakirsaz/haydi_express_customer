final class Endpoints {
  static final Endpoints instance = Endpoints();

  //Auth
  final String logIn = "/auth/log-in-customer";
  final String forgotPassword = "/auth/forgot-password-customer";
  final String mailVerificationRequest = "/auth/mail-verification-request";
  final String mailVerification = "/auth/mail-verification";
  final String signUp = "/auth/sign-up-customer";

  //Menu
  final String getRestaurantMenu = "/menu/get-restaurant-menu";

  //Flows
  final String getHaydiFirsatlar = "/flow/haydi-firsatlar";
}
