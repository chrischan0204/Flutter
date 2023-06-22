// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_action_item_bloc.dart';

class AddActionItemState extends Equatable {
  final AwarenessCategory? category;
  final String? observationType;
  final PriorityLevel? priorityLevel;

  /// written against
  final Company? company;
  final Project? project;

  /// other data points
  final Site? site;
  final String observer;
  final String reportedVia;
  final String followUpCloseout;
  final bool markAsClosed;
  final bool notifySender;

  const AddActionItemState({
    this.category,
    this.observationType,
    this.priorityLevel,
    this.company,
    this.project,
    this.site,
    this.observer = '',
    this.reportedVia = '',
    this.followUpCloseout = '',
    this.markAsClosed = false,
    this.notifySender = false,
  });

  @override
  List<Object?> get props => [
        category,
        observationType,
        priorityLevel,
        company,
        project,
        site,
        observer,
        reportedVia,
        followUpCloseout,
        markAsClosed,
        notifySender,
      ];
}
