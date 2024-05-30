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

  //Flow
  final String getAdvertedMenus = "/flow/adverted-menu";
  final String getMoreAdvertedMenus = "/flow/more-adverted-menu";
  final String discover = "/flow/discover";
  final String getMoreDiscover = "/flow/more-discover";

  //Search
  final String search = "/search";
  final String getSearchAds = "/search/get-search-ads";
}
