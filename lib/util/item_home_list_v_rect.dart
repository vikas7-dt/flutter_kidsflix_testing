import 'package:flutter/material.dart';
import 'package:kidsflix_flutter/util/constants.dart';

class ItemHomeListVRect extends StatefulWidget {
  const ItemHomeListVRect({super.key});

  @override
  State<ItemHomeListVRect> createState() => _ItemHomeListVRectState();
}

class _ItemHomeListVRectState extends State<ItemHomeListVRect> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(color: Colors.amber),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.network(Constants.IMAGE_BASE_URL),
      ),
    ));
  }
}
