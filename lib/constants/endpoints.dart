class Endpoints {
  static String djangoBaseURL = "http://192.168.246.125:5000";
  static String nodeBaseURL = "http://192.168.1.33:3000";
  static String login = "$nodeBaseURL/auth/login";
  static String signup = "$nodeBaseURL/auth/signup";
  static String refresh = "$nodeBaseURL/auth/refresh";
  static String getProfile = "$nodeBaseURL/profile";
  static String chatbotAsk = "$djangoBaseURL/ask";
  static String uploadDocNode = "$nodeBaseURL/upload";
  static String uploadDocFlask = "$djangoBaseURL/validateSign";
  static String verifyDocFlask = "$djangoBaseURL/verifySign";
  static String getCompanyPostings = "$nodeBaseURL/companyPosting";
  static String companyRegisterEvent = "$nodeBaseURL/studentResponse";
  static String getRegCompanies = "$nodeBaseURL/profile/registeredCompanies";
  static String analyzeResume = "$nodeBaseURL/analyze"; //! change this to djangoBaseURL later
}
