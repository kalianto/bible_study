import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import 'views/login.dart';
import 'views/register/index.dart';
import 'views/error_loading.dart';
import 'views/home/index.dart';
import 'views/settings/index.dart';
import 'views/profile/index.dart';
import 'views/bible/index.dart';
import 'views/cool_group/index.dart';
import 'views/samples/index.dart';
import 'views/splash_screen.dart';

class BaseRouter {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case '/settings':
        //return ScaleRoute(page: SettingPage());
        return SlideFromRoute(widget: SettingsPage(), direction: 'right');
        break;
      case '/profile':
        return SlideFromRoute(widget: ProfilePage(), direction: 'right');
        break;
      case '/cool-group':
        return SlideFromRoute(widget: CoolGroup(), direction: 'right');
        break;
      case '/pages':
        return SlideFromRoute(widget: SamplePages(), direction: 'right');
        break;
      case '/register':
        return ScaleRoute(page: RegisterPage());
        break;
      case '/error':
        return ScaleRoute(page: ErrorLoading(title: 'Loading Error'));
        break;
      case '/login':
        return ScaleRoute(page: LoginPage());
        break;
      case '/bible-view':
        return SlideFromRoute(widget: BibleViewPage(readingItem: settings.arguments), direction: 'right');
        break;
      case '/home':
        return ScaleRoute(page: Home(title: 'Home'));
        break;
      case '/':
      default:
        return SlideFromRoute(widget: SplashScreen(title: GlobalConfiguration().getValue('appName')), direction: 'left');
        break;
    }
  }
}

class SlideFromRoute extends PageRouteBuilder {
  final Widget widget;
  final String direction;
  static Offset begin;

  SlideFromRoute({this.widget, this.direction})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => widget,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            switch (direction) {
              case 'bottom':
                begin = const Offset(0, 1);
                break;
              case 'top':
                begin = const Offset(0, -1);
                break;
              case 'left':
                begin = const Offset(-1, 0);
                break;
              case 'right':
              default:
                begin = const Offset(1, 0);
                break;
            }
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: begin,
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: new Duration(milliseconds: 150),
        );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
          transitionDuration: new Duration(milliseconds: 300),
        );
}
