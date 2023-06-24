class ErrorMessage {
  final String title;

  ErrorMessage(this.title);

  String get add =>
      'There was an error while adding $title. Our team has been notified. Please wait a few minutes and try again.';

  String get edit =>
      'There was an error while editing $title. Our team has been notified. Please wait a few minutes and try again.';

  String get delete =>
      'There was an error while deleting $title. Our team has been notified. Please wait a few minutes and try again.';

  String assign(String from) =>
      'There was an error while assigning $from to $title. Our team has been notified. Please wait a few minutes and try again.';
}
