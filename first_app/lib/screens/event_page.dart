import 'package:flutter/material.dart';
import '../entities/event.dart';
import '../entities/event_category.dart';
import '../repositories/event_repository.dart';
import '../repositories/event_category_repository.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/event_list_item.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.eventRepo, required this.categoryRepo});

  final EventRepository eventRepo;
  final EventCategoryRepository categoryRepo;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final ScrollController _scroll = ScrollController();

  // Data
  List<Event> _events = [];
  List<EventCategory> _categories = [];
  EventCategory? _selected; // null = All

  // Pagination
  int _page = 1;
  final int _pageSize = 10;
  bool _loading = false;
  bool _hasMore = true;

  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInit();
    _scroll.addListener(_onScroll);
  }

  Future<void> _loadInit() async {
    await Future.wait([_loadCategories(), _resetAndLoadEvents(category: null)]);
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      if (!_loading && _hasMore) {
        _loadMoreEvents();
      }
    }
  }

  Future<void> _loadCategories() async {
    try {
      final items = await widget.categoryRepo.fetchCategories();
      if (!mounted) return;
      setState(() => _categories = items);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Failed to load categories');
    }
  }

  Future<void> _resetAndLoadEvents({required EventCategory? category}) async {
    setState(() {
      _selected = category;
      _events = [];
      _page = 1;
      _hasMore = true;
      _error = null;
    });
    await _loadMoreEvents();
  }

  Future<void> _loadMoreEvents() async {
    if (_loading) return;

    setState(() => _loading = true);

    try {
      final items = await widget.eventRepo.fetchEvents(page: _page, pageSize: _pageSize, categoryId: _selected?.id);

      final pageCount = await widget.eventRepo.fetchEventPageCount(pageSize: _pageSize, categoryId: _selected?.id);

      if (!mounted) return;
      setState(() {
        _events.addAll(items);
        _page++;
        _hasMore = _page <= pageCount;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Failed to load events');
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: Column(
        children: [
          CategoryFilterChips(
            categories: _categories,
            selected: _selected,
            onSelected: (c) => _resetAndLoadEvents(category: c),
          ),
          const Divider(height: 1),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null && _events.isEmpty) {
      return Center(child: Text(_error!));
    }

    if (_events.isEmpty && _loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_events.isEmpty && !_loading) {
      return const Center(child: Text('No events found'));
    }

    return ListView.builder(
      controller: _scroll,
      itemCount: _events.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, i) {
        if (i < _events.length) {
          return EventListItem(event: _events[i]);
        }
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
