class ApiUrl {
  // static const String baseUrl = String.fromEnvironment('BaseUrl');
  //static const String baseUrl = "http://64.225.82.127:8010";
  static const String baseUrl = "http://188.245.70.180:8010";
  static const String apiKey =
      "B53duKdPa_0FlTCWjeHLkpL_AxFqy7qDwZrmE7mfU2csLwhMU1dhRGPARm1GtJzh2_8qEB6GGiTBtx_qR0KbFII1BGkoSmugIm8LyVU9cK9HFT8iALzdOT6F6RZw1zXK19K8JA";

  // Auth
  static const String refresh = "/auth/api/v1/token/refresh/";
  static const String otp = "/authapp/api/v1/otp/";
  static const String customer = "/hostapp/api/v1/customer/";
  static const String updateUserAccount = "/authapp/api/v1/user_account_update/";
  static const String property = "/hostapp/api/v1/houses/";
  static const String propertyType = "/hostapp/api/v1/property_types/";
  static const String amenities = "/hostapp/api/v1/amenities/";
  static const String cities = "/hostapp/api/v1/cities/";
  static const String reservations = "/hostapp/api/v1/reservations/";
  static const String rejectReservations = "/hostapp/api/v1/reservations/reject/";
  static const String acceptReservations = "/hostapp/api/v1/reservations/accept/";


  static const String occupancyRate = "/hostapp/api/v1/occupancy_rate/";
  static const String totalProperty = "/hostapp/api/v1/total_number_of_property/";
  static const String agent = "/hostapp/api/v1/agent/";
  static const String hostHouseSearch = "/hostapp/api/v1/houses_search/";


  //guest
  static const String propertyByType = "/guestapp/api/v1/properties_by_type/";
  static const String tradingProperty = "/guestapp/api/v1/property_trending/";
  static const String propertyBooking = "/guestapp/api/v1/property_booking/";
  static const String cancelBooking = "/guestapp/api/v1/property_booking/cancel/";
  static const String filterProperties = "/guestapp/api/v1/filter_properties/";

}
