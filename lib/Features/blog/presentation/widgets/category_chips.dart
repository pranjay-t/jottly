// import 'package:flutter/material.dart';
// import 'package:jottly/Core/Theme/app_pallete.dart';

// class CategoryChips extends StatefulWidget {
//   const CategoryChips({super.key});

//   @override
//   State<CategoryChips> createState() => _CategoryChipsState();
// }

// class _CategoryChipsState extends State<CategoryChips> {
//   List<String> categories = [];
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           'Business',
//           'Programming',
//           'Entertainment',
//           'Sports',
//           'Technology',
//         ].map((e) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 6,
//               vertical: 0,
//             ),
//             child: GestureDetector(
//               onTap: () {
//                 if (categories.contains(e)) {
//                   categories.remove(e);
//                 } else {
//                   categories.add(e);
//                 }
//                 setState(() {});
//               },
//               child: Chip(
//                 color: categories.contains(e)
//                     ? WidgetStatePropertyAll(AppPallete.gradient1)
//                     : null,
//                 padding: const EdgeInsets.all(13),
//                 label: Text(
//                   e,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
