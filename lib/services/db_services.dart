import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insert_images_into_firebase/model/image_model.dart';

class DatabaseService {
  // Déclaraction et Initialisation
  final CollectionReference _images = FirebaseFirestore.instance.collection('images');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload de l'image vers Firebase Storage
  Future<String> uploadFile(File file, XFile fileWeb) async {
    Reference reference = _storage.ref().child('images/${DateTime.now()}.png');
    Uint8List imageTosave = await fileWeb.readAsBytes();
    SettableMetadata metaData = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = kIsWeb
        ? reference.putData(imageTosave, metaData)
        : reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  // ajout de la voiture dans la BD firestore
  void addImage(Image1 image1) {
    _images.add({
      "imageDescription": image1.imageDescription,
      "imageUrlImg": image1.imageUrlImg,
      "imageName": image1.imageName,
      "imagePrice": image1.imagePrice,
      "imageTimestamp": FieldValue.serverTimestamp(),
      "imageFavoriteCount": 0,
    });
  }

}
