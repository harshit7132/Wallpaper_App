// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// class ImageGenratePage extends StatefulWidget {
//   const ImageGenratePage({
//     super.key,
//   });

//   @override
//   State<ImageGenratePage> createState() => _ImageGenratePageState();
// }

// class _ImageGenratePageState extends State<ImageGenratePage> {
//   late String imgUrl =
//       'https://www.presse-citron.net/app/uploads/2019/01/Apple.jpg';
//   final String API_KEY = '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';
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController searchController = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.black,
//         title: RichText(
//             text: TextSpan(children: [
//           TextSpan(
//               text: 'Image',
//               style: TextStyle(
//                 fontFamily: GoogleFonts.poppins().fontFamily,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               )),
//           TextSpan(
//               text: '   Generator',
//               style: TextStyle(
//                   fontFamily: GoogleFonts.poppins().fontFamily,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.cyan)),
//         ])),
//       ),
//       body: Container(
//         constraints: BoxConstraints.expand(),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: const [
//               Color(0xff000000),
//               Color(0xff330867),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 50),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(12)),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 6,
//                     child: TextField(
//                       controller: searchController,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                           border: InputBorder.none, hintText: 'want you want?'),
//                     ),
//                   ),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () async {
//                         final result =
//                             await fetchImage(searchController.text.toString());
//                         setState(() {
//                           print(result);
//                         });
//                       },
//                       child: Icon(
//                         Icons.search,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//                 child: Center(
//               child: Image.network(imgUrl),
//             ))
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String?> fetchImage(String prompt) async {
//     final uri = Uri.parse('https://api.openai.com/v1/images/generations');
//     final header = {
//       'Authorization': 'Bearer $API_KEY',
//       'Content-Type': 'application/json',
//     };
//     final Map<String, dynamic> requestBody = {
//       'prompt': prompt,
//       'n': 1,
//       'size': '1024x1024',
//     };

//     final res = await http.post(
//       uri,
//       headers: header,
//       body: jsonEncode(requestBody),
//     );
//     if (res.statusCode == 200) {
//       final resBody = jsonDecode(res.body);
//       final data = resBody['data'];
//       final imgUrl = data is List && data.isNotEmpty ? data[0]['url'] : null;
//       return imgUrl is String ? imgUrl : null;
//     } else {
//       // throw Exception(res.body);
//     }
//   }
// }
