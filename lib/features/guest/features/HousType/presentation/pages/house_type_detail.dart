import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/houstype_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/popular_property/popular_property_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/near_house_card.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';

import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../../core/utils/get_token.dart';
import '../../../../../host/features/properties/presentation/pages/add_properties.dart';
import '../../../../../host/features/properties/presentation/widgets/search_filed.dart';
import '../widgets/popular_house_card.dart';
import '../widgets/section_header_text.dart';

class HouseTypeDetail extends StatefulWidget {
  HouseTypeDetail({super.key, required this.name});

  final String name;

  final TextEditingController cityController = TextEditingController();

  @override
  State<HouseTypeDetail> createState() => _HouseTypeDetailState();
}

class _HouseTypeDetailState extends State<HouseTypeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: ColorConstant.primaryColor,
        color: Colors.white,
        onRefresh: () async {
          context
              .read<HoustypeBloc>()
              .add(GetPropertyByHouseTypeEvent(name: widget.name));
          context.read<PopularPropertyBloc>().add(GetPopularPropertyEvent());
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: true,
              snap: true,
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: AppBarBackButton(),
              shadowColor: Colors.transparent,
              scrolledUnderElevation: 0,
            ),
            SliverToBoxAdapter(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          spacing: 15,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context.pushNamed("search"),
                                child: SearchField(
                                  isActive: false,
                                  prifixIcon: Icon(
                                    Icons.search,
                                    color: ColorConstant.secondBtnColor,
                                  ),
                                  onTextChnage: (value) {},
                                ),
                              ),
                            ),
                            BlocBuilder<FilterBloc, FilterState>(
                              buildWhen: (previous, current) =>
                                  previous != current,
                              builder: (context, state) {
                                if (state is FilterDataLoadedState) {
                                  return Badge(
                                    label:
                                        Text(state.properties.count.toString()),
                                    alignment: Alignment.topRight,
                                    offset: Offset(0.0, 10.0),
                                    isLabelVisible: state.category.isNotEmpty
                                        ? true
                                        : false,
                                    child: IconButton(
                                      iconSize: 33,
                                      icon: Icon(Icons.filter_list),
                                      onPressed: () =>
                                          filterModalBottomSheet(context),
                                    ),
                                  );
                                }
                                return Badge(
                                  label: Text(""),
                                  alignment: Alignment.topRight,
                                  offset: Offset(0.0, 10.0),
                                  isLabelVisible:
                                      state.category.isNotEmpty ? true : false,
                                  child: IconButton(
                                    iconSize: 33,
                                    icon: Icon(Icons.filter_list),
                                    onPressed: () =>
                                        filterModalBottomSheet(context),
                                  ),
                                );
                              },
                            )
                          ],
                        )),
                    BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, filterState) {
                        if (filterState is FilterErrorState) {
                          return Center(
                            child: Text(filterState.failure.message),
                          );
                        }
                        if (filterState is FilterDataLoadedState) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Selected  house type: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      filterState.category.isNotEmpty
                                          ? filterState.category
                                          : widget.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color:
                                                  ColorConstant.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filterState.properties.count,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () async {
                                        final token =
                                            await GetToken().getUserToken();
                                        context.push('/houseDetail/$token',
                                            extra: filterState
                                                .properties.results![index]);
                                      },
                                      child: NearHouseCard(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          property: filterState
                                              .properties.results![index]));
                                },
                              ),
                            ],
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: SecctionHeader(
                                title: tr("Most Popular"),
                                isSeeMore: true,
                              ),
                            ),
                            BlocBuilder<PopularPropertyBloc,
                                PopularPropertyState>(
                              buildWhen: (previous, current) =>
                                  previous != current,
                              builder: (context, state) {
                                if (state is PopularPropertyLoadingState) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.42,
                                    child: Center(
                                      child: loadingIndicator(),
                                    ),
                                  );
                                } else if (state.properties.count == 0 ||
                                    state.properties.results == null) {
                                  return Center(
                                    child: Text(
                                      "no property found",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  );
                                } else if (state
                                    .properties.results!.isNotEmpty) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.42,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      itemCount:
                                          state.properties.results!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () async {
                                          final token =
                                              await GetToken().getUserToken();
                                          context.push(
                                            '/houseDetail/$token',
                                            extra: state
                                                .properties.results![index],
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          child: Material(
                                            elevation: 2,
                                            shadowColor: ColorConstant.cardGrey
                                                .withValues(alpha: 0.3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: PopularHouseCard(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                height: 300,
                                                showBorder: true,
                                                showIndicator: false,
                                                property: state.properties
                                                    .results![index]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: SecctionHeader(
                                title: 'Nearby your location',
                                isSeeMore: false,
                              ),
                            ),
                            BlocBuilder<HoustypeBloc, HoustypeState>(
                              builder: (context, state) {
                                if (state is HouseTypeLoadingState) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (state.properties.count == 0 ||
                                    state.properties.results == null) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/icons/Inboxe.png",
                                          width: 80,
                                          height: 80,
                                        ),
                                        Text(
                                          "no property\n found under ${widget.name} ",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (state
                                    .properties.results!.isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.properties.results!.length,
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final token =
                                              await GetToken().getUserToken();
                                          context.push('/houseDetail/$token',
                                              extra: state
                                                  .properties.results![index]);
                                        },
                                        child: NearHouseCard(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 400,
                                          property:
                                              state.properties.results![index],
                                        ),
                                      );
                                    },
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ],
                        );
                      },
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filterModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: false,
      backgroundColor: Colors.white,
      useSafeArea: true,
      elevation: 10,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.80,
        child: BlocListener<FilterBloc, FilterState>(
          listener: (context, state) {
            if (state is FilterDataLoadedState) {

            } else if (state is FilterErrorState) {
              showWarningSnackBar(context, state.failure.message);
            }
          },
          child: BlocBuilder<FilterBloc, FilterState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, filterState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14, top: 10, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr('Filter Houses'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              tr("Close"),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: ColorConstant.red),
                            ),
                            IconButton(
                                onPressed: () {
                                  context.read<FilterBloc>().add(ResetEvent());
                                  context.pop();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: ColorConstant.red,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    children: [
                      SizedBox(
                        height: 110,
                        child: BlocBuilder<PropertyTypeBloc, PropertyTypeState>(
                          buildWhen: (previous, current) => previous != current,
                          builder: (context, state) {
                            return Column(
                              spacing: 10,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Selected  house type: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      filterState.category.isNotEmpty
                                          ? filterState.category
                                          : widget.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color:
                                                  ColorConstant.primaryColor),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.propertyTypes.length,
                                    itemBuilder: (context, index) => Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<FilterBloc>().add(
                                              AddHouseTypeEvent(
                                                  houseType: state
                                                      .propertyTypes[index]
                                                      .propertyType));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          spacing: 4,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(13),
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                  color: filterState
                                                          .category.isNotEmpty
                                                      ? filterState.category ==
                                                              state
                                                                  .propertyTypes[
                                                                      index]
                                                                  .propertyType
                                                          ? ColorConstant
                                                              .primaryColor
                                                              .withValues(
                                                                  alpha: 0.5)
                                                          : ColorConstant
                                                              .cardGrey
                                                      : widget.name ==
                                                              state
                                                                  .propertyTypes[
                                                                      index]
                                                                  .propertyType
                                                          ? ColorConstant
                                                              .primaryColor
                                                              .withValues(
                                                                  alpha: 0.5)
                                                          : ColorConstant
                                                              .cardGrey,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: SvgPicture.asset(
                                                  width: 20,
                                                  height: 20,
                                                  houseTypeIcons[state
                                                      .propertyTypes[index]
                                                      .propertyType]!,
                                                  semanticsLabel:
                                                      houseTypeList[index],
                                                  fit: BoxFit.cover,
                                                )),
                                            Text(
                                              state.propertyTypes[index]
                                                  .propertyType,
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SecctionHeader(
                            title: tr("Price range"), isSeeMore: false),
                      ),
                      RangeSlider(
                        values: filterState.priceRange,
                        labels: RangeLabels(
                            filterState.priceRange.start.toString(),
                            filterState.priceRange.end.toString()),
                        activeColor: ColorConstant.primaryColor,
                        inactiveColor: Colors.grey,
                        min: 100,
                        max: 5000,
                        divisions: 300,
                        onChanged: (value) {
                          if (filterState.category.isNotEmpty) {
                            context
                                .read<FilterBloc>()
                                .add(AddPriceRange(prices: value));
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: ColorConstant.secondBtnColor,
                                        )),
                                    child: Text(
                                      "${filterState.priceRange.start.ceil()} ETB",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    )),
                                Text(
                                  tr('Minimum'),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: ColorConstant.secondBtnColor,
                                        )),
                                    child: Text(
                                        "${filterState.priceRange.end.ceil()} ETB",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w400))),
                                Text(
                                  tr('Maximum'),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SecctionHeader(
                            title: tr("Location"), isSeeMore: false),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                          hintText: tr("Addis Ababa"),
                          validator: (value) {
                            return null;
                          },
                          textEditingController: widget.cityController,
                          surfixIcon: SizedBox(
                            child: CityDropDown(onSelected: (value) {
                              if (filterState.category.isNotEmpty) {
                                widget.cityController.text = value;
                                context
                                    .read<FilterBloc>()
                                    .add(AddFilterCityEvent(city: value));
                              }
                            }),
                          ),
                          onTextChnage: (value) {},
                          isMultiLine: false,
                          textInputType: TextInputType.text),
                      CheckboxListTile(
                        activeColor: ColorConstant.green,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: filterState.isNearSearch,
                        title: Text(
                          tr('Nearby Search'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        onChanged: (value) {
                          context
                              .read<FilterBloc>()
                              .add(AddIsNearSearchEvent(isNear: value!));
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 15,
                          children: [
                            Expanded(
                                child: CustomButton(
                                    onPressed: () {
                                      context
                                          .read<FilterBloc>()
                                          .add(ResetEvent());
                                      context.pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                                color: ColorConstant
                                                    .secondBtnColor))),
                                    child: Text(
                                      tr("Clear all"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color:
                                                  ColorConstant.secondBtnColor,
                                              fontWeight: FontWeight.w600),
                                    ))),
                            Expanded(
                                child: filterState is FilterDataLoadedState
                                    ? CustomButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstant.primaryColor,
                                          padding: EdgeInsets.all(20),
                                        ),
                                        child: Text(
                                                "${tr("Show")}(${filterState.properties.count})Result",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ))
                                    : CustomButton(
                                        onPressed:filterState is FilterDataLoadingState?(){}:
                                            () {
                                          if(filterState.category.isNotEmpty || filterState.city.isNotEmpty
                                          ){
                                            context
                                                .read<FilterBloc>()
                                                .add(FilterPropertyEvent());
                                          }

                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstant.primaryColor,
                                          padding: EdgeInsets.all(20),
                                        ),
                                        child: filterState
                                                is FilterDataLoadingState
                                            ? loading
                                            : Text(
                                                tr("Show"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              )))
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
