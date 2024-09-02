import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AhomePage extends GetView {
  AhomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF5E391F).withOpacity(0.1),
          leading: Image.asset('assets/logo/apple_logo.png'),
          actions: [
            Icon(
              Icons.search,
              size: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.local_mall_outlined,
              size: 25,
            ),
            SizedBox(
              width: 10,
            ),
          ],
          title: Text(
            '애플 하이랜드',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFF5E391F).withOpacity(0.1),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '과수원 소개',
                      style: TextStyle(color: Color(0xFF30180B), fontSize: 15),
                    ),
                    Text(
                      '사과',
                      style: TextStyle(color: Color(0xFF30180B), fontSize: 15),
                    ),
                    Text(
                      '사과즙',
                      style: TextStyle(color: Color(0xFF30180B), fontSize: 15),
                    ),
                    Text(
                      '오시는 길',
                      style: TextStyle(color: Color(0xFF30180B), fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFFF5F5F5),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/apple_Frame.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
