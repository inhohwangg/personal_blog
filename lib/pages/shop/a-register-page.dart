import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Aregister extends GetView {
  Aregister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          '회원가입',
          style: TextStyle(color: Color(0xFF856655), fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('아이디',
                      style: TextStyle(color: Color(0xFF343434), fontSize: 14)),
                  Gap(3),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFFF8484), fontSize: 14),
                  )
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '입력해주세요.',
                          hintStyle: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                  Gap(5),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Color(0xFFF5F5F5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          '중복 확인',
                          style:
                              TextStyle(color: Color(0xFF343434), fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Gap(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('비밀번호',
                      style: TextStyle(color: Color(0xFF343434), fontSize: 14)),
                  Gap(3),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFFF8484), fontSize: 14),
                  )
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '입력해주세요.',
                          hintStyle: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                              suffixIcon: Icon(Icons.visibility_off_outlined),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Gap(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('비밀번호 확인',
                      style: TextStyle(color: Color(0xFF343434), fontSize: 14)),
                  Gap(3),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFFF8484), fontSize: 14),
                  )
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '입력해주세요.',
                          hintStyle: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                              suffixIcon: Icon(Icons.visibility_off_outlined),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Gap(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('이름',
                      style: TextStyle(color: Color(0xFF343434), fontSize: 14)),
                  Gap(3),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFFF8484), fontSize: 14),
                  )
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '입력해주세요.',
                          hintStyle: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                ],
              ),
            ),
             Gap(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('전화번호',
                      style: TextStyle(color: Color(0xFF343434), fontSize: 14)),
                  Gap(3),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFFF8484), fontSize: 14),
                  )
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '입력해주세요.',
                          hintStyle: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                ],
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
                    'SMS 수신 동의',
                    style: TextStyle(
                      fontSize: 14, // 원하는 폰트 크기 설정
                      color: Colors.black, // 텍스트 색상 설정
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('각종 이벤트, 공지 소식 등 받아보실 수 있습니다.',style: TextStyle(color: Color(0xFF646464),fontSize: 11),),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('회원가입, 주문 관련 이메일 수신은 해당 동의와 상관없이 발송됩니다.',style: TextStyle(color: Color(0xFF646464),fontSize: 11),),
                ],
              ),
            ),
            //* 주소
            Gap(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('주소',
                      style: TextStyle(color: Color(0xFF343434), fontSize: 14)),
                  Gap(3),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFFF8484), fontSize: 14),
                  )
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                      decoration: InputDecoration(
                        // fillColor: Color(0xFFC8C8C8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // hintText: '입력해주세요.',
                          hintStyle: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                          contentPadding: EdgeInsets.only(top: 10, left: 10)),
                    ),
                  ),
                  Gap(5),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Color(0xFFF5F5F5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          '주소 찾기',
                          style:
                              TextStyle(color: Color(0xFF343434), fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            //* 성별
            Gap(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('성별 (선택)',
                      style: TextStyle(color: Color(0xFF343434), fontSize: 14)),
                ],
              ),
            ),
            Gap(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF343434).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Center(
                      child: Text('여자',style: TextStyle(color: Color(0xFF343434).withOpacity(0.5),fontSize: 14),),
                    ),
                  ),
                  Gap(10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF343434).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Center(
                      child: Text('남자',style: TextStyle(color: Color(0xFF343434).withOpacity(0.5),fontSize: 14),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
