// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  late final _$activeOrdersAtom =
      Atom(name: '_ProfileViewModelBase.activeOrders', context: context);

  @override
  ObservableList<OrderModel> get activeOrders {
    _$activeOrdersAtom.reportRead();
    return super.activeOrders;
  }

  @override
  set activeOrders(ObservableList<OrderModel> value) {
    _$activeOrdersAtom.reportWrite(value, super.activeOrders, () {
      super.activeOrders = value;
    });
  }

  late final _$orderHistoryAtom =
      Atom(name: '_ProfileViewModelBase.orderHistory', context: context);

  @override
  ObservableList<OrderModel> get orderHistory {
    _$orderHistoryAtom.reportRead();
    return super.orderHistory;
  }

  @override
  set orderHistory(ObservableList<OrderModel> value) {
    _$orderHistoryAtom.reportWrite(value, super.orderHistory, () {
      super.orderHistory = value;
    });
  }

  late final _$getActiveOrdersAsyncAction =
      AsyncAction('_ProfileViewModelBase.getActiveOrders', context: context);

  @override
  Future<bool> getActiveOrders() {
    return _$getActiveOrdersAsyncAction.run(() => super.getActiveOrders());
  }

  late final _$getOrderLogsAsyncAction =
      AsyncAction('_ProfileViewModelBase.getOrderLogs', context: context);

  @override
  Future<bool> getOrderLogs() {
    return _$getOrderLogsAsyncAction.run(() => super.getOrderLogs());
  }

  late final _$cancelOrderAsyncAction =
      AsyncAction('_ProfileViewModelBase.cancelOrder', context: context);

  @override
  Future<void> cancelOrder(OrderModel data) {
    return _$cancelOrderAsyncAction.run(() => super.cancelOrder(data));
  }

  @override
  String toString() {
    return '''
activeOrders: ${activeOrders},
orderHistory: ${orderHistory}
    ''';
  }
}
