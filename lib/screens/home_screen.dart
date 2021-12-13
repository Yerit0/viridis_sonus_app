import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        width: context.width(),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/wa_bg.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                50.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: IconButton(
                        
                        icon: Icon(Icons.person, color: Colors.black),
                        onPressed: (){},)
                        //onPressed: () => WAMyProfileScreen().launch(context),),
                    ),
                    GestureDetector(
                      onTap: (){
                              showDialog(
                                context: context, 
                                barrierDismissible: true,
                                builder: (_) =>AlertDialog(
                                actions: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: Text('Calendario'),
                                    ),
                                  ),
                                ],
                              )
                            );
                          },
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Icon(Icons.date_range, 
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          IconButton(
                            icon: Icon(Icons.restore_rounded), 
                            color: Colors.black,
                            onPressed: (){
                              showDialog(
                                context: context, 
                                barrierDismissible: true,
                                builder: (_) =>AlertDialog(
                                actions: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: Text('Reiniciar Calendario'),
                                    ),
                                  ),
                                ],
                              )
                            );
                          },
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(left: 16, right: 16,bottom: 16),

                //Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  children: [
                //    Text('Transactions', style: boldTextStyle(size: 20)),
                //    Icon(Icons.play_arrow, color: Colors.grey),
                //  ],
                //).paddingOnly(left: 16, right: 16),
                //16.height,
                //Column(
                //  children: transactionList.map((transactionItem) {
                //    return WATransactionComponent(transactionModel: transactionItem);
                //  }).toList(),
                //),
              ],
            ),
          ),
        ),
      ),
    );
  }
}