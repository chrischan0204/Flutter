part of 'add_edit_company_bloc.dart';

abstract class AddEditCompanyEvent extends Equatable {
  const AddEditCompanyEvent();

  @override
  List<Object> get props => [];
}

/// event to add company
class AddEditCompanyAdded extends AddEditCompanyEvent {}

/// event to edit company
class AddEditCompanyEdited extends AddEditCompanyEvent {
  /// company id to edit
  final String id;
  const AddEditCompanyEdited({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to load the company by id
class AddEditCompanyLoaded extends AddEditCompanyEvent {
  /// company id to load
  final String id;
  const AddEditCompanyLoaded({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

/// event to change the company name
class AddEditCompanyNameChanged extends AddEditCompanyEvent {
  /// company name to change
  final String name;
  const AddEditCompanyNameChanged({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

/// event to change the ein number
class AddEditCompanyEinNumberChanged extends AddEditCompanyEvent {
  /// company name to change
  final String einNumber;
  const AddEditCompanyEinNumberChanged({
    required this.einNumber,
  });

  @override
  List<Object> get props => [einNumber];
}
