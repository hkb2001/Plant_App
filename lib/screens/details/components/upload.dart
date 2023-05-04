import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class upload extends StatelessWidget {
  const upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ImageURL = '';
    return MaterialApp(
      title: 'Image Upload Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                //code here
                ImagePicker imagepicker = ImagePicker();
                XFile? file =
                    await imagepicker.pickImage(source: ImageSource.gallery);

                if (file == null) {
                  print("In IF");
                  return;
                } else {
                  print("In else");
                  print("File Path: ");
                  print(file?.path.toString());

                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDIRImages = referenceRoot.child('images');

                  Reference referenceImagetoUpload =
                      referenceDIRImages.child('${file?.name}');

                  try {
                    await referenceImagetoUpload.putFile(File(file!.path));
                    ImageURL = await referenceImagetoUpload.getDownloadURL();
                  } catch (error) {
                    print("FIle not Uploaded: $error");
                  }
                }
              },
              child: Text("Upload Image"),
            ),
          ],
        ),
      )),
    );
  }
}
