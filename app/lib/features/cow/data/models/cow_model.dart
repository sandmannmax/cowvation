import 'package:cowvation/features/cow/domain/entities/cow.dart';
import 'package:meta/meta.dart';

class CowModel extends Cow {
  CowModel({
    @required int number,
    @required String imageOne,
    @required String imageTwo,
    @required String imageThree,
    @required int numberEar,
    @required String race,
    @required String colorTendency,
    @required String height,
    @required bool manual,
    @required bool fetch,
    @required String group,
    @required int agrop,
  }) : super(
    number: number, 
    imageOne: imageOne, 
    imageTwo: imageTwo, 
    imageThree: imageThree, 
    numberEar: numberEar, 
    race: race, 
    colorTendency: colorTendency, 
    height: height, 
    manual: manual, 
    fetch: fetch, 
    group: group, 
    agrop: agrop
  );

  factory CowModel.fromJson(Map<String, dynamic> json) {
    dynamic imageOne = json['image_one'];
    if (imageOne == null)
      imageOne = json['imageOne'];

    dynamic imageTwo = json['image_two'];
    if (imageTwo == null)
      imageTwo = json['imageTwo'];

    dynamic imageThree = json['image_three'];
    if (imageThree == null)
      imageThree = json['imageThree'];

    dynamic numberEar = json['number_ear'];
    if (numberEar == null)
      numberEar = json['numberEar'];

    dynamic colorTendency = json['color_tendency'];
    if (colorTendency == null)
      colorTendency = json['colorTendency'];

    return CowModel(
      number: json['number'], 
      imageOne: imageOne, 
      imageTwo: imageTwo, 
      imageThree: imageThree, 
      numberEar: numberEar, 
      race: json['race'], 
      colorTendency: colorTendency, 
      height: json['height'], 
      manual: json['manual'], 
      fetch: json['fetch'], 
      group: json['group'], 
      agrop: json['agrop']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number, 
      'imageOne': imageOne, 
      'imageTwo': imageTwo, 
      'imageThree': imageThree, 
      'numberEar': numberEar, 
      'race': race, 
      'colorTendency': colorTendency, 
      'height': height, 
      'manual': manual, 
      'fetch': fetch, 
      'group': group, 
      'agrop': agrop
    };
  }
}