// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'response_scale_bloc.dart';

class ResponseScaleState extends Equatable {
  final List<ResponseScale> responseScaleList;
  final EntityStatus responseScaleLoadStatus;
  final EntityStatus responseScaleAddStatus;
  final EntityStatus responseScaleEditDeleteStatus;
  final EntityStatus responseScaleItemDeleteStatus;
  final String? selectedResponseScaleId;
  final String newResponseScaleName;

  final List<ResponseScaleItem> responseScaleItemList;
  final EntityStatus responseScaleItemListLoadStatus;
  final EntityStatus responseScaleItemListCrudStatus;
  final List<SortOrder> responseScaleOrderList;
  final List<SortOrder> responseScaleItemOrderList;
  final String message;

  const ResponseScaleState({
    this.responseScaleList = const [],
    this.responseScaleLoadStatus = EntityStatus.initial,
    this.responseScaleAddStatus = EntityStatus.initial,
    this.responseScaleItemDeleteStatus = EntityStatus.initial,
    this.selectedResponseScaleId,
    this.newResponseScaleName = '',
    this.responseScaleItemList = const [],
    this.responseScaleItemListLoadStatus = EntityStatus.initial,
    this.responseScaleItemListCrudStatus = EntityStatus.initial,
    this.responseScaleEditDeleteStatus = EntityStatus.initial,
    this.responseScaleOrderList = const [],
    this.responseScaleItemOrderList = const [],
    this.message = '',
  });

  ResponseScale? get selectedResponseScale {
    try {
      return responseScaleList
          .firstWhere((element) => element.id == selectedResponseScaleId);
    } catch (e) {
      return null;
    }
  }

  bool get isDirty => responseScaleItemList
      .where((element) =>
          Validation.isEmpty(element.name) || Validation.isEmpty(element.score))
      .isNotEmpty;

  bool get isSaveButtonEnable => !isDirty && responseScaleItemList.isNotEmpty;

  @override
  List<Object?> get props => [
        responseScaleList,
        responseScaleLoadStatus,
        responseScaleAddStatus,
        selectedResponseScaleId,
        newResponseScaleName,
        responseScaleItemList,
        responseScaleItemListLoadStatus,
        responseScaleItemListCrudStatus,
        responseScaleItemDeleteStatus,
        responseScaleEditDeleteStatus,
        responseScaleOrderList,
        responseScaleItemOrderList,
        message,
      ];

  ResponseScaleState copyWith({
    List<ResponseScale>? responseScaleList,
    EntityStatus? responseScaleLoadStatus,
    EntityStatus? responseScaleAddStatus,
    Nullable<String?>? selectedResponseScaleId,
    String? newResponseScaleName,
    List<ResponseScaleItem>? responseScaleItemList,
    EntityStatus? responseScaleItemListLoadStatus,
    EntityStatus? responseScaleItemListCrudStatus,
    EntityStatus? responseScaleEditDeleteStatus,
    EntityStatus? responseScaleItemDeleteStatus,
    List<SortOrder>? responseScaleOrderList,
    List<SortOrder>? responseScaleItemOrderList,
    String? message,
  }) {
    return ResponseScaleState(
      responseScaleList: responseScaleList ?? this.responseScaleList,
      responseScaleLoadStatus:
          responseScaleLoadStatus ?? this.responseScaleLoadStatus,
      responseScaleAddStatus:
          responseScaleAddStatus ?? this.responseScaleAddStatus,
      selectedResponseScaleId: selectedResponseScaleId != null
          ? selectedResponseScaleId.value
          : this.selectedResponseScaleId,
      newResponseScaleName: newResponseScaleName ?? this.newResponseScaleName,
      responseScaleItemList:
          responseScaleItemList ?? this.responseScaleItemList,
      responseScaleItemListLoadStatus: responseScaleItemListLoadStatus ??
          this.responseScaleItemListLoadStatus,
      responseScaleItemListCrudStatus: responseScaleItemListCrudStatus ??
          this.responseScaleItemListCrudStatus,
      responseScaleItemDeleteStatus:
          responseScaleItemDeleteStatus ?? this.responseScaleItemDeleteStatus,
      responseScaleEditDeleteStatus:
          responseScaleEditDeleteStatus ?? this.responseScaleEditDeleteStatus,
      responseScaleOrderList:
          responseScaleOrderList ?? this.responseScaleOrderList,
      responseScaleItemOrderList:
          responseScaleItemOrderList ?? this.responseScaleItemOrderList,
      message: message ?? this.message,
    );
  }
}
