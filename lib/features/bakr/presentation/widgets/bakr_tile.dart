import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/bakr_data_model.dart';

class BakrTile extends StatelessWidget {
  final BakrDataModel bakrDataModel;

  const BakrTile({super.key, required this.bakrDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: bakrDataModel.isLow
            ? Colors.red.withValues(alpha: .07)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 18,
            child: CircleAvatar(radius: 16, backgroundColor: bakrDataModel.color),
          ),
          Text(bakrDataModel.code, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            "${S.of(context).quantity}: ${bakrDataModel.qty}",
            style: TextStyle(
              color: bakrDataModel.isLow ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
