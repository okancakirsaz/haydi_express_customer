// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addresses_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressesViewModel on _AddressesViewModelBase, Store {
  late final _$addressesAtom =
      Atom(name: '_AddressesViewModelBase.addresses', context: context);

  @override
  ObservableList<AddressModel> get addresses {
    _$addressesAtom.reportRead();
    return super.addresses;
  }

  @override
  set addresses(ObservableList<AddressModel> value) {
    _$addressesAtom.reportWrite(value, super.addresses, () {
      super.addresses = value;
    });
  }

  late final _$deleteAddressAsyncAction =
      AsyncAction('_AddressesViewModelBase.deleteAddress', context: context);

  @override
  Future<void> deleteAddress(String addressId) {
    return _$deleteAddressAsyncAction.run(() => super.deleteAddress(addressId));
  }

  @override
  String toString() {
    return '''
addresses: ${addresses}
    ''';
  }
}
