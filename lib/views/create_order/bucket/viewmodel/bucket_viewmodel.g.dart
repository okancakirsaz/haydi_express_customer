// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BucketViewModel on _BucketViewModelBase, Store {
  late final _$bucketAtom =
      Atom(name: '_BucketViewModelBase.bucket', context: context);

  @override
  ObservableList<MenuModel> get bucket {
    _$bucketAtom.reportRead();
    return super.bucket;
  }

  @override
  set bucket(ObservableList<MenuModel> value) {
    _$bucketAtom.reportWrite(value, super.bucket, () {
      super.bucket = value;
    });
  }

  late final _$totalPriceAtom =
      Atom(name: '_BucketViewModelBase.totalPrice', context: context);

  @override
  int get totalPrice {
    _$totalPriceAtom.reportRead();
    return super.totalPrice;
  }

  @override
  set totalPrice(int value) {
    _$totalPriceAtom.reportWrite(value, super.totalPrice, () {
      super.totalPrice = value;
    });
  }

  late final _$deleteBucketElementAsyncAction =
      AsyncAction('_BucketViewModelBase.deleteBucketElement', context: context);

  @override
  Future<void> deleteBucketElement(int index) {
    return _$deleteBucketElementAsyncAction
        .run(() => super.deleteBucketElement(index));
  }

  @override
  String toString() {
    return '''
bucket: ${bucket},
totalPrice: ${totalPrice}
    ''';
  }
}
