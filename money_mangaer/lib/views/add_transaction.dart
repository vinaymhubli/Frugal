import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_mangaer/model/hive_data.dart';
class AddTransaction extends StatefulWidget {
  AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  
    int?amount;
    String note="Some Expense";
    String type="Income";
    List <String> months=[
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",

    ];
     Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
            builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black),
          ),
          accentColor: Colors.black,
          colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 5, 43, 141),
              primaryVariant: Colors.black,
              secondaryVariant: Colors.black,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black,
              secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );
    },
        initialDate: selectedDate,
        firstDate: DateTime(2015, 12),
        lastDate: DateTime(2050,12));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

    DateTime selectedDate= DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffe2e7ef),
    
    appBar: AppBar(toolbarHeight: 0.0,
      backgroundColor: Colors.transparent,elevation: 0.0,),
      body: ListView(
        
        padding: EdgeInsets.all(10.0),
       children: [
          SizedBox(height: 20.0,),

        Text("Add Transaction",style: GoogleFonts.adamina(
          fontSize: 30,fontWeight:FontWeight.bold,
          color:Color.fromARGB(255, 5, 43, 141) ),
          textAlign: TextAlign.center,),
          SizedBox(height: 20.0,),
          Row(
            children: [
              Container(decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(40.0)),
               padding: EdgeInsets.all(12.0),
                child: Icon(Icons.currency_rupee_sharp,size: 20,)),
                SizedBox(width: 20.0,),
                Expanded(child: TextField(
                  // textAlign: TextAlign.left,
                  decoration: InputDecoration(  
                   hintText: "Add",
                   border: InputBorder.none
                  ),
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
                  onChanged: (val){
                    try {
                      amount=int.tryParse(val);
                    } catch (e) {
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    
                  ],
                  keyboardType: TextInputType.number,
                ),
                
                )
            ],
          ),
          SizedBox(height: 20.0,),
           Row(
            children: [
              Container(decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(40.0)),
               padding: EdgeInsets.all(12.0),
                child: Icon(Icons.description_sharp,size: 20,)),
                SizedBox(width: 20.0,),
                Expanded(child: TextField(
                  // textAlign: TextAlign.left,
                  decoration: InputDecoration(  
                   hintText: "Description",
                   border: InputBorder.none
                  ),
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
                  onChanged: (val){
                    note=val;
                  },
                  maxLength: 20,
                ),
                
                
                )
            ],
          ),
          SizedBox(height: 18.0,),
          Row(
            children: [
               Container(decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(40.0)),
               padding: EdgeInsets.all(12.0),
                child: Icon(Icons.savings_outlined   ,size: 20,)),
                SizedBox(width: 20.0,),
                ChoiceChip(label: Text("Income",
                style: GoogleFonts.abrilFatface(color:type=="Income"?Color.fromARGB(255, 0, 0, 0):Colors.pink, fontSize: 15.0),),
                selectedColor: Color.fromARGB(255, 5, 43, 141).withOpacity(0.7),
                 selected: type=="Income"?true:false,

                 
                 onSelected: (val){
                  if(val){
                    setState(() {
                      type="Income";
                     
                    });
                  }
                 },
                 ),
                SizedBox(width: 20.0,),
                ChoiceChip(label: Text("Expense",
                style: GoogleFonts.abrilFatface(color:type=="Expense"?Color.fromARGB(255, 0, 0, 0):Colors.pink, fontSize: 15.0),),
                selectedColor: Color.fromARGB(255, 5, 43, 141).withOpacity(0.7),
                 selected: type=="Expense"?true:false,

               
                 onSelected: (val){
                  if(val){
                    setState(() {
                      type="Expense";
                      
                    });
                  }
                 },
                 ),


            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: [
              Container(decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(40.0)),
               padding: EdgeInsets.all(12.0),
                child: Icon(Icons.date_range,size: 20,)),
                SizedBox(width: 1.0,),
              TextButton(onPressed: (){
                _selectDate(context);
              }, child: Text("${selectedDate.day} ${months[selectedDate.month-1]} ${selectedDate.year}",
              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),)),
            ],
          ),
          SizedBox(height: 20.0,),
        Padding(
          padding: EdgeInsets.only(left:120 ,right:120 ),
          child: ElevatedButton(style:ElevatedButton.styleFrom(
            fixedSize: Size(80,50),
            primary: Color.fromARGB(255, 5, 43, 141),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
              
          ) ,
            onPressed: ()async{
             if(amount!=null && note.isNotEmpty){
            DbHelper dbhelper =DbHelper();
           await dbhelper.addData(amount!,selectedDate, note, type);
             Navigator.of(context).pop();
             }else{
              print("Values Not Provided");
             }
            }, child:Text("Save",style: TextStyle(color: Colors.teal,fontSize: 25,))
          ),
        )
       ],
      ),
    );
  }
}