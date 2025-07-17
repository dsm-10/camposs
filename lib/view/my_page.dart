import 'package:camposs/component/good.dart';
import 'package:camposs/component/lanking_botton.dart';
import 'package:camposs/component/out_botton.dart';
import 'package:camposs/view/rangking_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/util.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _State();
}

class _State extends State<MyPage> {
  Future<Map<String, dynamic>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(ConstValues.tokenKey) ?? '';

    Dio dio = Dio();

    final response = await dio.get(
      '${ConstValues.BaseURL}/mypage',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      throw Exception("서버 통신 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 43.h, vertical: 43.w),
        child: FutureBuilder(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '현재 순위',
                        style: TextStyle(
                          color: Color(0xff93928B),
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        "${snapshot.data!['user']['rank']}등",
                        style: TextStyle(fontSize: 25.sp, color: Colors.white),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        '나의 소유물',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 13.h),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: List.from(
                          snapshot.data!["heritages"],
                        ).length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Good(
                                level:
                                    snapshot.data!['heritages'][index]['name'],
                                time: snapshot
                                    .data!['heritages'][index]['discoveryDate'],
                              ),
                              SizedBox(height: 13.h),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${snapshot.data!['user']['nickname']}님의',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 40.sp,
                                color: Color(0xff93928B),
                              ),
                            ),
                            TextSpan(
                              text: ' 홈',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 40.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutBotton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          LankingBotton(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RangkingPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
