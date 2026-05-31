import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/shared/shared.dart';

import '../widgets/widgets.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            flexibleSpace: SizedBox(
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -10,
                    top: -10,
                    child: CustomCircleWidgets(width: 130, height: 130),
                  ),
                ],
              ),
            ),
            
            title: Text("Transfer"),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              KSize.h12,
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: KSize.symmetricHorizontal,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withAlphaOpacity(0.05),
                            blurRadius: 20,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(
                          context,
                        ).colorScheme.surface.withAlphaOpacity(0.2),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Theme.of(
                              context,
                            ).colorScheme.surface.withAlphaOpacity(0.08),

                            Theme.of(
                              context,
                            ).colorScheme.surface.withAlphaOpacity(0.95),
                          ],
                          stops: [0.0, 0.8],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withAlphaOpacity(0.1),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.arrowTrendUp,
                                  color: KColors.primary,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Top Reciepeint",
                                    style: KTextStyles.titleLarge(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Most received transactions this week",
                                    style: KTextStyles.bodySmall(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(),
                          const SizedBox(height: 10),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GridView.builder(
                              itemCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 2.5,
                                  ),
                              itemBuilder: (context, index) =>
                                  const TopSenderCard(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    KSize.h32,
                    CustomSectionHeadings(
                      title: "Payout Account",
                      showSeeMore: false,
                    ),

                    TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(hintText: "6501293747"),
                    ),
                    
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(KSize.symmetricHorizontalXl),
        child: DefaultButton(onPressed: () {}, text: "Next"),
      ),
    );
  }
}
