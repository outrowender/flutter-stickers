import 'package:flutter/cupertino.dart';

class PackAppleView extends StatefulWidget {
  @override
  _PackAppleViewState createState() => _PackAppleViewState();
}

class _PackAppleViewState extends State<PackAppleView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 500,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: Color(0xFF162A49),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
    );
  }
}

//  CustomScrollView(
//         slivers: <Widget>[
//           CupertinoSliverNavigationBar(
//             largeTitle: const Text('Pack view'),
//           ),
//           SliverGrid(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 if (index < 5) {
//                   return Container(
//                     child: Center(
//                       child: Text('item $index'),
//                     ),
//                   );
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
