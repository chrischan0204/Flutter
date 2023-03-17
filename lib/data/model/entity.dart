abstract class Entity {
  Map<String, dynamic> toMap();
  Map<String, dynamic> tableItemsToMap();
  Map<String, dynamic> detailItemsToMap();
  Map<String, EntityInputType> inputTypesToMap(); 
}

enum EntityInputType {
  textField,
  singleSelect,
  multiSelect,
  colorPicker,
}

enum EntityStatus {
  initial,
  loading,
  succuess,
  failure,
}
