import 'package:flutter/material.dart';

class PrivacyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        width: MediaQuery.of(context).size.width,
        top: MediaQuery.of(context).size.height * 0.95,
        child: Container(
          child: Column(
            children: [
              Text(
                'By continuing you agree theSocial\'s Terms of',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              Text(
                "Services & Privacy Policy",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ));
  }
}
