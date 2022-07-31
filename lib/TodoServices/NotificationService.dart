import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/utils/date_and_time_picker.dart';

class NotificationService {
  DateTimePicker dateTimePicker = DateTimePicker();

  Future<void> createTodoReminderNotification(
      DateTime dateTime, TodoModel todo) async {
    print('date ${dateTime.minute}');

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: todo.id!,
        channelKey: 'scheduled_channel',
        title: 'You have a Task to do',
        body: 'you have to ${todo.todoTitle}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark Done',
          buttonType: ActionButtonType.Default,
        ),
      ],
      schedule: NotificationCalendar(
        weekday: dateTime.weekday,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
    );
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
