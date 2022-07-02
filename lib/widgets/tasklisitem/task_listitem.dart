import 'package:flutter/material.dart';
import '../../../models/tasks/task.dart';
import 'package:flutter/cupertino.dart';

class TaskListItem extends StatefulWidget {

  final Task? task;
  final Function? updateTaskState;
  const TaskListItem({ Key? key, required this.task, required this.updateTaskState}) : super(key: key);

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  late bool? checkedValue;

  @override
  void initState() {
    super.initState();
    checkedValue = widget.task!.isCompleted;

  }

  @override
  Widget build(BuildContext context) {
    if (widget.task != null) {
      return Container(
          height: 220,
          margin: EdgeInsets.only(right: 18, left: 18, bottom: 10),
          child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: 100,
                    minWidth: 100
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: SizedBox()),
                    Text(widget.task!.title!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10,),
                    Text(widget.task!.description!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500), maxLines: 10, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 20,),
                    Text(widget.task!.translatedTitle!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10,),
                    Text(widget.task!.translatedDescription!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500), maxLines: 10, overflow: TextOverflow.ellipsis),
                    _showStateCheckbox(),
                    Expanded(child: SizedBox()),
                  ],
                ),
              )

          )
      );
    }
    else{
      return SizedBox(height: 10,);
    }
  }

  Widget _showStateCheckbox(){
    return CheckboxListTile(
      title: Text("Tarea completada"),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
          widget.updateTaskState!(widget.task?.documentId, checkedValue);
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}





/*
class TaskListItem extends StatelessWidget
{
  Task? task;
  TaskListItem(this.task);
  @override
  Widget build(BuildContext context) {
    if (task != null) {
      return Container(
          height: 200,
          margin: EdgeInsets.only(right: 18, left: 18, bottom: 10),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 100,
                  minWidth: 100
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: SizedBox()),
                    Text(task!.title!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10,),
                    Text(task!.description!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500), maxLines: 10, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 20,),
                    Text(task!.translatedTitle!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10,),
                    Text(task!.translatedDescription!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500), maxLines: 10, overflow: TextOverflow.ellipsis),
                    _showStateCheckbox(),
                    Expanded(child: SizedBox()),
                  ],
                ),
            )

          )
      );
    }
    else{
      return SizedBox(height: 10,);
    }
  }


}
 */


