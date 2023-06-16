part of 'add_edit_template_bloc.dart';

class AddEditTemplateState extends Equatable {
  /// creted template id
  final String createdTemplateId;

  /// loaded template by id
  final Template? loadedTemplate;

  /// template description
  final String templateDescription;

  /// initial template description to check form dirty
  final String initialTemplateDescription;

  /// validation message for template description
  final String templateDescriptionValidationMessage;

  /// revised date
  final DateTime? date;

  /// initial revised date to check form dirty
  final DateTime? initialDate;

  /// validation message for revised date;
  final String dateValidationMesage;

  /// creation & edition template status
  final EntityStatus status;

  /// response message
  final String message;

  const AddEditTemplateState({
    this.createdTemplateId = '',
    this.loadedTemplate,
    this.templateDescription = '',
    this.initialTemplateDescription = '',
    this.templateDescriptionValidationMessage = '',
    this.date,
    this.initialDate,
    this.dateValidationMesage = '',
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        createdTemplateId,
        loadedTemplate,
        templateDescription,
        initialTemplateDescription,
        templateDescriptionValidationMessage,
        date,
        dateValidationMesage,
        initialDate,
        status,
        message,
      ];

  bool get formDirty =>
      (!Validation.isEmpty(templateDescription) &&
          templateDescription != initialTemplateDescription) ||
      (!Validation.isEmpty(date?.toIso8601String()) && date != initialDate);

  Template get template => Template(
        name: templateDescription,
        revisionDate: date!.toIso8601String(),
      );

  AddEditTemplateState copyWith({
    String? createdTemplateId,
    Template? loadedTemplate,
    String? templateDescription,
    String? initialTemplateDescription,
    String? templateDescriptionValidationMessage,
    DateTime? date,
    DateTime? initialDate,
    String? dateValidationMesage,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditTemplateState(
      createdTemplateId: createdTemplateId ?? this.createdTemplateId,
      loadedTemplate: loadedTemplate ?? this.loadedTemplate,
      templateDescription: templateDescription ?? this.templateDescription,
      templateDescriptionValidationMessage:
          templateDescriptionValidationMessage ??
              this.templateDescriptionValidationMessage,
      initialTemplateDescription:
          initialTemplateDescription ?? this.initialTemplateDescription,
      date: date ?? this.date,
      initialDate: initialDate ?? this.initialDate,
      dateValidationMesage: dateValidationMesage ?? this.dateValidationMesage,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
