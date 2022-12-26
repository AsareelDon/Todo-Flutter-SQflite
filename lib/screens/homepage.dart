import 'package:flutter/material.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/edit_todo.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Controller conn = Controller();
  bool isUpdated = false;
  int? curId;
  @override
  void initState() {
    super.initState();
    loadUpdates();
  }
  void updateTodo(Todo todo) async {
    await conn.updateRow(todo);
  }
  void addTodo(Todo todo) async {
    await conn.insertData(todo);
    setState(() {});
  }
  deleteTodo(int rowId) async{
    await conn.deleteRow(rowId);
    setState(() {});
  }

  Future<List> loadUpdates() async{
    setState(() {
      isUpdated = true;
    });
    var response = await conn.fetchData();
    setState(() {
      isUpdated = false;
    });
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal,
            Color(0xFFB2EBF2),
          ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Todo", style: TextStyle(color: Colors.white, fontSize: 27,),),
            backgroundColor: Colors.teal.shade800,
            shape: const Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 2
              ),
            ),
            elevation: 0,
          ),
        body: Center(
          child: Expanded(
            child: FutureBuilder(
              future: conn.fetchData(),
              initialData: const [],
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                var todoList = snapshot.data!;
                var todo = todoList.length;
                return todo == 0 ? Center(
                  //widgets that will show if there's no data on table
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assests/image/nodata.png"),
                        height: 40,
                        width: 40,
                        colorBlendMode: BlendMode.modulate,
                      ),
                      Text('No Todo')
                    ],
                  ),
                ) : ListView.builder(
                  itemCount: todo,
                  itemBuilder: (context, item) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Card(
                        color: Colors.grey.shade500,
                        child: const Icon(Icons.delete),
                      ),
                      onDismissed: (DismissDirection direction) async{
                        setState(() {
                          deleteTodo(todoList[item]['id']);
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                        elevation: 10,
                        color: Colors.blue.shade50,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(
                            vertical: 3,
                            horizontal: 0,
                          ),
                          title: Text(todoList[item]['title']),
                          subtitle: Text(todoList[item]['timestamp']),
                          onTap: () async{
                            await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditTodo(title: "Update Todo", cursor: todoList[item])));
                            loadUpdates();
                          }
                        ),
                      ),
                    );
                  }
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade400,
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodo(title: "New Todo", insertData: addTodo)));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: const <Widget>[
                  Icon(Icons.edit_note, size: 40, color: Colors.white,),
                  Text('Todo', style: TextStyle(fontSize: 11, color: Colors.white),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}