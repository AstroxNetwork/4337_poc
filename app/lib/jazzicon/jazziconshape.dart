// export interface IJazziconProps {
// size?: number;
// address?: string;
// seed?: number;
// containerStyle?: StyleProp<ViewStyle>;
// }
//
// export interface IJazziconState {
// generator: MersenneTwister.IMersenneTwister;
// colors: string[];
// }

import 'package:flutter/cupertino.dart';

class JazziconShape {
  double center;
  double tx;
  double ty;
  double rotate;
  Color fill;

  JazziconShape(
      {required this.center,
      required this.tx,
      required this.ty,
      required this.rotate,
      required this.fill});

  @override
  String toString() {
    return "JazziconShape tx=$tx ty=$ty rotate=$rotate center=$center fill=$fill";
  }
}

class JazziconData {
  double size;
  Color background;
  List<JazziconShape> shapelist;

  JazziconData(
      {required this.size, required this.background, required this.shapelist});
}
