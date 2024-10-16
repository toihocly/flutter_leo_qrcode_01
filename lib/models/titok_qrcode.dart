import 'package:flutter_leo_qrcode_01/models/enums/qrcode_type.dart';

import 'url_qrcode.dart';

class TikTokQRCode extends UrlQRCode {
  TikTokQRCode(String data, DateTime createdAt, QRCodeType type)
      : super(data, createdAt, type);
}
