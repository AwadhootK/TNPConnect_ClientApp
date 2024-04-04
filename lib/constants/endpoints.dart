class Endpoints {
  static String flaskBaseURL = "http://192.168.246.125:5000";
  static String nodeBaseURL = "http://192.168.246.250:3000";
  static String login = "$nodeBaseURL/auth/login";
  static String signup = "$nodeBaseURL/auth/signup";
  static String refresh = "$nodeBaseURL/auth/refresh";
  static String getProfile = "$nodeBaseURL/profile";
  static String chatbotAsk = "$flaskBaseURL/ask";
  static String uploadDocNode = "$nodeBaseURL/upload";
  static String uploadDocFlask = "$flaskBaseURL/validateSign";
  static String verifyDocFlask = "$flaskBaseURL/verifySign";
  static String getCompanyPostings = "$nodeBaseURL/companyPosting";
  static String companyRegisterEvent = "$nodeBaseURL/studentResponse";
  static String getRegCompanies = "$nodeBaseURL/profile/registeredCompanies";
  static String analyzeResume = "$flaskBaseURL/analyzeUrl";
  static String postProfile = "$nodeBaseURL/profile";
  static String updateDeviceID = "$nodeBaseURL/auth/deviceID";
}
