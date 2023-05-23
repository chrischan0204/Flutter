part of 'template_designer_bloc.dart';

class TemplateDesignerState extends Equatable {
  final String newSection;
  final List<TemplateSection> templateSectionList;
  final EntityStatus templateSectionListLoadStatus;
  final EntityStatus templateSectionAddStatus;

  final List<ResponseScale> responseScaleList;
  final EntityStatus responseScaleListLoadStatus;

  final String message;
  final String templateId;
  const TemplateDesignerState({
    this.templateId = '',
    this.newSection = '',
    this.templateSectionList = const [],
    this.templateSectionListLoadStatus = EntityStatus.initial,
    this.templateSectionAddStatus = EntityStatus.initial,
    this.responseScaleList = const [],
    this.responseScaleListLoadStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object> get props => [
        templateId,
        newSection,
        templateSectionList,
        templateSectionListLoadStatus,
        templateSectionAddStatus,
        responseScaleList,
        responseScaleListLoadStatus,
        message,
      ];

  TemplateDesignerState copyWith({
    String? newSection,
    List<TemplateSection>? templateSectionList,
    EntityStatus? templateSectionListLoadStatus,
    EntityStatus? templateSectionAddStatus,
    List<ResponseScale>? responseScaleList,
    EntityStatus? responseScaleListLoadStatus,
    String? message,
    String? templateId,
  }) {
    return TemplateDesignerState(
      newSection: newSection ?? this.newSection,
      templateSectionList: templateSectionList ?? this.templateSectionList,
      templateSectionListLoadStatus:
          templateSectionListLoadStatus ?? this.templateSectionListLoadStatus,
      templateSectionAddStatus:
          templateSectionAddStatus ?? this.templateSectionAddStatus,
      responseScaleList: responseScaleList ?? this.responseScaleList,
      responseScaleListLoadStatus:
          responseScaleListLoadStatus ?? this.responseScaleListLoadStatus,
      message: message ?? this.message,
      templateId: templateId ?? this.templateId,
    );
  }
}
