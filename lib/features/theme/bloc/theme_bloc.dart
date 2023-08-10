import '/common_libraries.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  static final List<String> specialItems = [
    'templates/show',
    'templates/edit',
    'audits/show',
    'audits/edit',
    'observations/show'
  ];
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeSidebarItemExtended>(
      (event, emit) {
        if (specialItems.contains(event.collapsedItem)) {
          emit(state.copyWith(isSpecialPage: true));

          final List<String> items = List.from(state.collapsedItems);

          if (items.contains(event.collapsedItem)) {
            if (!event.force) {
              items.remove(event.collapsedItem);
            }
          } else {
            items.add(event.collapsedItem);
          }
          emit(state.copyWith(collapsedItems: items));
        } else {
          emit(state.copyWith(
            isCollapsed: Nullable.value(!state.isCollapsed),
            isSpecialPage: false,
          ));
        }
      },
    );

    on<ThemeSidebarHovered>(
      (event, emit) {
        emit(state.copyWith(hoveredItemName: event.hoveredItemName));
      },
    );
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
