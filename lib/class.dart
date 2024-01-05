import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class classPage extends StatefulWidget {
  @override
  createState() {
    return _classPage();
  }
}

List<List<String>> classSit = [];
fetchData() async {
  // 尝试从SharedPreferences中读取数据
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? serializedData = prefs.getString('classSit');

  classSit.clear();
  // 如果有存储的数据，则解析为List<List<String>>并赋值给classSit
  if (serializedData != null) {

    classSit = deserializeData(serializedData);

  } else {
    // 如果没有存储的数据，初始化classSit
    for (int i = 1; i <= 38; i++) {
      if (i != 5) {
        classSit.add([i.toString(), '0']);
      }
    }
  }
}

saveData() async {
  // 将classSit序列化为字符串并存储到SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String serializedData = serializeData(classSit);
  prefs.setString('classSit', serializedData);
}

String serializeData(List<List<String>> data) {
  // 将List<List<String>>序列化为字符串
  return data.map((row) => row.join(',')).join(';');
}

List<List<String>> deserializeData(String data) {
  // 将字符串反序列化为List<List<String>>
  return data.split(';').map((row) => row.split(',')).toList();
}

class _classPage extends State<classPage> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Color buttomColor(int idx){
    return (classSit[idx][1]=='0')? Colors.white :Colors.tealAccent;
  }

  @override
  Widget build(BuildContext context) {

    if (classSit.length == 0) {
      for (int i = 1; i <= 38; i++) {
        if (i != 5) {
          classSit.add([i.toString(), '0']);
        }
      }
    }

    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:6, // 列數
            childAspectRatio: 1,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: classSit.length,
          itemBuilder: (context ,index){
            return Card(
              color: buttomColor(index),
                child: InkWell(
                  child: Container(
                      child: Center(
                        child: Text(
                          classSit[index][0],
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                  ),
                  onTap: (){

                    if(classSit[index][1] == '0'){
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return sheetConfirm(index:index);
                        },
                      );
                    }else{
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 250.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('繳交取消',style: TextStyle(fontSize: 20),),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('${classSit[index][0]} 號 取消 315\$',style: TextStyle(fontSize: 30),),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            height: 50,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(220, 240, 240, 240),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text('取消',style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: Container(
                                            height: 50,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlue,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text('確認',style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                          onTap: (){
                                            print(index);
                                            classSit[index][1] = '0';
                                            Navigator.pop(context);
                                            saveData();
                                            setState(() {

                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                  },
                )
            );
          }
      ),
      height: 550,
    );

  }
}



class sheetConfirm extends StatefulWidget{

  final int index;
  sheetConfirm({required this.index});
  @override
  _sheetConfirm createState(){
    return _sheetConfirm(index: index);
  }

}

class _sheetConfirm extends State<sheetConfirm>{

  final int index;
  _sheetConfirm({required this.index});
  double _currentHeight = 300.0;
  @override
  Widget build(BuildContext context){

    return Container(
      height: _currentHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('繳交確認',style: TextStyle(fontSize: 20),),
            SizedBox(
              height: 30,
            ),
            Text('${classSit[index][0]} 號 繳交 315\$',style: TextStyle(fontSize: 30),),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(220, 240, 240, 240),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text('取消',style: TextStyle(fontSize: 15),),
                      ),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text('確認',style: TextStyle(fontSize: 15),),
                      ),
                    ),
                    onTap: (){
                      print(index);
                      classSit[index][1] = '1';
                      Navigator.pop(context);
                      saveData();
                      setState(() {

                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

}
