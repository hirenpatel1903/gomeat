import 'package:flutter/material.dart';
import 'package:vendor/Components/custom_button.dart';
import 'package:vendor/Components/entry_field.dart';
import 'package:vendor/Locale/locales.dart';

class SendToBank extends StatefulWidget {
  @override
  _SendToBankState createState() => _SendToBankState();
}

class _SendToBankState extends State<SendToBank> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.sendToBank.toUpperCase(),style: TextStyle(color:Theme.of(context). backgroundColor,),),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: locale.balanceAvailable + '\n',
                      style: Theme.of(context).textTheme.subtitle2),
                  TextSpan(
                      text: '\$2300.00',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(height: 1.6, fontSize: 20)),
                ])),
              ),
              Divider(
                height: 30,
                thickness: 8,
                color: Colors.grey[100],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                child: Text(
                  locale.provideBankDetails,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              EntryField(
                label: locale.fullName,
                labelFontSize: 15,
                labelFontWeight: FontWeight.w400,
                controller: TextEditingController()..text = 'Operum Market',
              ),
              EntryField(
                label: locale.bankName,
                labelFontSize: 15,
                labelFontWeight: FontWeight.w400,
                controller: TextEditingController()..text = 'Bank of New York',
              ),
              EntryField(
                label: locale.branchCode,
                labelFontSize: 15,
                labelFontWeight: FontWeight.w400,
                controller: TextEditingController()..text = 'NYC123456',
              ),
              EntryField(
                label: locale.accountNumber,
                labelFontSize: 15,
                labelFontWeight: FontWeight.w400,
                controller: TextEditingController()
                  ..text = '1234 5678 1234 5678',
              ),
              Divider(
                height: 30,
                thickness: 8,
                color: Colors.grey[100],
              ),
              EntryField(
                label: locale.enterAmountToTransfer,
                labelFontSize: 15,
                labelFontWeight: FontWeight.w400,
                controller: TextEditingController()..text = '\$1000',
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: CustomButton(
              onTap: () => Navigator.pop(context),
              label: locale.submit,
            ),
          ),
        ],
      ),
    );
  }
}
