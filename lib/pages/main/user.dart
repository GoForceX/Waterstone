import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waterstone/components/login_status.dart';
import 'package:waterstone/utils/auth.dart';

import '../../components/refreshable_image.dart';
import '../../main.dart';

@RoutePage()
class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  _invalidateCredentials(WidgetRef ref) {
    BaseSingleton.singleton.cookieJar.deleteAll();
    ref.invalidate(checkLoginStatusProvider);
    ref.invalidate(getLoginTicketsProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue status = ref.watch(checkLoginStatusProvider);
    AsyncValue tickets = ref.watch(getLoginTicketsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('我的')),
      body: ListView(
        children: [
          status.when(
            data: (data) {
              if (data) {
                return LoginStatus(
                  status: LoginStatusEnum.loggedIn,
                  onLongPress: () {
                    _invalidateCredentials(ref);
                  },
                );
              }
              return LoginStatus(
                status: LoginStatusEnum.loggedOut,
                onLongPress: () {
                  _invalidateCredentials(ref);
                },
              );
            },
            error: (error, stack) {
              return LoginStatus(
                status: LoginStatusEnum.loading,
                onLongPress: () {
                  _invalidateCredentials(ref);
                },
              );
            },
            loading: () {
              return LoginStatus(status: LoginStatusEnum.loading);
            },
          ),
          status.when(
            data: (data) {
              if (data) {
                return Container();
              }
              return tickets.when(
                data: (tickets) {
                  if (tickets == null) {
                    return Container();
                  }
                  return LoginForm(tickets: tickets as LoginTickets);
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Container(),
              );
            },
            error: (error, stack) => Container(),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key, required this.tickets});

  final LoginTickets tickets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final TextEditingController codeController = useTextEditingController();
    UniqueKey codeKey = UniqueKey();

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("学号"),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("密码"),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Expanded(
                  child: TextField(
                    controller: codeController,
                    maxLength: 4,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("验证码"),
                      counterText: "",
                    ),
                  ),
                ),
                RefreshableImage(
                  key: codeKey,
                  src: "https://pass.hust.edu.cn/cas/code",
                  width: 90,
                  height: 58,
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                login(
                  tickets,
                  usernameController.text,
                  passwordController.text,
                  codeController.text,
                ).then((data) {
                  ref.invalidate(checkLoginStatusProvider);
                  ref.invalidate(getLoginTicketsProvider);
                });
              },
              child: Text("登！录！"),
            ),
          ],
        ),
      ),
    );
  }
}
