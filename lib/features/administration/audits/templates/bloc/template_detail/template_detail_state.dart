part of 'template_detail_bloc.dart';

class TemplateDetailState extends Equatable {
  final Template? template;
  final List<TemplateSnapshot> templateSnapshotList;
  final EntityStatus templateSnapshotListLoadStatus;
  final EntityStatus templateLoadStatus;
  final EntityStatus templateDeleteStatus;
  final String message;
  const TemplateDetailState({
    this.template,
    this.templateSnapshotList = const [],
    this.templateLoadStatus = EntityStatus.initial,
    this.templateDeleteStatus = EntityStatus.initial,
    this.templateSnapshotListLoadStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        template,
        templateSnapshotList,
        templateSnapshotListLoadStatus,
        templateLoadStatus,
        templateDeleteStatus,
        message,
      ];

  TemplateDetailState copyWith({
    Template? template,
    List<TemplateSnapshot>? templateSnapshotList,
    EntityStatus? templateSnapshotListLoadStatus,
    EntityStatus? templateLoadStatus,
    EntityStatus? templateSiteAssignmentListLoadStatus,
    EntityStatus? templateSiteNotificationListLoadStatus,
    EntityStatus? templateDeleteStatus,
    String? message,
  }) {
    return TemplateDetailState(
      template: template ?? this.template,
      templateSnapshotList: templateSnapshotList ?? this.templateSnapshotList,
      templateLoadStatus: templateLoadStatus ?? this.templateLoadStatus,
      templateDeleteStatus: templateDeleteStatus ?? this.templateDeleteStatus,
      message: message ?? this.message,
    );
  }
}
