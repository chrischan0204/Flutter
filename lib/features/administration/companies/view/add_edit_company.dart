import '/common_libraries.dart';

class AddEditCompanyView extends StatefulWidget {
  final String? companyId;
  final String? view;
  const AddEditCompanyView({
    super.key,
    this.companyId,
    this.view,
  });

  @override
  State<AddEditCompanyView> createState() => _AddEditCompanyViewState();
}

class _AddEditCompanyViewState extends State<AddEditCompanyView> {
  late CompaniesBloc companiesBloc;
  late SitesBloc sitesBloc;
  late RolesBloc rolesBloc;
  TextEditingController companyNameController = TextEditingController(text: '');
  TextEditingController einNumberController = TextEditingController(text: '');
  String companyNameValidationMessage = '';
  String einNumberValidationMessage = '';

  bool isFirstInit = true;

  static String pageLabel = 'company';
  static String editButtonName = 'Update Details';

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>();
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    if (widget.companyId != null) {
      companiesBloc.add(CompanySelectedById(companyId: widget.companyId!));
      rolesBloc = context.read<RolesBloc>()..add(RolesRetrieved());
    } else {
      companiesBloc.add(const CompanySelected(selectedCompany: Company()));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompaniesBloc, CompaniesState>(
      listener: (context, state) {
        _changeFormData(state);
        _checkCrudResult(state, context);
      },
      // listenWhen: (previous, current) =>
      //     previous.selectedCompany != current.selectedCompany,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.companyId,
          selectedEntity: state.selectedCompany,
          addEntity: () => _addCompany(state),
          editEntity: () => _editCompany(state),
          isCrudDataFill: state.isFormDataFill,
          crudStatus: state.companyCrudStatus,
          tabItems: _buildTabs(state),
          editButtonName: editButtonName,
          view: widget.view,
          child: Column(
            children: [
              _buildCompanyNameField(state),
              _buildEinNumberField(state),
            ],
          ),
        );
      },
    );
  }

  Map<String, Widget> _buildTabs(CompaniesState state) {
    if (widget.companyId != null) {
      return {
        'Sites': AssignSitesToCompanyView(
          companyId: widget.companyId!,
          companyName: state.selectedCompany?.name ?? '',
          view: widget.view,
        ),
        'Projects': AssignProjectsToCompanyView(
          companyId: widget.companyId!,
          companyName: state.selectedCompany?.name ?? '',
          view: widget.view,
        ),
      };
    }
    return {};
  }

  // check if some of fields are filled
  bool _checkFormDataFill() {
    return companyNameController.text.trim().isNotEmpty ||
        einNumberController.text.trim().isNotEmpty;
  }

  // change form data whenever the state changes
  void _changeFormData(CompaniesState state) {
    if (state.selectedCompany != null) {
      if (isFirstInit) {
        companyNameController.text =
            widget.companyId == null ? '' : state.selectedCompany!.name ?? '';
        einNumberController.text =
            widget.companyId == null ? '' : state.selectedCompany!.einNumber;
        isFirstInit = false;
        _checkFormDirty();
      }
    }
  }

  bool _checkEinNumber(String einNumber) {
    // final numericSpecialReg = RegExp(r'^[0-9. -]+$');
    final reg = RegExp(r'^\d{2}-\d{7}');
    return reg.hasMatch(einNumber);
  }

  void _clearForm() {
    if (widget.companyId == null) {
      companyNameController.clear();
      einNumberController.clear();
    }
  }

  // check if the crud result is success or failure
  void _checkCrudResult(CompaniesState state, BuildContext context) {
    if (state.companyCrudStatus == EntityStatus.success) {
      companiesBloc.add(CompaniesStatusInited());

      _clearForm();

      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
      if (widget.companyId == null) {
        GoRouter.of(context)
            .go('/companies/edit/${state.selectedCompany!.id}?view=created');
      }
    }
    if (state.companyCrudStatus == EntityStatus.failure) {
      if (state.message.contains('EIN')) {
        setState(() {
          einNumberValidationMessage = state.message;
          companyNameValidationMessage = '';
        });
      } else if (state.message.contains('Our team')) {
        CustomNotification(
          context: context,
          notifyType: NotifyType.error,
          content: state.message,
        ).showNotification();
      } else if (state.message.isNotEmpty) {
        setState(() {
          companyNameValidationMessage = state.message;
          einNumberValidationMessage = '';
        });
      }
      companiesBloc.add(CompaniesStatusInited());
    }
  }

  void _checkFormDirty() {
    context.read<FormDirtyBloc>().add(FormDirtyChanged(
        isDirty: widget.view == 'created' ? false : _checkFormDataFill()));
  }

  // return text field for company name
  Widget _buildCompanyNameField(CompaniesState state) {
    return BlocListener<CompaniesBloc, CompaniesState>(
      listener: (context, state) {},
      listenWhen: (previous, current) =>
          previous.selectedCompany != current.selectedCompany,
      child: FormItem(
        label: 'Company Name (*)',
        content: CustomTextField(
          controller: companyNameController,
          hintText: 'Company Name',
          onChanged: (companyName) {
            setState(() {
              companyNameValidationMessage = '';
            });
            _checkFormDirty();

            companiesBloc.add(
              CompanySelected(
                selectedCompany: state.selectedCompany!.copyWith(
                  name: companyName,
                ),
              ),
            );
          },
        ),
        message: companyNameValidationMessage,
      ),
    );
  }

  // return text field for reference number
  FormItem _buildEinNumberField(CompaniesState state) {
    return FormItem(
      label: 'EIN Number',
      content: CustomTextField(
        controller: einNumberController,
        hintText: 'Company EIN #',
        onChanged: (einNumber) {
          setState(() {
            einNumberValidationMessage = '';
          });
          _checkFormDirty();
          companiesBloc.add(
            CompanySelected(
              selectedCompany: state.selectedCompany!.copyWith(
                einNumber: einNumber,
              ),
            ),
          );
        },
      ),
      message: einNumberValidationMessage,
    );
  }

  // check if field are empty
  bool _validate() {
    bool validated = true;
    if (companyNameController.text.isEmpty ||
        companyNameController.text.trim().isEmpty) {
      setState(() {
        companyNameValidationMessage =
            'Company name is required and cannot be blank.';
      });

      validated = false;
    }

    if (einNumberController.text.isNotEmpty &&
        !_checkEinNumber(einNumberController.text)) {
      setState(() {
        einNumberValidationMessage =
            'EIN Number can have only Number and Dahses in the format XX-XXXXXXX.';
      });
      validated = false;
    }

    return validated;
  }

  // call event to add company
  void _addCompany(CompaniesState state) {
    if (!_validate()) return;
    companiesBloc.add(CompanyAdded(company: state.selectedCompany!));
  }

  // call even to edit company
  void _editCompany(CompaniesState state) {
    if (!_validate()) return;
    companiesBloc.add(CompanyEdited(company: state.selectedCompany!));
  }
}
