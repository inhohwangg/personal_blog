import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'a-register-page.dart';

class AloginPage extends GetView {
  AloginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFECE8).withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 투명하게 설정
        elevation: 0, // 그림자 제거
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white, // 배경 색상 설정 (원하는 색상으로 변경 가능)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Icon(Icons.close),
                  )
                ],
              ),
              Gap(10),
              Center(
                child: Image.asset(
                  'assets/images/apple_image.png',
                  width: 75,
                  height: 75,
                ),
              ),
              Text(
                'Login',
                style: TextStyle(fontSize: 25, color: Color(0xFF856655)),
              ),
              Gap(40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: '아이디',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), // 여기에 패딩 설정
                    // prefixText: '아이디'
                  ),
                ),
              ),
              Gap(20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: '비밀번호',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), // 여기에 패딩 설정
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                    ),
                    // prefixText: '아이디'
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                // width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact, // 시각적 밀도 조정
                      value: false, // 초기 체크 상태 설정
                      onChanged: (bool? newValue) {
                        // 체크 상태 변경 시 동작 설정
                      },
                    ),
                    Text(
                      '로그인 유지',
                      style: TextStyle(
                        fontSize: 16, // 원하는 폰트 크기 설정
                        color: Colors.black, // 텍스트 색상 설정
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // width: MediaQuery.of(context).size.width * 0.8, // 원하는 너비 설정
                  height: 50, // 원하는 높이 설정
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF856655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // 모서리 둥글게 설정
                      ),
                    ),
                    onPressed: () {
                      // 버튼 클릭 시 동작
                    },
                    child: Text(
                      '확인',
                      style: TextStyle(
                          fontSize: 16, // 텍스트 크기 설정
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              // Gap(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(Aregister());
                      },
                      child: Text(
                        '회원가입',
                        style: TextStyle(fontSize: 14, color: Color(0xFF646464)),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '아이디',
                      style: TextStyle(fontSize: 14, color: Color(0xFF646464)),
                    ),
                    Gap(5),
                    Text(
                      '|',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF646464),
                        height: 1.2, // 텍스트 높이 조정으로 중앙 정렬
                      ),
                    ),
                    Gap(5),
                    Text(
                      '비밀번호 찾기',
                      style: TextStyle(fontSize: 14, color: Color(0xFF646464)),
                    ),
                  ],
                ),
              ),
              Gap(30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFF646464).withOpacity(0.5),
                        thickness: 1, // 선의 두께
                        endIndent: 10, // 텍스트와 선 사이의 간격
                      ),
                    ),
                    Text(
                      "간편 로그인",
                      style: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF646464).withOpacity(0.5),
                        thickness: 1, // 선의 두께
                        indent: 10, // 텍스트와 선 사이의 간격
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Color(0xFFF8F8F8),
                        child: Center(
                          child: Text('구글',style: TextStyle(
                            color: Color(0xFF141414),
                          ),),
                        ),
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Color(0xFF2DB400),
                        child: Center(
                          child: Text('네이버',style: TextStyle(
                            color: Color(0xFFFFFFFF),
                          ),),
                        ),
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Color(0xFFFEE500),
                        child: Center(
                          child: Text('카카오',style: TextStyle(
                            color: Color(0xFF191919),
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
