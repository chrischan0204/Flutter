extension BoolToString on bool {
  String asString() {
    return this ? 'Yes' : 'No';
  }
}

extension IsImageUrl on String {
  bool get isImage {
    switch (toLowerCase().split('.').last.toLowerCase()) {
      case 'png':
      case 'jpg':
      case 'jpeg':
        return true;
      default:
        return false;
    }
  }
}
