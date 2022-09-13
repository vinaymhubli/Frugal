import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_mangaer/model/hive_data.dart';
import 'package:money_mangaer/model/transaction.dart';
import 'package:money_mangaer/views/add_transaction.dart';
import 'package:money_mangaer/views/logout.dart';
import 'package:money_mangaer/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';



class MHome extends StatefulWidget {
  @override
  State<MHome> createState() => _MHomeState();
}
class _MHomeState extends State<MHome> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  
            


  DbHelper dbhelper =DbHelper();
  DateTime today = DateTime.now();
  int totalBalance=0;
  int totalIncome=0;
  int totalExpense=0;
 List<FlSpot>dataSet=[];
 
 late Box box;
  List<FlSpot> getPlotGraph(List<TransactionModel> entireData) {
  dataSet = [];
  List tempdataSet = [];
 for (TransactionModel item in entireData) {
 if (item.date.month == today.month && item.type == "Expense") {
  tempdataSet.add(item);
  }
    }
    
tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSet;
  }





    getTotalBalance(List<TransactionModel> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (TransactionModel data in entireData) {
      
        if (data.type == "Income") {
          totalBalance += data.amount;
          totalIncome += data.amount;
        } else {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      
    }
  }

  Future<List<TransactionModel>>fetch()async{
   if(box.values.isEmpty){
    return Future.value([]);
   }
   else{
    List<TransactionModel>items=[];
    box.toMap().values.forEach((element) { 
      items.add(TransactionModel(element['amount']as int, element['note'], element['date'] as DateTime, element['type']));
    });
    return items;
   }
  }
@override
  void initState() {
   box= Hive.box('money');
   fetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Color(0xffe2e7ef),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      floatingActionButton: FloatingActionButton(   
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),   
        backgroundColor:Color.fromARGB(255, 5, 43, 141) ,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransaction(),
          )
          ).whenComplete((){
            setState(() {
              
            });
          });
        },
        child: Icon(Icons.add),
      ),
       body: FutureBuilder<List<TransactionModel>>(
         future: fetch(),
         builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text("404 error"),);
          }
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
            return Center(child: Text("Data Not Found"),);

            }
            getTotalBalance(snapshot.data!);
            getPlotGraph(snapshot.data!);
            return ListView(
              children: [
               Padding(
                 padding: const EdgeInsets.all(13.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Row(
                      children: [
                          Column(
                            children: [
                              Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 5, 43, 141),
                        borderRadius: BorderRadius.circular(32)
                      ),
                      child: CircleAvatar(maxRadius: 32,
                      backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!.toString()),
                                  
                        )),
                      Text("Welcome",style: TextStyle(fontSize: 8),),
                      Text(FirebaseAuth.instance.currentUser!.displayName!,style: TextStyle(fontSize: 8,color: Colors.teal,fontWeight: FontWeight.bold),)

                            ],
                          ),
                      SizedBox(width: 80.0,),
                      Text("Frugal",style: GoogleFonts.adamina(
          fontSize: 30,fontWeight:FontWeight.bold,
          color:Color.fromARGB(255, 5, 43, 141)),
          
          )
                      ],
                    ),
                    
                      
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Logout()));
                      }
                        
                      ,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 5, 43, 141),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child:Icon(Icons.logout_sharp,color: Colors.white,size: 25,) ),
                    ),
                    
                  ],
                 ),
               ),
               
               Container(
                width: MediaQuery.of(context).size.width*0.9,
                margin: EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color.fromARGB(255, 5, 43, 141),
                    Color.fromARGB(255, 20, 132, 237)
                    ]),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  
                  padding: EdgeInsets.symmetric(vertical: 22.0,horizontal: 9.0),
                  child: Column(
                    children: [
                      Text("Balance",style: GoogleFonts.adamina(fontSize: 20,color:Colors.white),),
                      SizedBox(height: 4.0,),
                      Text("\u{20B9} $totalBalance",style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w300),),
                      SizedBox(height: 14.0,),
                      Padding(padding: EdgeInsets.all(7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardIncome(totalIncome.toString()),
                          cardExpense(totalExpense.toString())
                        ],
                      ),
                      )
                    ],
                  ),
                ),
                
               ),
               Padding(padding: EdgeInsets.all(10.0),
               child: Text("Summary",style: GoogleFonts.adamina(fontSize: 30,color:Color.fromARGB(255, 5, 43, 141),fontWeight: FontWeight.w600),
               textAlign: TextAlign.center,
               ),
               ),
              
                 dataSet.length<2?Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 5, 43, 141).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 9,
                        offset: Offset(15,5)
                      )
                    ]
                  ),
                  padding: EdgeInsets.all(12.0),
                  // height: 400,
                 
                   child: Text("No enough data found",style: TextStyle(fontSize: 15,color: Colors.red),textAlign: TextAlign.center)
                 )
                 :Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 5, 43, 141).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.4),
                          spreadRadius: 4,
                          blurRadius: 9,
                          offset: Offset(15,5)
                        )
                      ]
                    ),
                    padding: EdgeInsets.all(12.0),
                    height: 400,
                   
                    child: LineChart(
                      
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots:getPlotGraph(snapshot.data!), 
                            isCurved: false,
                            barWidth: 3.5,
                            color:Color.fromARGB(255, 5, 43, 141) 
                          )
                        ]
                      )
                    ),
                   ),
                 ),
               
               Padding(padding: EdgeInsets.all(10.0),
               child: Text("History",style: GoogleFonts.adamina(fontSize: 30,color:Color.fromARGB(255, 5, 43, 141),fontWeight: FontWeight.w600)),
               ),
               ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  
                  TransactionModel dataIndex ;
                  try {
                    dataIndex=snapshot.data![index];
                  } catch (e) {
                    return Container();
                  }
                 
                 if(dataIndex.type=="Income"){
                  return incomeTile(dataIndex.amount,
                   dataIndex.note,
                    dataIndex.date,
                    index);
                 }
                 else{
                  return expenseTile(dataIndex.amount,
                   dataIndex.note,
                   dataIndex.date,
                   index);
                 }
                 
                
                },
               ),
               SizedBox(height: 75),
              ],
            );
            
          }else{
            return Center(child: Text("404 error"),);

          }
         

           
          
         }
       ),  
       
  
      
    );
  }

  Widget cardIncome(String value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(20),
            
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(Icons.arrow_downward_rounded,color: Colors.teal,),
        ),
        SizedBox(width: 5.0,),
        Column(
          children: [
            Text("Income",style: GoogleFonts.adamina(fontSize: 13,color:Colors.white)),
            Text("\u{20B9} $value",style:TextStyle(fontSize: 18,color:Colors.white)),

          ],
        )
      ],
    );
  }

  Widget cardExpense(String value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(20),
            
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(Icons.arrow_upward_rounded,color: Color.fromARGB(255, 143, 16, 7),),
        ),
        SizedBox(width: 5.0,),
        Column(
          children: [
            Text("Expense",style: GoogleFonts.adamina(fontSize: 13,color:Colors.white)),
            Text("\u{20B9} $value",style: TextStyle(fontSize: 18,color:Colors.white)),

          ],
        )
      ],
    );
  }



  Widget expenseTile(int value, String note, DateTime date,int index){
    return InkWell(
      onLongPress: ()async{
        bool? answer=await showConfirmDialog(context, 'ALERT', 'Do You Want To Delete');
        if(answer!=null && answer){dbhelper.deleteData(index);
        setState(() {
          
        });
        }
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 5, 43, 141).withOpacity(0.4),
          borderRadius: BorderRadius.circular(18.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_circle_up_rounded,color: Color.fromARGB(255, 143, 16, 7),),
                    SizedBox(width: 5.0),
                    Text('Expense')
                  ],
                ),
                SizedBox(height: 5.0,),
                Text("${date.day}/${date.month}/${date.year}",style: TextStyle(
                  color:Color.fromARGB(255, 5, 43, 141) ,
                  fontSize: 13),textAlign: TextAlign.center,),
              ],
            ),
            // SizedBox(width: 5.0,),
            Column(
              children: [
                Text('\u{20B9} -$value'),
                SizedBox(height: 5.0,),
                Text(note,style: TextStyle(
                  color:Color.fromARGB(255, 5, 43, 141) ,
                  fontSize: 14),textAlign: TextAlign.center,),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget incomeTile(int value, String note, DateTime date,int index){
    return InkWell(
      onLongPress: ()async{
        bool? answer=await showConfirmDialog(context, 'ALERT', 'Do You Want To Delete');
        if(answer!=null && answer){dbhelper.deleteData(index);
        setState(() {
          
        });
        }
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 5, 43, 141).withOpacity(0.4),
          borderRadius: BorderRadius.circular(18.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_circle_down_rounded,color: Colors.teal,),
                    SizedBox(width: 5.0),
                    Text('Income')
                  ],
                ),
                SizedBox(height: 5.0,),
                Text("${date.day}/${date.month}/${date.year}",style: TextStyle(
                  color:Color.fromARGB(255, 5, 43, 141) ,
                  fontSize: 13),textAlign: TextAlign.center,),
              ],
            ),
            // SizedBox(width: 5.0,),
            Column(
              children: [
                Text('\u{20B9} +$value'),
                SizedBox(height: 5.0,),
                Text(note,style: TextStyle(
                  color:Color.fromARGB(255, 5, 43, 141) ,
                  fontSize: 14),textAlign: TextAlign.center,),
    
              ],
            )
          ],
        ),
      ),
    );
  }
  
}

