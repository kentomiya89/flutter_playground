package com.example.flutter_playground

import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone

internal fun buildIcsContent(input: CalendarEventInput): String {
  val sdf = SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'", Locale.US).apply {
    timeZone = TimeZone.getTimeZone("UTC")
  }
  val startDate = sdf.format(Date(input.startDateMs ?: System.currentTimeMillis()))
  val endDate = sdf.format(Date(input.endDateMs ?: System.currentTimeMillis() + 3_600_000L))

  return buildString {
    appendLine("BEGIN:VCALENDAR")
    appendLine("VERSION:2.0")
    appendLine("PRODID:-//flutter_playground//CustomCalendar//EN")
    appendLine("BEGIN:VEVENT")
    appendLine("DTSTART:$startDate")
    appendLine("DTEND:$endDate")
    input.title?.let { appendLine("SUMMARY:${it.escapeIcs()}") }
    input.description?.let { appendLine("DESCRIPTION:${it.escapeIcs()}") }
    input.location?.let { appendLine("LOCATION:${it.escapeIcs()}") }
    input.url?.let { appendLine("URL:$it") }
    input.remindersSeconds?.filterNotNull()?.forEach { seconds ->
      appendLine("BEGIN:VALARM")
      appendLine("TRIGGER:-PT${seconds}S")
      appendLine("ACTION:DISPLAY")
      appendLine("DESCRIPTION:Reminder")
      appendLine("END:VALARM")
    }
    appendLine("END:VEVENT")
    appendLine("END:VCALENDAR")
  }
}

private fun String.escapeIcs(): String =
  replace("\\", "\\\\")
    .replace(";", "\\;")
    .replace(",", "\\,")
    .replace("\n", "\\n")
