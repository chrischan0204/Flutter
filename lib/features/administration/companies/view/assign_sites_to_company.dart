import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '/data/model/model.dart';
import '/utils/utils.dart';
import '/constants/color.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';

class AssignSitesToCompanyView extends StatefulWidget {
  final String companyId;
  final String companyName;
  final String? view;
  const AssignSitesToCompanyView({
    super.key,
    required this.companyId,
    this.companyName = '',
    this.view,
  });

  @override
  State<AssignSitesToCompanyView> createState() =>
      _AssignSitesToCompanyViewState();
}

class _AssignSitesToCompanyViewState extends State<AssignSitesToCompanyView> {
  late CompaniesBloc companiesBloc;
  TextEditingController filterController = TextEditingController(text: '');

  @override
  void initState() {
    companiesBloc = context.read<CompaniesBloc>()
      ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId))
      ..add(AssignedCompanySitesRetrieved(companyId: widget.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAssignedSitesTableViewHeader(state),
                        const CustomDivider(),
                        _buildAssignedSitesTableView(state, context),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sites can be assigned to this company by selecting from the list below.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const CustomDivider(),
                        _buildFilterTextField(),
                        const CustomDivider(),
                        _buildUnassignedSitesTableView(state),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildAssignedSitesTableViewHeader(CompaniesState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: 'OpenSans',
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  'The company \'${widget.companyName}\' has been ${widget.view == 'created' ? 'created' : 'updated'}.',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text:
                  ' Sites can be assigned from list on right. Once assigned they will show here in this list below.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnassignedSitesTableView(CompaniesState state) {
    return state.unassignedCompanySitesRetrievedStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Assigned?'),
                ),
                DataColumn(
                  label: Text(
                    'Site Name',
                  ),
                ),
              ],
              rows: state.unassignedCompanySites
                  .map(
                    (unassignedCompanySite) => DataRow(
                      cells: [
                        DataCell(
                          CustomSwitch(
                            trueString: 'Yes',
                            falseString: 'No',
                            textColor: darkTeal,
                            switchValue: false,
                            onChanged: (value) =>
                                _assignSiteToCompany(unassignedCompanySite),
                          ),
                        ),
                        ...unassignedCompanySite
                            .toTableDetailMap()
                            .values
                            .map(
                              (detail) => DataCell(
                                CustomDataCell(data: detail),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
  }

  Widget _buildAssignedSitesTableView(
      CompaniesState state, BuildContext context) {
    return state.assignedCompanySitesRetrievedStatus == EntityStatus.loading
        ? const Padding(
            padding: EdgeInsets.only(top: 300),
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text('Assigned?'),
                ),
                DataColumn(
                  label: Text(
                    'Site Name',
                  ),
                ),
              ],
              rows: List<CompanySite>.from(state.assignedCompanySites)
                  .map(
                    (assignedCompanySite) => DataRow(
                      cells: [
                        DataCell(
                          CustomSwitch(
                            switchValue: true,
                            trueString: 'Yes',
                            falseString: 'No',
                            textColor: darkTeal,
                            onChanged: (value) =>
                                _unassignFromCompany(assignedCompanySite.id),
                          ),
                        ),
                        DataCell(
                          CustomDataCell(
                            data: assignedCompanySite.siteName,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
  }

  void _assignSiteToCompany(CompanySite companySite) {
    companiesBloc.add(SiteToCompanyAssigned(
        companySiteUpdation: companySite.toCompanySiteUpdation()));
  }

  void _unassignFromCompany(String companySiteId) {
    CustomAlert(
      context: context,
      width: MediaQuery.of(context).size.width / 4,
      title: 'Confirm',
      description: 'Do you really want to remove this site from company?',
      btnOkText: 'Remove',
      btnOkOnPress: () {
        companiesBloc.add(
            SiteFromCompanyUnassigned(companySiteUpdationId: companySiteId));
      },
      dialogType: DialogType.question,
    );
  }

  Padding _buildFilterTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextField(
        hintText: 'Filter unassigned sites by name..',
        onChanged: (value) {},
        controller: filterController,
        suffixIconData: PhosphorIcons.funnel,
        onSuffixIconClick: () => _filterApply(),
      ),
    );
  }

  _filterApply() {
    companiesBloc.add(UnassignedCompanySitesRetrieved(
      companyId: widget.companyId,
      name: filterController.text,
    ));
  }
}
