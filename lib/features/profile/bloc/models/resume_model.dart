class AnalyzeResumeModel {
  final int jdMatch;
  final List<String> missingKeywords;
  final String summary;

  AnalyzeResumeModel({
    required this.jdMatch,
    required this.missingKeywords,
    required this.summary,
  });

  factory AnalyzeResumeModel.fromJson(Map<String, dynamic> json) {
    return AnalyzeResumeModel(
      jdMatch: json['jd_match'] ?? 0,
      missingKeywords: List<String>.from(json['missing_keywords'] ?? []),
      summary: json['summary'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jd_match': jdMatch,
      'missing_keywords': missingKeywords,
      'summary': summary,
    };
  }
}
