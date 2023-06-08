part of 'form_dirty_bloc.dart';

class FormDirtyState extends Equatable {
  final bool isDirty;
  const FormDirtyState({
    this.isDirty = false,
  });

  @override
  List<Object> get props => [isDirty];

  FormDirtyState copyWith({
    bool? isDirty,
  }) {
    return FormDirtyState(
      isDirty: isDirty ?? this.isDirty,
    );
  }
}
