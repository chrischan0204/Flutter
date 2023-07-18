extension BoolToString on bool {
  String asString() {
    return this ? 'Yes' : 'No';
  }
}

extension IsImageUrl on String {
  bool get isImage {
    switch (toLowerCase().split('.').last) {
      case 'png':
      case 'jpg':
        return true;
      default:
        return false;
    }
  }
}
