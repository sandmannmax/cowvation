import 'package:cowvation/features/cowlist/domain/entities/cow.dart';
import 'package:meta/meta.dart';

class CowModel extends Cow {
  CowModel({
    @required int number,
    @required int numberEar,
    @required String race,
    @required int agrop,
  }) : super(number: number, numberEar: numberEar, race: race, agrop: agrop);

  factory CowModel.fromJson(Map<String, dynamic> json) {
    dynamic numberEar = json['number_ear'];
    if (numberEar == null)
      numberEar = json['numberEar'];
    return CowModel(
      number: json['number'], 
      numberEar: numberEar,
      race: json['race'],
      agrop: json['agrop'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberEar': numberEar,
      'race': race,
      'agrop': agrop,
    };
  }
}