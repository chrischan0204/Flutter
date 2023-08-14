// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'response_scale_bloc.dart';

class ResponseScaleState extends Equatable {
  final List<ResponseScale> responseScaleList;
  final EntityStatus responseScaleLoadStatus;
  final EntityStatus responseScaleCrudStatus;
  final String? selectedResponseScaleId;
  final String newResponseScaleName;

  final List<TemplateResponseScaleItem> responseScaleItemList;
  final EntityStatus responseScaleItemListLoadStatus;
  final List<SortOrder> responseScaleOrderList;
  final List<SortOrder> responseScaleItemOrderList;
  final String message;

  const ResponseScaleState({
    this.responseScaleList = const [],
    this.responseScaleLoadStatus = EntityStatus.initial,
    this.responseScaleCrudStatus = EntityStatus.initial,
    this.selectedResponseScaleId,
    this.newResponseScaleName = '',
    this.responseScaleItemList = const [],
    this.responseScaleItemListLoadStatus = EntityStatus.initial,
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

  @override
  List<Object?> get props => [
        responseScaleList,
        responseScaleLoadStatus,
        responseScaleCrudStatus,
        selectedResponseScaleId,
        newResponseScaleName,
        responseScaleItemList,
        responseScaleItemListLoadStatus,
        responseScaleOrderList,
        responseScaleItemOrderList,
        message,
      ];

  ResponseScaleState copyWith({
    List<ResponseScale>? responseScaleList,
    EntityStatus? responseScaleLoadStatus,
    EntityStatus? responseScaleCrudStatus,
    String? selectedResponseScaleId,
    String? newResponseScaleName,
    List<TemplateResponseScaleItem>? responseScaleItemList,
    EntityStatus? responseScaleItemListLoadStatus,
    List<SortOrder>? responseScaleOrderList,
    List<SortOrder>? responseScaleItemOrderList,
    String? message,
  }) {
    return ResponseScaleState(
      responseScaleList: responseScaleList ?? this.responseScaleList,
      responseScaleLoadStatus:
          responseScaleLoadStatus ?? this.responseScaleLoadStatus,
      responseScaleCrudStatus:
          responseScaleCrudStatus ?? this.responseScaleCrudStatus,
      selectedResponseScaleId:
          selectedResponseScaleId ?? this.selectedResponseScaleId,
      newResponseScaleName: newResponseScaleName ?? this.newResponseScaleName,
      responseScaleItemList:
          responseScaleItemList ?? this.responseScaleItemList,
      responseScaleItemListLoadStatus: responseScaleItemListLoadStatus ??
          this.responseScaleItemListLoadStatus,
      responseScaleOrderList:
          responseScaleOrderList ?? this.responseScaleOrderList,
      responseScaleItemOrderList:
          responseScaleItemOrderList ?? this.responseScaleItemOrderList,
      message: message ?? this.message,
    );
  }
}
