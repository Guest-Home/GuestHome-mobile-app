import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          tr('language'),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('language'),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Expanded(
                  child: BlocProvider.value(
                    value: context.read<LanguageBloc>(),
                    child: BlocConsumer<LanguageBloc, LanguageState>(
                      listener: (context, state) {
                        context.setLocale(state.locale);
                      },
                      builder: (context, state) {
                        return TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: state.selectedLanguage.name.toString(),
                            filled: true,
                            fillColor: ColorConstant.cardGrey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: PopupMenuButton<String>(
                              icon: Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                print(value);
                                context
                                    .read<LanguageBloc>()
                                    .add(ChangeAppLocalSetting(value));
                              },
                              color: Colors.white,
                              itemBuilder: (BuildContext context) {
                                return AppLocal.values
                                    .map(
                                      (e) => PopupMenuItem(
                                          value: e.name,
                                          child: Text(e.name == "amharic"
                                              ? "አማርኛ"
                                              : e.name)),
                                    )
                                    .toList();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
