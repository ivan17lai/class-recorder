import 'package:flutter/material.dart';
import 'package:class_recorder/class.dart' as classPage;
import 'package:class_recorder/save.dart' as save;


//12:56
void main() {
  save.saveSetup();
  runApp(appMain());
}

class appMain extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'class Recorder',
      home: mainPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.tealAccent,  // 设置主要颜色
          onPrimary: Colors.black,  // 设置主要颜色上的文本颜色
          secondary: Colors.tealAccent,  // 设置次要颜色
          onSecondary: Colors.black,  // 设置次要颜色上的文本颜色
        ),
      ),
    );
  }

}

class mainPage extends StatefulWidget{

  @override
  createState(){
    return _mainPage();
  }

}

class _mainPage extends State<mainPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: [
          Text('Class 0',style:TextStyle(fontSize: 30),),

          Container(
            height: 550,
            margin: EdgeInsets.all(25),
            child: classPage.classPage(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '紀錄',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '任務',
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.article_outlined),
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){

                int edCot = 0;
                for(int i=0;i<classPage.classSit.length;i++){
                  if(classPage.classSit[i][1] == '1'){
                    edCot ++;
                  }
                }

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
                        Text('繳交統計',style: TextStyle(fontSize: 20),),
                        SizedBox(
                          height: 30,
                        ),
                        Text('繳交人數 37/$edCot',style: TextStyle(fontSize: 30),),
                        SizedBox(
                          height: 5,
                        ),
                        Text('總金額 ${edCot*315} \$',style: TextStyle(fontSize: 30),),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        },
        backgroundColor: Colors.white,
      ),

    );
  }

}