import 'bakr_data_model.dart';

class BakrModel {
  final String id;
  final String title;
  final List<BakrDataModel> bakrData;

  const BakrModel({required this.title, required this.bakrData, required this.id});

  int get totalQty => bakrData.fold(0, (total, data) => total + data.qty);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'bakrData': bakrData.map((e) => e.toMap()).toList(),
    };
  }

  factory BakrModel.fromMap(Map<String, dynamic> map) {
    return BakrModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      bakrData: List<Map<String, dynamic>>.from(
        map['bakrData'] ?? [],
      ).map((e) => BakrDataModel.fromMap(e)).toList(),
    );
  }
}
