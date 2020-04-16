import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hello_firebase/screens/shared/colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainBackgroundColor,
      child: Center(
        child: SpinKitChasingDots(
          color: appBarColor,
          size: 50.0,
        ),
      ),
    );
  }
}
