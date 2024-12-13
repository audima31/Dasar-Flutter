import 'package:belajar_dasar_individu/models/todo.dart';
import 'package:flutter/material.dart';

class TodoListClass extends StatefulWidget {
  const TodoListClass({required this.todosData, super.key});

  final List<TodoModel> todosData;

  @override
  State<TodoListClass> createState() => _TodoListClassState();
}

class _TodoListClassState extends State<TodoListClass> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.todosData.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: widget.todosData[index].priority.color.withOpacity(0.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.todosData[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.todosData[index].description,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: widget.todosData[index].priority.color,
                    ),
                    child: SizedBox(
                      width: 80,
                      child: Center(
                        child: Text(
                          widget.todosData[index].priority.title,
                          style: TextStyle(
                            backgroundColor:
                                widget.todosData[index].priority.color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
