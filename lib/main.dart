import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:const Quiz() ,
  ) );
}
class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
int questionnumber=0;
List<Icon> icon=[];
bool selectedanswer=false;
int count=0;

List<Myquestion> questionbank=[
  Myquestion(q:"Elephant have black horn ",a:false),
  Myquestion(q:"China is the neighbour country of india ",a:true),
  Myquestion(q:"28 states in India",a:true),
  Myquestion(q:"Narendra Modi is the first prime minister of india ",a:false),
  Myquestion(q:"Cristiano Ronaldo is a Portugal player ",a:false),
];   //question list

void Nextquestions(){  //for iterating next question
  if(questionnumber<questionbank.length-1){
    questionnumber++;
  }
}

String? questionselect(){      //for selecting questions by iterating
  return questionbank[questionnumber].question;
}
bool? answerselect(){    //for corresponding answer
  return questionbank[questionnumber].answer;
}

bool? finished(){                //for check whether the questions are finished or not
  if(questionnumber==questionbank.length-1){
    return true;
  }else{
    return false;
  }
}

int reset(){        //for reset the questions
  return questionnumber=0;
}


void checkanswer(bool userselectedanswer){
  bool? ans=answerselect();
  setState(() {
    if(finished()==true){
      if(count>3){
        Alert(context: context,title: "Finished",desc:"CONGRATZZ!!").show();
      }else{
        Alert(context: context,title: "Finished",desc:"Better luck next time").show();
      }
      reset();
      icon=[];
    }else if(userselectedanswer==answerselect()){
      icon.add(Icon(Icons.check,color: Colors.green,size: 20,));
      count++;
      print(count);
    }else{
      icon.add(Icon(Icons.close,color: Colors.red,size: 20,));
    }

  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(alignment: Alignment.center,
              child: Text("${questionbank[questionnumber].question}",style: TextStyle(fontSize: 32,color: Colors.white60,fontWeight: FontWeight.bold),)),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedanswer=true;
                  checkanswer(selectedanswer);
                  Nextquestions();
                });
              },
              child: Container(color: Colors.green,
                height: 35,width: double.maxFinite,
                child:
                Align(alignment: Alignment.center,
                    child: Text("TRUE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedanswer=false;
                  checkanswer(selectedanswer);
                  Nextquestions();
                });
              },
              child: Container(
                color: Colors.red,
                height: 35,width: double.maxFinite,
                child:
                Align(alignment: Alignment.center,
                    child: Text("False",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
              ),
            ),
          ),
          SizedBox(height: 120,),

          Row(
            children:
              icon,
          )

        ],
      ),
    );
  }
}

