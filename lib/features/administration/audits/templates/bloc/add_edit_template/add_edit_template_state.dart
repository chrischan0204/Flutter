part of 'add_edit_template_bloc.dart';

class AddEditTemplateState extends Equatable {
  final String templateDescription;
  final String templateDescriptionValidationMessage;

  final DateTime? date;
  final String dateValidationMesage;

  final bool usedInAudit;
  final bool usedInInspection;

  final EntityStatus templateAddStatus;
  final EntityStatus templateEditStatus;
  final String message;

  const AddEditTemplateState({
    this.templateDescription = '',
    this.templateDescriptionValidationMessage = '',
    this.date,
    this.dateValidationMesage = '',
    this.usedInAudit = false,
    this.usedInInspection = false,
    this.templateAddStatus = EntityStatus.initial,
    this.templateEditStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        templateDescription,
        templateDescriptionValidationMessage,
        date,
        dateValidationMesage,
        usedInAudit,
        usedInInspection,
        templateAddStatus,
        templateEditStatus,
        message,
      ];

  bool get templateDetailFilled => !(Validation.isEmpty(templateDescription) &&
      Validation.isEmpty(date?.toIso8601String()));

  AddEditTemplateState copyWith({
    String? templateDescription,
    String? templateDescriptionValidationMessage,
    DateTime? date,
    String? dateValidationMesage,
    bool? usedInAudit,
    bool? usedInInspection,
    EntityStatus? templateAddStatus,
    EntityStatus? templateEditStatus,
    String? message,
  }) {
    return AddEditTemplateState(
      templateDescription: templateDescription ?? this.templateDescription,
      templateDescriptionValidationMessage:
          templateDescriptionValidationMessage ??
              this.templateDescriptionValidationMessage,
      date: date ?? this.date,
      dateValidationMesage: dateValidationMesage ?? this.dateValidationMesage,
      usedInAudit: usedInAudit ?? this.usedInAudit,
      usedInInspection: usedInInspection ?? this.usedInInspection,
      templateAddStatus: templateAddStatus ?? this.templateAddStatus,
      templateEditStatus: templateEditStatus ?? this.templateEditStatus,
      message: message ?? this.message,
    );
  }
}
