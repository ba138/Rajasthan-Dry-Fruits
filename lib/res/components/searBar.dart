// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rjfruits/res/components/colors.dart';

// class SearchBar extends StatelessWidget {
//   const SearchBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 46,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         color: AppColor.boxColor,
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search products',
//           prefixIcon: const Icon(
//             Icons.search,
//             color: AppColor.textColor1,
//           ),
//           suffixIcon: Container(
//             height: 47.0,
//             width: 47.0,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(24),
//                 color: AppColor.primaryColor),
//             child: Center(
//               child: IconButton(
//                 onPressed: () {},
//                 icon: const ImageIcon(
//                   AssetImage("images/filter.png"),
//                   color: AppColor.whiteColor,
//                 ),
//               ),
//             ),
//           ),
//           hintStyle: GoogleFonts.getFont(
//             "Roboto",
//             textStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: AppColor.textColor2,
//             ),
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
