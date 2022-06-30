import 'package:cloud_firestore/cloud_firestore.dart';

class Image1 {
  String? imageDescription, imageID, imageUrlImg, imageName, imagePrice;
  Timestamp? imageTimestamp;
  bool? isMyFavoritedCar;
  int? imageFavoriteCount;
  Image1(
      {this.imageDescription,
      this.imageID,
      this.imageUrlImg,
      this.imageName,
      this.imagePrice,
      this.imageTimestamp,
      this.isMyFavoritedCar,
      this.imageFavoriteCount});
}
