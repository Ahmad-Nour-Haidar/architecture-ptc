import 'package:flutter/material.dart';

import '../../../src/features/core/data/models/file_model.dart';
import '../../helper/operation_file.dart';
import '../../utils/color_manager.dart';

class FileDownloadWidget extends StatelessWidget {
  const FileDownloadWidget({
    super.key,
    required this.file,
    this.onTap,

  });


  final FileModel file;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.download,
            color: ColorManager.secondary,
          )),
      leading: const CircleAvatar(
        child: Icon(
          Icons.file_present_outlined,
        ),
      ),
      title: Text(file.name ?? ''),
      subtitle: Text(formatFileSize(file.size ?? 0)),
    );
  }
}
