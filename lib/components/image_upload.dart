import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {

  final Function(String) onImageUrlChange;
  final String type;

  // const ImageUpload({super.key});
  const ImageUpload({required this.type, required this.onImageUrlChange, Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (widget.type == 'camera')? const Icon(Icons.camera_alt_outlined) : const Icon(Icons.photo) ,
      onPressed: () async {
        ImagePicker imagePicker = ImagePicker();

        XFile? file;
        if(widget.type == 'camera'){
          file = await imagePicker.pickImage(source: ImageSource.camera);
        }else{
          file = await imagePicker.pickImage(source: ImageSource.gallery);
        }
        print(file?.path);        

        if(file == null) return;

        //reference to firebase storage
        Reference refRoot = FirebaseStorage.instance.ref();
        Reference refDirImages = refRoot.child('users');  //ref to sub folder

        //creating a unique name for the image
        // String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
        String formattedDateTime = DateTime.now().toString(); 
        String uniqueFileName = formattedDateTime.replaceAll(RegExp(r'[^0-9]'), ''); // Removing non-numeric characters

        //ref for the image to be stored
        Reference refImageToUpload = refDirImages.child(uniqueFileName);  //'${file?.path}'

        try{
          //storing the file
          await refImageToUpload.putFile(File(file.path));

          //download url
          imageUrl = await refImageToUpload.getDownloadURL();
          // print(imageUrl);
          widget.onImageUrlChange(imageUrl);

        }catch(e) {
          print(e.toString());
        }
      },
    );
  }
}