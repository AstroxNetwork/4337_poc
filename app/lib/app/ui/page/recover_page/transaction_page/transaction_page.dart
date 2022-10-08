import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/recover_page/transaction_page/transaction_controller.dart';
import 'package:app/app/ui/page/recover_page/transaction_page/widget/pouring_hour_glass.dart';
import 'package:app/app/ui/page/recover_page/transaction_page/widget/transaction_item.dart';
import 'package:app/app/ui/widget/topbar_widget.dart';
import 'package:flutter/material.dart';

class TransactionPage extends GetCommonView<TransactionController> {
  const TransactionPage({super.key});

  Widget _buildGuardiansList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemCount: controller.guardians.length,
        itemBuilder: (_, index) => TransactionItem(
          model: controller.guardians[index],
          isWaiting: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () async => false,
      onWillPop: () async => true,
      child: Scaffold(
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
                  const Align(alignment: Alignment.topCenter, child: TopBar()),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 20,
                          ),
                          child: const PouringHourGlass(
                            size: 60,
                            color: Colors.black,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Text(
                            'Waiting for the guardians to sign transaction…',
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            'Ask the guardian to scan the QR code below '
                            'and sign transaction',
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorStyle.color_black_60,
                            ),
                          ),
                        ),
                        Expanded(child: _buildGuardiansList(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
