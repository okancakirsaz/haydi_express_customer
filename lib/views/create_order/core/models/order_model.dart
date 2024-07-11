import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import 'package:haydi_express_customer/views/create_order/core/models/payment_model.dart';

class OrderModel {
  PaymentModel paymentData;
  List<MenuModel> menuData;
  AddressModel addressData;
  String paymentMethod;
  String orderState;
  String orderCreationDate;
  String customerName;
  String customerId;
  String customerPhoneNumber;
  String? note;
  bool? isPaidSuccess;
  String? courierId;
  String orderId;

  OrderModel({
    required this.paymentData,
    required this.menuData,
    required this.addressData,
    required this.paymentMethod,
    required this.isPaidSuccess,
    required this.orderState,
    required this.orderCreationDate,
    required this.customerName,
    required this.customerId,
    required this.customerPhoneNumber,
    required this.note,
    this.courierId,
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentData': paymentData.toJson(),
      'menuData': menuData.map((e) => e.toJson()).toList(),
      'addressData': addressData.toJson(),
      'paymentMethod': paymentMethod,
      'orderState': orderState,
      'orderCreationDate': orderCreationDate,
      'customerName': customerName,
      'customerId': customerId,
      'customerPhoneNumber': customerPhoneNumber,
      'note': note,
      'isPaidSuccess': isPaidSuccess,
      'courierId': courierId,
      'orderId': orderId
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      paymentData: PaymentModel.fromJson(json['paymentData']),
      menuData: (json['menuData'] as List<dynamic>)
          .map((e) => MenuModel.fromJson(e))
          .toList(),
      addressData: AddressModel.fromJson(json['addressData']),
      paymentMethod: json['paymentMethod'] as String,
      orderState: json['orderState'] as String,
      orderCreationDate: json['orderCreationDate'] as String,
      customerName: json['customerName'] as String,
      customerId: json['customerId'] as String,
      customerPhoneNumber: json['customerPhoneNumber'] as String,
      note: json['note'] as String?,
      isPaidSuccess: json['isPaidSuccess'] as bool?,
      courierId: json['courierId'] as String?,
      orderId: json['orderId'] as String,
    );
  }

  @override
  String toString() =>
      "OrderModel(paymentData: $paymentData,menuData: $menuData,addressData: $addressData,paymentMethod: $paymentMethod,orderState: $orderState,orderCreationDate: $orderCreationDate,customerName: $customerName,customerPhoneNumber: $customerPhoneNumber,note: $note)";

  @override
  int get hashCode => Object.hash(
        paymentData,
        menuData,
        addressData,
        paymentMethod,
        orderState,
        orderCreationDate,
        customerName,
        customerPhoneNumber,
        note,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModel &&
          runtimeType == other.runtimeType &&
          paymentData == other.paymentData &&
          menuData == other.menuData &&
          addressData == other.addressData &&
          paymentMethod == other.paymentMethod &&
          orderState == other.orderState &&
          orderCreationDate == other.orderCreationDate &&
          customerName == other.customerName &&
          customerPhoneNumber == other.customerPhoneNumber &&
          note == other.note;
}
