import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload to Firebase',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ImageUploader(),
    );
  }
}

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;
  final picker = ImagePicker();
  bool _isUploading = false;

  // Check and request permissions before picking an image
  Future<void> _checkPermissions() async {
    if (await Permission.storage.request().isGranted) {
      _pickImage();
    } else {
      print('Storage permission denied');
    }
  }

  // Pick image from gallery
  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Upload the image to Firebase Storage
  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Create a reference for the image file in Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the image to Firebase Storage
      final uploadTask = ref.putFile(_image!);

      // Monitor upload progress
      uploadTask.snapshotEvents.listen((event) {
        print('Task state: ${event.state}');
        print(
            'Progress: ${(event.bytesTransferred / event.totalBytes) * 100}%');
      });

      // Wait for the upload to complete
      await uploadTask;

      // Get the download URL of the uploaded image
      final downloadUrl = await ref.getDownloadURL();
      print('Image uploaded successfully: $downloadUrl');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image to Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, width: 200, height: 200)
                : Text('No image selected', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkPermissions, // Check permissions before picking
              child: Text('Pick Image'),
            ),
            SizedBox(height: 10),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadImage,
                    child: Text('Upload Image'),
                  ),
          ],
        ),
      ),
    );
  }
}
