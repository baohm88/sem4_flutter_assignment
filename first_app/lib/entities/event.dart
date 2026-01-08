class Event {
  final int id;
  final String title;
  final String status;

  // Optional: hiển thị thêm nếu muốn
  final DateTime? startTime;
  final DateTime? endTime;

  Event({required this.id, required this.title, required this.status, this.startTime, this.endTime});

  factory Event.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      return DateTime.tryParse(v.toString());
    }

    return Event(
      id: (json['id'] ?? 0) as int,
      title: (json['Title'] ?? '').toString(),
      status: (json['EventStatus'] ?? '').toString(),
      startTime: parseDate(json['StartTime']),
      endTime: parseDate(json['EndTime']),
    );
  }
}
