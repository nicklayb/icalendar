defmodule ICalendar.EventTest do
  use ExUnit.Case

  alias ICalendar.Event

  test "ICalendar.to_ics/1 of event" do
    ics = %Event{} |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with some attributes" do
    ics =
      %Event{
        summary: "Going fishing",
        description: "Escape from the world. Stare at some water.",
        comment: "Don't forget to take something to eat !"
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           COMMENT:Don't forget to take something to eat !
           DESCRIPTION:Escape from the world. Stare at some water.
           SUMMARY:Going fishing
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with date start and end" do
    ics =
      %Event{
        dtstart: ~D[2015-12-24],
        dtend: ~D[2015-12-24]
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           DTEND:20151224
           DTSTART:20151224
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with datetime start and end" do
    ics =
      %Event{
        dtstart: DateTime.new!(~D[2015-12-24], ~T[08:30:00]),
        dtend: DateTime.new!(~D[2015-12-24], ~T[08:45:00])
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           DTEND:20151224T084500Z
           DTSTART:20151224T083000Z
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with datetime with timezone" do
    dtstart = DateTime.new!(~D[2015-12-24], ~T[08:30:00], "America/Chicago")
    dtend = DateTime.new!(~D[2015-12-24], ~T[08:45:00], "America/Chicago")

    ics =
      %Event{dtstart: dtstart, dtend: dtend}
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           DTEND;TZID=America/Chicago:20151224T084500
           DTSTART;TZID=America/Chicago:20151224T083000
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 does not damage url in description" do
    ics =
      %Event{
        summary: "Going fishing",
        description:
          "See this link http://example.com/pub" <>
            "/calendars/jsmith/mytime.ics"
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           DESCRIPTION:See this link http://example.com/pub/calendars/jsmith/mytime.ics
           SUMMARY:Going fishing
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with url" do
    ics =
      %Event{
        url: "http://example.com/pub/calendars/jsmith/mytime.ics"
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           URL:http://example.com/pub/calendars/jsmith/mytime.ics
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with integer UID" do
    ics =
      %Event{
        uid: 815
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           UID:815
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with string UID" do
    ics =
      %Event{
        uid: "0815"
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           UID:0815
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with geo" do
    ics =
      %Event{
        geo: {43.6978819, -79.3810277}
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           GEO:43.6978819;-79.3810277
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with categories" do
    ics =
      %Event{
        categories: ["Fishing", "Nature", "Sport"]
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           CATEGORIES:Fishing,Nature,Sport
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with status" do
    ics =
      %Event{
        status: :tentative
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           STATUS:TENTATIVE
           END:VEVENT
           """
  end

  test "ICalendar.to_ics/1 with class" do
    ics =
      %Event{
        class: :private
      }
      |> ICalendar.to_ics()

    assert ics == """
           BEGIN:VEVENT
           CLASS:PRIVATE
           END:VEVENT
           """
  end
end
