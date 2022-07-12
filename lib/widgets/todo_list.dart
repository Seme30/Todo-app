import 'package:flutter/material.dart';


class TaskList extends StatelessWidget {
  final String title;
  final DateTime date;
  final int number;

  const TaskList(this.title, this.date, this.number);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          borderOnForeground: true,
          color: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              child: Text('$number'),
            ),
            title: Text(title),
            subtitle: Text('$date'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
