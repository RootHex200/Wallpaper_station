import 'package:flutter/material.dart';

class Details_view extends StatelessWidget {
  final String Imageurl;
  const Details_view({Key? key,required this.Imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        image: NetworkImage(Imageurl),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
