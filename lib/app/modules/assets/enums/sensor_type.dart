enum SensorType {
  energy,
  vibration;

  static SensorType parse(String value) {
    switch (value.toUpperCase()) {
      case 'ENERGY':
        return SensorType.energy;
      case 'VIBRATION':
        return SensorType.vibration;
      default:
        throw FormatException('', value);
    }
  }

  static SensorType? tryParse(String value) {
    try {
      return parse(value);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  toString() {
    switch (this) {
      case SensorType.energy:
        return 'ENERGY';
      case SensorType.vibration:
        return 'VIBRATION';
    }
  }
}
