import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/shop/a-home-page-controller.dart';

AhomePageController controller = Get.put(AhomePageController());

question(title, item) {
  List getPageItems() {
    int startIndex =
        (controller.currentPage.value - 1) * controller.itemsPerPage.value;
    int endIndex = startIndex + controller.itemsPerPage.value;
    endIndex = endIndex > item.length ? item.length : endIndex;
    return item.sublist(startIndex, endIndex);
  }

  return controller.helpCenterTitle.value == '자주 묻는 질문'
      ? otherQst()
      : controller.helpCenterTitle.value != '문의글 작성하기'
          ? Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.helpCenterIndex.value = 0;
                            controller.helpCenterTitle.value = '';
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFF1C1B1F),
                            size: 24,
                          )),
                      // Gap(10),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4D2E1C)),
                      ),
                    ],
                  ),
                  Gap(15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFF5F5F5)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                size: 16,
                                color: Color(0xFF646464),
                              ),
                              Gap(10),
                              Text(
                                '검색하세요',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF646464)),
                              ),
                              Gap(30),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xFFD9D9D9)),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton(
                            items: controller.dropDownMenuList
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF343434),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.dropDownValue.value = value.toString();
                            },
                            icon: Padding(
                              padding: EdgeInsets.only(
                                  left: 10), // 아이콘과 텍스트 사이 간격 조정
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            value: controller.dropDownValue.value,
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            isDense: true,
                            padding: EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        border: Border.symmetric(
                            horizontal:
                                BorderSide(width: 1, color: Color(0xFFD9D9D9))),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Center(
                                child: Text(
                              '후기',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF343434)),
                            )),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                                child: Text('등록일',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF343434)))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(Get.context!).size.height * 0.5,
                    child: ListView.builder(
                      itemCount: getPageItems().length,
                      itemBuilder: (context, index) {
                        var item = getPageItems()[index];
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              item['secret'] ? showDialog(
                          context: Get.context!,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
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
                                        Icons.lock_outline,
                                        size: 15,
                                        color: Color(0xFF343434),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  SizedBox(
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '비밀번호를 입력하세요',
                                        style: TextStyle(
                                            color: Color(0xFF343434),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Gap(15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5),
                                                borderSide: BorderSide(color: Color(0xFFD9D9D9))),
                                            hintText: '비밀번호 입력',
                                            hintStyle: TextStyle(
                                                color: Color(0xFF343434).withOpacity(0.5),
                                                fontSize: 14),
                                            contentPadding: EdgeInsets.only(top: 10, left: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ) : null;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xFFD9D9D9))),
                              ),
                              width: double.infinity,
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Row(
                                      children: [
                                        Text(
                                          item['title'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF343434)),
                                        ),
                                        Gap(5),
                                        item['secret'] == true
                                            ? Icon(Icons.lock_outline,
                                                color: Color(0xFF343434),
                                                size: 15)
                                            : SizedBox(),
                                        Gap(5),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: item['status'] == '답변완료'
                                                ? Color(0xFF92D090)
                                                : Color(0xFFD5D5D5),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2.5),
                                          child: Text(
                                            item['status'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(item['date']),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(10),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 왼쪽 화살표
                          GestureDetector(
                            onTap: () {
                              controller.previousPageGroup();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                          ),
                          Gap(15),
                          // 페이지 번호들
                          ...List<Widget>.generate(
                              controller.pageGroupSize.value, (index) {
                            int pageNumber =
                                controller.pageGroupStart.value + index;
                            if (pageNumber <= controller.totalPages.value) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.changePage(pageNumber);
                                  },
                                  child: Text(
                                    '$pageNumber',
                                    style: TextStyle(
                                      fontWeight:
                                          controller.currentPage.value ==
                                                  pageNumber
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      color: controller.currentPage.value ==
                                              pageNumber
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(); // 페이지 번호가 전체 페이지 수를 초과하면 빈 컨테이너 반환
                            }
                          }),
                          Gap(15),
                          // 오른쪽 화살표
                          GestureDetector(
                            onTap: () {
                              controller.nextPageGroup();
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                          ),
                        ],
                      )),
                  Gap(25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        controller.helpCenterTitle.value = '문의글 작성하기';
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.5),
                        // width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFB59888)),
                        child: Center(
                            child: Text(
                          '작성하기',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            )
          : qstwrite();
}

otherQst() {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  controller.helpCenterIndex.value = 0;
                  controller.helpCenterTitle.value = '';
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF1C1B1F),
                  size: 24,
                )),
            // Gap(10),
            Text(
              controller.helpCenterTitle.value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4D2E1C)),
            ),
          ],
        ),
        Gap(15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 50, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF5F5F5)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 16,
                      color: Color(0xFF646464),
                    ),
                    Gap(10),
                    Text(
                      '검색하세요',
                      style: TextStyle(fontSize: 12, color: Color(0xFF646464)),
                    ),
                    Gap(30),
                  ],
                ),
              ),
            ],
          ),
        ),
        Gap(30),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          child: ListView.builder(
            itemCount: controller.faqs.length,
            itemBuilder: (context, index) {
              var faqItem = controller.faqs[index];
              return GestureDetector(
                onTap: () {
                  faqItem['isExpanded'].value = !faqItem['isExpanded'].value;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color(0xFFD9D9D9).withOpacity(0.5)))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Q',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF343434),
                                fontWeight: FontWeight.w500),
                          ),
                          Gap(10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.785,
                            child: Text(
                              '${controller.faqs[index]['faqTitle']} ${controller.faqs[index]['title']}',
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF343434),
                              ),
                            ),
                          )
                        ],
                      ),
                      Obx(
                        () => AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Text(
                                  faqItem['content'],
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF343434)),
                                ),
                                Gap(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFFF7F7F7)),
                                      child: Text(
                                        '접기',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF271300)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          crossFadeState: faqItem['isExpanded'].value
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(
                            milliseconds: 300,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 왼쪽 화살표
                GestureDetector(
                  onTap: () {
                    controller.previousPageGroup();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                ),
                Gap(15),
                // 페이지 번호들
                ...List<Widget>.generate(controller.pageGroupSize.value,
                    (index) {
                  int pageNumber = controller.pageGroupStart.value + index;
                  if (pageNumber <= controller.totalPages.value) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          controller.changePage(pageNumber);
                        },
                        child: Text(
                          '$pageNumber',
                          style: TextStyle(
                            fontWeight:
                                controller.currentPage.value == pageNumber
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color: controller.currentPage.value == pageNumber
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // 페이지 번호가 전체 페이지 수를 초과하면 빈 컨테이너 반환
                  }
                }),
                Gap(15),
                // 오른쪽 화살표
                GestureDetector(
                  onTap: () {
                    controller.nextPageGroup();
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}

qstwrite() {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(Get.context!).size.height,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    controller.helpCenterIndex.value = 0;
                    controller.helpCenterTitle.value = '';
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF1C1B1F),
                    size: 24,
                  )),
              // Gap(10),
              Text(
                controller.helpCenterTitle.value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4D2E1C)),
              ),
            ],
          ),
        ),
        Gap(10),
        Row(
          children: [
            Checkbox(
              value: controller.secretValue.value,
              onChanged: (value) {
                controller.secretValue.value
                    ? controller.secretValue.value = false
                    : controller.secretValue.value = true;
              },
            ),
            Text(
              '비밀글',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF343434)),
            ),
            Gap(30),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Color(0xFFC8C8C8))),
                  hintText: '입력해주세요.',
                  hintStyle: TextStyle(
                      color: Color(0xFF343434).withOpacity(0.5), fontSize: 14),
                  contentPadding: EdgeInsets.only(top: 10, left: 10),
                ),
              ),
            ),
            Gap(10)
          ],
        ),
        Gap(20),
        // textField 문의 유형
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '문의 유형',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF343434)),
          ),
        ),
        Gap(5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButton(
              items: controller.dropDownMenuList
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF343434)),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.dropDownValue.value = value.toString();
              },
              icon: Padding(
                padding: EdgeInsets.only(left: 10), // 아이콘과 텍스트 사이 간격 조정
                child: Icon(Icons.keyboard_arrow_down),
              ),
              value: controller.dropDownValue.value,
              underline: Container(
                color: Colors.transparent,
              ),
              isExpanded: true,
              isDense: true,
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        Gap(20),
        // textField 상품
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '상품',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF343434)),
          ),
        ),
        Gap(5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButton(
              items: controller.dropDownMenuList
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF343434)),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.dropDownValue.value = value.toString();
              },
              icon: Padding(
                padding: EdgeInsets.only(left: 10), // 아이콘과 텍스트 사이 간격 조정
                child: Icon(Icons.keyboard_arrow_down),
              ),
              value: controller.dropDownValue.value,
              underline: Container(
                color: Colors.transparent,
              ),
              isExpanded: true,
              isDense: true,
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        Gap(20),
        // 첨부파일 버튼
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '첨부파일 (1MB 이내)',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF343434)),
          ),
        ),
        Gap(5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(5)),
            child: Text('파일선택'),
          ),
        ),

        Gap(20),
        // textField 제목
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '제목',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF343434)),
          ),
        ),
        Gap(5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Color(0xFFC8C8C8))),
                    hintText: '입력해주세요.',
                    hintStyle: TextStyle(
                        color: Color(0xFF343434).withOpacity(0.5),
                        fontSize: 14),
                    contentPadding: EdgeInsets.only(top: 10, left: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(20),
        // textField 문의글
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '문의글 ',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF343434)),
          ),
        ),
        Gap(5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: TextField(
                    maxLines: null, // null로 설정하면 Container의 높이만큼 확장됨
                    expands: true, // TextField가 Container 높이에 맞춰 확장되도록 설정
                    textAlignVertical:
                        TextAlignVertical.top, // 텍스트를 상단에서 시작하도록 설정
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color(0xFFC8C8C8))),
                      hintText: '입력해주세요.',
                      hintStyle: TextStyle(
                          color: Color(0xFF343434).withOpacity(0.5),
                          fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerRight,
          child: Text(
            '최대 0/1000',
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xFF646464))
          ),
        ),
        Gap(20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                     controller.helpCenterIndex.value = 0;
                    controller.helpCenterTitle.value = '';
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFF1F1F1)
                    ),
                    child: Center(
                      child: Text('취소',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF343434)),),
                    ),
                  ),
                ),
              ),
              Gap(10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                          context: Get.context!,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
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
                                        Icons.check_circle,
                                        color: Color(0xFF4AD35F),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  SizedBox(
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '정상적으로\n등록되었습니다.',
                                        style: TextStyle(
                                            color: Color(0xFF343434),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Gap(20),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFFF5F5F5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                          child: Text(
                                            '닫기',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF856655)
                    ),
                    child: Center(
                      child: Text('등록',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
