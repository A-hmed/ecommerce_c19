import 'package:ecommerce_c19/features/network/api_result.dart';
import 'package:ecommerce_c19/features/network/model/response/auth/auth_response.dart';
import 'package:flutter/material.dart';


// Cart-> Map<Id,Product>
// List -> O(n)
// Widget -> ViewModel -> Usecase -> Repository -> DataSource(Local - Remote)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
