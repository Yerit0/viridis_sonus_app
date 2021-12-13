import 'package:flutter/material.dart';
import 'package:viridis_sonus_app/models/models.dart';
import 'package:nb_utils/nb_utils.dart';

class RegistroWidget extends StatelessWidget {

  final Registro? registroModel;

  RegistroWidget({this.registroModel});

  final _color = Color(0xFF26C884);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16,left: 16,right: 16),
      decoration: boxDecorationRoundedWithShadow(16, backgroundColor: Colors.white),
      child: ListTile(
        tileColor: Colors.red,
        enabled: true,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: boxDecorationWithRoundedCorners(
            boxShape: BoxShape.circle,
            backgroundColor: _color .withOpacity(0.1),
          ),
          child: ImageIcon(
            AssetImage('assets/images/wa_voucher.png'),
            size: 24,
            color: _color,
          ),
        ),
        title: RichTextWidget(
          list: [
            //TextSpan(
            //  text: '${widget.transactionModel!.title!}',
            //  style: primaryTextStyle(color: Colors.black54, size: 14),
            //),
            TextSpan(
              text: '${registroModel!.creatorUser.userName}',
              style: boldTextStyle(size: 14),
            ),
          ],
          maxLines: 1,
        ),
        subtitle: Text('${registroModel!.fechaCreacion}', style: primaryTextStyle(color: Colors.black54, size: 14)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: _color,)
        // Container(
        //  width: 80,
        //  height: 35,
        //  alignment: Alignment.center,
        //  decoration: boxDecorationWithRoundedCorners(
        //    borderRadius: BorderRadius.circular(30),
        //    backgroundColor: widget.transactionModel!.color!.withOpacity(0.1),
        //  ),
        //  child: Text(
        //    '${widget.transactionModel!.balance!}',
        //    maxLines: 1,
        //    style: boldTextStyle(size: 12, color: widget.transactionModel!.color!),
        //  ),
        //),
      ),
    );
  }
}