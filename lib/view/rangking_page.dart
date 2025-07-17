import 'package:camposs/component/collect.dart';
import 'package:camposs/component/my_button.dart';
import 'package:camposs/component/out_botton.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:camposs/view/my_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/util.dart';

class RangKingPage extends StatefulWidget {
  const RangKingPage({super.key});

  @override
  State<RangKingPage> createState() => _RangKingPageState();
}

class _RangKingPageState extends State<RangKingPage> {
  Future<Map<String, dynamic>> _lank() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(ConstValues.tokenKey) ?? '';

    Dio dio = Dio();

    final response = await dio.get(
      '${ConstValues.BaseURL2}/leaderboard',
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
        padding: EdgeInsets.symmetric(vertical: 43.h, horizontal: 43.w),
        child: FutureBuilder(
          future: _lank(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '랭킹 순위',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Color(0xff93928B),
                        ),
                      ),
                      Text(
                        '전체 유적 보유 순위',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                        height: 600.h,
                        child: ListView.builder(
                          itemCount: List.from(snapshot.data!['ranks']).length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: Collect(
                                level:
                                    "${snapshot.data!['ranks'][index]['rank']}. ${snapshot.data!['ranks'][index]['nickname']}",
                                count:
                                    '${snapshot.data!['ranks'][index]['total_score']}개',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutBotton(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DistancePage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                          MyButton(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyPage(),
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
