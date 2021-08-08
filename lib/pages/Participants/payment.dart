import 'package:flutter/material.dart';
import 'package:EMMA/services/databaseservice.dart';

// ignore: must_be_immutable
class PaymentInfo extends StatefulWidget {
  String amount;
   String eventuid;
                  String docuid;
  PaymentInfo(this.amount,this.eventuid,this.docuid);
  @override
  _PaymentInfoState createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  
  final TextEditingController amountController = new TextEditingController();

  @override
  // ignore: must_call_super
  void initState() {
amountController.text= widget.amount;
  }
    int selectedCardIndex = 0;

  @override
  
  Widget build(BuildContext context) {
  
    return Scaffold(
    
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.red[700],
      ),  
    body: SingleChildScrollView(child: Column(children: [
      Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'Enter Amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          enabled: false,
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'Amount',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Payment Method',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _getBankCard(index);
                  }),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: GestureDetector(
              onTapUp: (tapDetail) {
                
              },
              onTap: ()async{
                await DatabaseService().updatePayment(
                  widget.eventuid,
                  widget.docuid,

                );
                Navigator.of(context).pop();
              },
              child: Text('PROCEED',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    )
    ],),),
    );

  }

  Widget _getBankCard(int index) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Image.asset(index % 2 == 0
              ? 'assets/images/visa.png'
              : 'assets/images/fpx-logo.jpg',width: 50,),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(index % 2 == 0
              ? 'VISA'
              : 'FPX'),
          )),
          Radio(
            activeColor: Colors.red,
            groupValue:  selectedCardIndex,
            value: index,
            onChanged: (value){
                            selectedCardIndex = value;

              setState(() {
              });
                         },
            
          )
        ],
      ),
    );
  }

}