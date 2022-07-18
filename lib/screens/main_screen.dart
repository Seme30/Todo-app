import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/todoController.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/route_helper.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/todo_list.dart';


class AllScreen extends StatefulWidget {

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: 'Tasks', color: Colors.blueAccent,),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
          onPressed: (){
            Get.toNamed(RouteHelper.signinScreen);
          }, 
          icon: Container(
              padding: EdgeInsets.all(Dimensions.height10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.iconColor1
              ),
              child: Icon(Icons.logout_outlined)),
              iconSize: Dimensions.iconSize16
          ),
        ],
      ),
      body: Container(
      padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height45),
        height: MediaQuery.of(context).size.height,
       width: double.maxFinite,
       decoration: BoxDecoration(color: AppColors.mainColor),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
             SizedBox(height:Dimensions.height30),
             GetBuilder<TodoController>(builder: (todoController){
              return todoController.isLoaded?
                  Expanded(
                    child: SingleChildScrollView(
                        child: Container(
                          height: Dimensions.height450,
                          child: ListView.builder(
                            itemCount: todoController.todoList.length,
                            itemBuilder: (context,index){
                          return todoController.todoList.isEmpty? 
                            Center(child: Row(
                              children: [
                                BigText(text: 'There is no Task yet', color: AppColors.textColor,),
                                BigText(text: 'Add a new Task', color: AppColors.textColor,)
                              ],
                            ),)
                            :TodoList(
                              title: todoController.todoList[index].todoTitle!, 
                              date: todoController.todoList[index].todoDeadline!, 
                              status: todoController.todoList[index].status!);
                      }),
                        ),
                    ),
                  ) : Center(child: CircularProgressIndicator());
            }),
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
                      GestureDetector(
                        onTap: (){},
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