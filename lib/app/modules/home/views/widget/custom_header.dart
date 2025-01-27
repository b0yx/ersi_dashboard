import 'package:ersei/app/core/constant/imagesassets.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final String logoPath;

  const CustomHeader({
    Key? key,
    required this.onBackPressed,
    required this.logoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBackPressed,
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black54,
        ),
        const Expanded(
          child: Center(
            child: Image(
              image: AssetImage(ImageAssets.applogo),
              height: 60,
            ),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }
}
