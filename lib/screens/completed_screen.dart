import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/TodoServices/todoProvider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/todo_list.dart';

class CompletedScreen extends StatefulWidget {
  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  // late List<TodoModel> todos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TodoProvider>(context, listen: false).readTodos();
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    List<TodoModel> todoList = [];
    for (var element in todoProvider.todos) {
      if (element.status == 'Completed') {
        todoList.add(element);
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
        width: Dimensions.screenWidth,
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.height10),
            todoList.isEmpty
                ? Container(child: Center(child: BigText(text: 'No Todos')))
                : Container(
                    height: Dimensions.height45 * 10,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: todoList.length,
                          itemBuilder: (context, index) {
                            return TodoList(
                              id: todoList[index].id!,
                              title: todoList[index].todoTitle!,
                              date: todoList[index].todoDeadline!,
                              status: todoList[index].status!,
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
