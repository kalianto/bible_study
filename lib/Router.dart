import 'package:flutter/material.dart';
import 'package:bible_study/views/Login.dart';
import 'package:bible_study/views/Register.dart';
import 'package:bible_study/views/ErrorLoading.dart';
import 'package:bible_study/views/Home.dart';
import 'package:bible_study/views/SplashScreen.dart';

class SlideFromRoute extends PageRouteBuilder {
  final Widget widget;
  final String direction;
  static Offset begin;

  SlideFromRoute({this.widget, this.direction}) : super(
    pageBuilder: (
      BuildContext context, 
      Animation<double> animation,
      Animation<double> secondaryAnimation
    ) => widget,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child
    ) {
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
    transitionDuration: new Duration(milliseconds: 450),
  );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page}) : super(

    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) => page,

    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) => ScaleTransition(
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
    transitionDuration: new Duration(milliseconds: 500),
  );
}

class BaseRouter {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      // case '/settings':
      //   //return ScaleRoute(page: SettingPage());
      //   return SlideFromRoute(widget: SettingPage(), direction: 'right');
      //   break;
      // case '/myprofile':
      //   return ScaleRoute(page: MyProfile());
      //   // return SlideFromRoute(widget: MyProfile(), direction: 'right');
      //   // return MaterialPageRoute(builder: (_) => MyProfile());
      //   break;
      case '/register':
        return ScaleRoute(page: RegisterPage());
        break;
      case '/error':
        return ScaleRoute(page: ErrorLoading(title: 'Loading Error'));
      break;
      case '/login':
        return ScaleRoute(page: LoginPage());
        break;
      case '/home':
        return ScaleRoute(page: Home(title: 'Home'));
        break;
      case '/':
      default:
        return SlideFromRoute(widget: SplashScreen(title: 'BibleStudy'), direction: 'left');
        break;
    }
  }
}