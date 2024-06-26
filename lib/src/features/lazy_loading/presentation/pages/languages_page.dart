
import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/widgets/widgets_Informative/loading_data_view.dart';
import '../../data/datasource/configuration/language_items.dart';
import '../widgets/category_widget.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  List<String>? languages;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       // languages=await getLanguages();
      languages=await LanguagesItems.instance.item;
      setState(() {});
    });

   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'Languages',
          style: TextStyle(
              color: ColorManager.primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
      builderItems(context)
    );
  }

  Widget builderItems(BuildContext context){
    return
      languages==null?
          const LoadingDataView()
      :ListView.builder(
        itemCount: languages?.length??0,
        itemBuilder: (context,index)=>
            ItemWidget(
        item: languages?[index]??''));
  }
}


