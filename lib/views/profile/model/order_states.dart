import 'package:flutter/material.dart';

extension StringOrderStates on String {
  OrderState get asOrderState {
    switch (this) {
      case 'Restoran Onayı Bekleniyor':
        return WaitingRestaurantAccept.instance;
      case 'Kurye Ataması Bekleniyor':
        return WaitingCourierAttachment.instance;
      case 'Kuryeden Onay Bekleniyor':
        return WaitingAcceptFromCourier.instance;
      case 'Kurye Yolda':
        return CourierIsOnWay.instance;
      case 'Paket Yolda':
        return PackageIsOnWay.instance;
      case 'Hazırlanıyor':
        return Preparing.instance;
      case 'Teslim Edildi':
        return PackageDelivered.instance;
      case 'İptal Edildi':
        return Cancelled.instance;
      default:
        return WaitingCourierAttachment.instance;
    }
  }
}

abstract class OrderState {
  late final String text;
  late final Color color;
}

final class WaitingRestaurantAccept extends OrderState {
  static OrderState instance = WaitingRestaurantAccept();
  WaitingRestaurantAccept() {
    init();
  }
  init() {
    text = 'Restoran Onayı Bekleniyor';
    color = Colors.white;
  }
}

final class WaitingCourierAttachment extends OrderState {
  static OrderState instance = WaitingCourierAttachment();
  WaitingCourierAttachment() {
    init();
  }

  init() {
    text = 'Kurye Ataması Bekleniyor';
    color = const Color(0xFFD04A20);
  }
}

final class WaitingAcceptFromCourier extends OrderState {
  static OrderState instance = WaitingAcceptFromCourier();
  WaitingAcceptFromCourier() {
    init();
  }

  init() {
    text = 'Kuryeden Onay Bekleniyor';
    color = const Color(0xFFCD8F18);
  }
}

final class CourierIsOnWay extends OrderState {
  static OrderState instance = CourierIsOnWay();
  CourierIsOnWay() {
    init();
  }

  init() {
    text = "Kurye Yolda";
    color = const Color(0xFF6ABD29);
  }
}

final class PackageIsOnWay extends OrderState {
  static OrderState instance = PackageIsOnWay();
  PackageIsOnWay() {
    init();
  }

  init() {
    text = "Paket Yolda";
    color = const Color(0xFF166283);
  }
}

final class PackageDelivered extends OrderState {
  static OrderState instance = PackageDelivered();
  PackageDelivered() {
    init();
  }

  init() {
    text = "Teslim Edildi";
    color = const Color(0xFF401F71);
  }
}

final class Cancelled extends OrderState {
  static OrderState instance = Cancelled();
  Cancelled() {
    init();
  }

  init() {
    text = "İptal Edildi";
    color = const Color(0xFFD72036);
  }
}

final class Preparing extends OrderState {
  static OrderState instance = Preparing();
  Preparing() {
    init();
  }

  init() {
    text = 'Hazırlanıyor';
    color = const Color(0xFFCD8F18);
  }
}
