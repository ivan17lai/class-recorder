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
            children: [
              pageList[0],
              pageList[1],
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
        currentIndex: pageIndex,
        onTap: (index){
          setState(() {
            pageIndex = index;
            controller.animateToPage(index,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastEaseInToSlowEaseOut);
          });
        },
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
            height: 550,
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


class page_case extends StatefulWidget{

  @override
  _page_case createState(){
    return _page_case();
  }

}

class _page_case extends State<page_case>{

  @override
  Widget build(BuildContext context){


    return Column(
      children: [
        caseList.caseList(),
      ],
    );
  }

}