// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_edit_address_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateEditAddressViewModel on _CreateEditAddressViewModelBase, Store {
  late final _$mapHeightAtom =
      Atom(name: '_CreateEditAddressViewModelBase.mapHeight', context: context);

  @override
  double get mapHeight {
    _$mapHeightAtom.reportRead();
    return super.mapHeight;
  }

  @override
  set mapHeight(double value) {
    _$mapHeightAtom.reportWrite(value, super.mapHeight, () {
      super.mapHeight = value;
    });
  }

  late final _$currentLatAtom = Atom(
      name: '_CreateEditAddressViewModelBase.currentLat', context: context);

  @override
  double get currentLat {
    _$currentLatAtom.reportRead();
    return super.currentLat;
  }

  @override
  set currentLat(double value) {
    _$currentLatAtom.reportWrite(value, super.currentLat, () {
      super.currentLat = value;
    });
  }

  late final _$currentLongAtom = Atom(
      name: '_CreateEditAddressViewModelBase.currentLong', context: context);

  @override
  double get currentLong {
    _$currentLongAtom.reportRead();
    return super.currentLong;
  }

  @override
  set currentLong(double value) {
    _$currentLongAtom.reportWrite(value, super.currentLong, () {
      super.currentLong = value;
    });
  }

  late final _$cityDropdownItemsAtom = Atom(
      name: '_CreateEditAddressViewModelBase.cityDropdownItems',
      context: context);

  @override
  ObservableList<DropdownMenuEntry<dynamic>> get cityDropdownItems {
    _$cityDropdownItemsAtom.reportRead();
    return super.cityDropdownItems;
  }

  @override
  set cityDropdownItems(ObservableList<DropdownMenuEntry<dynamic>> value) {
    _$cityDropdownItemsAtom.reportWrite(value, super.cityDropdownItems, () {
      super.cityDropdownItems = value;
    });
  }

  late final _$stateDropdownItemsAtom = Atom(
      name: '_CreateEditAddressViewModelBase.stateDropdownItems',
      context: context);

  @override
  ObservableList<DropdownMenuEntry<dynamic>> get stateDropdownItems {
    _$stateDropdownItemsAtom.reportRead();
    return super.stateDropdownItems;
  }

  @override
  set stateDropdownItems(ObservableList<DropdownMenuEntry<dynamic>> value) {
    _$stateDropdownItemsAtom.reportWrite(value, super.stateDropdownItems, () {
      super.stateDropdownItems = value;
    });
  }

  late final _$cacheNewAddressAsyncAction = AsyncAction(
      '_CreateEditAddressViewModelBase.cacheNewAddress',
      context: context);

  @override
  Future<void> cacheNewAddress() {
    return _$cacheNewAddressAsyncAction.run(() => super.cacheNewAddress());
  }

  late final _$_CreateEditAddressViewModelBaseActionController =
      ActionController(
          name: '_CreateEditAddressViewModelBase', context: context);

  @override
  dynamic fetchCityAsDropdownMenuItem() {
    final _$actionInfo =
        _$_CreateEditAddressViewModelBaseActionController.startAction(
            name:
                '_CreateEditAddressViewModelBase.fetchCityAsDropdownMenuItem');
    try {
      return super.fetchCityAsDropdownMenuItem();
    } finally {
      _$_CreateEditAddressViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fetchStatesAsDropdownMenuItem() {
    final _$actionInfo =
        _$_CreateEditAddressViewModelBaseActionController.startAction(
            name:
                '_CreateEditAddressViewModelBase.fetchStatesAsDropdownMenuItem');
    try {
      return super.fetchStatesAsDropdownMenuItem();
    } finally {
      _$_CreateEditAddressViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeMapExtend() {
    final _$actionInfo = _$_CreateEditAddressViewModelBaseActionController
        .startAction(name: '_CreateEditAddressViewModelBase.changeMapExtend');
    try {
      return super.changeMapExtend();
    } finally {
      _$_CreateEditAddressViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePlaceMarkerState(double lat, double long) {
    final _$actionInfo =
        _$_CreateEditAddressViewModelBaseActionController.startAction(
            name: '_CreateEditAddressViewModelBase.changePlaceMarkerState');
    try {
      return super.changePlaceMarkerState(lat, long);
    } finally {
      _$_CreateEditAddressViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mapHeight: ${mapHeight},
currentLat: ${currentLat},
currentLong: ${currentLong},
cityDropdownItems: ${cityDropdownItems},
stateDropdownItems: ${stateDropdownItems}
    ''';
  }
}
