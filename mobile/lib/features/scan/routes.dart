import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/features/scan/ui/screens/screens.dart';

final scanRoutes = GoRoute(
  name: AppRoutesNames.scan,
  path: "/scan", builder: (_, _) => ScanScreen());
