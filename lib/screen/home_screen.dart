import 'package:flutter/material.dart';
import 'package:mytodo_list/constants/gaps.dart';
import 'package:mytodo_list/widget/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Todo> myTodo = [];
  int _baseid = 1;
  TextEditingController _titleCon = TextEditingController();
  TextEditingController _detailCon = TextEditingController();

  @override
  void dispose() {
    _titleCon.dispose();
    _detailCon.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void add_base() {
    _baseid += 1;
  }

  void FlutterDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text("할일 추가"),
            content: Container(
                height: 170,
                child: Column(children: [
                  TextField(
                    controller: _titleCon,
                    decoration: const InputDecoration(hintText: "할일"),
                  ),
                  TextField(
                    controller: _detailCon,
                    decoration: const InputDecoration(hintText: "설명"),
                  ),
                  Gaps.v14,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            ComMkJob(_baseid, _titleCon.text, _detailCon.text);
                            _titleCon.clear();
                            _detailCon.clear();
                          },
                          child: Text("저장")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _titleCon.clear();
                            _detailCon.clear();
                          },
                          child: Text("삭제")),
                    ],
                  )
                ])),
          );
        });
  }

  void ComMkJob(int id, String title, String detail) {
    setState(() {
      myTodo.add(Todo(
        id: id,
        title: title,
        detail: detail,
      ));
      add_base();
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo List",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: BuildList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: FlutterDialog,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }

  Widget? BuildList() {
    if (myTodo.isEmpty) {
      return const Center(child: Text("할일을 추가해주세요.."));
    } else {
      return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Gaps.v20;
        },
        itemBuilder: (BuildContext context, int idx) {
          return Todo(
            id: idx,
            title: myTodo[idx].title,
            detail: myTodo[idx].detail,
          );
        },
        itemCount: myTodo.length,
      );
    }
  }
}
