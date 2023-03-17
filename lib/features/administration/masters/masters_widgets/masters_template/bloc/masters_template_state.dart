// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'masters_template_bloc.dart';

enum CrudType {
  add,
  editOrDelete,
}

class MastersTemplateState extends Equatable {
  final CrudType crudType;
  const MastersTemplateState({
    this.crudType = CrudType.add,
  });

  @override
  List<Object> get props => [
        crudType,
      ];

  MastersTemplateState copyWith({
    CrudType? crudType,
  }) {
    return MastersTemplateState(
      crudType: crudType ?? this.crudType,
    );
  }
}
