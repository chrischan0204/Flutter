import '/common_libraries.dart';

class CompanySelectField extends StatelessWidget {
  const CompanySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditObservationBloc, AddEditObservationState>(
      builder: (context, state) {
        Map<String, Company> items = {}..addEntries(state.companyList
            .map((company) => MapEntry(company.name ?? '', company)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Company',
          selectedValue: state.companyList.isEmpty ? null : state.company?.name,
          onChanged: (company) {
            context
                .read<AddEditObservationBloc>()
                .add(AddEditObservationCompanyChanged(company: company.value));
          },
        );
      },
    );
  }
}
