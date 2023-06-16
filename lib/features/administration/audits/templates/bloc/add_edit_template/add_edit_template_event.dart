part of 'add_edit_template_bloc.dart';

abstract class AddEditTemplateEvent extends Equatable {
  const AddEditTemplateEvent();

  @override
  List<Object?> get props => [];
}

class AddEditTemplateDescriptionChanged extends AddEditTemplateEvent {
  final String description;
  const AddEditTemplateDescriptionChanged({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

class AddEditTemplateDateChanged extends AddEditTemplateEvent {
  final DateTime date;
  const AddEditTemplateDateChanged({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}


class AddEditTemplateTemplateAddEdited extends AddEditTemplateEvent {
  final String? templateId;
  const AddEditTemplateTemplateAddEdited({
    this.templateId,
  });

  @override
  List<Object?> get props => [templateId];
}
