import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/global_widgets/global_widget.dart';
import '/utils/utils.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class AddEditCompanyView extends StatefulWidget {
  final String? companyId;
  const AddEditCompanyView({
    super.key,
    this.companyId,
  });

  @override
  State<AddEditCompanyView> createState() => _AddEditCompanyViewState();
}

class _AddEditCompanyViewState extends State<AddEditCompanyView> {
  late CompaniesBloc companiesBloc;
  late SitesBloc sitesBloc;
  TextEditingController companyNameController = TextEditingController(text: '');
  TextEditingController einNumberController = TextEditingController(text: '');

  String companyNameValidationMessage = '';
  String einNumberValidationMessage = '';

  bool isFirstInit = true;

  static String pageLabel = 'company';
  static String addButtonName = 'Assign Sites';

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>();
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());
    if (widget.companyId != null) {
      companiesBloc.add(
        CompanySelectedById(companyId: widget.companyId!),
      );
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
          addButtonName: addButtonName,
          isCrudDataFill: _checkFormDataFill(),
          crudStatus: state.companyCrudStatus,
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

  // check if the crud result is success or failure
  void _checkCrudResult(CompaniesState state, BuildContext context) {
    if (state.companyCrudStatus == EntityStatus.success) {
      companiesBloc.add(CompaniesStatusInited());
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
      GoRouter.of(context).go('/companies/abc/assign-sites');
    }
    if (state.companyCrudStatus == EntityStatus.failure) {
      if (state.message.contains('EIN')) {
        setState(() {
          einNumberValidationMessage = state.message;
        });
      } else {
        setState(() {
          companyNameValidationMessage = state.message;
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
