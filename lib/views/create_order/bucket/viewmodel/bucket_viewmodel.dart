import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'bucket_viewmodel.g.dart';

class BucketViewModel = _BucketViewModelBase with _$BucketViewModel;

abstract class _BucketViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {
    getBucket();
    calculateTotalCount();
  }

  @observable
  ObservableList<MenuModel> bucket = ObservableList<MenuModel>.of([]);
  @observable
  int totalPrice = 0;

  getBucket() {
    final List rawBucket =
        localeManager.getNullableJsonData(LocaleKeysEnums.bucket.name) ?? [];
    bucket = ObservableList<MenuModel>.of(
      rawBucket.map((e) => MenuModel.fromJson(e)).toList(),
    );
  }

  calculateTotalCount() {
    for (int i = 0; i <= bucket.length - 1; i++) {
      totalPrice += getBucketElementPrice(i);
    }
  }

  @action
  Future<void> deleteBucketElement(int index) async {
    totalPrice -= getBucketElementPrice(index);

    bucket.removeAt(index);
    await localeManager.setJsonData(
      LocaleKeysEnums.bucket.name,
      bucket.map((element) => element.toJson()).toList(),
    );
  }

  int getBucketElementPrice(int index) {
    return bucket[index].isOnDiscount
        ? calculateDiscount(bucket[index].price, bucket[index].discountAmount!)
        : bucket[index].price;
  }

  //TODO: Check is totalPrice == 0 before navigate to create order views.
}
