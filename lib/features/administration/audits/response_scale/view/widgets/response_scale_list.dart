import 'package:safety_eta/common_libraries.dart';

import '../../blocs/bloc/response_scale_bloc.dart';
import 'response_scale_list_item.dart';
import 'response_scale_text_field.dart';

class ResponseScaleListView extends StatefulWidget {
  const ResponseScaleListView({super.key});

  @override
  State<ResponseScaleListView> createState() => _ResponseScaleListViewState();
}

class _ResponseScaleListViewState extends State<ResponseScaleListView> {
  @override
  void initState() {
    context.read<ResponseScaleBloc>().add(ResponseScaleListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResponseScaleBloc, ResponseScaleState>(
      listener: (context, state) => CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification(),
      listenWhen: (previous, current) =>
          previous.responseScaleEditDeleteStatus !=
              current.responseScaleEditDeleteStatus &&
          current.responseScaleEditDeleteStatus.isSuccess,
      builder: (context, state) {
        return Card(
          elevation: 3,
          child: Padding(
            padding: inset10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBottomBorderContainer(
                  child: Padding(
                    padding: inset20,
                    child: Text(
                      'Response Scales',
                      style: textBold18,
                    ),
                  ),
                ),
                CustomBottomBorderContainer(
                  padding: inset10,
                  child: const AddNewResponseScaleField(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (int index = 0;
                            index < state.responseScaleList.length;
                            index++)
                          ResponseScaleListItemView(
                            responseScale: state.responseScaleList[index],
                            first: index == 0,
                            last: index == state.responseScaleList.length - 1,
                            active: state.responseScaleList[index].id ==
                                state.selectedResponseScaleId,
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
