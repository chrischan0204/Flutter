import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class AwarenessCategoryShowView extends StatefulWidget {
  final String awarenessCategoryId;
  const AwarenessCategoryShowView({
    super.key,
    required this.awarenessCategoryId,
  });

  @override
  State<AwarenessCategoryShowView> createState() =>
      _AwarenessCategoryShowViewState();
}

class _AwarenessCategoryShowViewState extends State<AwarenessCategoryShowView> {
  late AwarenessCategoriesBloc awarenessCategoriesBloc;

  @override
  void initState() {
    awarenessCategoriesBloc = context.read<AwarenessCategoriesBloc>();
    awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
    awarenessCategoriesBloc.add(AwarenessCategorySelectedById(
      awarenessCategoryId: widget.awarenessCategoryId,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessCategoriesBloc, AwarenessCategoriesState>(
      listener: (context, state) {
        if (state.awarenessCategoryCrudStatus == EntityStatus.success) {
          awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/awareness-categories');
        }
        if (state.awarenessCategoryCrudStatus == EntityStatus.failure) {
          awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return EntityShowTemplate(
          title: 'Awareness Category',
          label: 'awareness category',
          entity: state.selectedAwarenessCategory,
          deleteEntity: () {
            awarenessCategoriesBloc.add(
              AwarenessCategoryDeleted(
                awarenessCategoryId: state.selectedAwarenessCategory!.id!,
              ),
            );
          },
          crudStatus: state.awarenessCategoryCrudStatus,
        );
      },
    );
  }
}
