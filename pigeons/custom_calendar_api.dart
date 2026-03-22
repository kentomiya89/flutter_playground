import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/custom_calendar_api.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/com/example/flutter_playground/CustomCalendarApi.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.example.flutter_playground'),
    swiftOut: 'ios/Runner/CustomCalendarApi.g.swift',
  ),
)
class CalendarEventInput {
  String? title;
  int? startDateMs; // UTC millisecondsSinceEpoch
  int? endDateMs;
  bool? isAllDay;
  String? description;
  String? url;
  String? location;
  List<int?>? remindersSeconds;
}

@HostApi()
abstract class CustomCalendarHostApi {
  @async
  void createEvent(CalendarEventInput input);
}
