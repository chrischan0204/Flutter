part of 'add_edit_template_bloc.dart';

abstract class AddEditTemplateEvent extends Equatable {
  const AddEditTemplateEvent();

  @override
  List<Object> get props => [];
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
  final String date;
  const AddEditTemplateDateChanged({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

class AddEditTemplateUsedInInspection extends AddEditTemplateEvent {
  final bool usedInInspection;
  const AddEditTemplateUsedInInspection({
    required this.usedInInspection,
  });

  @override
  List<Object> get props => [usedInInspection];
}

class AddEditTemplateUsedInAudit extends AddEditTemplateEvent {
  final bool usedInAudit;
  const AddEditTemplateUsedInAudit({
    required this.usedInAudit,
  });

  @override
  List<Object> get props => [usedInAudit];
}

class AddEditTemplateTemplateAdded extends AddEditTemplateEvent {}
