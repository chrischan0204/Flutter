import '../../../../form_item.dart';
import '/common_libraries.dart';

class CompanySelectField extends StatelessWidget {
  const CompanySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Company',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          Map<String, Company> items = {}..addEntries(state.companyList
              .map((company) => MapEntry(company.name ?? '', company)));

          return CustomSingleSelect(
            items: items,
            hint: 'Select Company',
            selectedValue:
                state.companyList.isEmpty ? null : state.company?.name,
            onChanged: (company) {
              context
                  .read<AddActionItemBloc>()
                  .add(AddActionItemCompanyChanged(company: company.value));
            },
          );
        },
      ),
    );
  }
}
