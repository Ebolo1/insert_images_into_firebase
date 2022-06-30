import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insert_images_into_firebase/views/home/show_image_dialog.dart';

import 'notif.dart';

class AddImagesSection extends StatelessWidget {
  const AddImagesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hey Hernadez'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      'Welcom to New Insert Into Firebase', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 50.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      child: IconButton(
                        onPressed: () => showImageDialog(context), 
                        icon: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              )

            ],
          )
        ]
      )
    );
  }


  void showImageDialog(BuildContext context) async {
    if (kIsWeb) {
      ImageDialog().showImageDialog(context, ImageSource.gallery);
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          ImageDialog().showImageDialog(context, ImageSource.gallery);
        }
      } on SocketException catch (_) {
        showNotification(context, 'Aucune connexion internet');
      }
    }
  }
}
