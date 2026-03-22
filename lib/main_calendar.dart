import 'package:eventide/eventide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/src/pigeon/custom_calendar_api.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarComparisonPage();
  }
}

class CalendarComparisonPage extends StatefulWidget {
  const CalendarComparisonPage({super.key});

  @override
  State<CalendarComparisonPage> createState() => _CalendarComparisonPageState();
}

class _CalendarComparisonPageState extends State<CalendarComparisonPage> {
  bool _isLoading = false;

  static final _startDate = DateTime(2026, 4, 1, 10, 0);
  static final _endDate = DateTime(2026, 4, 1, 11, 0);

  Future<void> _createWithEventide() async {
    setState(() => _isLoading = true);
    try {
      await Eventide().createEventThroughNativePlatform(
        title: 'Sample Event (Eventide)',
        startDate: _startDate,
        endDate: _endDate,
        isAllDay: false,
        description: 'Created via Eventide package',
        url: 'https://example.com',
        location: 'Tokyo, Japan',
        reminders: const [Duration(minutes: 15)],
      );
      _showSnackBar('Eventide: event created');
    } on ETUserCanceledException {
      _showSnackBar('Eventide: canceled by user');
    } on ETPresentationException catch (e) {
      _showSnackBar('Eventide presentation error: $e');
    } catch (e) {
      _showSnackBar('Eventide error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _createWithCustomPigeon() async {
    setState(() => _isLoading = true);
    try {
      await CustomCalendarHostApi().createEvent(
        CalendarEventInput(
          title: 'Sample Event (Custom Pigeon)',
          startDateMs: _startDate.millisecondsSinceEpoch,
          endDateMs: _endDate.millisecondsSinceEpoch,
          isAllDay: false,
          description: 'Created via custom Pigeon channel',
          url: 'https://example.com',
          location: 'Tokyo, Japan',
          remindersSeconds: [15 * 60],
        ),
      );
      _showSnackBar('Custom Pigeon: event created');
    } catch (e) {
      final message = e.toString().contains('CANCELED')
          ? 'Custom Pigeon: canceled by user'
          : 'Custom Pigeon error: $e';
      _showSnackBar(message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar: Eventide vs Custom Pigeon')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _createWithEventide,
                    child: const Text('Create Event via Eventide'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _createWithCustomPigeon,
                    child: const Text('Create Event via Custom Pigeon'),
                  ),
                ],
              ),
      ),
    );
  }
}
