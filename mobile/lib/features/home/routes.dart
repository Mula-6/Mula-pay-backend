import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';
import 'ui/screens/screens.dart';

final homeRoutes = GoRoute(
  name: AppRoutesNames.home,
  path: "/home",
  builder: (_, _) => HomeScreen(),
);
