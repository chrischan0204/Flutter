part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// event to extend side bar item
class ThemeSidebarItemExtended extends ThemeEvent {
  final bool? isCollapsed;
  final String  collapsedItem;
  final bool force;
  const ThemeSidebarItemExtended({
    this.collapsedItem = '',
    this.isCollapsed,
    this.force = false,
  });
  @override
  List<Object?> get props => [
        force,
        isCollapsed,
      ];
}

/// event to hover side bar
class ThemeSidebarHovered extends ThemeEvent {
  final String hoveredItemName;
  const ThemeSidebarHovered({
    this.hoveredItemName = '',
  });

  @override
  List<Object> get props => [hoveredItemName];
}
