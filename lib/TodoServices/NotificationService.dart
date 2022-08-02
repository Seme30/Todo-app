import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/constants/app_constants.dart';
import 'package:todoapp/utils/date_and_time_picker.dart';

class NotificationService {
  DateTimePicker dateTimePicker = DateTimePicker();

  Future<void> createTodoReminderNotification(
      DateTime dateTime, TodoModel todo) async {
    print('date ${dateTime.minute}');

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: AppConstants.createUniqueId(),
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

  Future<void> createTodo1hourReminderNotification(
      DateTime dateTime, TodoModel todo) async {
    DateTime h1our = dateTime.subtract(Duration(hours: 1));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: AppConstants.createUniqueId(),
        channelKey: 'scheduled_channel',
        title: 'You have a Task to do',
        body: '1 hour remaining for ${todo.todoTitle}',
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
        hour: h1our.hour,
        minute: dateTime.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
    );

    Future<void> cancelScheduledNotifications() async {
      await AwesomeNotifications().cancelAllSchedules();
    }
  }
}
