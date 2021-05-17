import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/modules/qrcode/models/business_card.dart';
import 'package:qrlo_mobile/services/profile_service.dart';

class BusinessCardCardView extends StatefulWidget {
  final BusinessCard businessCard;

  const BusinessCardCardView({
    required Key key,
    required this.businessCard,
  }) : super(key: key);

  @override
  _BusinessCardCardViewState createState() => _BusinessCardCardViewState();
}

class _BusinessCardCardViewState extends State<BusinessCardCardView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://musically.com/wp-content/uploads/2021/05/kakao.jpg',
            ),
          ),
          title: Text(
              "${widget.businessCard.company} ${widget.businessCard.position}"),
        ),
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.apartment_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("${widget.businessCard.company}"),
          ),
          ListTile(
            leading: Icon(
              Icons.work,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("${widget.businessCard.position}"),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("${widget.businessCard.email}"),
          ),
          ListTile(
            leading: Icon(
              Icons.phone_android,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("${widget.businessCard.phone}"),
          ),
          ListTile(
              title: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _displayQRCode(context),
                  child: Text("QR 코드"),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  void _displayQRCode(BuildContext context) async {
    final Uint8List imageData = await getIt<ProfileService>()
        .getQrCodeImageForBusinessCard(widget.businessCard);
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => SingleChildScrollView(
        child: Container(
          child: Image.memory(imageData),
        ),
      ),
    );
  }
}
