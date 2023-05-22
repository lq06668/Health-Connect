class Doctors {
  final String name;
  final String specialization;
  final String education;
  final String about;
  final String experience;
  final int bad;
  final int good;
  final int medium;

  Doctors({
    required this.name,
    required this.specialization,
    required this.education,
    required this.about,
    required this.experience,
    required this.bad,
    required this.good,
    required this.medium
  });

  // Factory method to create a Doctor object from a map of data
  factory Doctors.fromMap(Map<String, dynamic> map) {
    return Doctors(
      name: map['name'] as String,
      specialization: map['specialization'] as String,
      education: map['education'] as String,
      about: map['about'] as String,
      experience: map['experience'] as String,
      bad: map['bad'] as int,
      good: map['good'] as int,
      medium : map['medium'] as int,

    );
  }

  // Method to convert a Doctor object to a map of data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialization': specialization,
      'education': education,
    };
  }
}
