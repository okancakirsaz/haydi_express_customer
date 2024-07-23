import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/models/comment_model.dart';
import 'package:haydi_ekspres_dev_tools/models/http_exception_model.dart';
import 'package:haydi_ekspres_dev_tools/models/order_model.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/comment/service/comment_service.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'comment_viewmodel.g.dart';

class CommentViewModel = _CommentViewModelBase with _$CommentViewModel;

abstract class _CommentViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  @observable
  double selectedStarCount = 0;

  final TextEditingController comment = TextEditingController();
  final TextEditingController menuOption = TextEditingController();

  final CommentService service = CommentService();

  @action
  changeStarsValue(double val) {
    selectedStarCount = val;
  }

  List<DropdownMenuEntry> buildMenuOptionProps(OrderModel data) {
    List<DropdownMenuEntry> elements = [];
    elements = data.menuData
        .map((e) => DropdownMenuEntry(
            value: e.menuElement.name,
            label: e.menuElement.name) as DropdownMenuEntry<dynamic>)
        .toList();
    elements.add(
      const DropdownMenuEntry(value: "Hepsi", label: "Hepsi"),
    );
    return elements;
  }

  bool get _validation {
    if (selectedStarCount < 1) {
      showErrorDialog("Lütfen değerlendirme yapınız.");
      return false;
    }
    if (comment.text.isEmpty) {
      showErrorDialog("Lütfen yorum yapınız.");
      return false;
    }
    if (menuOption.text.isEmpty) {
      showErrorDialog("Lütfen menü seçimi yapınız.");
      return false;
    }
    return true;
  }

  CommentModel _fetchCommentModel(String menuId, String restaurantId) {
    return CommentModel(
      comment: comment.text,
      like: selectedStarCount.toInt(),
      menuId: menuId,
      uid: const Uuid().v4(),
      customerId: localeManager.getStringData(LocaleKeysEnums.id.name),
      restaurantId: restaurantId,
    );
  }

  Future<void> sendComment(OrderModel data) async {
    if (_validation) {
      if (menuOption.text == "Hepsi") {
        for (int i = 0; i <= data.menuData.length - 1; i++) {
          await _fetchCommentToApi(
            data.menuData[i].menuElement.menuId,
            data.restaurantId,
          );
        }
      } else {
        String selectedMenuId = data.menuData
            .where((e) => e.menuElement.name == menuOption.text)
            .first
            .menuElement
            .menuId;
        await _fetchCommentToApi(selectedMenuId, data.restaurantId);
      }
      navigatorPop();
    }
  }

  Future<void> _fetchCommentToApi(String menuId, String restaurantId) async {
    final response = await service.writeComment(
        _fetchCommentModel(menuId, restaurantId), accessToken!);
    if (response == null) {
      showErrorDialog();
      return;
    }
    if (response is HttpExceptionModel) {
      showErrorDialog(response.message);
      return;
    }
  }
}
