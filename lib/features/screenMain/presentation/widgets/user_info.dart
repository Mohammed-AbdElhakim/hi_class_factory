import 'package:flutter/material.dart';

import '../../../../core/constants/app_styles.dart';
import '../../data/models/user_info_model.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.userInfoModel});

  final UserInfoModel userInfoModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xffFAFAFA),
      child: Center(
        child: ListTile(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(userInfoModel.name, style: AppStyles.styleSemiBold16(context)),
          ),
          subtitle: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(userInfoModel.email, style: AppStyles.styleRegular12(context)),
          ),
          leading: Icon(Icons.person_pin),
        ),
      ),
    );
  }
}
