import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insert_images_into_firebase/model/image_model.dart';
import 'package:insert_images_into_firebase/services/db_services.dart';
import 'package:insert_images_into_firebase/views/home/notif.dart';

class ImageDialog {
  void showImageDialog(BuildContext context, ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);
    final _formKey = GlobalKey<FormState>();
    String _imageName = '';
    String _imageDescription = '';
    String _imagePrice = '';
    String _formErrorName = 'Veillez svp fournir le nom de l\'image';
    String _formErrorDes = 'Veillez svp fournir la description de l\'image';
    String _formErrorPrice = 'Veillez svp fournir le prix de l\'image';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final mobilHeight = MediaQuery.of(context).size.height * 0.25;
          final webHeight = MediaQuery.of(context).size.height * 0.5;
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Container(
                height: kIsWeb ? webHeight : mobilHeight,
                margin: const EdgeInsets.all(8.0),
                color: Colors.grey,
                child: kIsWeb
                    ? Image(
                        image: NetworkImage(_file.path),
                        fit: BoxFit.cover,
                      )
                    : Image(
                        image: FileImage(_file),
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            maxLength: 20,
                            onChanged: (value) => _imageName = value,
                            validator: (value) =>
                                _imageName == '' ? _formErrorName : null,
                            decoration: const InputDecoration(
                              labelText: 'Nom de l\'image',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          TextFormField(
                            maxLength: 50,
                            onChanged: (value) => _imageDescription = value,
                            validator: (value) =>
                                _imageDescription == '' ? _formErrorDes : null,
                            decoration: const InputDecoration(
                              labelText: 'Description de l\'image',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          TextFormField(
                            maxLength: 6,
                            onChanged: (value) => _imagePrice = value,
                            validator: (value) =>
                                _imagePrice == '' ? _formErrorPrice : null,
                            decoration: const InputDecoration(
                              labelText: 'Prix de l\'image',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('ANNULER'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => onSubmit(
                                context,
                                _formKey,
                                _file,
                                _pickedFile,
                                _imageName,
                                _imageDescription,
                                _imagePrice),
                            child: const Text('PUBLIER'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  void onSubmit(context, formKey, file, fileWeb, imageName, imageDescription,
      imagePrice) async {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement...");
      try {
        DatabaseService db = DatabaseService();
        String _imageUrlImg = await db.uploadFile(file, fileWeb);
        db.addImage(Image1(
          imageDescription: imageDescription,
          imageName: imageName,
          imagePrice: imagePrice,
          imageUrlImg: _imageUrlImg,
        ));
      } catch (error) {
        showNotification(context, "Erreur $error");
      }
    }
  }
}
