part of 'add_edit_template_bloc.dart';

class AddEditTemplateState extends Equatable {
  final String createdTemplateId;

  final String templateDescription;
  final String templateDescriptionValidationMessage;

  final DateTime? date;
  final String dateValidationMesage;

  final EntityStatus templateAddEditStatus;
  final EntityStatus templateEditStatus;
  final String message;

  const AddEditTemplateState({
    this.createdTemplateId = '',
    this.templateDescription = '',
    this.templateDescriptionValidationMessage = '',
    this.date,
    this.dateValidationMesage = '',
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
      templateAddEditStatus:
          templateAddEditStatus ?? this.templateAddEditStatus,
      templateEditStatus: templateEditStatus ?? this.templateEditStatus,
      message: message ?? this.message,
    );
  }
}
