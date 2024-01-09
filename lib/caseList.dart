import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class caseList extends StatefulWidget{

  @override
  _caseList createState(){
    return _caseList();
  }

}

class _caseList extends State<caseList>{

  @override
  Widget build(BuildContext context){
    return Container(
      child: Text('任務清單'),
    );
  }

}