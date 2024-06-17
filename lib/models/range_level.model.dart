import 'dart:convert';

RangeLevelModel difficultyLevelsModelFromJson(String str) => RangeLevelModel.fromJson(json.decode(str));

String difficultyLevelsModelToJson(RangeLevelModel data) => json.encode(data.toJson());

class RangeLevelModel {
    int max;
    int min;
    

    RangeLevelModel({
        required this.max,
        required this.min,
        
    });

    factory RangeLevelModel.fromJson(Map<String, dynamic> json) => RangeLevelModel(
        max: json["max"],
        min: json["min"]
    );

    Map<String, dynamic> toJson() => {
        "max": max,
        "min": min
    };
}
