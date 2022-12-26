import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/models/todo_model.dart';

class EditTodo extends StatefulWidget {
  final dynamic cursor;
  final String title;
  const EditTodo({Key? key, this.cursor, required this.title}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  Controller conn = Controller();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  var uniqueKey = GlobalKey<FormState>();
  var curId;
  bool? isUpdate;

  @override
  void initState() {
    super.initState();
    title.text = widget.cursor['title'];
    description.text = widget.cursor['description'];
    curId = widget.cursor['id'];
    isUpdate = true;
  }
  void updateTodo(Todo todo) async {
    await conn.updateRow(todo);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal.shade800,
        elevation: 3,
      ),
      body: Form(
        key: uniqueKey,
        child: SizedBox(
          height: 300,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  "What's on your mind?",
                  style: TextStyle(
                    fontSize: 27,
                    color: Color(0xFF004D40),
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: "e.g Goto Barbershop",
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.teal
                      )
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (input){
                    return (input == "") ? "Required Field!" : null;
                  },
                ),
              ),
              // description will be optional since its just a todo
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 15),
                child: TextFormField(
                  maxLines: 5,
                  minLines: 1,
                  controller: description,
                  decoration: InputDecoration(
                    hintText: "write something about your todos",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.teal
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                  child: const Text("Submit"),
                  onPressed: () async{
                    var isValid = uniqueKey.currentState!.validate();
                    if(isValid){
                      setState(() {
                        var stamp = DateFormat.yMMMEd().format(DateTime.now());
                        var todo = Todo(id: curId, title: title.text, status: false, description: description.text, datestamp: stamp.toString());
                        updateTodo(todo);
                        // to see if the row is change
                        print(todo.toString());
                        Navigator.pop(context, isUpdate);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
