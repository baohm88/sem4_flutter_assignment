import 'package:flutter/material.dart';
import '../services/api_client.dart';
import '../repositories/event_repository.dart';
import '../repositories/event_category_repository.dart';

import 'home_page.dart';
import 'event_page.dart';
import 'event_register_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _index = 0;

  late final ApiClient _api;
  late final EventRepository _eventRepo;
  late final EventCategoryRepository _categoryRepo;

  @override
  void initState() {
    super.initState();
    _api = ApiClient();
    _eventRepo = EventRepository(_api);
    _categoryRepo = EventCategoryRepository(_api);
  }

  void setTab(int i) {
    setState(() => _index = i);
  }

  @override
  void dispose() {
    _api.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onGoRegister: () => setTab(2)),
      EventPage(eventRepo: _eventRepo, categoryRepo: _categoryRepo),
      EventRegisterPage(eventRepo: _eventRepo, onSuccessGoHome: () => setTab(0)),
    ];

    // IndexedStack để giữ state khi đổi tab
    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: setTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Register'),
        ],
      ),
    );
  }
}
