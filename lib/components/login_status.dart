import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterstone/utils/auth.dart';

enum LoginStatusEnum { loggedIn, loggedOut, loading }

class LoginStatus extends ConsumerStatefulWidget {
  const LoginStatus({super.key, required this.status, this.onLongPress});

  final LoginStatusEnum status;
  final Function()? onLongPress;

  @override
  ConsumerState createState() => _LoginStatusState();
}

class _LoginStatusState extends ConsumerState<LoginStatus> {
  final styles = {
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

  _buildStatusWidget(LoginStatusEnum status, WidgetRef ref) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(10),
      color: styles[status]!['background'] as Color,
      child: InkWell(
        onTap: () {
          ref.invalidate(checkLoginStatusProvider);
        },
        onLongPress: widget.onLongPress,
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
                        width: 29,
                        height: 29,
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
    return _buildStatusWidget(widget.status, ref);
  }
}
