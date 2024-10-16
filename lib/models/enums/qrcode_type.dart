enum QRCodeType {
  /// An unknown barcode type.
  unknown(0),

  /// Barcode value type constant for contact information.
  contactInfo(1),

  /// Barcode value type constant for email message details.
  email(2),

  /// Barcode value type constant for ISBNs.
  isbn(3),

  /// Barcode value type constant for phone numbers.
  phone(4),

  /// Barcode value type constant for product codes.
  product(5),

  /// Barcode value type constant for SMS details.
  sms(6),

  /// Barcode value type constant for plain text.
  text(7),

  /// Barcode value type constant for URLs or bookmarks.
  url(8),

  /// Barcode value type constant for WiFi access point details.
  wifi(9),

  /// Barcode value type constant for geographic coordinates.
  geo(10),

  /// Barcode value type constant for calendar events.
  calendarEvent(11),

  /// Barcode value type constant for driver license data.
  driverLicense(12);

  const QRCodeType(this.rawValue);

  factory QRCodeType.fromRawValue(int value) {
    switch (value) {
      case 0:
        return QRCodeType.unknown;
      case 1:
        return QRCodeType.contactInfo;
      case 2:
        return QRCodeType.email;
      case 3:
        return QRCodeType.isbn;
      case 4:
        return QRCodeType.phone;
      case 5:
        return QRCodeType.product;
      case 6:
        return QRCodeType.sms;
      case 7:
        return QRCodeType.text;
      case 8:
        return QRCodeType.url;
      case 9:
        return QRCodeType.wifi;
      case 10:
        return QRCodeType.geo;
      case 11:
        return QRCodeType.calendarEvent;
      case 12:
        return QRCodeType.driverLicense;
      default:
        throw ArgumentError.value(value, 'value', 'Invalid raw value.');
    }
  }

  /// The raw barcode type value.
  final int rawValue;
}
