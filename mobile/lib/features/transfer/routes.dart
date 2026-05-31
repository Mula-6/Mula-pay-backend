import 'package:go_router/go_router.dart';
import 'package:mobile/core/constant/constant.dart';

import 'ui/screens/screens.dart';


final transactionRoutes = GoRoute(
  path: "/transfer",
  name: AppRoutesNames.transfer,
  builder: (_, _)=> TransactionScreen(),
  routes: []);