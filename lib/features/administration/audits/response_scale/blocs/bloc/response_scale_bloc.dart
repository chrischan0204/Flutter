import 'package:uuid/uuid.dart';

import '../../../../../../common_libraries.dart';
import '../../data/model/response_scale_item.dart';

part 'response_scale_event.dart';
part 'response_scale_state.dart';

class ResponseScaleBloc extends Bloc<ResponseScaleEvent, ResponseScaleState> {
  final BuildContext context;

  late ResponseScalesRepository _responseScalesRepository;

  ResponseScaleBloc(this.context) : super(const ResponseScaleState()) {
    _responseScalesRepository = context.read();

    on<ResponseScaleListLoaded>(_onResponseScaleListLoaded);
    on<ResponseScaleSelected>(_onResponseScaleSelected);
    on<ResponseScaleAdded>(_onResponseScaleAdded);
    on<ResponseScaleEdited>(_onResponseScaleEdited);
    on<ResponseScaleDeleted>(_onResponseScaleDeleted);
    on<ResponseScaleListSorted>(_onResponseScaleListSorted);
    on<ResponseScaleNewResponseScaleChanged>(
        _onResponseScaleNewResponseScaleChanged);
    on<ResponseScaleItemListLoaded>(_onResponseScaleItemListLoaded);
    on<ResponseScaleItemAdded>(_onResponseScaleItemAdded);
    on<ResponseScaleItemNameChanged>(_onResponseScaleItemNameChanged);
    on<ResponseScaleItemIsRequiredChanged>(
        _onResponseScaleItemIsRequiredChanged);
    on<ResponseScaleItemScoreChanged>(_onResponseScaleItemScoreChanged);
    on<ResponseScaleItemDeleted>(_onResponseScaleItemDeleted);
    on<ResponseScaleItemListSorted>(_onResponseScaleItemListSorted);
    on<ResponseScaleItemListSaved>(_onResponseScaleItemListSaved);
  }

  Future<void> _onResponseScaleItemListSaved(
    ResponseScaleItemListSaved event,
    Emitter<ResponseScaleState> emit,
  ) async {
    emit(state.copyWith(responseScaleItemListCrudStatus: EntityStatus.loading));

    try {
      List<ResponseScaleItem> responseScaleItemList = [];

      for (int i = 0; i < state.responseScaleItemList.length; i++) {
        responseScaleItemList
            .add(state.responseScaleItemList[i].copyWith(order: i));
      }

      EntityResponse response =
          await _responseScalesRepository.updateResponseScaleItemList(
              state.selectedResponseScaleId!, responseScaleItemList);

      emit(state.copyWith(
        responseScaleItemListCrudStatus: EntityStatus.success,
        message: response.message,
      ));
    } catch (e) {
      emit(state.copyWith(
          responseScaleItemListCrudStatus: EntityStatus.failure));
    }
  }

  void _onResponseScaleItemDeleted(
    ResponseScaleItemDeleted event,
    Emitter<ResponseScaleState> emit,
  ) {
    List<ResponseScaleItem> responseScaleItemList =
        List.from(state.responseScaleItemList);

    responseScaleItemList.removeAt(event.index);

    emit(state.copyWith(responseScaleItemList: responseScaleItemList));
  }

  void _onResponseScaleItemNameChanged(
    ResponseScaleItemNameChanged event,
    Emitter<ResponseScaleState> emit,
  ) {
    emit(state.copyWith(
        responseScaleItemList: state.responseScaleItemList
            .map((e) => e.id == state.responseScaleItemList[event.index].id
                ? e.copyWith(name: event.responseScaleItemName)
                : e)
            .toList()));
  }

  void _onResponseScaleItemIsRequiredChanged(
    ResponseScaleItemIsRequiredChanged event,
    Emitter<ResponseScaleState> emit,
  ) {
    emit(state.copyWith(
        responseScaleItemList: state.responseScaleItemList
            .map((e) => e.id == state.responseScaleItemList[event.index].id
                ? e.copyWith(isRequired: event.isRequired)
                : e)
            .toList()));
  }

  void _onResponseScaleItemScoreChanged(
    ResponseScaleItemScoreChanged event,
    Emitter<ResponseScaleState> emit,
  ) {
    emit(state.copyWith(
        responseScaleItemList: state.responseScaleItemList
            .map((e) => e.id == state.responseScaleItemList[event.index].id
                ? e.copyWith(score: event.score)
                : e)
            .toList()));
  }

  void _onResponseScaleItemAdded(
    ResponseScaleItemAdded event,
    Emitter<ResponseScaleState> emit,
  ) {
    emit(state.copyWith(responseScaleItemList: [
      ResponseScaleItem(
        id: const Uuid().v1(),
        responseScaleId: state.selectedResponseScaleId ?? '',
        name: '',
        isRequired: false,
        score: '',
        order: 0,
        isNew: true,
      ),
      ...state.responseScaleItemList
    ]));
  }

  Future<void> _onResponseScaleItemListLoaded(
    ResponseScaleItemListLoaded event,
    Emitter<ResponseScaleState> emit,
  ) async {
    emit(state.copyWith(responseScaleItemListLoadStatus: EntityStatus.loading));
    try {
      List<ResponseScaleItem> responseScaleItemList =
          await _responseScalesRepository
              .getResponseScaleItemList(event.responseScaleId);

      emit(state.copyWith(
        responseScaleItemList: responseScaleItemList,
        responseScaleItemListLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          responseScaleItemListLoadStatus: EntityStatus.success));
    }
  }

  void _onResponseScaleNewResponseScaleChanged(
    ResponseScaleNewResponseScaleChanged event,
    Emitter<ResponseScaleState> emit,
  ) {
    emit(state.copyWith(newResponseScaleName: event.responseScale));
  }

  Future<void> _onResponseScaleSelected(
    ResponseScaleSelected event,
    Emitter<ResponseScaleState> emit,
  ) async {
    emit(
        state.copyWith(selectedResponseScaleId: event.selectedResponseScaleId));

    add(ResponseScaleItemListLoaded(
        responseScaleId: event.selectedResponseScaleId));
  }

  Future<void> _onResponseScaleListLoaded(
    ResponseScaleListLoaded event,
    Emitter<ResponseScaleState> emit,
  ) async {
    emit(state.copyWith(responseScaleLoadStatus: EntityStatus.loading));
    try {
      List<ResponseScale> responseScaleList =
          await _responseScalesRepository.getResponseScaleList();
      emit(state.copyWith(
        responseScaleList: responseScaleList,
        responseScaleLoadStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(responseScaleLoadStatus: EntityStatus.failure));
    }
  }

  Future<void> _onResponseScaleAdded(
    ResponseScaleAdded event,
    Emitter<ResponseScaleState> emit,
  ) async {
    emit(state.copyWith(responseScaleCrudStatus: EntityStatus.loading));
    try {
      EntityResponse response = await _responseScalesRepository
          .addResponseScale(state.newResponseScaleName);

      if (response.isSuccess) {
        emit(state.copyWith(
          responseScaleCrudStatus: EntityStatus.success,
          message: response.message,
        ));

        add(ResponseScaleListLoaded());
      }
    } catch (e) {
      emit(state.copyWith(responseScaleCrudStatus: EntityStatus.failure));
    }
  }

  Future<void> _onResponseScaleEdited(
    ResponseScaleEdited event,
    Emitter<ResponseScaleState> emit,
  ) async {
    try {
      EntityResponse response = await _responseScalesRepository
          .editResponseScale(event.responseScaleId, event.responseScaleName);

      if (response.isSuccess) {
        add(ResponseScaleListLoaded());
      }
    } catch (e) {}
  }

  Future<void> _onResponseScaleDeleted(
    ResponseScaleDeleted event,
    Emitter<ResponseScaleState> emit,
  ) async {
    try {
      EntityResponse response = await _responseScalesRepository
          .deleteResponseScale(event.responseScaleId);

      if (response.isSuccess) {
        add(ResponseScaleListLoaded());
      }
    } catch (e) {}
  }

  Future<void> _onResponseScaleListSorted(
    ResponseScaleListSorted event,
    Emitter<ResponseScaleState> emit,
  ) async {
    final List<ResponseScale> responseScaleList =
        List.from(state.responseScaleList);
    final List<ResponseScale> savedResponseScaleList =
        List.from(state.responseScaleList);

    int draggingIndex = responseScaleList
        .indexWhere((element) => ValueKey(element.id) == event.currentId);
    int newIndex = responseScaleList
        .indexWhere((element) => ValueKey(element.id) == event.newId);

    final draggedItem = responseScaleList[draggingIndex];

    responseScaleList.removeAt(draggingIndex);
    responseScaleList.insert(newIndex, draggedItem);

    List<SortOrder> sortOrderList = [];

    for (int i = 0; i < responseScaleList.length; i++) {
      sortOrderList.add(SortOrder(id: responseScaleList[i].id, order: i));
    }

    if (sortOrderList != state.responseScaleOrderList) {
      emit(state.copyWith(
        responseScaleList: responseScaleList,
        responseScaleOrderList: sortOrderList,
      ));

      try {
        // await _templatesRepository.sortTemplateSectionList(sortOrderList);
      } catch (e) {
        emit(state.copyWith(responseScaleList: savedResponseScaleList));
      }
    }
  }

  Future<void> _onResponseScaleItemListSorted(
    ResponseScaleItemListSorted event,
    Emitter<ResponseScaleState> emit,
  ) async {
    final List<ResponseScaleItem> responseScaleItemList =
        List.from(state.responseScaleItemList);

    int draggingIndex = responseScaleItemList
        .indexWhere((element) => ValueKey(element.id) == event.currentId);
    int newIndex = responseScaleItemList
        .indexWhere((element) => ValueKey(element.id) == event.newId);

    final draggedItem = responseScaleItemList[draggingIndex];

    responseScaleItemList.removeAt(draggingIndex);
    responseScaleItemList.insert(newIndex, draggedItem);

    emit(state.copyWith(responseScaleItemList: responseScaleItemList));
  }
}
