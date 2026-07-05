// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponseModel _$HomeResponseModelFromJson(Map<String, dynamic> json) =>
    HomeResponseModel(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      monthlyIncome: (json['monthlyIncome'] as num).toDouble(),
      monthlyExpense: (json['monthlyExpense'] as num).toDouble(),
    );

Map<String, dynamic> _$HomeResponseModelToJson(HomeResponseModel instance) =>
    <String, dynamic>{
      'totalBalance': instance.totalBalance,
      'monthlyIncome': instance.monthlyIncome,
      'monthlyExpense': instance.monthlyExpense,
    };
