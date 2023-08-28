part of 'add_edit_template_bloc.dart';

abstract class AddEditTemplateEvent extends Equatable {
  const AddEditTemplateEvent();

  @override
  List<Object?> get props => [];
}

/// event to change description
class AddEditTemplateDescriptionChanged extends AddEditTemplateEvent {
  final String description;
  const AddEditTemplateDescriptionChanged({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

/// event to change date
class AddEditTemplateDateChanged extends AddEditTemplateEvent {
  final DateTime date;
  const AddEditTemplateDateChanged({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

/// event to add or edit template
class AddEditTemplateTemplateAddEdited extends AddEditTemplateEvent {
  final String? templateId;
  const AddEditTemplateTemplateAddEdited({this.templateId});

  @override
  List<Object?> get props => [templateId];
}

/// event to load template detail by id
class AddEditTemplateLoaded extends AddEditTemplateEvent {
  final String templateId;
  const AddEditTemplateLoaded({required this.templateId});

  @override
  List<Object?> get props => [templateId];
}
