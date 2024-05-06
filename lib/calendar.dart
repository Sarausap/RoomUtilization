import 'package:flutter/material.dart';
import 'package:room_utilization/model/schedule.dart';
import 'package:room_utilization/model/semester.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MeetingDataSource>(
        future: _fetchMeetings(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            return SfCalendar(
              view: CalendarView.week,
              dataSource: snapshot.data,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              timeSlotViewSettings:
                  TimeSlotViewSettings(startHour: 6, endHour: 20),
            );
          }
        },
      ),
    );
  }

  Future<MeetingDataSource> _fetchMeetings(int room_id) async {
    print("fetching data");
    List<Meeting> appointments = <Meeting>[];
    String semester_id = "OeuPodVAHxh2AKNQWU77";
    final Semester? semester = await Semester.getSemesterbyID(semester_id);
    final List<Schedule_Details> scheduleDetails =
        await Schedule_Details.readScheduleDetails(semester_id);

    if (semester != null) {
      print(
          "Semester details: ${semester.start_date.toDate()} - ${semester.end_date.toDate()}");
      print("Schedule details count: ${scheduleDetails.length}");
      for (var detail in scheduleDetails) {
        print("Processing detail: ${detail.class_name}");
        print("Processing detail: ${detail.course}");
        print("Processing detail: ${detail.instructor}");
        print("Processing detail: ${detail.start_time}");
        print("Processing detail: ${detail.end_time}");

        String recurrenceRule = 'FREQ=WEEKLY;BYDAY=';
        for (String day in detail.weekdays) {
          switch (day.toLowerCase()) {
            case 'monday':
              recurrenceRule += 'MO';
              break;
            case 'tuesday':
              recurrenceRule += 'TU';
              break;
            case 'wednesday':
              recurrenceRule += 'WE';
              break;
            case 'thursday':
              recurrenceRule += 'TH';
              break;
            case 'friday':
              recurrenceRule += 'FR';
              break;
            default:
              print("Invalid weekday: ${day}");
              continue;
          }
        }
        int daysCount = countDays(semester.start_date.toDate(),
            semester.end_date.toDate(), detail.weekdays);
        appointments.add(Meeting(
          eventName: detail.class_name,
          from: DateTime(
              semester.start_date.toDate().year,
              semester.start_date.toDate().month,
              semester.start_date.toDate().day,
              detail.start_time),
          to: DateTime(
              semester.start_date.toDate().year,
              semester.start_date.toDate().month,
              semester.start_date.toDate().day,
              detail.end_time),
          background: Colors.green,
          recurrenceRule: '$recurrenceRule;COUNT=$daysCount',
        ));
      }
    } else {
      print("Semester not found");
    }

    return MeetingDataSource(appointments);
  }
}

int countDays(DateTime startDate, DateTime endDate, List<String> days) {
  int count = 0;
  DateTime currentDate = startDate;

  Set<int> targetWeekdays = days.map((day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      case 'sunday':
        return DateTime.sunday;
      default:
        throw ArgumentError('Invalid weekday: $day');
    }
  }).toSet();

  while (
      currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
    if (targetWeekdays.contains(currentDate.weekday)) {
      count++;
    }
    currentDate = currentDate.add(Duration(days: 1));
  }
  print(count);
  return count;
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  String getRecurrenceRule(int index) {
    return appointments![index].recurrenceRule;
  }
}

class Meeting {
  Meeting(
      {this.eventName = '',
      required this.from,
      required this.to,
      required this.background,
      this.isAllDay = false,
      this.recurrenceRule});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? recurrenceRule;
}
