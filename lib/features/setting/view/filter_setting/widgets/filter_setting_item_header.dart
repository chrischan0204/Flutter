import '/common_libraries.dart';

class FilterSettingItemHeader extends StatelessWidget {
  const FilterSettingItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        children: const [
          SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: Text('Action'),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 100,
            child: Text('And/Or'),
          ),
          SizedBox(width: 5),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Text('Field'),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 100,
            child: Text('Operator'),
          ),
          SizedBox(width: 5),
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: Text('Value'),
          ),
        ],
      ),
    );
  }
}
