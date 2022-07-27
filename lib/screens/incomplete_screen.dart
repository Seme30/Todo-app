import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/todoDatabase.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/screens/sign_in_screen.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/todo_list.dart';

class InCompletedScreen extends StatefulWidget {
  @override
  State<InCompletedScreen> createState() => _InCompletedScreenState();
}

class _InCompletedScreenState extends State<InCompletedScreen> {
  late List<TodoModel> todos;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshTodos();
  }

  Future refreshTodos() async {
    setState(() => isLoading = true);

    todos = await TodoDatabase.instance.readAllTodos();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
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
            BigText(
              text: 'Tasks',
              color: Colors.blueAccent,
            ),
            SizedBox(height: Dimensions.height30),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : todos.isEmpty
                    ? BigText(text: 'No Todos')
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            height: Dimensions.height45 * 10,
                            child: ListView.builder(
                                itemCount: todos.length,
                                itemBuilder: (context, index) {
                                  return TodoList(
                                      title: todos[index].todoTitle!,
                                      date: todos[index].todoDeadline!,
                                      status: todos[index].status!);
                                }),
                          ),
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
