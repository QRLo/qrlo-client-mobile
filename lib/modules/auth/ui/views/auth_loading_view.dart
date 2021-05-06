import 'package:flutter/material.dart';

class AuthLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "QRLo",
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
