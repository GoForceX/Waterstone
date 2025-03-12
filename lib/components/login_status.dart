import 'dart:math';

import 'package:flutter/material.dart';
import 'package:waterstone/utils/auth.dart';

enum LoginStatusEnum { loggedIn, loggedOut, loading }

class LoginStatus extends StatefulWidget {
  const LoginStatus({super.key});

  @override
  State<LoginStatus> createState() => _LoginStatusState();
}

class _LoginStatusState extends State<LoginStatus> {
  var styles = {
    LoginStatusEnum.loggedIn: {
      'icon': Icons.check_circle,
      'color': Colors.green,
      'background': Colors.lightGreenAccent.shade400,
      'text': '已登录',
    },
    LoginStatusEnum.loggedOut: {
      'icon': Icons.cancel,
      'color': Colors.red,
      'background': Colors.grey,
      'text': '未登录',
    },
    LoginStatusEnum.loading: {
      'icon': Icons.cancel,
      'color': Colors.red,
      'background': Colors.grey,
      'text': '',
    },
  };

  _buildStatusWidget(status) {
    return Card(
      color: styles[status]!['background'] as Color,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children:
            status != LoginStatusEnum.loading
                ? [
              Icon(
                styles[status]!['icon'] as IconData,
                size: 24,
                color: styles[status]!['color'] as Color,
              ),
              Text(
                styles[status]!['text'] as String,
                style: TextStyle(
                  fontSize: 20,
                  color: styles[status]!['color'] as Color,
                ),
              ),
            ]
                : [
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: checkLoginStatus(), builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          return _buildStatusWidget(snapshot.data! ? LoginStatusEnum.loggedIn : LoginStatusEnum.loggedOut);
        } else if (snapshot.hasError) {
          return _buildStatusWidget(LoginStatusEnum.loggedOut);
        }
      }
      return _buildStatusWidget(LoginStatusEnum.loading);
    });
  }
}
