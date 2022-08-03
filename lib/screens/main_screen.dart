import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/NotificationService.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoProvider.dart';
import 'package:todoapp/constants/app_constants.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/screens/Add_todo_screen.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/utils/date_and_time_picker.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/todo_list.dart';

class AllScreen extends StatefulWidget {
  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  NotificationService notificationService = NotificationService();
  // late TodoModel thisTodo;
  // String taskTitle = '';

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
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(
      //     'Notification Created on ${notification.channelKey}',
      //   ),
      // ));
    });

    AwesomeNotifications().actionStream.listen((notification) async {
      if (notification.channelKey == 'scheduled_channel') {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }
    });
  }

  @override
  void dispose() {
    TodoDatabase.instance.close();
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TodoProvider>(context, listen: false).readTodos();
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);

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
            top: Dimensions.height10),
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
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: todoProvider.todos.length,
                            itemBuilder: (context, index) {
                              return TodoList(
                                id: todoProvider.todos[index].id!,
                                title: todoProvider.todos[index].todoTitle!,
                                date: todoProvider.todos[index].todoDeadline!,
                                status: todoProvider.todos[index].status!,
                              );
                            }),
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => AddTodoScreen(),
                        ));
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
