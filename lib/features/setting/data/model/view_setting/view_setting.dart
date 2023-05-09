import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class ViewSetting extends Equatable {
  final List<ViewSettingColumn> columnList;
  final List<ViewSettingDisplayColumn> displayColumnList;
  final List<ViewSettingSortingColumn> sortingColumnList;
  const ViewSetting({
    required this.columnList,
    required this.displayColumnList,
    required this.sortingColumnList,
  });

  @override
  List<Object?> get props => [
        columnList,
        displayColumnList,
        sortingColumnList,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'columnList': columnList.map((x) => x.toMap()).toList(),
      'displayColumnList': displayColumnList.map((x) => x.toMap()).toList(),
      'sortingColumnList': sortingColumnList.map((x) => x.toMap()).toList(),
    };
  }

  factory ViewSetting.fromMap(Map<String, dynamic> map) {
    return ViewSetting(
      columnList: List.from(
        (map['columnList']).map<ViewSettingColumn>(
          (columnMap) => ViewSettingColumn.fromMap(columnMap),
        ),
      ),
      displayColumnList: List.from(
        (map['displayColumnList']).map(
          (columnMap) => ViewSettingDisplayColumn.fromMap(columnMap),
        ),
      ),
      sortingColumnList: List.from(
        (map['sortingColumnList']).map(
          (columnMap) => ViewSettingSortingColumn.fromMap(columnMap),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewSetting.fromJson(String source) =>
      ViewSetting.fromMap(json.decode(source) as Map<String, dynamic>);
}
