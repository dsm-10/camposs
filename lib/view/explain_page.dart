import 'package:camposs/component/explain.dart';
import 'package:camposs/component/my_button.dart';
import 'package:camposs/component/now.dart';
import 'package:camposs/component/out_botton.dart';
import 'package:camposs/component/relics.dart';
import 'package:camposs/view/distance_page.dart';
import 'package:camposs/view/my_page.dart';
import 'package:camposs/view/rangking_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/util.dart';

class ExplainPage extends StatefulWidget {
  final String heritageId;

  const ExplainPage({super.key, required this.heritageId});

  @override
  State<ExplainPage> createState() => _ExplainPageState();
}

class _ExplainPageState extends State<ExplainPage> {
  Future<Map<String, dynamic>> _getEnd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(ConstValues.tokenKey) ?? '';

    print("ID:: ${accessToken}");

    Dio dio = Dio();

    final response = await dio.post(
      '${ConstValues.BaseURL2}/compass/arrive',
      data: {"heritage_id": widget.heritageId},
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
      body: FutureBuilder(
        future: _getEnd(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Now(),
                  SizedBox(height: 72.h),
                  Padding(
                    padding: EdgeInsets.only(left: 83.w),
                    child: Relics(image: snapshot.data!['heritage']['image']),
                  ),
                  Explain(
                    name: snapshot.data!['heritage']['name'],
                    explain: snapshot.data!['heritage']['description'],
                  ),
                  SizedBox(height: 160.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                      right: 30.w,
                      bottom: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 43.w),
                          child: OutBotton(
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
                        ),
                        MyButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
