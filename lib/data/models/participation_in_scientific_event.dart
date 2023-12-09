class ParticipationInScientificEvent {
  int id;
  String eventName;
  DateTime date;
  int authorId;

  ParticipationInScientificEvent({
    required this.id,
    required this.eventName,
    required this.date,
    required this.authorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'event_name': eventName,
      'date': date.toIso8601String(),
      'author_id': authorId,
    };
  }
}
