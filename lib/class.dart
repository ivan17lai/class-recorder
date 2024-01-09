import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class classPage extends StatefulWidget {
  @override
  createState() {
    return _classPage();
  }
}

List<List<String>> classSit = [];
fetchData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? serializedData = prefs.getString('classSit');

  classSit.clear();
  if (serializedData != null) {

    classSit = deserializeData(serializedData);

  } else {
    for (int i = 1; i <= 38; i++) {
      if (i != 5) {
        classSit.add([i.toString(), '0']);
      }
    }
  }
}

saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String serializedData = serializeData(classSit);
  prefs.setString('classSit', serializedData);
}

String serializeData(List<List<String>> data) {
  return data.map((row) => row.join(',')).join(';');
}

List<List<String>> deserializeData(String data) {
  return data.split(';').map((row) => row.split(',')).toList();
}


int nowIndex = 0;
String pageText = '確認繳交';

class _classPage extends State<classPage> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Color buttomColor(int idx){
    return (classSit[idx][1]=='0')? Colors.white :Colors.tealAccent;
  }

  double CardEle(int idx){
    return (classSit[idx][1]=='0')? 5:5;
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

    PageController _pageController = PageController(initialPage: 0);

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:6, // 列數
                childAspectRatio: 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: classSit.length,
              itemBuilder: (context ,index){
                return Card(
                    elevation: CardEle(index),
                    color: buttomColor(index),
                    child: InkWell(
                      child: Container(
                          child: Center(
                            child: Text(
                              classSit[index][0],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ),
                      onTap: (){
                        HapticFeedback.heavyImpact();

                        setState(() {
                            nowIndex = index;
                            print(nowIndex);
                            print(classSit[index][1]=='0');

                            HapticFeedback.heavyImpact();
                            _pageController.animateToPage(
                              1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            );
                          });


                      },
                    )
                );
              }
          ),
          height: 450,
        ),
        Container(
          height: 450,
          child: Column(
            children: [
              SizedBox(
                child: InkWell(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            HapticFeedback.lightImpact();
                            _pageController.animateToPage(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 25,
                          ),
                      ),
                      SizedBox(
                        width:85,
                      ),
                      Text('繳交確認',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  onTap: (){
                    print(nowIndex);
                    HapticFeedback.heavyImpact();

                    _pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastEaseInToSlowEaseOut,
                    );
                  },
                ),
                height: 60,
              ),
              SizedBox(
                height: 50,
              ),
              Text('${classSit[nowIndex][0]}',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 50,
              ),

              Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  OutlinedButton(
                      onPressed: (){

                      },
                      child: Container(
                          width: 50,
                          height: 20,
                          child: Center(
                            child: Text('註記',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),
                            ),
                          )
                      )
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: (){
                        HapticFeedback.heavyImpact();

                        classSit[nowIndex][1] = (classSit[nowIndex][1]=='0')? '1':'0';

                        saveData();
                        setState(() {
                          _pageController.animateToPage(
                            0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastEaseInToSlowEaseOut,
                          );
                        });

                      },
                      child: Container(
                        width: 70,
                        height: 20,
                        child: Center(
                          child: Text(
                            (classSit[nowIndex][1]=='0')? '確認繳交':'取消繳交',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15
                            ),
                          ),
                        )
                      )
                  ),

                ],
              )

            ],
          ),
        ),
      ],
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


class resheetConfirm extends StatefulWidget{

  final int index;
  resheetConfirm({required this.index});
  @override
  _resheetConfirm createState(){
    return _resheetConfirm(index: index);
  }

}

class _resheetConfirm extends State<resheetConfirm>{

  final int index;
  _resheetConfirm({required this.index});
  double _currentHeight = 300.0;
  @override
  Widget build(BuildContext context){

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
            Text('${classSit[index][0]} 號 取消\$',style: TextStyle(fontSize: 30),),
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

  }

}
