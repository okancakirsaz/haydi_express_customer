enum PaymentMethods { creditCard, cash, online, foodTicket }

extension PaymentMExtension on PaymentMethods {
  String get value {
    switch (this) {
      case PaymentMethods.creditCard:
        return 'Kapıda Kredi Kartı';
      case PaymentMethods.cash:
        return 'Kapıda Nakit';
      case PaymentMethods.online:
        return 'Online Ödeme';
      case PaymentMethods.foodTicket:
        return 'Yemek Çeki(Multinet,Sodexo...)';
      default:
        return '';
    }
  }
}
