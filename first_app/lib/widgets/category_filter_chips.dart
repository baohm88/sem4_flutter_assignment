import 'package:flutter/material.dart';
import '../entities/event_category.dart';

class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({super.key, required this.categories, required this.selected, required this.onSelected});

  final List<EventCategory> categories;
  final EventCategory? selected; // null => All
  final ValueChanged<EventCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          ChoiceChip(label: const Text('All'), selected: selected == null, onSelected: (_) => onSelected(null)),
          const SizedBox(width: 8),
          ...categories.map((c) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(label: Text(c.title), selected: selected?.id == c.id, onSelected: (_) => onSelected(c)),
            );
          }),
        ],
      ),
    );
  }
}
