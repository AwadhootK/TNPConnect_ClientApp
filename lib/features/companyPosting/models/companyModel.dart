enum Branch { CSE, IT, ENTC, None }

class Company {
  final String id;
  final String? name;
  final int? stipend;
  final bool? ppo;
  final String? jdLink;
  final String? location;
  final int? duration;
  final int? rounds;
  final String? dateTimeOfTest;
  final String? notes;
  final String? criteria;
  final List<dynamic>? eligibleBranches;
  final String? mode;
  final bool? driveCompleted;

  Company({
    required this.id,
    required this.name,
    this.stipend = 0,
    this.ppo,
    this.jdLink,
    this.location,
    this.duration,
    this.rounds,
    this.dateTimeOfTest,
    this.notes,
    this.criteria,
    this.eligibleBranches,
    this.mode,
    this.driveCompleted = false,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      stipend: json['stipend'] ?? 0,
      ppo: json['ppo'],
      jdLink: json['jdLink'],
      location: json['location'],
      duration: json['duration'],
      rounds: json['rounds'] ?? 1,
      dateTimeOfTest: json['dateTimeOfTest'],
      notes: json['notes'],
      criteria: json['criteria'],
      eligibleBranches: (json['eligibleBranches'].map((branch) => (branch == 'CSE') ? Branch.CSE : ((branch == 'IT') ? Branch.IT : Branch.ENTC))).toList(),
      mode: json['mode'],
      driveCompleted: json['driveCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stipend': stipend,
      'ppo': ppo,
      'jdLink': jdLink,
      'location': location,
      'duration': duration,
      'rounds': rounds,
      'dateTimeOfTest': dateTimeOfTest,
      'notes': notes,
      'criteria': criteria,
      'eligibleBranches': eligibleBranches,
      'mode': mode?.toString().split('.').last,
      'driveCompleted': driveCompleted,
    };
  }
}
