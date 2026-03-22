package com.example.flutter_playground

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class IcsBuilderTest {

  @Test
  fun `ICS content contains SUMMARY for given title`() {
    val input = CalendarEventInput(
      title = "Test Meeting",
      startDateMs = 1_000_000L,
      endDateMs = 2_000_000L,
      isAllDay = false,
      description = "Test description",
      url = null,
      location = "Tokyo",
      remindersSeconds = listOf(900L),
    )

    val ics = buildIcsContent(input)

    assertTrue(ics.contains("SUMMARY:Test Meeting"))
    assertTrue(ics.contains("BEGIN:VCALENDAR"))
    assertTrue(ics.contains("BEGIN:VEVENT"))
    assertTrue(ics.contains("END:VEVENT"))
    assertTrue(ics.contains("END:VCALENDAR"))
    assertTrue(ics.contains("DESCRIPTION:Test description"))
    assertTrue(ics.contains("LOCATION:Tokyo"))
    assertTrue(ics.contains("BEGIN:VALARM"))
    assertTrue(ics.contains("TRIGGER:-PT900S"))
  }

  @Test
  fun `ICS content omits optional fields when null`() {
    val input = CalendarEventInput(
      title = null,
      startDateMs = 1_000_000L,
      endDateMs = 2_000_000L,
    )

    val ics = buildIcsContent(input)

    assertFalse(ics.contains("SUMMARY:"))
    assertFalse(ics.contains("DESCRIPTION:"))
    assertFalse(ics.contains("LOCATION:"))
    assertFalse(ics.contains("VALARM"))
  }

  @Test
  fun `ICS content escapes semicolons and commas`() {
    val input = CalendarEventInput(
      title = "Meeting; with, special chars",
      startDateMs = 1_000_000L,
      endDateMs = 2_000_000L,
    )

    val ics = buildIcsContent(input)

    assertTrue(ics.contains("SUMMARY:Meeting\\; with\\, special chars"))
  }

  @Test
  fun `CalendarEventInput fields are accessible`() {
    val input = CalendarEventInput(
      title = "Test",
      startDateMs = 1_000_000L,
      endDateMs = 2_000_000L,
      isAllDay = false,
      description = "Desc",
      url = "https://example.com",
      location = "Tokyo",
      remindersSeconds = listOf(600L, 900L),
    )

    assertEquals("Test", input.title)
    assertEquals(1_000_000L, input.startDateMs)
    assertEquals(false, input.isAllDay)
    assertEquals(2, input.remindersSeconds?.size)
  }
}
