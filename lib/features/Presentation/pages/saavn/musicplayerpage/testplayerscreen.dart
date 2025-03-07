import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'localmodels/localmodel1.dart';

class Testplayerscreen extends StatelessWidget {
  static const String textscreen = './testscreen';
  const Testplayerscreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LocalModel1(currentscreen: '');
  }
}
