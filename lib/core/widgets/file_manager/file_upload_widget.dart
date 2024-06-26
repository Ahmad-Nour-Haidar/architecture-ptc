import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../data/models/info_file_model.dart';
import '../../helper/operation_file.dart';
import '../../utils/color_manager.dart';

class FileUploadWidget extends StatelessWidget {
  const FileUploadWidget({
    super.key,
    required this.file,
    this.onTap,
    this.isComplete = false,
  });

  final InfoFile file;
  final VoidCallback? onTap;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      trailing: file.complete??false
          ? IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.delete,
            color: ColorManager.error,
          ))
          : null,
      leading: const CircleAvatar(
        child: Icon(
          Icons.file_present_outlined,
        ),
      ),
      title: file.complete??false
          ? Text(file.name ??'',maxLines: 2,overflow:TextOverflow.ellipsis ,)
          : LinearPercentIndicator(
        padding: EdgeInsets.zero,
        trailing: Text(' ${int.parse(file.progress??'0')}%'),
        animation: true,
        curve: Curves.easeInOut,
        percent: double.parse(file.progress??'0')/100,
        progressColor: ColorManager.primary,
      ),
      subtitle:  Text(formatFileSize(int.parse(file.size ?? '0'))),
    );
  }
}
