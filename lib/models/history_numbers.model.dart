import 'dart:convert';
import 'package:agnostiko_test/enums/result.enum.dart';
import 'package:agnostiko_test/models/range_level.model.dart';
import 'package:flutter/material.dart';

HistoryNumbersModel difficultyLevelsModelFromJson(String str) => HistoryNumbersModel.fromJson(json.decode(str));

String difficultyLevelsModelToJson(HistoryNumbersModel data) => json.encode(data.toJson());

class HistoryNumbersModel {
    Result result;
    Color color;
    int numberHistory;

    HistoryNumbersModel({
        required this.result,
        required this.color,
        required this.numberHistory
    });

    factory HistoryNumbersModel.fromJson(Map<String, dynamic> json) => HistoryNumbersModel(
        result: json["result"],
        color: json["color"],
        numberHistory: json["numberHistory"]
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "color": color,
        "numberHistory": numberHistory,

    };
}