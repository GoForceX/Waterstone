import 'dart:math';

import 'package:flutter/material.dart';
import 'package:waterstone/utils/auth.dart';

enum LoginStatusEnum { loggedIn, loggedOut, loading }

class LoginStatus extends StatefulWidget {
  const LoginStatus({super.key, required this.status});

  final LoginStatusEnum status;

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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: styles[widget.status]!['background'] as Color,
      child: InkWell(
        onTap: () async {
          bool status = await checkLoginStatus();
          if (!status) {
            await getLoginTickets();
          }
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children:
                widget.status != LoginStatusEnum.loading
                    ? [
                      Icon(
                        styles[widget.status]!['icon'] as IconData,
                        size: 24,
                        color: styles[widget.status]!['color'] as Color,
                      ),
                      Text(
                        styles[widget.status]!['text'] as String,
                        style: TextStyle(
                          fontSize: 20,
                          color: styles[widget.status]!['color'] as Color,
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
}
