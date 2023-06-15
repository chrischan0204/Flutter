import '../bloc/add_edit_company/add_edit_company_bloc.dart';
import '/common_libraries.dart';

class AddEditCompanyView extends StatelessWidget {
  final String? companyId;
  final String? view;
  const AddEditCompanyView({
    super.key,
    this.companyId,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddEditCompanyBloc(
            companiesRepository: RepositoryProvider.of(context),
            formDirtyBloc: context.read(),
          ),
        ),
      ],
      child: AddEditCompanyWidget(
        companyId: companyId,
        view: view,
      ),
    );
  }
}

class AddEditCompanyWidget extends StatefulWidget {
  final String? companyId;
  final String? view;
  const AddEditCompanyWidget({
    super.key,
    this.companyId,
    this.view,
  });

  @override
  State<AddEditCompanyWidget> createState() => _AddEditCompanyWidgetState();
}

class _AddEditCompanyWidgetState extends State<AddEditCompanyWidget> {
  late AddEditCompanyBloc _addEditCompanyBloc;

  static String pageLabel = 'company';
  static String editButtonName = 'Update Details';

  Map<String, Widget> get tabViews => widget.companyId != null
      ? {
          'Sites': AssignSitesToCompanyView(
            companyId: widget.companyId!,
            view: widget.view,
          ),
          'Projects': AssignProjectsToCompanyView(
            companyId: widget.companyId!,
            view: widget.view,
          ),
        }
      : {};

  @override
  void initState() {
    _addEditCompanyBloc = context.read();

    if (widget.companyId != null) {
      _addEditCompanyBloc.add(AddEditCompanyLoaded(id: widget.companyId!));
      context.read<SitesBloc>().add(SitesRetrieved());
      context.read<RolesBloc>().add(RolesRetrieved());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditCompanyBloc, AddEditCompanyState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          if (widget.companyId == null) {
            GoRouter.of(context)
                .go('/companies/edit/${state.createdCompanyId}?view=created');
          }
        } else if (state.status.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.companyId,
          selectedEntity: state.loadedCompany,
          addEntity: () => _addEditCompanyBloc.add(AddEditCompanyAdded()),
          editEntity: () => _addEditCompanyBloc
              .add(AddEditCompanyEdited(id: widget.companyId ?? '')),
          crudStatus: state.status,
          formDirty: state.formDirty,
          tabItems: tabViews,
          editButtonName: editButtonName,
          view: widget.view,
          child: Column(
            children: [
              _buildCompanyNameField(),
              _buildEinNumberField(),
            ],
          ),
        );
      },
    );
  }

  // return text field for company name
  Widget _buildCompanyNameField() {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(
      builder: (context, state) {
        return FormItem(
          label: 'Company Name (*)',
          content: CustomTextField(
            key: ValueKey(state.loadedCompany?.id),
            initialValue: state.companyName,
            hintText: 'Company Name',
            onChanged: (name) =>
                _addEditCompanyBloc.add(AddEditCompanyNameChanged(name: name)),
          ),
          message: state.companyNameValidationMessage,
        );
      },
    );
  }

  // return text field for reference number
  Widget _buildEinNumberField() {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(
      builder: (context, state) {
        return FormItem(
          label: 'EIN Number',
          content: CustomTextField(
            key: ValueKey(state.loadedCompany?.id),
            initialValue: state.einNumber,
            hintText: 'Company EIN #',
            onChanged: (einNumber) => _addEditCompanyBloc
                .add(AddEditCompanyEinNumberChanged(einNumber: einNumber)),
          ),
          message: state.einNumberValidationMessage,
        );
      },
    );
  }
}
