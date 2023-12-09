class ScientificPublication {
  int id;
  String publicationTitle;
  int publicationYear;
  int authorId;
  int fieldId;
  String filePath;

  ScientificPublication({
    required this.id,
    required this.publicationTitle,
    required this.publicationYear,
    required this.authorId,
    required this.fieldId,
    required this.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'publication_title': publicationTitle,
      'publication_year': publicationYear,
      'author_id': authorId,
      'field_id': fieldId,
      'file_path': filePath,
    };
  }
}
