import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapp/config/color/color.dart';

import '../../../../core/common/bloc/language_bloc.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        spacing: 40,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing:10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   "assets/icons/language.svg",
              //   semanticsLabel: 'language',
              //   width: 20,
              //   height: 20
              // ),
              Icon(Icons.translate),
              Text(
                context.tr('language'),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ColorConstant.primaryColor),
              ),
            ],
          ),
          BlocConsumer<LanguageBloc, LanguageState>(
            listener: (context, state) {
              context.setLocale(state.locale);
            },
            buildWhen: (previous, current) =>
                previous.selectedLanguage.name != current.selectedLanguage.name,
            builder: (context, state) {
              return Column(
                  spacing: 10,
                  children: AppLocal.values
                      .map((e) => Container(
                          width: 238,
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              border: Border.all(color: ColorConstant.primaryColor)),
                          child: RadioListTile.adaptive(
                            enableFeedback: false,
                            value: e,
                            activeColor: ColorConstant.primaryColor,
                            tileColor: Colors.transparent,
                            selectedTileColor: ColorConstant.primaryColor,
                            title: Text(e.name=="amharic"?"አማርኛ":e.name=="afanOromo"?"afan oromo":
                              e.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: ColorConstant.primaryColor),
                            ),
                            groupValue: state.selectedLanguage,
                            onChanged: (value) {
                              context
                                  .read<LanguageBloc>()
                                  .add(ChangeAppLocalEvent(value!));
                            },
                          )))
                      .toList());
            },
          ),
        ],
      ),
    );
  }
}
