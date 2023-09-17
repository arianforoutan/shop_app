import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cachedimage extends StatelessWidget {
  String? imageUrl;
  var fit;
  double radius;
  Cachedimage(
      {Key? key, this.imageUrl, this.radius = 0, this.fit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
          fit: fit,
          placeholder: (context, url) {
            return Container(
              color: Colors.grey,
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              color: Colors.orange,
            );
          },
          imageUrl: imageUrl ??
              'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/78q8w901e6iipuk/rectangle_63_7kADbEzuEo.png'),
    );
  }
}
