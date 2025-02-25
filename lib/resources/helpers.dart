import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class NewHelpers{
  //for single file selection from gallery
  Future addFilePicker() async {
    try{
      final selectedFile = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpg','jpeg','png']);
      if(selectedFile == null){
        return null;
      }else{
        return File(selectedFile.files.first.path!);
      }
    }on PlatformException catch (e) {
      throw Exception(e);
    }
  }

  // for multiple file select from the gallery
  Future<List<File>?> addFilePickerList() async {
    try{
      final selectedImgList = await FilePicker.platform.pickFiles(allowMultiple: true,allowedExtensions: ['jpg'],type: FileType.custom);
        if(selectedImgList == null){
          return null;
        } else{
          return selectedImgList.files.map((item)=>File(item.path!)).toList();
        }
    } on PlatformException catch(e){
      throw Exception(e);
    }
  }

  // for image take from camera
  Future takeImgFromCamera( {ImageSource imageSource = ImageSource.gallery,
    int imageQuality = 50}) async {
    try{
      final chooseImg = await ImagePicker()
          .pickImage(source: imageSource, imageQuality: imageQuality);
      if(chooseImg == null){
        return null;
      }else{
        return File(chooseImg.path);
      }
    }on PlatformException catch(e){
      throw Exception(e);
    }

  }
}