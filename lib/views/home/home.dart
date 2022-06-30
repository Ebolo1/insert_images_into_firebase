import 'package:flutter/material.dart';
import 'package:insert_images_into_firebase/views/home/addImageSection.dart';
import 'package:insert_images_into_firebase/views/home/homeAppBar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(),
            AddImagesSection(),
          ],
        ),
      )
    );
  }
}
