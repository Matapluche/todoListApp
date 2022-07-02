import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EmptyState extends StatelessWidget
{
  final String title;

  EmptyState({
    required this.title,
  });

  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Center(
        child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                Image(image: AssetImage('assets/images/empty.png'), height: 100,),
                SizedBox(height: 30,),
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 1,), maxLines: 5, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                Expanded(child: SizedBox()),
              ],
            )
        ),
      )
    );
  }

}
