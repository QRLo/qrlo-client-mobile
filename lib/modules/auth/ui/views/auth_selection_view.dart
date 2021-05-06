import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrlo_mobile/config/dependency_injector.dart';
import 'package:qrlo_mobile/config/routes_manager.dart';
import 'package:qrlo_mobile/modules/auth/states/auth_state.dart';
import 'package:qrlo_mobile/modules/dashboard/routes/dashboard_route.dart';

class AuthSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              final authState = Provider.of<AuthState>(context, listen: false);
              authState.loginWithKakao().then((_) {
                getIt<RoutesManager>().router.navigateTo(
                      context,
                      DashboardRoute().url,
                      replace: true,
                    );
              }).catchError((e) {});
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Image.asset("assets/images/kakao_login_wide.png"),
          ),
          FlatButton(
            onPressed: () => {
              // TODO: NAVER OAUTH SHOULD BE IMPLEMENTED
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Image.asset("assets/images/naver_login_wide.png"),
          ),
          // Container(
          //   height: 40.0,
          //   margin: EdgeInsets.symmetric(horizontal: 35),
          //   child: RaisedButton(
          //     onPressed: () => showBottom(context),
          //     color: Theme.of(context).primaryColor,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(5.0),
          //     ),
          //     child: Container(
          //       alignment: Alignment.center,
          //       child: Text(
          //         "이메일 로그인",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20),
        ],
      ),
    );
  }
}
