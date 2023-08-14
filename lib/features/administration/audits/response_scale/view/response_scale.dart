import 'package:safety_eta/common_libraries.dart';

import '../blocs/bloc/response_scale_bloc.dart';
import 'widgets/response_scale_item_list.dart';
import 'widgets/response_scale_list.dart';

class ResponseScaleCrudView extends StatelessWidget {
  const ResponseScaleCrudView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResponseScaleBloc(context),
      child: Padding(
        padding: inset10,
        child: const Row(
          children: [
            Expanded(
              child: ResponseScaleListView(),
            ),
            Expanded(
              flex: 2,
              child: ResponseScaleItemListView(),
            )
          ],
        ),
      ),
    );
  }
}
