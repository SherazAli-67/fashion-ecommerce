import 'package:fashion_ecommerce/core/models/lookbook_image.dart';
import 'package:fashion_ecommerce/presentation/screens/home_screen.dart';
import 'package:fashion_ecommerce/presentation/screens/image_view_screen.dart';
import 'package:fashion_ecommerce/presentation/screens/main_menu_page.dart';
import 'package:fashion_ecommerce/presentation/screens/messaging_screen.dart';
import 'package:fashion_ecommerce/presentation/screens/profile_screen.dart';
import 'package:fashion_ecommerce/presentation/screens/search_screen.dart';
import 'package:fashion_ecommerce/presentation/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => WelcomeScreen()),
    GoRoute(
      path: NamedRoutes.imageView.routeName,
      builder: (_, state) => ImageViewScreen(item: state.extra as LookbookImage),
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.home.routeName, builder: (_, state) => HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.search.routeName, builder: (_, state) => SearchScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.messaging.routeName, builder: (_, state) => MessagingScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.profile.routeName, builder: (_, state) => ProfileScreen()),
        ]),
      ],
      builder: (ctx, state, navigationShell) => MainMenuPage(navigationShell: navigationShell),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  search('/search'),
  messaging('/messaging'),
  profile('/profile'),
  imageView('/image-view');

  final String routeName;
  const NamedRoutes(this.routeName);
}
