import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagles_customer_app/main.dart';
import 'package:eagles_customer_app/parent%20App/mainPageP.dart';
import 'package:eagles_customer_app/parent%20App/Model/leaveModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUploadPage extends StatefulWidget {
  const ProfileUploadPage({Key? key}) : super(key: key);

  @override
  State<ProfileUploadPage> createState() => _ProfileUploadPageState();
}

class _ProfileUploadPageState extends State<ProfileUploadPage> {

  String url = '';
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: const Text('Upload Profile'),
          ),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: SizedBox(
                            width: 110,
                            height: 110,
                            child: _image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey,),
                              child: Icon(
                                Icons.camera_alt,
                                size:50,
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent),
                            onPressed: () async {

                              if(url != ''  || url != null) {
                                await FirebaseFirestore.instance
                                    .collection('parent')
                                    .doc(currentParentId)
                                    .update({'profileUrl': url})
                                    .then((value) {
                                  showSnackBar('Registered Successfully');
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (
                                          context) => const MainPageP()), (route) => false);
                                });
                              }
                              else{
                                showSnackBar('Please Upload Your Photo');
                              }

                            },
                            child: const Text('Submit')),
                        SizedBox(width: 20,),
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }

  _imgFromGallery() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    setState(() {
      _image = image;
    });

    var ref = FirebaseStorage.instance.ref().child('parent/profile/$currentParentId');
    UploadTask uploadTask = ref.putFile(File(_image!.path));
    uploadTask.then((res) async {
      url = (await ref.getDownloadURL()).toString();
      print('--------------------------------------------------------------');
      print(url);
      print('--------------------------------------------------------------');
    });
  }

  _imgFromCamera() async {
    final XFile? photo =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    setState(() {
      _image = photo;
    });

    var ref = FirebaseStorage.instance.ref().child('parent/profile/$currentParentId');
    UploadTask uploadTask = ref.putFile(File(_image!.path));
    uploadTask.then((res) async {
      url = (await ref.getDownloadURL()).toString();
      print('--------------------------------------------------------------');
      print(url);
      print('--------------------------------------------------------------');
    });
  }

  void _showPicker(context) {

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),

              ],
            ),
          );
        });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
          width: 400,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Text(message,style: const TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 15)),

          action: SnackBarAction(
            label: "Dismiss" ,
            textColor: Colors.black54,
            disabledTextColor: Colors.white,
            onPressed: () { print('Dismiss pressed'); },

          ),
        )
    );
  }
}
