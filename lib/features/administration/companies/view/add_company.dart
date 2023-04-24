import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/global_widgets/global_widget.dart';
import '/utils/utils.dart';
import '/data/model/model.dart';
import '/data/bloc/bloc.dart';

class AddCompanyView extends StatefulWidget {
  const AddCompanyView({
    super.key,
  });

  @override
  State<AddCompanyView> createState() => _AddCompanyViewState();
}

class _AddCompanyViewState extends State<AddCompanyView> {
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
    companiesBloc = context.read<CompaniesBloc>()
      ..add(const CompanySelected(selectedCompany: Company()));
    sitesBloc = context.read<SitesBloc>()..add(SitesRetrieved());

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
          id: null,
          selectedEntity: state.selectedCompany,
          addEntity: () => _addCompany(state),
          editEntity: () {},
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
    return companyNameController.text.trim().isNotEmpty ||
        einNumberController.text.trim().isNotEmpty;
  }

  // change form data whenever the state changes
  void _changeFormData(CompaniesState state) {
    if (state.selectedCompany != null) {
      if (isFirstInit) {
        companyNameController.text = state.selectedCompany!.name ?? '';
        einNumberController.text = state.selectedCompany!.einNumber;
        isFirstInit = false;
      }
    }
  }

  bool _checkEinNumber(String einNumber) {
    final numericSpecialReg = RegExp(r'^[0-9. /\\]+$');
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
      GoRouter.of(context).go(
          '/companies/assign-sites?companyId=${state.selectedCompany!.id}&companyName=${state.selectedCompany!.name}');
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

    if (!_checkEinNumber(einNumberController.text)) {
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
}
