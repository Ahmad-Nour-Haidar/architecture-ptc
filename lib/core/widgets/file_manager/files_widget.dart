import 'package:flutter/material.dart';
import '../../../src/features/core/data/models/file_model.dart';
import '../../utils/color_manager.dart';
import '../../utils/theme_manager.dart';
import 'file_download_widget.dart';


class FilesWidget extends StatelessWidget {
  const FilesWidget({super.key, required this.fileModels});
  final List<FileModel> fileModels;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeManager.myTheme.copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10.0)),
        child: ExpansionTile(
          leading: TextButton.icon(
            icon: const Icon(
              Icons.description,
              color: ColorManager.secondary,
            ),
            label:  Text(
              'Files attached (${fileModels.length}) : ',
              style: const TextStyle(color: ColorManager.primary),
            ),
            onPressed: null,
          ),
          iconColor: Colors.transparent,
          trailing: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: null,
              child: const Text(
                'show files',
                style: TextStyle(
                    color: ColorManager.primary, fontSize: 12),
              )),
          title: const Text(''),
          children: (fileModels)
              .map(
                (fileModel) => FileDownloadWidget(
              file:fileModel,
              onTap: () {},
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
