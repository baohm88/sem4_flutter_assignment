class EventRegistration {
  final int? id;
  final String fullName;
  final String email;
  final String phone;
  final int eventId;

  EventRegistration({this.id, required this.fullName, required this.email, required this.phone, required this.eventId});

  Map<String, dynamic> toStrapiCreateBody() {
    return {
      "data": {
        "FullName": fullName, 
        "Email": email,
        "Phone": phone,
        "event": eventId, 
      },
    };
  }

  factory EventRegistration.fromJson(Map<String, dynamic> json) {
    return EventRegistration(
      id: json['id'] as int?,
      fullName: (json['FullName'] ?? '').toString(),
      email: (json['Email'] ?? '').toString(),
      phone: (json['Phone'] ?? '').toString(),
      eventId: (json['event'] is Map ? json['event']['id'] : 0),
    );
  }
}
