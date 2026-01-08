import 'package:flutter/material.dart';

import '../entities/event.dart';
import '../entities/event_registration.dart';
import '../repositories/event_repository.dart';

class EventRegisterPage extends StatefulWidget {
  const EventRegisterPage({super.key, required this.eventRepo, required this.onSuccessGoHome});

  final EventRepository eventRepo;
  final VoidCallback onSuccessGoHome;

  @override
  State<EventRegisterPage> createState() => _EventRegisterPageState();
}

class _EventRegisterPageState extends State<EventRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  List<Event> _events = [];
  Event? _selected;

  bool _loadingEvents = true;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadEventsForDropdown();
    _fullName.addListener(_refresh);
    _email.addListener(_refresh);
    _phone.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _loadEventsForDropdown() async {
    try {
      final items = await widget.eventRepo.fetchAllEvents(pageSize: 50);
      if (!mounted) return;
      setState(() {
        _events = items;
        _loadingEvents = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingEvents = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load events')));
    }
  }

  bool get _canSubmit {
    return !_submitting &&
        _fullName.text.trim().isNotEmpty &&
        _email.text.trim().isNotEmpty &&
        _phone.text.trim().isNotEmpty &&
        _selected != null;
  }

  Future<void> _submit() async {
    if (_submitting) return;

    // Validate Form fields
    if (!_formKey.currentState!.validate()) return;

    // Validate event
    if (_selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an event')));
      return;
    }

    setState(() => _submitting = true);

    try {
      final reg = EventRegistration(
        fullName: _fullName.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        eventId: _selected!.id,
      );

      await widget.eventRepo.createRegistration(reg);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered successfully')));

      // Clear form
      _formKey.currentState!.reset();
      _fullName.clear();
      _email.clear();
      _phone.clear();
      setState(() => _selected = null);

      // Switch tab to Home
      widget.onSuccessGoHome();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))));
    } finally {
      if (!mounted) return;
      setState(() => _submitting = false);
    }
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Event')),
      body: _loadingEvents
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullName,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Full name is required' : null,
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Email is required';
                        if (!v.contains('@')) return 'Invalid email format';
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phone,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Phone is required';
                        if (v.trim().length < 9) return 'Phone is invalid';
                        return null;
                      },
                    ),
                    DropdownButtonFormField<Event>(
                      value: _selected,
                      decoration: const InputDecoration(labelText: 'Event'),
                      items: _events
                          .map(
                            (e) =>
                                DropdownMenuItem<Event>(value: e, child: Text(e.title.isEmpty ? 'No title' : e.title)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selected = v),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canSubmit ? _submit : null,
                        child: _submitting
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
