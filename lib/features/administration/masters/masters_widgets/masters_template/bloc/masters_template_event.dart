// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'masters_template_bloc.dart';

abstract class MastersTemplateEvent extends Equatable {
  const MastersTemplateEvent();

  @override
  List<Object> get props => [];
}

class MastersTemplateCrudTypeChanged extends MastersTemplateEvent {
  final CrudType crudType;
  const MastersTemplateCrudTypeChanged({
    required this.crudType,
  });
  @override
  List<Object> get props => [
        crudType,
      ];
}
