import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoProvider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/todo_list.dart';

class InCompletedScreen extends StatefulWidget {
  @override
  State<InCompletedScreen> createState() => _InCompletedScreenState();
}

class _InCompletedScreenState extends State<InCompletedScreen> {
  // late List<TodoModel> todos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoProvider>(context);
    List<TodoModel> incompletedList = [];
    for (var element in todos.todos) {
      if (element.status == 'Incomplete') {
        incompletedList.add(element);
      }
    }
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
            top: Dimensions.height45),
        height: Dimensions.screenHeight,
        width: double.maxFinite,
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.height10),
            incompletedList.isEmpty
                ? Container(child: Center(child: BigText(text: 'No Todos')))
                : Container(
                    height: Dimensions.height45 * 10,
                    child: Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: incompletedList.length,
                          itemBuilder: (context, index) {
                            return TodoList(
                              id: incompletedList[index].id!,
                              title: incompletedList[index].todoTitle!,
                              date: incompletedList[index].todoDeadline!,
                              status: incompletedList[index].status!,
                            );
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
