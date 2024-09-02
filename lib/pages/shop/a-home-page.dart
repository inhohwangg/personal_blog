import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
              Gap(40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF271300),
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF271300),
                            ),
                          ),
                          Text(
                            "언제나 소비자에게",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "정직함을 약속합니다.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF271300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5), // 이미지 둥글게 만들기
                        child: Image.asset(
                          'assets/images/farm_info1.png',
                          // height: 150,
                          // width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '강원도 양구 펀치볼 650고지 청정지역에서 잔류농약',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 12),
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
                      '걱정 없이 껍질째 먹을 수 있는 건강한 안심 먹거리를',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 12),
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
                      '위해 노력하는 착한 농부가 있습니다.',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Gap(40),

              //* 두번째 사진
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5), // 이미지 둥글게 만들기
                        child: Image.asset(
                          'assets/images/farm_info2.png',
                          // height: 150,
                          // width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF271300),
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF271300),
                            ),
                          ),
                          Text(
                            "건강하고 안전한 사과",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "생산에 노력합니다.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF271300),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '건강한 사과만을 위해 강원도 양구 펀치볼로 이주했습니다.',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '병충해와 기후온난화에 보다 안전한 지역인 펀치볼은',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '안전한 사과 생산에 최적지입니다.',
                      style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Gap(50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFF271300),
                ),
              ),
              Gap(20),
              Center(
                child: Text(
                  '애플 하이랜드의',
                  style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                ),
              ),
              Center(
                child: Text(
                  '사과와 사과즙을 소개합니다.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                ),
              ),
              Gap(20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFF271300),
                ),
              ),
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                        child: Image.asset(
                          'assets/images/product_info1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(10),
                      Text(
                        '감홍',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF30180B)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                        child: Image.asset(
                          'assets/images/product_info2.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(10),
                      Text('시나골드',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF30180B))),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                        child: Image.asset(
                          'assets/images/product_info3.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(10),
                      Text('부사',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF30180B))),
                    ],
                  ),
                ],
              ),
              Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                        child: Image.asset(
                          'assets/images/product_info4.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(10),
                      Text('아리수 / 홍로',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF30180B))),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                        child: Image.asset(
                          'assets/images/product_info5.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(10),
                      Text('사과즙',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF30180B))),
                    ],
                  ),
                ],
              ),
              Gap(50),
              //! CarouselSlider 로 변경해야함
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5), // 이미지 둥글게 만들기
                  child: Image.asset(
                    'assets/images/farm_info3.png',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
