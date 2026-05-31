import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:mobile/core/application/provider/app_auth_state_provider.dart';
import 'package:mobile/core/application/state/app_auth_state.dart';
import 'package:mobile/core/constant/constant.dart';
import '../../../../core/shared/shared.dart';
import '../widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int filterDays = 7;
  




  @override
  Widget build(BuildContext context) {
    var user = ref.watch(
      appAuthStateProvider.select(
        (data) => data.value!.whenOrNull(isUserAuthenticated: (user) => user),
      ),
    )!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: KSize.symmetricHorizontal,
                ),
                child: Badge.count(
                  count: 5,
                  textColor: KColors.backgroundLight,
                  smallSize: 12,
                  textStyle: KTextStyles.labelSmall(context),
                  child: HugeIcon(icon: HugeIconsStrokeRounded.notification01),
                ),
              ),
            ],
            expandedHeight: 60,
            toolbarHeight: 70,
            pinned: true,
            floating: true,
            excludeHeaderSemantics: true,
            flexibleSpace: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -10,
                  top: -10,
                  child: CustomCircleWidgets(width: 125, height: 125),
                ),
              ],
            ),
            // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
            title: UserHomeCard(user: user),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              HomeBalanceSection(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: KSize.symmetricHorizontalX,
                ),
                child: Column(
                  children: [
                    // TODO: ADD DROPDOWN TIME
                    KSize.h24,
                    TransactionLinerChartHistory(),
                    KSize.h12,
                    HomeQuickActions(),
                    KSize.h12,
                    CustomSectionHeadings(),
                    ...List.generate(4, (index) {
                      var type = index % 2 == 0;
                      return TransactionListTile(
                        transactionType: type
                            ? TransactionTypeEnum.received
                            : TransactionTypeEnum.sent,
                        description: 'Salary Deposit',
                        amount: 50000,
                        time: 'Today, 10:30 AM',
                        category: 'Salary',
                        onTap: () {},
                      );
                    }),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
