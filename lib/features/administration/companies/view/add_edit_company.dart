import '/common_libraries.dart';
import 'assign_projects_to_company.dart';
import 'assign_sites_to_company.dart';

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
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.companyId,
          selectedEntity: state.selectedCompany,
          addEntity: () => _addCompany(state),
          editEntity: () => _editCompany(state),
          isCrudDataFill: _checkFormDataFill(),
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
        'Details': Container(),
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
        '': Container(),
      };
    }
    return {};
  }

  // check if some of fields are filled
  bool _checkFormDataFill() {
    return widget.companyId == null
        ? companyNameController.text.trim().isNotEmpty ||
            einNumberController.text.trim().isNotEmpty
        : true;
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
      }
    }
  }

  bool _checkEinNumber(String einNumber) {
    final numericSpecialReg = RegExp(r'^[A-Za-z0-9.-/\\]+$');
    return numericSpecialReg.hasMatch(einNumber);
  }

  // check if the crud result is success or failure
  void _checkCrudResult(CompaniesState state, BuildContext context) {
    if (state.companyCrudStatus == EntityStatus.success) {
      companiesBloc.add(CompaniesStatusInited());
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
      }
      if (state.message.contains('Our team')) {
        CustomNotification(
          context: context,
          notifyType: NotifyType.error,
          content: state.message,
        ).showNotification();
      } else {
        setState(() {
          companyNameValidationMessage = state.message;
          einNumberValidationMessage = '';
        });
      }
      companiesBloc.add(CompaniesStatusInited());
    }
  }

  // return text field for company name
  FormItem _buildCompanyNameField(CompaniesState state) {
    return FormItem(
      label: 'Company Name (*)',
      content: CustomTextField(
        controller: companyNameController,
        hintText: 'Company Name',
        onChanged: (companyName) {
          setState(() {
            companyNameValidationMessage = '';
          });
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
            'EIN Field should allow only numbers, white space, dots and dashes in it. No alphabets and no other special characters.';
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
