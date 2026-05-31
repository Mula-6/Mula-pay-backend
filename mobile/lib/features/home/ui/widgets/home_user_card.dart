import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:mobile/core/shared/ui/ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/constant.dart';
import '../../../auth/data/model/model.dart';

class UserHomeCard extends ConsumerStatefulWidget {
  const UserHomeCard({super.key, required this.user});

  final CurrentUserModel user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserHomeCardState();
}

class _UserHomeCardState extends ConsumerState<UserHomeCard> {
  // KycModel? _kycModel;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   final dt = ref.read(userKycInfoProvider);
    //   dt.whenOrNull(
    //     data: (model) {
    //       if (mounted) {
    //         setState(() {
    //           _kycModel = model;
    //         });
    //       }
    //     },
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    final kycAsync = ref.watch(userKycInfoProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withAlphaOpacity(0.3),
            ),
            shape: BoxShape.circle,
          ),
          child: kycAsync.when(
            data: (kyc) =>
                DeafultProfileAvaterWidget(imageUrl: kyc?.profileUrl),
            loading: () => DeafultProfileAvaterWidget(),
            error: (_, st) => DeafultProfileAvaterWidget(),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back!",
                style: KTextStyles.bodyMedium(context).copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlphaOpacity(0.6),
                ),
              ),
              Text(
                capitalize(widget.user.userBasicInfo.firstName),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
