enum ItemType {
  location,
  asset,
  component;

  static ItemType parse(String value) {
    switch (value.toUpperCase()) {
      case 'LOCATION':
        return ItemType.location;
      case 'ASSET':
        return ItemType.asset;
      case 'COMPONENT':
        return ItemType.component;
      default:
        throw FormatException('', value);
    }
  }

  static ItemType? tryParse(String value) {
    try {
      return parse(value);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  toString() {
    switch (this) {
      case ItemType.location:
        return 'LOCATION';
      case ItemType.asset:
        return 'ASSET';
      case ItemType.component:
        return 'COMPONENT';
    }
  }
}
