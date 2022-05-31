import 'package:flutter/material.dart';

import '../../constanins.dart';
import '../../models/TyrePsi.dart';

class tyrepsi extends StatelessWidget {
  const tyrepsi({
    Key? key,
    required this.isBottomTwoTyre, required this.tyrePsi,
  }) : super(key: key);
  final isBottomTwoTyre;
  final TyrePsi tyrePsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: tyrePsi.isLowPressure ? redColor.withOpacity(0.3) : Colors.white10,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color:tyrePsi.isLowPressure ? redColor : primaryColor, width: 2),
      ),
      child: isBottomTwoTyre
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lowpressureText(context),
          Spacer(),
          psiText(context, psi: tyrePsi.psi.toString()),
          const SizedBox(
            height: defaultPadding,
          ),
          Text("${tyrePsi.temp}\u2103", style: TextStyle(fontSize: 17)),

        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          psiText(context, psi: tyrePsi.psi.toString()),
          const SizedBox(
            height: defaultPadding,
          ),
          Text("${tyrePsi.temp}\u2103", style: TextStyle(fontSize: 17)),
          Spacer(),

          lowpressureText(context),
        ],
      ),
    );
  }

  Column lowpressureText(BuildContext context) {
    return Column(
      children: [
        Text(
          "Low".toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        Text("Pressure".toUpperCase(), style: TextStyle(fontSize: 20))
      ],
    );
  }

  Text psiText(BuildContext context, {required String psi}) {
    return Text.rich(
      TextSpan(
          text: psi,
          style: Theme.of(context).textTheme.headline4!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          children: [TextSpan(text: "psi", style: TextStyle(fontSize: 25))]),
    );
  }
}
