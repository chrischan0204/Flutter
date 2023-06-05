part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeSidebarItemExtended extends ThemeEvent {
  final String collapsedItem;
  final bool force;
  const ThemeSidebarItemExtended({
    required this.collapsedItem,
    this.force = false,
  });
  @override
  List<Object> get props => [collapsedItem];
}

class ThemeSidebarHovered extends ThemeEvent {
  final String hoveredItemName;
  const ThemeSidebarHovered({
    this.hoveredItemName = '',
  });

  @override
  List<Object> get props => [hoveredItemName];
}
