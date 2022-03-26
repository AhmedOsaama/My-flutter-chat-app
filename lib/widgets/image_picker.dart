import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File) getPickedImage;
  ImagePickerWidget(this.getPickedImage);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _pickedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery,
    // imageQuality: 50,   //0 to 100
    // maxWidth:
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.getPickedImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage!) : null,
            radius: 40,
          ),
          FlatButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.add_photo_alternate,
                  color: Theme.of(context).primaryColor),
              label: Text(
                "Add Image",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    );
  }
}
