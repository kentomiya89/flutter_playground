import 'package:flutter_playground/src/pigeon/custom_calendar_api.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_calendar_test.mocks.dart';

@GenerateMocks([CustomCalendarHostApi])
void main() {
  group('CustomCalendarHostApi', () {
    late MockCustomCalendarHostApi mockApi;

    setUp(() {
      mockApi = MockCustomCalendarHostApi();
    });

    test('createEvent is called with correct title', () async {
      when(mockApi.createEvent(any)).thenAnswer((_) => Future<void>.value());

      final input = CalendarEventInput(
        title: 'Test Event',
        startDateMs: 1_000_000,
        endDateMs: 2_000_000,
        isAllDay: false,
        description: 'Test description',
        remindersSeconds: [900],
      );
      await mockApi.createEvent(input);

      verify(mockApi.createEvent(any)).called(1);
    });

    test('createEvent propagates exceptions', () {
      when(mockApi.createEvent(any)).thenThrow(Exception('channel error'));

      expect(
        () => mockApi.createEvent(CalendarEventInput()),
        throwsA(isA<Exception>()),
      );
    });

    test('CalendarEventInput holds all fields correctly', () {
      final input = CalendarEventInput(
        title: 'Event',
        startDateMs: 1_000_000,
        endDateMs: 2_000_000,
        isAllDay: true,
        description: 'Desc',
        url: 'https://example.com',
        location: 'Tokyo',
        remindersSeconds: [600, 900],
      );

      expect(input.title, 'Event');
      expect(input.startDateMs, 1_000_000);
      expect(input.isAllDay, true);
      expect(input.remindersSeconds, [600, 900]);
    });
  });
}
