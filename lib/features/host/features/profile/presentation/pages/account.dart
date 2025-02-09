import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/back_button.dart';
class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AppBarBackButton(),
          title: Text(
            tr('Account'),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListTile(
            onTap: (){
              if(GoRouter.of(context).routerDelegate.state!.name=='guestAccount'){
                context.pushNamed("guestDeleteAccount");
              }else{
                context.goNamed('deleteAccount');
              }
              },
            leading:Icon(Icons.delete_outline_outlined,size: 19,),
            title:Text(
              tr("Deactivate account"),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w400,fontSize: 14),
            ),
            trailing: Icon(Icons.arrow_forward_ios,size: 17,),
          ),
        ));
  }

}
