class EventCategory {
  final int id;
  final String title;

  EventCategory({required this.id, required this.title});

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(id: (json['id'] ?? 0) as int, title: (json['Title'] ?? '').toString());
  }
}
