import 'package:flutter/cupertino.dart';
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

  void deleteList(int i) {
    setState(() {
      myTodo.removeAt(i);
    });
  }

  void modifyTodo(int idx) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text("할일 수정"),
            content: Container(
                height: 170,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _titleCon =
                            new TextEditingController(text: myTodo[idx].title),
                      ),
                      TextField(
                        controller: _detailCon =
                            new TextEditingController(text: myTodo[idx].detail),
                      ),
                      Gaps.v16,
                      CupertinoButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              myTodo[idx].title = _titleCon.text;
                              myTodo[idx].detail = _detailCon.text;
                            });
                            _titleCon.clear();
                            _detailCon.clear();
                            Navigator.of(context).pop();
                          },
                          child: Text("저장"))
                    ])),
          );
        });
  }

  void flutterdialog() {
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _titleCon,
                        decoration: const InputDecoration(hintText: "할일"),
                      ),
                      TextField(
                        controller: _detailCon,
                        decoration: const InputDecoration(hintText: "설명"),
                      ),
                      Gaps.v16,
                      CupertinoButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (_titleCon.text.length != 0 &&
                                _detailCon.text.length != 0) {
                              makeTodo(
                                  _baseid, _titleCon.text, _detailCon.text);
                              _titleCon.clear();
                              _detailCon.clear();
                              print("할일생성");
                            } else {}
                          },
                          child: Text("저장"))
                    ])),
          );
        });
  }

  void makeTodo(int id, String title, String detail) {
    setState(() {
      myTodo.add(Todo(
        deletel: deleteList,
        myid: id,
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
          onPressed: flutterdialog,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }

  Widget? BuildList() {
    if (myTodo.isEmpty) {
      return const Center(
          child: Text(
        "할일을 추가해주세요....",
        style: TextStyle(fontSize: 20),
      ));
    } else {
      return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Gaps.v20;
        },
        itemBuilder: (BuildContext context, int idx) {
          return GestureDetector(
            onTap: () => modifyTodo(idx),
            child: Todo(
              deletel: deleteList,
              myid: idx,
              title: myTodo[idx].title,
              detail: myTodo[idx].detail,
            ),
          );
        },
        itemCount: myTodo.length,
      );
    }
  }
}
