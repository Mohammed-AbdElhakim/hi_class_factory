import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/home_data.dart';

part 'home_response_model.g.dart';

@JsonSerializable()
class HomeResponseModel {
  final double totalBalance;
  final double monthlyIncome;
  final double monthlyExpense;

  HomeResponseModel({
    required this.totalBalance,
    required this.monthlyIncome,
    required this.monthlyExpense,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseModelToJson(this);

  HomeData toDomain() => HomeData(
        totalBalance: totalBalance,
        monthlyIncome: monthlyIncome,
        monthlyExpense: monthlyExpense,
      );
}

extension HomeResponseModelX on HomeResponseModel {
  HomeData toDomain() => HomeData(
        totalBalance: totalBalance,
        monthlyIncome: monthlyIncome,
        monthlyExpense: monthlyExpense,
      );
}
