import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/TodoServices/todoModel.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/todo_provider.dart';
import 'package:todoapp/widgets/big_text.dart';
import 'package:todoapp/widgets/small_text.dart';
import 'package:todoapp/widgets/todo_list.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);



  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late Future<List<TodoModel>> _getData;

  Future<List<TodoModel>> getTodoList() async {
    List<TodoModel> todoList = await TodoProvider.getData();
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
      appBar: AppBar(
        title: BigText(text: "Tasks", color: Colors.blueAccent,),
      ),
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
                  return  Container(
                        padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                        height: double.maxFinite,
                        width: double.maxFinite,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              SingleChildScrollView(
                                child: ListView.builder(itemBuilder: (context,index){
                                  return TodoList(
                                    title: snaphot.data![index].todoTitle!, 
                                    date: snaphot.data![index].todoDeadline!, 
                                    status: snaphot.data![index].status!);
                                }),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.width20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  color: Colors.black26
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(text: "Add a Task", color: Colors.blueAccent,),
                                    Icon(Icons.add, color: Colors.blueAccent)
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
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black26,
            unselectedItemColor: Colors.black87,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), 
              backgroundColor: Colors.black87,
              label: 'All'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Completed'),
              BottomNavigationBarItem(icon: Icon(Icons.circle_outlined,), label: 'InComplete')
             ])
                  
    );
    
  }
}
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