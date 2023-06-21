part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.collapsedItems = const [
      'templates/show',
      'templates/edit',
      'audits/show',
      'audits/edit',
    ],
    this.hoveredItemName = '',
  });
  final String hoveredItemName;
  final List<String> collapsedItems;

  @override
  List<Object> get props => [
        collapsedItems,
        hoveredItemName,
      ];

  ThemeState copyWith({
    String? selectedItemName,
    String? hoveredItemName,
    List<String>? collapsedItems,
  }) {
    return ThemeState(
      collapsedItems: collapsedItems ?? this.collapsedItems,
      hoveredItemName: hoveredItemName ?? this.hoveredItemName,
    );
  }

  bool isExtended(context) {
    final pathSegments = Uri.parse(GoRouter.of(context).location).pathSegments;
    String path = pathSegments[0] +
        (pathSegments.length > 1
            ? pathSegments[1] == 'index'
                ? ''
                : '/${pathSegments[1]}'
            : '');

    return !collapsedItems.any((element) => path == element);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'collapsedItems': collapsedItems,
      'hoveredItemName': '',
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      collapsedItems:
          List.from(map['collapsedItems']).map((e) => e as String).toList(),
      hoveredItemName: map['hoveredItemName'] as String,
    );
  }
}
