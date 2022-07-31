import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/DateProvider.dart';
import 'package:todoapp/TodoServices/NotificationService.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoProvider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/utils/date_and_time_picker.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/text_field.dart';
import 'package:todoapp/widgets/todo_list.dart';
import 'package:intl/intl.dart';

class AllScreen extends StatefulWidget {
  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  TextEditingController titleController = TextEditingController();
  String selectedDateTime = 'Schedule task';
  NotificationService notificationService = NotificationService();
  DateTime schedule = DateTime.now();
  late TodoModel thisTodo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Notification Created on ${notification.channelKey}',
        ),
      ));
    });

    AwesomeNotifications().actionStream.listen((notification) async {
      if (notification.channelKey == 'scheduled_channel') {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
        final todo = Provider.of<TodoProvider>(context, listen: false)
            .getTodo(notification.id!);
        todo.status = "Completed";
        await TodoDatabase.instance.update(todo);
      }
    });
  }

  Future refreshTodos(TodoProvider todoProvider) async {
    final todos = await TodoDatabase.instance.readAllTodos();
    todoProvider.setTodos(todos);
  }

  @override
  void dispose() {
    TodoDatabase.instance.close();
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  Future<dynamic> showModal(BuildContext con) {
    DateTimePicker dateTimePicker = DateTimePicker();
    return showModalBottomSheet(
        context: con,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
                left: Dimensions.width15,
                right: Dimensions.width15,
                top: Dimensions.height10),
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                border: Border.all(color: AppColors.iconColor1, width: 2)),
            child: Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFieldBuilder(
                  validator: 'please add task title',
                  controller: titleController,
                  labelText: 'Task Title',
                  obsecureText: false,
                ),
                SizedBox(
                  height: Dimensions.width20,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                      bottom: Dimensions.width20),
                  padding: EdgeInsets.symmetric(vertical: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.secColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: selectedDateTime,
                        color: AppColors.textColor,
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.height15,
                            vertical: Dimensions.height10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.iconColor1,
                        ),
                        child: IconButton(
                            onPressed: () async {
                              await dateTimePicker.selectDateTime(
                                context,
                              );
                              setState(() {
                                selectedDateTime = dateTimePicker
                                    .getDateTime()
                                    .substring(0, 10);
                                schedule = dateTimePicker.getDateTime2();
                              });
                            },
                            icon: Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.textColor,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.width20,
                ),
                InkWell(
                  onTap: () {
                    final todo = TodoModel(
                        todoTitle: titleController.text,
                        todoDeadline: selectedDateTime,
                        todoCreatedDate: DateFormat('yyyy-MM-dd HH: ss a')
                            .format(DateTime.now()),
                        status: 'Incomplete');
                    print(todo.todoTitle);
                    creatingTodos(todo, context, schedule);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width30,
                        right: Dimensions.width30,
                        bottom: Dimensions.width20),
                    padding: EdgeInsets.symmetric(vertical: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.secColor),
                    child: Center(
                        child: BigText(
                            text: "Add Task", color: AppColors.textColor)),
                  ),
                ),
              ],
            )),
          );
        });
  }

  void creatingTodos(todo, BuildContext con, DateTime schedule) async {
    thisTodo = await TodoDatabase.instance.createTodo(todo, con, schedule);
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    DateProvider date = Provider.of<DateProvider>(context, listen: true);
    refreshTodos(todoProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secColor,
        title: BigText(
          text: 'Tasks',
          color: AppColors.textColor,
        ),
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SigninScreen()),
                    (route) => false);
              },
              icon: Container(
                  padding: EdgeInsets.all(Dimensions.height10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.iconColor1),
                  child: Icon(Icons.logout_outlined)),
              iconSize: Dimensions.iconSize16),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20),
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: Dimensions.height10),
            todoProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : todoProvider.todos.isEmpty
                    ? BigText(
                        text: 'No Todos',
                        color: AppColors.textColor,
                      )
                    : Container(
                        height: Dimensions.height45 * 10,
                        width: Dimensions.screenWidth,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              itemCount: todoProvider.todos.length,
                              itemBuilder: (context, index) {
                                return TodoList(
                                    title: todoProvider.todos[index].todoTitle!,
                                    date: date.dateTime[thisTodo.id]!,
                                    status: todoProvider.todos[index].status!);
                              }),
                        ),
                      ),
            Container(
              height: Dimensions.height45 + Dimensions.height54,
              width: Dimensions.screenWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20, vertical: Dimensions.width20),
              margin: EdgeInsets.only(bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color: AppColors.secColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: "Add a Task", color: AppColors.textColor),
                  IconButton(
                      onPressed: () async {
                        await showModal(context);
                        await notificationService
                            .createTodoReminderNotification(schedule, thisTodo);
                      },
                      icon: Icon(Icons.add),
                      color: AppColors.textColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
