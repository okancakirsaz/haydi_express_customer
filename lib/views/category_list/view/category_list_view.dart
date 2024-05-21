import 'package:flutter/material.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/category_list_viewmodel.dart';

class CategoryListView extends StatelessWidget {
  final String category;
  const CategoryListView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryListViewModel>(
        viewModel: CategoryListViewModel(),
        onPageBuilder: (context, model) {
          return const Scaffold();
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
