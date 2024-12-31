// import 'package:flutter/material.dart';
//
// class CustomImage {
//   final double defaultWidth;
//   final double defaultHeight;
//   final BoxFit defaultFit;
//   final BorderRadiusGeometry defaultBorderRadius;
//
//   // Constructor for customization
//   CustomImage({
//     this.defaultWidth = 100.0,
//     this.defaultHeight = 100.0,
//     this.defaultFit = BoxFit.cover,
//     this.defaultBorderRadius = BorderRadius.zero,
//   });
//
//   // Method to create a circular image
//   Widget circularImage({
//     required String imageUrl,
//     double? size,
//     BoxFit? fit,
//     Color? backgroundColor,
//   }) {
//     return Container(
//       width: size ?? defaultWidth,
//       height: size ?? defaultHeight,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: backgroundColor ?? Colors.transparent,
//         image: DecorationImage(
//           image: NetworkImage(imageUrl),
//           fit: fit ?? defaultFit,
//         ),
//       ),
//     );
//   }
//
//   // Method to create a rounded rectangular image
//   Widget roundedImage({
//     required String imageUrl,
//     double? width,
//     double? height,
//     BoxFit? fit,
//     BorderRadiusGeometry? borderRadius,
//   }) {
//     return ClipRRect(
//       borderRadius: borderRadius ?? defaultBorderRadius,
//       child: Image.network(
//         imageUrl,
//         width: width ?? defaultWidth,
//         height: height ?? defaultHeight,
//         fit: fit ?? defaultFit,
//       ),
//     );
//   }
//
//   // Method to create a square image
//   Widget squareImage({
//     required String imageUrl,
//     double? size,
//     BoxFit? fit,
//   }) {
//     return Image.network(
//       imageUrl,
//       width: size ?? defaultWidth,
//       height: size ?? defaultHeight,
//       fit: fit ?? defaultFit,
//     );
//   }
//
//
//
// }
