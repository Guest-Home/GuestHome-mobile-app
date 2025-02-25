class ApiUrl {
  // static const String baseUrl = String.fromEnvironment('BaseUrl');
  //static const String baseUrl = "http://64.225.82.127:8010";
  //"BaseUrl":"http://188.245.70.180:9010",
  static const String baseUrl = String.fromEnvironment('BaseUrl');
  static const String apiKey = String.fromEnvironment('X-API-Key');
  // Auth
  static const String refresh = "/auth/api/v1/token/refresh/";
  static const String otp = "/authapp/api/v1/otp/";
  static const String tGOtp = "/authapp/api/v1/otp_for_telegram/";
  static const String changePhone = "/authapp/api/v1/change_phone_number/";
  static const String logOut = "/authapp/api/v1/logout/";
  static const String deactivateAccount = "/authapp/api/v1/deactivate_user/";

  static const String customer = "/hostapp/api/v1/customer/";
  static const String updateUserAccount = "/authapp/api/v1/user_account_update/";
  static const String property = "/hostapp/api/v1/houses/";
  static const String propertyType = "/hostapp/api/v1/property_types/";
  static const String amenities = "/hostapp/api/v1/amenities/";
  static const String cities = "/hostapp/api/v1/cities/";

  static const String reservations = "/hostapp/api/v1/reservations/";
  static const String rejectReservations =
      "/hostapp/api/v1/reservations/reject/";
  static const String acceptReservations =
      "/hostapp/api/v1/reservations/accept/";

  static const String occupancyRate = "/hostapp/api/v1/occupancy_rate/";
  static const String totalProperty =
      "/hostapp/api/v1/total_number_of_property/";
  static const String agent = "/hostapp/api/v1/agent/";
  static const String hostHouseSearch = "/hostapp/api/v1/houses_search/";

  static const String downloadReport = "/hostapp/api/v1/reservation_report/";

  //guest
  static const String propertyByType = "/guestapp/api/v1/properties_by_type/";
  static const String tradingProperty = "/guestapp/api/v1/property_trending/";
  static const String propertyBooking = "/guestapp/api/v1/property_booking/";
  static const String cancelBooking =
      "/guestapp/api/v1/property_booking/cancel/";
  static const String filterProperties = "/guestapp/api/v1/filter_properties/";
  static const String searchProperties = "/guestapp/api/v1/search_properties/";

  //payment
  static const String deposit = "/payment/api/v1/deposit_point_to_system/";
  static const String reservationPayment = "/payment/api/v1/reservation_payment/";
  static const String commission = "/hostapp/api/v1/commission_history/";
  static const String depositTransaction = "/payment/api/v1/deposit_transaction/";
  static const String paymentConfig = "/hostapp/api/v1/payment_configuration/";

}
