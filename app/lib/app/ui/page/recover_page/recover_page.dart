import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/model/guardian_model.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/guardians_page/widget/guardians_item.dart';
import 'package:app/app/ui/page/recover_page/recover_controller.dart';
import 'package:app/app/ui/page/recover_page/widget/recover_item.dart';
import 'package:app/app/ui/widget/button_widget.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';

class RecoverPage extends GetCommonView<RecoverController> {
  RecoverPage({super.key});

  List<GuardianModel?> seleted = [];

  List<GuardianModel> datas = [
    GuardianModel(
      name: 'Bob',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Sean',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Yin',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'King',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Tony',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Tony',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Tony',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Tony',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Tony',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Tony',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
    GuardianModel(
      name: 'Tony',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: TopBar(
                    isInfo: false,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            'Request more than 50% of the Guardians to Sign Transaction',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 9),
                          child: Text(
                            'Once the guardian signs the transaction, the wallet will recover immediately.',
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorStyle.color_black_60,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return RecoverItem(
                              model: datas[index],
                            );
                          },
                          itemCount: datas.length,
                          separatorBuilder: (_, index) {
                            return index != datas.length
                                ? const Divider(
                                    height: 1,
                                    color: ColorStyle.color_80979797,
                                  )
                                : Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Select',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorStyle.color_black_60,
                              ),
                            ),
                            TextSpan(
                              text: ' ${datas.length} ',
                              style: const TextStyle(
                                fontSize: 18,
                                color: ColorStyle.color_3940FF_80,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(
                              text: 'guardian to send request',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorStyle.color_black_60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          width: double.infinity,
                          height: 61,
                          onPressed: () {},
                          data: 'Send Request',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
