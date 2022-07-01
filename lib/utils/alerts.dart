import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

successAlert(BuildContext context, String description, {Function? onAcceptTap = null}) {
  Alert(
    context: context,
    type: AlertType.info,
    title: "Alerta",
    desc: description,
    buttons: [
      DialogButton(
        child: Text(
          "Aceptar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          if (onAcceptTap != null) {
            onAcceptTap();
          }
        },
        width: 120,
      )
    ],
  ).show();
}

newTaskAlert(BuildContext context, Function? onSaveTap) {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Alert(
      context: context,
      title: "Nueva tarea",
      content: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Titulo',
            ),
          ),
          TextField(
            controller: _descriptionController,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Descripción',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => {
            Navigator.of(context, rootNavigator: true).pop(),
            if (onSaveTap != null) {
              onSaveTap(_titleController.text, _descriptionController.text)
            }
          },
          child: Text(
            "Guardar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
