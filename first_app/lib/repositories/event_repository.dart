import '../entities/event.dart';
import '../entities/event_registration.dart';
import '../services/api_client.dart';

class EventRepository {
  EventRepository(this._api);
  final ApiClient _api;

  Future<List<Event>> fetchEvents({required int page, required int pageSize, int? categoryId}) async {
    final filter = categoryId != null ? '&filters[event_category][id]=$categoryId' : '';
    final endpoint = 'events?pagination[page]=$page&pagination[pageSize]=$pageSize$filter';

    final json = await _api.get(endpoint);
    final list = (json['data'] as List?) ?? [];
    return list.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<int> fetchEventPageCount({required int pageSize, int? categoryId}) async {
    final filter = categoryId != null ? '&filters[event_category][id]=$categoryId' : '';
    final endpoint = 'events?pagination[page]=1&pagination[pageSize]=$pageSize$filter';

    final json = await _api.get(endpoint);
    final meta = (json['meta'] as Map?) ?? {};
    final pagination = (meta['pagination'] as Map?) ?? {};
    return (pagination['pageCount'] ?? 1) as int;
  }

  Future<List<Event>> fetchAllEvents({int pageSize = 100}) async {
    // Dùng cho dropdown register: lấy đủ để user chọn
    final pageCount = await fetchEventPageCount(pageSize: pageSize);
    final List<Event> all = [];

    for (int p = 1; p <= pageCount; p++) {
      final items = await fetchEvents(page: p, pageSize: pageSize);
      all.addAll(items);
    }
    return all;
  }

  Future<void> createRegistration(EventRegistration reg) async {
    await _api.post('event-registrations', reg.toStrapiCreateBody());
  }
}
