import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Aregister extends GetView {
  Aregister({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
          title: Text(
            '회원가입',
            style: TextStyle(color: Color(0xFF856655), fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20),

              //* userId
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('아이디',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
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
                                borderSide:
                                    BorderSide(color: Color(0xFFC8C8C8))),
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
                            style: TextStyle(
                                color: Color(0xFF343434), fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gap(30),

              //* password
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('비밀번호',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
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
                                borderSide:
                                    BorderSide(color: Color(0xFFC8C8C8))),
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

              //* password_check
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('비밀번호 확인',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
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
                                borderSide:
                                    BorderSide(color: Color(0xFFC8C8C8))),
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

              //* name
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('이름',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
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
                                borderSide:
                                    BorderSide(color: Color(0xFFC8C8C8))),
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

              //* phone number
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('전화번호',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
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
                                borderSide:
                                    BorderSide(color: Color(0xFFC8C8C8))),
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

              //* sms option
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
                    Text(
                      '각종 이벤트, 공지 소식 등 받아보실 수 있습니다.',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '회원가입, 주문 관련 이메일 수신은 해당 동의와 상관없이 발송됩니다.',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 11),
                    ),
                  ],
                ),
              ),

              //* address
              Gap(30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('주소',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
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
                      child: Container(
                        color: Color(0xFFF5F5F5),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color(0xFFC8C8C8))),
                              // hintText: '입력해주세요.',
                              hintStyle: TextStyle(
                                  color: Color(0xFF343434).withOpacity(0.5),
                                  fontSize: 14),
                              contentPadding:
                                  EdgeInsets.only(top: 10, left: 10)),
                        ),
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
                            style: TextStyle(
                                color: Color(0xFF343434), fontSize: 14),
                          ),
                        ),
                      ),
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
                      child: Container(
                        color: Color(0xFFF5F5F5),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color(0xFFC8C8C8)))),
                        ),
                      ),
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
                                borderSide:
                                    BorderSide(color: Color(0xFFC8C8C8)))),
                      ),
                    )
                  ],
                ),
              ),
              Gap(30),

              //* email(optionnal)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('이메일 (선택)',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
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
                      flex: 5,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFFC8C8C8),
                            ),
                          ),
                          hintText: '입력해주세요.',
                          hintStyle: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),
                        ),
                      ),
                    ),
                    Gap(10),
                    Text('@'),
                    Gap(10),
                    Expanded(
                        flex: 4,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Color(0xFFC8C8C8)),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          items: [
                            '직접입력',
                            'naver.com',
                            'google.com',
                            'daum.net',
                            'kakao.com'
                          ].map((value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (value) {},
                        )),
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
                      '이메일 동의 수신',
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
                    Text(
                      '각종 이벤트, 공지 소식 등 받아보실 수 있습니다.',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '회원가입, 주문 관련 이메일 수신은 해당 동의와 상관없이 발송됩니다.',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 11),
                    ),
                  ],
                ),
              ),

              //* gender
              Gap(30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('성별 (선택)',
                        style:
                            TextStyle(color: Color(0xFF343434), fontSize: 14)),
                  ],
                ),
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color(0xFF343434).withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '여자',
                          style: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Gap(10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color(0xFF343434).withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '남자',
                          style: TextStyle(
                              color: Color(0xFF343434).withOpacity(0.5),
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gap(50),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF856655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // 모서리 둥글게 설정
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            surfaceTintColor: Colors.white,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  child: Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Color(0xFFFF8484),
                                    ),
                                  ),
                                ),
                                Gap(10),
                                SizedBox(
                                  child: Center(
                                    child: Text(
                                      '회원가입을',
                                      style: TextStyle(
                                          color: Color(0xFF343434),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Center(
                                    child: Text(
                                      '중단하시겠습니까?',
                                      style: TextStyle(
                                          color: Color(0xFF343434),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                Gap(20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFFF5F5F5),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Center(
                                          child: Text(
                                            '예',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xFF856655),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Center(
                                            child: Text(
                                              '아니오',
                                              style: TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      '가입하기',
                      style: TextStyle(
                          fontSize: 16, // 텍스트 크기 설정
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
