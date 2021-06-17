import 'package:flutter/cupertino.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';

class TaglineText extends StatelessWidget {
  const TaglineText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.60,
      left: 20,
      child: Container(
        constraints: BoxConstraints(maxWidth: 170),
        child: RichText(
          text: TextSpan(
            text: 'Are ',
            style: kTextSpanStyle.copyWith(fontSize: 40),
            children: <TextSpan>[
              TextSpan(
                text: 'You ',
                style: kTextSpanStyle.copyWith(
                  color: kWhiteColor,
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: 'Social',
                style: kTextSpanStyle.copyWith(
                  color: kBlueColor,
                  fontSize: 40,
                ),
              ),
              TextSpan(
                text: '?',
                style: kTextSpanStyle.copyWith(
                  color: kWhiteColor,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
