import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditObservationView extends StatelessWidget {
  final String? observationId;
  final String? view;
  const AddEditObservationView({
    super.key,
    this.observationId,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditObservationBloc(context),
      child: AddEditObservationWidget(observationId: observationId),
    );
  }
}

class AddEditObservationWidget extends StatefulWidget {
  final String? observationId;
  final String? view;
  const AddEditObservationWidget({
    super.key,
    this.observationId,
    this.view,
  });

  @override
  State<AddEditObservationWidget> createState() =>
      _AddEditObservationWidgetState();
}

class _AddEditObservationWidgetState extends State<AddEditObservationWidget> {
  late AddEditObservationBloc addEditObservationBloc;

  static String pageLabel = 'observation';

  @override
  void initState() {
    addEditObservationBloc = context.read();

    if (widget.observationId != null) {
      addEditObservationBloc
          .add(AddEditObservationLoaded(id: widget.observationId!));
    }

    super.initState();
  }

  Map<String, Widget> get tabItems => widget.observationId != null
      ? {
          'Observation questions': Container(),
        }
      : {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditObservationBloc, AddEditObservationState>(
      listener: (context, state) {
        if (state.status == EntityStatus.success) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          if (widget.observationId == null) {
            GoRouter.of(context).go(
                '/observations/edit/${state.createdObservationId}?view=created');
          }
        }
        if (state.status == EntityStatus.failure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.observationId,
          selectedEntity: state.loadedObservation,
          addEntity: () =>
              addEditObservationBloc.add(AddEditObservationAdded()),
          editEntity: () => addEditObservationBloc
              .add(AddEditObservationEdited(id: widget.observationId ?? '')),
          crudStatus: state.status,
          tabItems: tabItems,
          view: widget.view,
          formDirty: state.formDirty,
          child: const AddEditObservationFormView(),
        );
      },
    );
  }
}
