part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.collapsedItems = const [],
    this.hoveredItemName = '',
    this.isCollapsed = true,
    this.isSpecialPage = false,
  });
  final String hoveredItemName;
  final List<String> collapsedItems;
  final bool isCollapsed;
  final bool isSpecialPage;

  @override
  List<Object?> get props => [
        collapsedItems,
        hoveredItemName,
        isCollapsed,
        isSpecialPage,
      ];

  ThemeState copyWith({
    String? selectedItemName,
    String? hoveredItemName,
    List<String>? collapsedItems,
    Nullable<bool>? isCollapsed,
    bool? isSpecialPage,
  }) {
    return ThemeState(
      collapsedItems: collapsedItems ?? this.collapsedItems,
      hoveredItemName: hoveredItemName ?? this.hoveredItemName,
      isCollapsed: isCollapsed != null ? isCollapsed.value : this.isCollapsed,
      isSpecialPage: isSpecialPage ?? this.isSpecialPage,
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
      'isCollapsed': isCollapsed,
      'isSpecialPage': isSpecialPage,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      collapsedItems:
          List.from(map['collapsedItems']).map((e) => e as String).toList(),
      hoveredItemName: map['hoveredItemName'] as String,
      isCollapsed: map['isCollapsed'],
      isSpecialPage: map['isSpecialPage'],
    );
  }
}
