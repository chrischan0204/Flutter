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
    on<RolesLoaded>(_onRolesLoaded);
  }

  Future<void> _onRolesLoaded(
    RolesLoaded event,
    Emitter<RolesState> emit,
  ) async {
    emit(state.copyWith(rolesLoadedStatus: EntityStatus.loading));
    try {
      List<Role> roles = await rolesRepository.getRoles();
      emit(state.copyWith(
        roles: roles,
        rolesLoadedStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(rolesLoadedStatus: EntityStatus.failure));
    }
  }
}
