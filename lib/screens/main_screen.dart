import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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
  String selectedDateTime = 'Select deadline';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future refreshTodos(TodoProvider todoProvider) async {
    final todos = await TodoDatabase.instance.readAllTodos();
    todoProvider.setTodos(todos);
  }

  @override
  void dispose() {
    TodoDatabase.instance.close();
    super.dispose();
  }

  Future<dynamic> showModal(BuildContext con, TodoProvider todoProvider) {
    DateTimePicker dateTimePicker = DateTimePicker();

    return showModalBottomSheet(
        context: con,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
                left: Dimensions.width15,
                right: Dimensions.width15,
                top: Dimensions.height10),
            decoration: BoxDecoration(color: AppColors.mainColor),
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
                      IconButton(
                          onPressed: () async {
                            await dateTimePicker.selectDateTime(con);
                            setState(() {
                              selectedDateTime = dateTimePicker.getDateTime();
                            });
                          },
                          icon: Icon(Icons.calendar_today_outlined)),
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
                    creatingTodos(todo);
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

  void creatingTodos(todo) async {
    await TodoDatabase.instance.createTodo(todo, context);
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    refreshTodos(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: 'Tasks',
          color: Colors.blueAccent,
        ),
        elevation: 0,
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
        height: MediaQuery.of(context).size.height,
        width: double.maxFinite,
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: Dimensions.height30),
            todoProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : todoProvider.todos.isEmpty
                    ? BigText(
                        text: 'No Todos',
                        color: AppColors.textColor,
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            height: Dimensions.height45 * 10,
                            child: ListView.builder(
                                itemCount: todoProvider.todos.length,
                                itemBuilder: (context, index) {
                                  return TodoList(
                                      title:
                                          todoProvider.todos[index].todoTitle!,
                                      date: todoProvider
                                          .todos[index].todoDeadline!,
                                      status:
                                          todoProvider.todos[index].status!);
                                }),
                          ),
                        ),
                      ),
            Container(
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
                  GestureDetector(
                      onTap: () {
                        showModal(context, todoProvider);
                      },
                      child: Icon(Icons.add, color: AppColors.textColor)),
                ],
              ),
            ),
          ],
        ),
      ),

      //  bottomNavigationBar: BottomNavigationBar(

      //     backgroundColor: AppColors.mainColor,
      //       // fixedColor: AppColors.textColor2,
      //       type: BottomNavigationBarType.fixed,
      //       selectedItemColor: AppColors.textColor,
      //       unselectedItemColor: AppColors.textColor2,
      //       currentIndex: 0,
      //       items: const [
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.list,color: AppColors.iconColor1,),
      //         label: 'All'
      //         ),
      //         BottomNavigationBarItem(icon: Icon(Icons.circle, color: AppColors.iconColor1), label: 'Completed'),
      //         BottomNavigationBarItem(icon: Icon(Icons.circle_outlined,color: AppColors.iconColor1), label: 'InComplete')
      //        ])
    );
  }
}

// ListView(
//                                     children: snaphot.data!.map((e){
//                                     return TodoList(title: e.todoTitle!, date: e.todoDeadline!, status: e.status!);
//                                   }).toList(),
//                                   )
// Container(
//         padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.width20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Icon(Icons.list),
//                 SmallText(text: 'All',),
//               ],
//             ),
//             Column(
//               children: [
//                 Icon(Icons.circle),
//                 SmallText(text: 'Complted',),
//               ],
//             ),
//             Column(
//               children: [
//                 Icon(Icons.circle_outlined),
//                 SmallText(text: 'Incomplete',),
//               ],
//             )
//           ],
//         ),
//       ),
