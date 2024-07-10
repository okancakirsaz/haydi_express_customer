import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/create_order/bucket/model/bucket_element_model.dart';
import 'package:haydi_express_customer/views/create_order/order_steps/view/order_steps_view.dart';
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
  ObservableList<BucketElementModel> bucket =
      ObservableList<BucketElementModel>.of([]);
  @observable
  int totalPrice = 0;

  getBucket() {
    final List rawBucket =
        localeManager.getNullableJsonData(LocaleKeysEnums.bucket.name) ?? [];
    bucket = ObservableList<BucketElementModel>.of(
      rawBucket.map((e) => BucketElementModel.fromJson(e)).toList(),
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
    return bucket[index].menuElement.isOnDiscount
        ? calculateDiscount(
            (bucket[index].menuElement.price * bucket[index].count),
            bucket[index].menuElement.discountAmount!)
        : bucket[index].menuElement.price * bucket[index].count;
  }

  navigateToCreateOrder() {
    if (totalPrice > 0) {
      navigationManager.navigate(
        OrderStepsView(
          totalPrice: totalPrice,
        ),
      );
    }
  }
}
