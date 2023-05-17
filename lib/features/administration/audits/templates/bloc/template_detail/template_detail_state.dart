part of 'template_detail_bloc.dart';

class TemplateDetailState extends Equatable {
  final Template? template;
  final EntityStatus templateLoadStatus;
  final EntityStatus templateDeleteStatus;
  final String message;
  const TemplateDetailState({
    this.template,
    this.templateLoadStatus = EntityStatus.initial,
    this.templateDeleteStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        template,
        templateLoadStatus,
        templateDeleteStatus,
        message,
      ];

  TemplateDetailState copyWith({
    Template? template,
    EntityStatus? templateLoadStatus,
    EntityStatus? templateSiteAssignmentListLoadStatus,
    EntityStatus? templateSiteNotificationListLoadStatus,
    EntityStatus? templateDeleteStatus,
    String? message,
  }) {
    return TemplateDetailState(
      template: template ?? this.template,
      templateLoadStatus: templateLoadStatus ?? this.templateLoadStatus,
      templateDeleteStatus: templateDeleteStatus ?? this.templateDeleteStatus,
      message: message ?? this.message,
    );
  }
}
