import '../../blocs/bloc/response_scale_bloc.dart';
import '/common_libraries.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddNewResponseScaleField extends StatefulWidget {
  const AddNewResponseScaleField({
    super.key,
  });

  @override
  State<AddNewResponseScaleField> createState() =>
      _AddNewResponseScaleFieldState();
}

class _AddNewResponseScaleFieldState extends State<AddNewResponseScaleField> {
  TextEditingController sectionController = TextEditingController();
  late ResponseScaleBloc responseScaleBloc;

  @override
  void initState() {
    responseScaleBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResponseScaleBloc, ResponseScaleState>(
      listener: (context, state) {
        if (state.responseScaleAddStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          sectionController.text = '';
        } else if (state.responseScaleAddStatus.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) =>
          previous.responseScaleAddStatus != current.responseScaleAddStatus,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: CustomTextFieldWithIcon(
          hintText: 'Add new response scale',
          suffixWidget: SizedBox(
            width: 40,
            child: Center(
              child: state.responseScaleAddStatus.isLoading
                  ? LoadingAnimationWidget.inkDrop(
                      color: Colors.blue,
                      size: 20,
                    )
                  : Icon(
                      PhosphorIcons.regular.plusCircle,
                      color: textColor,
                      size: 18,
                    ),
            ),
          ),
          onSuffixClicked: () {
            if (Validation.isEmpty(sectionController.text)) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.info,
                content: FormValidationMessage(fieldName: 'Response scale')
                    .requiredMessage,
              ).showNotification();
            } else {
              responseScaleBloc.add(ResponseScaleAdded());
            }
          },
          onChange: (value) => responseScaleBloc
              .add(ResponseScaleNewResponseScaleChanged(responseScale: value)),
          controller: sectionController,
        ),
      ),
    );
  }
}
