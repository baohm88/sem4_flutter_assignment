import '../entities/event_category.dart';
import '../services/api_client.dart';

class EventCategoryRepository {
  EventCategoryRepository(this._api);
  final ApiClient _api;

  Future<List<EventCategory>> fetchCategories() async {
    final json = await _api.get('event-categories');
    final list = (json['data'] as List?) ?? [];
    return list.map((e) => EventCategory.fromJson(e as Map<String, dynamic>)).toList();
  }
}
