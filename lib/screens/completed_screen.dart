import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/todoController.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/todo_list.dart';


class CompletedScreen extends StatefulWidget {

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
      padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height45),
        height: MediaQuery.of(context).size.height,
       width: double.maxFinite,
       decoration: BoxDecoration(color: AppColors.mainColor),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
             BigText(text: 'Tasks', color: Colors.blueAccent,),
             SizedBox(height:Dimensions.height30),
             GetBuilder<TodoController>(builder: (todoController){
              return todoController.isLoaded? Center(child: CircularProgressIndicator()):
                  Expanded(
                    child: SingleChildScrollView(
                        child: Container(
                          height: Dimensions.height450,
                          child: ListView.builder(
                            itemCount: todoController.todoList.length,
                            itemBuilder: (context,index){
                          return todoController.completedTodoList.isEmpty? 
                            Center(child: BigText(text: 'There is nothing here', color: AppColors.textColor,),) :
                            TodoList(
                              title: todoController.completedTodoList[index].todoTitle!, 
                              date: todoController.completedTodoList[index].todoDeadline!, 
                              status: todoController.completedTodoList[index].status!);
                      }),
                        ),
                    ),
                  );
            }),
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
