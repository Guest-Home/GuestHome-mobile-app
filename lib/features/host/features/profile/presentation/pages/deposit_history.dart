
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';
import '../bloc/profile_bloc.dart';

class DepositHistory extends StatefulWidget {
  const DepositHistory({super.key});

  @override
  State<DepositHistory> createState() => _DepositHistoryState();
}

class _DepositHistoryState extends State<DepositHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: AppBarBackButton(),
        title: Text(
          'Deposit History',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: ColorConstant.cardGrey,
                ),
              ),
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                  title: Text(
                    "Current Deposit",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if(state is ProfileErrorState || state.userProfileEntity.id==null){
                                  return SizedBox();
                                }
                                return RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:"${state.userProfileEntity.points}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " ETB",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ]));
                              },
                            ),
                      ),
                      SizedBox(
                        child: CustomButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                            ),
                            onPressed: () => context.goNamed('addFunds'),
                            child: Text(
                              "Add Funds",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Deposit History ",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color:
                  ColorConstant.inActiveColor.withValues(alpha: 0.5)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                  itemBuilder: (context, index) =>
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: ColorConstant.cardGrey,
                      ),
                    ),
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ListTile(
                        leading: Icon(Icons.download,color: ColorConstant.green,),
                        title: Text(
                          "Deposit",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          "2-Feb-2025",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:
                              ColorConstant.inActiveColor.withValues(alpha: 0.5)),
                        ),
                        trailing:Text("500 ETB",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                        ),)
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
