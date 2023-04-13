import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/model/model.dart';
import '/data/repository/repository.dart';

part 'roles_event.dart';
part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  final RolesRepository rolesRepository;
  RolesBloc({
    required this.rolesRepository,
  }) : super(const RolesState()) {
    on<RolesRetrieved>(_onRolesRetrieved);
  }

  Future<void> _onRolesRetrieved(
    RolesRetrieved event,
    Emitter<RolesState> emit,
  ) async {
    emit(state.copyWith(rolesRetrievedStatus: EntityStatus.loading));
    try {
      List<Role> roles = await rolesRepository.getRoles();
      emit(state.copyWith(
        roles: roles,
        rolesRetrievedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(rolesRetrievedStatus: EntityStatus.failure));
    }
  }
}
