import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:todo_app/screens/home/home_bloc.dart';
import '../../utils/alerts.dart';


class HomePage extends StatefulWidget {

  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  bool _isLoading = false;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    _homeBloc.user = widget.user;

    //region Streams

    Stream navigationStream = _homeBloc.navigationStream.stream;
    navigationStream.listen((value) {

    });

    Stream showLoadingStream = _homeBloc.showLoadingStream.stream;
    showLoadingStream.listen((value) {
      _showLoading(value);
    });

    //endregion
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tareas de ${_homeBloc.user!.displayName!}"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              newTaskAlert(context, _homeBloc.startCreateCollection);
            },
            tooltip: 'Nueva tarea',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),

        bloc: _homeBloc
    );

  }

  void _showLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

}