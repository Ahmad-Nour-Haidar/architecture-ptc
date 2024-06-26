
import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/widgets/widgets_Informative/loading_data_view.dart';
import '../../data/datasource/configuration/category_items.dart';
import '../widgets/category_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String>? categories;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // categories=await getCategories();
      categories=await CategoryItems.instance.item;
      setState(() {});
    });

   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'Categories',
          style: TextStyle(
              color: ColorManager.primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
      builderCourses(context)
    );
  }

  Widget builderCourses(BuildContext context){
    return
      categories==null?
          const LoadingDataView()
      :ListView.builder(
        itemCount: categories?.length??0,
        itemBuilder: (context,index)=>
            ItemWidget(
        item: categories?[index]??''));
  }
}


