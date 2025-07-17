import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Relics extends StatelessWidget {
  final String image;

  const Relics({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image, width: 256.w);
  }
}
