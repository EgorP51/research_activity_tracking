class FieldOfScience {
  int id;
  String fieldName;

  FieldOfScience({required this.id, required this.fieldName});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'field_name': fieldName,
    };
  }
}
