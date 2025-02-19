import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

// import 'views/bible/index.dart';
import 'views/bible/page.dart';
import 'views/coolGroup/index.dart';
import 'views/dailyReading/index.dart';
import 'models/daily_reading_arguments.dart'; // Ensure this is the correct path to the DailyReadingArguments type
import 'models/home_arguments.dart'; // Ensure this is the correct path to the HomeArguments type
import 'models/add_rhema_arguments.dart';
import 'views/error_loading.dart';
import 'views/feedback/index.dart';
import 'views/home/index.dart';
import 'views/login.dart';
import 'views/news/index.dart';
import 'views/notes/index.dart';
import 'views/plans/index.dart';
import 'views/profile/index.dart';
import 'views/register/index.dart';
import 'views/rhemas/add_rhema.dart';
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
      case '/profile':
        return SlideFromRoute(widget: ProfilePage(), direction: 'right');
      case '/cool-group':
        return SlideFromRoute(widget: CoolGroup(), direction: 'right');
      case '/notes':
        return SlideFromRoute(widget: NotesPage(), direction: 'right');
      case '/plans':
        return SlideFromRoute(widget: ReadingPlans(), direction: 'right');
      case '/rhema':
        return SlideFromRoute(widget: RhemaPage(), direction: 'right');
      case '/pages':
        return SlideFromRoute(widget: SamplePages(), direction: 'right');
      case '/register':
        return ScaleRoute(widget: RegisterPage());
      case '/error':
        return ScaleRoute(widget: ErrorLoading(key: UniqueKey(), title: 'Loading Error'));
      case '/login':
        return ScaleRoute(widget: LoginPage());
      // case '/bible-view':
      //   return SlideFromRoute(
      //       widget: BibleViewPage(readingItem: settings.arguments), direction: 'right');
      case '/daily-reading':
        return SlideFromRoute(widget: DailyReadingPage(key: UniqueKey(), arguments: settings.arguments as DailyReadingArguments), direction: 'right');
      case '/bible':
        return SlideFromRoute(widget: BiblePage(key: UniqueKey()), direction: 'right');
      case '/home':
        final args = settings.arguments as HomeArguments;
        return ScaleRoute(widget: Home(key: UniqueKey(), title: 'Home', startDate: args.startDate));
      case '/news':
        return ScaleRoute(widget: NewsPage());
      case '/feedback':
        return SlideFromRoute(widget: FeedbackPage(), direction: 'right');
      case '/add-rhema':
        return SlideFromRoute(widget: AddRhemaPage(key: UniqueKey(), arguments: settings.arguments as AddRhemaArguments), direction: 'right');
      case '/':
      default:
        return SlideFromRoute(widget: SplashScreen(key: UniqueKey(), title: GlobalConfiguration().getValue('appName')), direction: 'left');
    }
  }
}

class SlideFromRoute extends PageRouteBuilder {
  final Widget widget;
  final String direction;
  static Offset begin = Offset.zero;

  SlideFromRoute({required this.widget, required this.direction})
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
  final Widget widget;

  ScaleRoute({required this.widget})
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
