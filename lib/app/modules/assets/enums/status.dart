enum Status {
  operating,
  alert;

  static Status parse(String value) {
    switch (value.toUpperCase()) {
      case 'OPERATING':
        return Status.operating;
      case 'ALERT':
        return Status.alert;
      default:
        throw FormatException('', value);
    }
  }

  static Status? tryParse(String value) {
    try {
      return parse(value);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  toString() {
    switch (this) {
      case Status.operating:
        return 'OPERATING';
      case Status.alert:
        return 'ALERT';
    }
  }
}
