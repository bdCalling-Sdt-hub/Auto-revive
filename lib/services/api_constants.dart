class ApiConstants{
  // static const String baseUrl = "http://192.168.10.80:8080/api/v1";
  // static const String imageBaseUrl = "http://192.168.10.80:8080";
  static const String baseUrl = "https://auto-revive-mamun.sarv.live/api/v1";
  static const String imageBaseUrl = "https://auto-revive-mamun.sarv.live/uploads";




  static const String signUpEndPoint = "/auth/register";
  static const String loginUpEndPoint = "/auth/login";
  static const String changePassword = "/auth/change-password";
  static const String verifyEmailEndPoint = "/auth/verify-email";
  static const String uploadEndPoint = "/upload";
  static const String getAllToolsEndPoint = "/tool";
  static const String getAllExperienceEndPoint = "/experience";
  static const String resendOtpEndPoint = "/auth/resend-otp";
  static const String mechanicBasicInfoEndPoint = "/mechanic/basic-info";
  static const String experienceCertificationsEndPoint = "/mechanic/experience-certifications";
  static const String mechanicToolsEndPoint = "/mechanic/tools";
  static const String mechanicEmploymentHistoriesEndPoint = "/mechanic/employment-history";
  static const String referenceEndPoint = "/mechanic/reference";
  static const String additionalInformationEndPoint = "/mechanic/why-on-site";
  static const String mechanicResumeCertificateEndPoint = "/mechanic/resume-certificate";
  static const String getProfileEndPoint = "/user/me";
  static const String carModel = "/car-model";
  static const String postJob = "/job";
  static const String findMechanicRadius = "/user/radius/mechanic";
  static const String privacyPolicy = "/setting";
  static const String adminSupport = "/setting/support";
  static const String radiusLimits = "/setting/radius-limits";
  static const String jobRequest = "/job-process/provider/do-request";
  static  String addServiceProvider(String id) => "/job-process/provider/add-services/$id";
  static const String customerBookingEndPoint = "/job-process/customer";
  static const String getAllServiceEndPoint = "/service";
  static  String changeStatus (String id) => "/job-process/provider/$id";
  static  String bookingAllPaginationFilters = "/job-process/provider";
  static  String allHistories (String page,limit) => "/job-process/provider?page=1&limit=11&sortField=createdAt&sortOrder=desc";
  static  String getAllJobProvider(String page, sortField,  sortOrder, radius) => "/job/provider/$radius?page=$page&limit=10&sortField=$sortField&sortOrder=$sortOrder";


}