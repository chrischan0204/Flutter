import '../../blocs/bloc/response_scale_bloc.dart';
import '/common_libraries.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class ResponseScaleListItemView extends StatefulWidget {
  final ResponseScale responseScale;
  final bool first;
  final bool last;
  final bool active;
  const ResponseScaleListItemView({
    super.key,
    required this.responseScale,
    this.first = false,
    this.last = false,
    this.active = false,
  });

  @override
  State<ResponseScaleListItemView> createState() =>
      _ResponseScaleListItemViewState();
}

class _ResponseScaleListItemViewState extends State<ResponseScaleListItemView> {
  bool _hover = false;
  bool _isEditing = false;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        TextEditingController(text: widget.responseScale.name);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Color _getColor() {
    if (_hover) {
      return const Color(0xfff7fdf1);
    } else if (widget.active) {
      return const Color(0xffecfadc);
    }
    return Colors.transparent;
  }

  void _getQuestionListForResponseScale() {
    context.read<ResponseScaleBloc>().add(ResponseScaleSelected(
        selectedResponseScaleId: widget.responseScale.id));
  }

  Widget _buildEditButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              context.read<ResponseScaleBloc>().add(ResponseScaleEdited(
                    responseScaleName: _textEditingController.text,
                    responseScaleId: widget.responseScale.id,
                  ));
              _isEditing = false;
            });
          },
          icon: PhosphorIcon(
            PhosphorIcons.regular.check,
            color: successHoverColor,
            size: 20,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _isEditing = false;
            });
          },
          icon: PhosphorIcon(
            PhosphorIcons.regular.x,
            color: Colors.red,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildCrudButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _textEditingController.text = widget.responseScale.name;
              _isEditing = true;
            });
          },
          icon: PhosphorIcon(
            PhosphorIcons.regular.pencil,
            color: successHoverColor,
            size: 20,
          ),
        ),
        IconButton(
          onPressed: () {
            CustomAlert(
              context: context,
              width: MediaQuery.of(context).size.width / 4,
              title: 'Confirm',
              description: 'Do you really want to delete this response scale?',
              btnOkText: 'OK',
              btnCancelOnPress: () {},
              btnOkOnPress: () => context.read<ResponseScaleBloc>().add(
                  ResponseScaleDeleted(
                      responseScaleId: widget.responseScale.id)),
              dialogType: DialogType.question,
            ).show();
          },
          icon: PhosphorIcon(
            PhosphorIcons.regular.trashSimple,
            color: Colors.red,
            size: 20,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomAlert.checkFormDirty(
            () => _getQuestionListForResponseScale(), context);
      },
      onHover: (value) => setState(() => _hover = value),
      child: CustomBottomBorderContainer(
        child: Container(
          height: 50,
          decoration: widget.active
              ? BoxDecoration(
                  border: Border(
                    top: widget.first
                        ? BorderSide(
                            color: primaryColor,
                            width: 0.5,
                          )
                        : BorderSide(
                            color: grey,
                            width: 1,
                          ),
                    left: BorderSide(
                      color: primaryColor,
                      width: 0.5,
                    ),
                    right: BorderSide(
                      color: primaryColor,
                      width: 0.5,
                    ),
                  ),
                  color: _getColor(),
                )
              : BoxDecoration(color: _getColor()),
          child: ListTile(
            title: _isEditing
                ? SizedBox(
                    height: 40,
                    child: CustomTextField(
                      controller: _textEditingController,
                    ),
                  )
                : Tooltip(
                    message: widget.responseScale.name,
                    child: Text(
                      widget.responseScale.name,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
            trailing: _isEditing ? _buildEditButtons() : _buildCrudButtons(),
          ),
        ),
      ),
    );
  }
}
