import 'package:flutter/material.dart';
import 'package:class_recorder/class.dart' as classPage;
import 'package:class_recorder/save.dart' as save;
import 'package:flutter/services.dart';
import 'package:class_recorder/caseList.dart' as caseList;

//12:56
void main() {

  save.saveSetup();
  runApp(appMain());

}


List<Widget> pageList = [page_record() , page_case()];
int pageIndex = 0;

class appMain extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'class Recorder',
      initialRoute: '/',
      routes: {
        '/': (context) => page_case(),
        '/caseview': (context) => mainPage(),
      },
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
    PageController controller = PageController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                HapticFeedback.heavyImpact();
                setState(() {

                });
              },
              icon: Icon(Icons.settings),
          )
        ],
      ),
      body:
          PageView(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            children: [
              pageList[0],
              pageList[1],
            ],


          ),



    );
  }

}

class page_record extends StatefulWidget{

  @override
  _page_record createState(){
    return _page_record();
  }

}

class _page_record extends State<page_record>{

  @override
  Widget build(BuildContext context){

    int edCot = 0;
    for(int i=0;i<classPage.classSit.length;i++){
      if(classPage.classSit[i][1] == '1'){
        edCot++;
      }
    }

    return Column(

      children: [
        Text('繳交紀錄',style:TextStyle(fontSize: 30),),
        SizedBox(
          height: 20,
        ),
        Container(
            height: 700,
            margin: EdgeInsets.all(25),
            child: Column(
              children: [

                Row(
                  children: [
                    Text(
                      '  已繳交 $edCot',
                      style:TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '  未繳交 ${classPage.classSit.length-edCot}',
                      style:TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      '  已收到金額 ${edCot*315}',
                      style:TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Divider(
                  color: Color.fromARGB(255, 200, 200, 200),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 450,
                  child: classPage.classPage(),
                )

              ],
            )
        )
      ],
    );
  }

}


class page_case extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: Center(
        ),
        backgroundColor: Color.fromARGB(, 255, 255, 255),
        actions: [
          IconButton(
              onPressed: (){
              },
              icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          caseList.caseList(),
        ],
      ),
      backgroundColor: Color.fromARGB(250, 255, 255, 255),
    );

  }

}
