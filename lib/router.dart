import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import 'views/bible/index.dart';
import 'views/bible/page.dart';
import 'views/coolGroup/index.dart';
import 'views/dailyReading/index.dart';
import 'views/error_loading.dart';
import 'views/feedback/index.dart';
import 'views/home/index.dart';
import 'views/login.dart';
import 'views/news/index.dart';
import 'views/notes/index.dart';
import 'views/plans/index.dart';
import 'views/profile/index.dart';
import 'views/register/index.dart';
import 'views/rhemas/index.dart';
import 'views/samples/index.dart';
import 'views/settings/index.dart';
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
      case '/notes':
        return SlideFromRoute(widget: NotesPage(), direction: 'right');
        break;
      case '/plans':
        return SlideFromRoute(widget: ReadingPlans(), direction: 'right');
        break;
      case '/rhema':
        return SlideFromRoute(widget: RhemaPage(), direction: 'right');
        break;
      case '/pages':
        return SlideFromRoute(widget: SamplePages(), direction: 'right');
        break;
      case '/register':
        return ScaleRoute(widget: RegisterPage());
        break;
      case '/error':
        return ScaleRoute(widget: ErrorLoading(title: 'Loading Error'));
        break;
      case '/login':
        return ScaleRoute(widget: LoginPage());
        break;
      case '/bible-view':
        return SlideFromRoute(
            widget: BibleViewPage(readingItem: settings.arguments), direction: 'right');
        break;
      case '/daily-reading':
        return SlideFromRoute(
            widget: DailyReadingPage(arguments: settings.arguments), direction: 'right');
        break;
      case '/bible':
        return SlideFromRoute(widget: BiblePage(), direction: 'right');
        break;
      case '/home':
        return ScaleRoute(widget: Home(title: 'Home'));
        break;
      case '/news':
        return ScaleRoute(widget: NewsPage());
        break;
      case '/feedback':
        return SlideFromRoute(widget: FeedbackPage(), direction: 'right');
        break;
      case '/':
      default:
        return SlideFromRoute(
            widget: SplashScreen(title: GlobalConfiguration().getValue('appName')),
            direction: 'left');
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
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              widget,
          transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) {
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
  final Widget widget;

  ScaleRoute({this.widget})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              widget,
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
