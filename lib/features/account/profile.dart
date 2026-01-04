import 'package:app3/core/resources/app_colors.dart';
import 'package:app3/core/resources/app_icons.dart';
import 'package:app3/features/account/widgets/account_field.dart';
import 'package:app3/features/account/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: SizedBox(),

        title: Text(
          "Account",
          style: TextStyle(
            fontSize: 24,
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(),

            AccountField(
              icon: SvgPicture.asset(AppIcons.orders),
              text: "My Orders",
            ),
            Divider(thickness: 8, color: Color(0xffE6E6E6)),
            AccountField(
              icon: SvgPicture.asset(AppIcons.details),
              text: "My Details",
            ),
            Divider(thickness: 1, color: Color(0xffAAAAAA)),
            AccountField(
              icon: SvgPicture.asset(AppIcons.address),
              text: "Address Book",
            ),
            Divider(thickness: 1, color: Color(0xffAAAAAA)),
            AccountField(
              icon: SvgPicture.asset(AppIcons.question),
              text: "FAQs",
            ),
            Divider(thickness: 1, color: Color(0xffAAAAAA)),
            AccountField(
              icon: SvgPicture.asset(AppIcons.headphones),
              text: "Help Center",
            ),
            Divider(thickness: 8, color: Color(0xffE6E6E6)),
            const SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) => const LogoutDialog(),
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.logout),
                  SizedBox(width: 8,),
                  Text("Logout",style: TextStyle(fontSize: 16,color: Colors.red),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
