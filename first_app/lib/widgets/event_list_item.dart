import 'package:flutter/material.dart';
import '../entities/event.dart';

class EventListItem extends StatelessWidget {
  const EventListItem({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.event),
      title: Text(event.title.isEmpty ? 'No title' : event.title),
      subtitle: Text(event.status.isEmpty ? 'Unknown' : event.status),
    );
  }
}
