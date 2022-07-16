import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/todo_provider.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/todo_list.dart';


class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late Future<List<TodoModel>> _getData;
  TodoProvider todoProvider = TodoProvider();

  Future<List<TodoModel>> getTodoList() async {
    final todoList = await todoProvider.getData();
    return todoList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData = getTodoList();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder<List<TodoModel>>(
        future: _getData,
        builder: (context,snaphot){
          switch(snaphot.connectionState){
            case ConnectionState.waiting:{
              return CircularProgressIndicator();
            }
            case ConnectionState.active: {
              return CircularProgressIndicator();
            }
            case ConnectionState.done: {
              if(snaphot.hasData){
                final todos = todoProvider.todoModeList;
                  return  Container(
                        padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height45),
                        height: MediaQuery.of(context).size.height,
                        width: double.maxFinite,
                        decoration: BoxDecoration(color: AppColors.mainColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              BigText(text: "Tasks", color: Colors.blueAccent,),
                              SizedBox(height:Dimensions.height30),
                              Expanded(
                                child: SingleChildScrollView(
                                    child: Container(
                                      height: 450,
                                      child: ListView.builder(
                                        itemCount: todos.length,
                                        itemBuilder: (context,index){
                                      return TodoList(
                                        title: todos[index].todoTitle!, 
                                        date: todos[index].todoDeadline!, 
                                        status: todos[index].status!);
                                  }),
                                    ),
                                  
                                ),
                              ),
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
                                    Icon(Icons.add, color: AppColors.textColor)
                                  ],
                                ),
                              ),
                        
                          ],  
                          
                        ),
                      );
              }else{
                return Text('No Data');
              }
              
            }
            default: return Text(snaphot.error.toString());
          }
  
        },
      ),
       bottomNavigationBar: BottomNavigationBar(
        
          backgroundColor: AppColors.mainColor,
            // fixedColor: AppColors.textColor2,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.textColor,
            unselectedItemColor: AppColors.textColor2,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list,color: AppColors.iconColor1,), 
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