class Scientist {
  int id;
  String position;
  String educationalInstitution;
  String academicDegree;

  Scientist({
    required this.id,
    required this.position,
    required this.educationalInstitution,
    required this.academicDegree,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'position': position,
      'educational_institution': educationalInstitution,
      'academic_degree': academicDegree,
    };
  }
}
