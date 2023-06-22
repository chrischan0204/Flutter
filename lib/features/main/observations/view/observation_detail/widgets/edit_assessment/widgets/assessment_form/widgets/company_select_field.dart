import '/common_libraries.dart';
import 'form_item.dart';

class CompanySelectField extends StatelessWidget {
  const CompanySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return AssessmentFormItemView(
      label: 'Company',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, Company> items = {}..addEntries(observationDetailState
              .companyList
              .map((company) => MapEntry(company.name ?? '', company)));
          return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
            builder: (context, editAssessmentState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Company',
                selectedValue: observationDetailState.companyList.isEmpty
                    ? null
                    : editAssessmentState.company?.name,
                onChanged: (company) {
                  context.read<EditAssessmentBloc>().add(
                      EditAssessmentCompanyChanged(company: company.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
