import 'package:flutter/material.dart';

import '../../../widgets/subtitle_widget.dart';

class ClintCreateProfileView extends StatelessWidget {
  const ClintCreateProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset('assets/images/createProfile.png'),
          ),
          SizedBox(
            height: 20,
          ),
          SubTitleWidget(
            title: 'Please create your profile',
          ),
        ],
      ),
    );
  }
}
