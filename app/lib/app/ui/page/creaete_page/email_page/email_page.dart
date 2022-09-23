import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_controller.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/edit_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';

class EmailPage extends GetCommonView<EmailController> {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: TopBar(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 34, top: 25),
                      child: Text(
                        'Email Verification',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 34, top: 39),
                      child: Opacity(
                        opacity: 0.4,
                        child: Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 34, top: 9),
                      child: Edit(
                        width: 322,
                        height: 55,
                        hintText: 'info@xxx.com',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 34, top: 40),
                      child: Opacity(
                        opacity: 0.4,
                        child: Text(
                          'Verification Code',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 34, top: 9),
                      child: Edit(
                        width: 322,
                        height: 55,
                        hintText: 'code',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 34, top: 19),
                      child: RichText(
                          text: TextSpan(
                              text: 'You can resend after ',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                            TextSpan(
                                text: controller.countdown.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: ColorStyle.color_FF3940FF,
                                )),
                            const TextSpan(
                                text: ' seconds.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ))
                          ])),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Button(
                    width: 322,
                    height: 61,
                    onPressed: () => controller.isVerification
                        ? controller.verification()
                        : controller.sendVerification(),
                    data: controller.isVerification
                        ? 'Confirm'
                        : 'Send Verification Code',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}