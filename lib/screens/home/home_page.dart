import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:todo_app/screens/home/home_bloc.dart';
import '../../models/tasks/task.dart';
import '../../utils/alerts.dart';
import '../../widgets/emptystate/empty_state.dart';
import '../../widgets/tasklisitem/task_listitem.dart';


class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  bool _refreshPage = false;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    _homeBloc.user = widget.user;

    Stream reloadStream = _homeBloc.reloadStream.stream;
    reloadStream.listen((value) {
      if (value) {
        setState(() {
          _refreshPage = true;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tareas de ${_homeBloc.user!.displayName!}"),
          ),
          body: _showMainContent(),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              newTaskAlert(context, _homeBloc.translate);
            },
            tooltip: 'Nueva tarea',
            child: const Icon(Icons.add),
          ),
        ),

        bloc: _homeBloc
    );
  }

  Widget _showMainContent(){
    return FutureBuilder<List<Task>>(
        future: _homeBloc.getTasks(),
        builder: (context,snapshot){
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done)  {
            if(snapshot.data!.length > 0){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(snapshot.data![index].documentId!),
                    onDismissed: (direction) {
                      _homeBloc.deleteTask(snapshot.data![index].documentId!);
                      setState(() {
                        snapshot.data!.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tarea eliminada")));
                    },
                    child:  TaskListItem(task: snapshot.data![index], updateTaskState: _homeBloc.updateTaskState,),
                  );
                },
              );
            }
            else{
              return EmptyState(title: "Lista vacia, agrega tu primera tarea haciendo click en el botón +");
            }
          }
          else {
            return Center(
                child: CircularProgressIndicator()
            );
          }
        }
    );
  }


}