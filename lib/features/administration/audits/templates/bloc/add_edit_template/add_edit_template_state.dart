part of 'add_edit_template_bloc.dart';

class AddEditTemplateState extends Equatable {
  final String createdTemplateId;

  final String templateDescription;
  final String templateDescriptionValidationMessage;

  final DateTime? date;
  final String dateValidationMesage;

  final bool usedInAudit;
  final bool usedInInspection;

  final EntityStatus templateAddEditStatus;
  final EntityStatus templateEditStatus;
  final String message;

  const AddEditTemplateState({
    this.createdTemplateId = '',
    this.templateDescription = '',
    this.templateDescriptionValidationMessage = '',
    this.date,
    this.dateValidationMesage = '',
    this.usedInAudit = false,
    this.usedInInspection = false,
    this.templateAddEditStatus = EntityStatus.initial,
    this.templateEditStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        createdTemplateId,
        templateDescription,
        templateDescriptionValidationMessage,
        date,
        dateValidationMesage,
        usedInAudit,
        usedInInspection,
        templateAddEditStatus,
        templateEditStatus,
        message,
      ];

  bool get templateDetailFilled => !(Validation.isEmpty(templateDescription) &&
      Validation.isEmpty(date?.toIso8601String()));

  AddEditTemplateState copyWith({
    String? createdTemplateId,
    String? templateDescription,
    String? templateDescriptionValidationMessage,
    DateTime? date,
    String? dateValidationMesage,
    bool? usedInAudit,
    bool? usedInInspection,
    EntityStatus? templateAddEditStatus,
    EntityStatus? templateEditStatus,
    String? message,
  }) {
    return AddEditTemplateState(
      createdTemplateId: createdTemplateId ?? this.createdTemplateId,
      templateDescription: templateDescription ?? this.templateDescription,
      templateDescriptionValidationMessage:
          templateDescriptionValidationMessage ??
              this.templateDescriptionValidationMessage,
      date: date ?? this.date,
      dateValidationMesage: dateValidationMesage ?? this.dateValidationMesage,
      usedInAudit: usedInAudit ?? this.usedInAudit,
      usedInInspection: usedInInspection ?? this.usedInInspection,
      templateAddEditStatus: templateAddEditStatus ?? this.templateAddEditStatus,
      templateEditStatus: templateEditStatus ?? this.templateEditStatus,
      message: message ?? this.message,
    );
  }
}
