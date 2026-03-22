package com.example.flutter_playground

import android.content.Context
import android.content.Intent
import android.provider.CalendarContract

class CustomCalendarEventHandler(private val context: Context) : CustomCalendarHostApi {

  override fun createEvent(input: CalendarEventInput, callback: (Result<Unit>) -> Unit) {
    try {
      val intent = Intent(Intent.ACTION_INSERT).apply {
        data = CalendarContract.Events.CONTENT_URI
        putExtra(CalendarContract.Events.TITLE, input.title)
        putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, input.startDateMs ?: 0L)
        putExtra(CalendarContract.EXTRA_EVENT_END_TIME, input.endDateMs ?: 0L)
        putExtra(CalendarContract.Events.ALL_DAY, input.isAllDay ?: false)
        putExtra(CalendarContract.Events.DESCRIPTION, input.description)
        putExtra(CalendarContract.Events.EVENT_LOCATION, input.location)
        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      }
      context.startActivity(intent)
      callback(Result.success(Unit))
    } catch (e: Exception) {
      callback(Result.failure(e))
    }
  }
}
