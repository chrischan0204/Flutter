import '../../../../form_item.dart';
import '/common_libraries.dart';

class CompanySelectField extends StatelessWidget {
  const CompanySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Company',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, Company> items = {}..addEntries(observationDetailState
              .companyList
              .map((company) => MapEntry(company.name ?? '', company)));
          return BlocBuilder<AddActionItemBloc, AddActionItemState>(
            builder: (context, addActionItemState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Company',
                selectedValue: observationDetailState.companyList.isEmpty
                    ? null
                    : addActionItemState.company?.name,
                onChanged: (company) {
                  context
                      .read<AddActionItemBloc>()
                      .add(AddActionItemCompanyChanged(company: company.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
