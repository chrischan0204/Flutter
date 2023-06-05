// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeSidebarItemExtended extends ThemeEvent {
  final String collapsedItem;
  const ThemeSidebarItemExtended({required this.collapsedItem});
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
