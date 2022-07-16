import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/todoController.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/todo_list.dart';


class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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
             GetBuilder<TodoController>(builder: (todoController){
              return todoController.todoList.isEmpty? CircularProgressIndicator():BigText(text: todoController.todoList[0].todoCreatedDate!, color: Colors.blueAccent,);}),
             SizedBox(height:Dimensions.height30),
            //  Expanded(
            //    child: todoList.isEmpty ? CircularProgressIndicator() : SingleChildScrollView(
            //        child: Container(
            //          height: 450,
            //          child: ListView.builder(
            //            itemCount: todoList.length,
            //            itemBuilder: (context,index){
            //          return TodoList(
            //            title: todoList[index].todoTitle!, 
            //            date: todoList[index].todoDeadline!, 
            //            status: todoList[index].status!);
            //      }),
            //        ),
                 
            //    ),
            //  ),
             Container(
               padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.width20),
               margin: EdgeInsets.only(bottom: Dimensions.height30),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(Dimensions.radius15),
                 color: AppColors.secColor
               ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(text: "Add a Task", color: AppColors.textColor),
                      Icon(Icons.add, color: AppColors.textColor),
                    ],
                  ),
                ),
            ],  
          ),
        ),
       bottomNavigationBar: BottomNavigationBar(
        
          backgroundColor: AppColors.mainColor,
            // fixedColor: AppColors.textColor2,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.textColor,
            unselectedItemColor: AppColors.textColor2,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list,color: AppColors.iconColor1,), 
              label: 'All'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.circle, color: AppColors.iconColor1), label: 'Completed'),
              BottomNavigationBarItem(icon: Icon(Icons.circle_outlined,color: AppColors.iconColor1), label: 'InComplete')
             ])
                  
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