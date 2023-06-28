import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AppImportFile extends StatefulWidget {
  final String label;
  final String? imageUrl;
  final Function(FilePickerResult?) setFilePickerResult;
  final double? maxHeightImage;
  final double? maxWidthImage;

  const AppImportFile({
    Key? key,
    this.label = '',
    this.imageUrl,
    required this.setFilePickerResult,
    this.maxHeightImage,
    this.maxWidthImage,
  }) : super(key: key);

  @override
  State<AppImportFile> createState() => _AppImportFileState();
}

class _AppImportFileState extends State<AppImportFile> {
  // final FilePickerResult _picker = FilePickerResult();
  FilePickerResult? _filePickerResult;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _filePickerResult != null
          ? Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.file_present),
                  Text('Nome: ${_filePickerResult?.files.single.name}'),
                ],
              ),
            )
          : widget.imageUrl == null
              ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.imageUrl!,
                    height: 150,
                    width: 150,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return errorBuilderWidget();
                    },
                  ),
                ),
      onTap: () async {
        final FilePickerResult? pickedFile =
            await FilePicker.platform.pickFiles();

        if (pickedFile != null) {
          widget.setFilePickerResult(pickedFile);
          setState(() {
            _filePickerResult = pickedFile;
          });
        }
      },
    );
  }

  Container errorBuilderWidget() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text('Erro ao buscar esta imagem'),
      ),
    );
  }
}
