import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {

  final image;

  const ImageDialog({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * .95,
        height: 350,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/gallery/$image.png'),
                fit: BoxFit.fill
            )
        ),
      ),
    );
  }
}