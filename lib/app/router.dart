import 'package:avto_parking/app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:avto_parking/common/utils/utils.dart';

import '../pages/LoginPage.dart';
import '../pages/MainPage.dart';
import '../pages/ProfilePage.dart';
import '../pages/UnlockPage.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: Utils.getToken().isEmpty
          ? MainRoutes.unlock_page
          : MainRoutes.main_page,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder? builder;
        switch (settings.name) {
          case MainRoutes.unlock_page:
            builder = (BuildContext _) => const UnlockPage();
            break;
          case MainRoutes.main_page:
            builder = (BuildContext _) => const MainPage();
            break;
          case MainRoutes.login_page:
            builder = (BuildContext _) => const LoginPage();
            break;
          case MainRoutes.profile:
            builder = (BuildContext _) => const ProfilePage();
            break;
        }
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }
      },
      onPopPage: (Route<dynamic> route, dynamic result) {
        return route.didPop(result);
      },
    );
  }
}
