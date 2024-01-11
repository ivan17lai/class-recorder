import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class caseList extends StatefulWidget{

  @override
  _caseList createState(){
    return _caseList();
  }

}

int pageTag = 0;

class _caseList extends State<caseList>{

  double getTextSize(index){
    return ((index)==pageTag)? 25:20;
  }

  PageController controller = PageController();


  @override
  Widget build(BuildContext context){
    return Column(

      children: [
        Text('任務清單',style:TextStyle(fontSize: 30),),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 500,
            margin: EdgeInsets.all(25),
            child: Column(
              children: [

                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          InkWell(
                            child: AnimatedDefaultTextStyle(
                              child: Text(' 待完成 '),
                              style:TextStyle(
                                color: Colors.black,
                                fontSize: getTextSize(0),
                                fontWeight: FontWeight.w500,
                              ),
                              duration: Duration(milliseconds: 50),
                              curve: Curves.easeInOut,
                            ),
                            onTap: (){
                              pageTag = 0;
                              controller.animateToPage(
                                0,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                              );
                              setState(() {

                              });
                            },
                          ),
                          InkWell(
                            child: AnimatedDefaultTextStyle(
                              child: Text(' 已完成 '),
                              style:TextStyle(
                                color: Colors.black,
                                fontSize: getTextSize(1),
                                fontWeight: FontWeight.w500,
                              ),
                              duration: Duration(milliseconds: 50),
                              curve: Curves.easeInOut,
                            ),
                            onTap: (){
                              pageTag = 1;
                              controller.animateToPage(
                                1,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                              );
                              setState(() {

                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                Divider(
                  color: Color.fromARGB(255, 200, 200, 200),
                ),

                SizedBox(
                  height: 10,
                ),

                Expanded(
                  child: SizedBox(
                    child: PageView(

                      controller:  controller,
                      children: [
                        notfinishList(),
                        finishList(),
                      ],

                      onPageChanged: (index){

                        pageTag = index;
                        setState(() {

                        });

                      },

                    ),

                  ),
                ),


              ],
            )
        )
      ],
    );
  }

}

class finishList extends StatefulWidget{

  @override
  _finishList createState(){
    return _finishList();
  }

}
List<String> myList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

class _finishList extends State<finishList>{

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: myList.length,
              itemBuilder: (BuildContext context,int index){
                return Container(
                  width: 550,
                  height: 80,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(100, 240, 240, 240),
                  ),
                  child: Text(myList[index]),
                  
                );
              }
          ),
        ),
      ],
    );
  }

}

class notfinishList extends StatefulWidget{

  @override
  _notfinishList createState(){
    return _notfinishList();
  }

}

class _notfinishList extends State<notfinishList>{

  @override
  Widget build(BuildContext context){
    return Text('ddff');
  }

}

