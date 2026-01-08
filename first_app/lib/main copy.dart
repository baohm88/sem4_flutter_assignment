import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

/// =======================================================
/// APP CONFIG / CONSTANTS
/// =======================================================
class AppConfig {
  static const String baseUrl = 'http://10.0.2.2:1337/api';
  static const int pageSize = 10;
}

/// =======================================================
/// ROOT APP
/// =======================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

/// =======================================================
/// SPLASH SCREEN
/// =======================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayout()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage('assets/logo.jpg'), width: 120, height: 120),
            SizedBox(height: 16),
            Text('Event Management', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// MAIN LAYOUT (BOTTOM NAVIGATION)
/// =======================================================
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> pages = const [HomePage(), EventPage(), EventRegisterPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Register'),
        ],
      ),
    );
  }
}

/// =======================================================
/// HOME PAGE
/// =======================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/logo.jpg'), width: 140, height: 140),
            const SizedBox(height: 24),
            const Text('Event Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EventRegisterPage()));
              },
              child: const Text('Register Event'),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// EVENT LIST PAGE (CATEGORY FILTER + PAGINATION)
/// =======================================================
class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final ScrollController _scrollController = ScrollController();

  List events = [];
  List categories = [];
  dynamic selectedCategory;

  int page = 1;
  bool loading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchEvents();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !loading && hasMore) {
      fetchEvents();
    }
  }

  Future<void> fetchCategories() async {
    try {
      final res = await http.get(Uri.parse('${AppConfig.baseUrl}/event-categories'));
      final jsonData = json.decode(res.body);
      setState(() => categories = jsonData['data'] ?? []);
    } catch (_) {}
  }

  Future<void> fetchEvents() async {
    if (loading) return;
    setState(() => loading = true);

    final categoryFilter = selectedCategory != null ? '&filters[event_category][id]=${selectedCategory['id']}' : '';

    final url =
        '${AppConfig.baseUrl}/events?pagination[page]=$page&pagination[pageSize]=${AppConfig.pageSize}$categoryFilter';

    try {
      final res = await http.get(Uri.parse(url));
      final jsonData = json.decode(res.body);
      final List newEvents = jsonData['data'] ?? [];
      final meta = jsonData['meta']['pagination'];

      setState(() {
        page++;
        events.addAll(newEvents);
        hasMore = page <= meta['pageCount'];
      });
    } catch (_) {
    } finally {
      setState(() => loading = false);
    }
  }

  void resetAndFetch({dynamic category}) {
    setState(() {
      selectedCategory = category;
      page = 1;
      events.clear();
      hasMore = true;
    });
    fetchEvents();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: Column(
        children: [
          _buildCategoryFilter(),
          const Divider(height: 1),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 56,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            ChoiceChip(
              label: const Text('All'),
              selected: selectedCategory == null,
              onSelected: (_) => resetAndFetch(),
            ),
            const SizedBox(width: 8),
            ...categories.map((c) {
              final title = c['Title'] ?? c['title'] ?? c['name'] ?? 'Category';
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(title),
                  selected: selectedCategory?['id'] == c['id'],
                  onSelected: (_) => resetAndFetch(category: c),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    if (events.isEmpty && loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (events.isEmpty) {
      return const Center(child: Text('No events found'));
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: events.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < events.length) {
          final event = events[index];
          return ListTile(
            leading: const Icon(Icons.event),
            title: Text(event['Title'] ?? 'No title'),
            subtitle: Text(event['EventStatus'] ?? 'Unknown'),
          );
        }
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

/// =======================================================
/// EVENT REGISTER PAGE
/// =======================================================
class EventRegisterPage extends StatefulWidget {
  const EventRegisterPage({super.key});

  @override
  State<EventRegisterPage> createState() => _EventRegisterPageState();
}

class _EventRegisterPageState extends State<EventRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  List events = [];
  dynamic selectedEvent;
  bool loading = true;
  bool submitting = false;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final res = await http.get(Uri.parse('${AppConfig.baseUrl}/events'));
    final jsonData = json.decode(res.body);
    setState(() {
      events = jsonData['data'];
      loading = false;
    });
  }

  Future<void> submit() async {
    if (submitting) return;
    if (!_formKey.currentState!.validate()) return;
    if (selectedEvent == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an event')));
      return;
    }

    setState(() => submitting = true);

    await http.post(
      Uri.parse('${AppConfig.baseUrl}/event-registrations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "data": {
          "FullName": fullNameController.text,
          "Email": emailController.text,
          "Phone": phoneController.text,
          "event": {
            "connect": [selectedEvent['id']],
          },
        },
      }),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered successfully')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Event')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(fullNameController, 'Full Name'),
                    _buildTextField(emailController, 'Email', keyboard: TextInputType.emailAddress),
                    _buildTextField(phoneController, 'Phone', keyboard: TextInputType.phone),
                    DropdownButtonFormField(
                      value: selectedEvent,
                      items: events.map((e) => DropdownMenuItem(value: e, child: Text(e['Title']))).toList(),
                      onChanged: (v) => setState(() => selectedEvent = v),
                      decoration: const InputDecoration(labelText: 'Event'),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: submitting ? null : submit,
                      child: submitting ? const CircularProgressIndicator(strokeWidth: 2) : const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(labelText: label),
      validator: (v) => v == null || v.trim().isEmpty ? '$label is required' : null,
    );
  }
}
