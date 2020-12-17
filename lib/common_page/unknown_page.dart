import 'package:f_ui/button/f_common_buttons.dart';
import 'package:f_ui/model/button_model.dart';
import 'package:flutter/material.dart';
import 'package:f_ui/config/res/resources.dart';

/// @description: 404页面
///@date: 2020/12/17 11

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/image/404.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '抱歉，您访问的页面不存在',
                style: TextStyle(
                  color: FColours.notFindColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 50),
              FCommonButtons(
                buttonType: ButtonType.Outlined,
                child: Text('回到上一页', style: TextStyle(fontSize: 16),),
                textColor: FColours.notFindColor,
                borderColor: FColours.notFindColor,
                radius: 100,
                color: FColours.notFindColor,
                hoverColor: FColours.notFindColor,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
