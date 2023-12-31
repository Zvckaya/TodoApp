import 'package:flutter/material.dart';
import 'package:mytodo_list/screen/home_screen.dart';

class Todo extends StatefulWidget {
  final Function(int) deletel;
  Todo(
      {super.key,
      required this.myid,
      required this.title,
      required this.detail,
      required this.deletel});
  int myid;
  String title;
  String detail;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool check = false;

  void toggleBool() {}

  @override
  Widget build(BuildContext context) {
    HomeState? home = context.findAncestorStateOfType<HomeState>();
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Checkbox(
              value: check,
              onChanged: (value) {
                setState(() {
                  check = value!;
                });
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        decoration: check
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  )
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (check == true) {
                  widget.deletel(widget.myid);
                } else {}
              },
              icon: const Icon(
                Icons.delete_forever,
                size: 30,
              ))
        ]),
      ),
    );
  }
}
