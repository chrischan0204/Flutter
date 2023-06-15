// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_company_bloc.dart';

class AddEditCompanyState extends Equatable {
  /// created company id
  final String? createdCompanyId;

  /// loaded company
  final Company? loadedCompany;

  /// company name
  final String companyName;

  /// EIN number
  final String einNumber;

  /// initial company name for check dirty
  final String initialCompanyName;

  /// initial ein number for check dirty
  final String initialEinNumber;

  /// validation message for company name
  final String companyNameValidationMessage;

  /// validation message for ein number
  final String einNumberValidationMessage;

  /// creation & edition company status
  final EntityStatus status;

  /// response message from server
  final String message;

  const AddEditCompanyState({
    this.companyName = '',
    this.einNumber = '',
    this.createdCompanyId,
    this.loadedCompany,
    this.companyNameValidationMessage = '',
    this.einNumberValidationMessage = '',
    this.initialCompanyName = '',
    this.initialEinNumber = '',
    this.status = EntityStatus.initial,
    this.message = '',
  });

  /// check if the form is dirty
  bool get formDirty =>
      (!Validation.isEmpty(companyName) && initialCompanyName != companyName) ||
      (!Validation.isEmpty(einNumber) && initialEinNumber != einNumber);

  @override
  List<Object?> get props => [
        companyName,
        einNumber,
        createdCompanyId,
        loadedCompany,
        initialCompanyName,
        initialEinNumber,
        companyNameValidationMessage,
        einNumberValidationMessage,
        message,
        status,
      ];

  AddEditCompanyState copyWith({
    String? createdCompanyId,
    Company? loadedCompany,
    String? companyName,
    String? einNumber,
    String? initialCompanyName,
    String? initialEinNumber,
    String? companyNameValidationMessage,
    String? einNumberValidationMessage,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditCompanyState(
      createdCompanyId: createdCompanyId ?? this.createdCompanyId,
      loadedCompany: loadedCompany ?? this.loadedCompany,
      companyName: companyName ?? this.companyName,
      einNumber: einNumber ?? this.einNumber,
      initialCompanyName: initialCompanyName ?? this.initialCompanyName,
      initialEinNumber: initialEinNumber ?? this.initialEinNumber,
      companyNameValidationMessage:
          companyNameValidationMessage ?? this.companyNameValidationMessage,
      einNumberValidationMessage:
          einNumberValidationMessage ?? this.einNumberValidationMessage,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
