import 'package:flutter/material.dart';
import '../widgets/todo_list.dart';


class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Lists',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () {},
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(children: [
        Container(
          height: (MediaQuery.of(context).size.height * 0.91),
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Text('No Data');
            },
            itemCount: 1,
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: IconButton(
      //           onPressed: () {},
      //           icon: Icon(Icons.mic),
      //         ),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: TextField(
      //           decoration: InputDecoration(
      //             label: Text('Enter a Quick Task here'),
      //           ),
      //         ),
      //       )
      //     ]),
    );
  }
}
