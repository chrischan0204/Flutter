part of 'form_dirty_bloc.dart';

abstract class FormDirtyEvent extends Equatable {
  const FormDirtyEvent();

  @override
  List<Object> get props => [];
}

class FormDirtyChanged extends FormDirtyEvent {
  final bool isDirty;
  const FormDirtyChanged({
    required this.isDirty,
  });

  @override
  List<Object> get props => [isDirty];
}
