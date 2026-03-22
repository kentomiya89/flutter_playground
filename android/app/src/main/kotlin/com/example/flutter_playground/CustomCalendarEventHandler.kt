package com.example.flutter_playground

import android.content.Context
import android.content.Intent
import androidx.core.content.FileProvider
import java.io.File

class CustomCalendarEventHandler(private val context: Context) : CustomCalendarHostApi {

  override fun createEvent(input: CalendarEventInput, callback: (Result<Unit>) -> Unit) {
    try {
      val icsContent = buildIcsContent(input)
      val file = writeIcsToTemp(icsContent)
      val uri = FileProvider.getUriForFile(
        context,
        "${context.packageName}.custom.fileprovider",
        file,
      )
      val intent = Intent(Intent.ACTION_VIEW).apply {
        setDataAndType(uri, "text/calendar")
        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      }
      context.startActivity(intent)
      callback(Result.success(Unit))
    } catch (e: Exception) {
      callback(Result.failure(e))
    }
  }

  private fun writeIcsToTemp(content: String): File {
    val dir = File(context.cacheDir, "custom_calendar")
    dir.mkdirs()
    val file = File(dir, "event.ics")
    file.writeText(content)
    return file
  }
}
