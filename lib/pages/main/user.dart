import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:waterstone/components/login_status.dart';

import '../../components/refreshable_image.dart';

@RoutePage()
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的')),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: LoginStatus(),
          ),
          RefreshableImage(src: "https://pass.hust.edu.cn/cas/code", width: 90, height: 58,),
          ListTile(title: Text('个人信息'), onTap: () {}),
          ListTile(title: Text('设置'), onTap: () {}),
        ],
      ),
    );
  }
}
