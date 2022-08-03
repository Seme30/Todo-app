import 'package:flutter/material.dart';
import 'package:todoapp/TodoServices/NotificationService.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/constants/app_constants.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/utils/date_and_time_picker.dart';
import 'package:todoapp/widgets/big_text.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController titleController = TextEditingController();
  String selectedDateTime = 'Schedule task';
  DateTime schedule = DateTime.now();
  DateTimePicker dateTimePicker = DateTimePicker();
  final int _newId = AppConstants.createUniqueId();
  NotificationService notificationService = NotificationService();

  void creatingTodos(todo, BuildContext con, DateTime schedule) async {
    print('creating todo');
    await TodoDatabase.instance.createTodo(todo, con);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Task Added',
      ),
    ));
    await notificationService.createTodoReminderNotification(schedule, todo);
    await notificationService.createTodo1hourReminderNotification(
        schedule, todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.secColor,
          title: BigText(
            text: 'Add Task',
            color: AppColors.textColor,
          ),
          elevation: 2,
          centerTitle: true,
        ),
        body: Container(
          height: Dimensions.screenHeight,
          width: Dimensions.screenWidth,
          padding: EdgeInsets.only(
              left: Dimensions.width15,
              right: Dimensions.width15,
              top: Dimensions.height10),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
          ),
          child: Center(
            child: Card(
              elevation: 5,
              color: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                side: BorderSide(width: 2, color: AppColors.iconColor1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.height20 * 2,
                        vertical: Dimensions.height20),
                    height: Dimensions.height20 * 6,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                      controller: titleController,
                      obscureText: false,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: Dimensions.font16,
                      ),
                      decoration: InputDecoration(
                          labelText: "Task Title",
                          labelStyle: TextStyle(
                            color: AppColors.iconColor1,
                            fontSize: Dimensions.font16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            borderSide: BorderSide(
                                width: 1.5, color: AppColors.iconColor1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.height15),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.textColor),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.width20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width30,
                        right: Dimensions.width30,
                        bottom: Dimensions.width20),
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.width20,
                        horizontal: Dimensions.width10),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
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
                                      .toString()
                                      .substring(0, 10);
                                  schedule = dateTimePicker.getDateTime();
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
                          id: _newId,
                          todoTitle: titleController.text,
                          todoDeadline: schedule,
                          todoCreatedDate: DateTime.now(),
                          status: 'Incomplete');
                      print(todo.todoTitle);
                      creatingTodos(todo, context, schedule);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width30,
                          right: Dimensions.width30,
                          bottom: Dimensions.width20),
                      padding:
                          EdgeInsets.symmetric(vertical: Dimensions.width20),
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
              ),
            ),
          ),
        ));
  }
}
