import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/city/city_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/widgets/property_photo_card.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/amenitie_type_card.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/constants/house_type_icons.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/house_type_card.dart';
import '../../../../../../core/common/upload_photo_widget.dart';
import '../../../../../../core/common/custom_text_field.dart';

class AddProperties extends StatefulWidget {
  const AddProperties({super.key});

  @override
  State<AddProperties> createState() => _AddPropertiesState();
}

class _AddPropertiesState extends State<AddProperties> {
  late PageController pageController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController addressNmaeController;
  late TextEditingController cityController;
  late TextEditingController priceController;
  late TextEditingController roomController;
  late TextEditingController agentIdController;

  final _houseFormKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();
  final _priceFormKey = GlobalKey<FormState>();
  final _agentFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    addressNmaeController = TextEditingController();
    cityController = TextEditingController();
    priceController = TextEditingController();
    roomController = TextEditingController();
    agentIdController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    addressNmaeController.dispose();
    cityController.dispose();
    priceController.dispose();
    roomController.dispose();
    agentIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 27,
          leading: AppBarBackButton(
            route: "properties",
          ),
        ),
        body: BlocConsumer<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //step1
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(
                              context, 'What type of house do you host?'),
                          Expanded(
                            child: BlocBuilder<PropertyTypeBloc,
                                PropertyTypeState>(
                              builder: (context, state) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 7,
                                          mainAxisSpacing: 7,
                                          mainAxisExtent: 100),
                                  itemCount: state.propertyTypes.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      context.read<PropertyTypeBloc>().add(
                                          SelectPropertyType(
                                              propertyType:
                                                  state.propertyTypes[index]));
                                      context.read<AddPropertyBloc>().add(
                                          AddHouseTypeEvent(
                                              houseTYpe: state
                                                  .propertyTypes[index]
                                                  .propertyType));
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 100),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: state.selectedPropertyType ==
                                                    state.propertyTypes[index]
                                                ? ColorConstant.primaryColor
                                                : Colors.white,
                                          )),
                                      child: HouseTypeCard(
                                        image: houseTypeIcons[state
                                            .propertyTypes[index]
                                            .propertyType]!,
                                        title: state
                                            .propertyTypes[index].propertyType,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    // step 2
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Form(
                        key: _houseFormKey,
                        child: Column(
                          spacing: 15,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stepTitleText(context, 'About the house'),
                            stepSutTitle(
                                context, "Registered House name?", true),
                            CustomTextField(
                              textEditingController: nameController,
                              hintText: "eg Diamond Guest House",
                              surfixIcon: null,
                              textInputType: TextInputType.text,
                              isMultiLine: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter house name';
                                }
                                return null;
                              },
                              onTextChnage: (value) {
                                context
                                    .read<AddPropertyBloc>()
                                    .add(AddNameEvent(name: value));
                              },
                            ),
                            stepSutTitle(
                                context, "Description of the house", true),
                            CustomTextField(
                              textEditingController: descriptionController,
                              hintText: "eg Diamond Guest House",
                              surfixIcon: null,
                              isMultiLine: true,
                              textInputType: TextInputType.multiline,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter house name';
                                }
                                return null;
                              },
                              onTextChnage: (value) {
                                context.read<AddPropertyBloc>().add(
                                    AddDescriptionEvent(description: value));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // step 3
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, 'Add Amenities '),
                          Expanded(
                              child: BlocBuilder<AmenitiesBloc, AmenitiesState>(
                            builder: (context, state) {
                              return GridView.builder(
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          mainAxisExtent: 100),
                                  itemCount: state.amenities.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          context.read<AmenitiesBloc>().add(
                                              SelectAmenityEvent(
                                                  amenity:
                                                      state.amenities[index]));
                                          context.read<AddPropertyBloc>().add(
                                              AddAmenityEvent(
                                                  amenityName: state
                                                      .amenities[index]
                                                      .amenity));
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 100),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: state.selectedAmenity
                                                          .contains(state
                                                              .amenities[index])
                                                      ? ColorConstant
                                                          .primaryColor
                                                      : Colors.white)),
                                          child: AmenitieTypeCard(
                                            icon: amenitiesIcon[state
                                                .amenities[index].amenity]!,
                                            title:
                                                state.amenities[index].amenity,
                                          ),
                                        ),
                                      ));
                            },
                          ))
                        ],
                      ),
                    ),
                    // step 4
                    Container(
                        padding: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _locationFormKey,
                            child: Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                stepTitleText(context, "Location"),
                                Stack(children: [
                                  Placeholder(
                                    fallbackHeight: 340,
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    left:
                                        MediaQuery.of(context).size.width / 2 -
                                            100,
                                    right:
                                        MediaQuery.of(context).size.width / 2 -
                                            100,
                                    child: CustomButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              ColorConstant.primaryColor,
                                          padding: EdgeInsets.all(1),
                                        ),
                                        child: Text(
                                          "use current location",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )
                                ]),
                                stepSutTitle(context,
                                    "Know or address  name of the place", true),
                                CustomTextField(
                                  textEditingController: addressNmaeController,
                                  hintText: "eg bole ",
                                  surfixIcon: null,
                                  isMultiLine: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter address name';
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.text,
                                  onTextChnage: (value) {
                                    context.read<AddPropertyBloc>().add(
                                        AddAdressNameEvent(addressName: value));
                                  },
                                ),
                                stepSutTitle(context,
                                    "Please select the name of the city", true),
                                CustomTextField(
                                  textEditingController: cityController,
                                  hintText: state.city,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter city name';
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.text,
                                  surfixIcon: SizedBox(
                                    child: CityDropDown(onSelected: (value) {
                                      cityController.text = value;
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(AddCityEvent(city: value));
                                    }),
                                  ),
                                  isMultiLine: false,
                                  onTextChnage: (value) {
                                    context
                                        .read<AddPropertyBloc>()
                                        .add(AddCityEvent(city: value));
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
                    // step 5
                    Container(
                        padding: EdgeInsets.all(15),
                        child: Form(
                          key: _priceFormKey,
                          child: Column(
                            spacing: 15,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              stepTitleText(context, "Price"),
                              stepSutTitle(
                                  context,
                                  "How many rooms do you have with the same price?",
                                  true),
                              CustomTextField(
                                textEditingController: roomController,
                                hintText: "eg 4",
                                surfixIcon: null,
                                isMultiLine: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter room number';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.number,
                                onTextChnage: (value) {
                                  context.read<AddPropertyBloc>().add(
                                      AddRoomNumberEvent(roomNumber: value));
                                },
                              ),
                              stepSutTitle(context, 'Enter the price', true),
                              CustomTextField(
                                textEditingController: priceController,
                                hintText: "500",
                                surfixIcon: null,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter price';
                                  }
                                  return null;
                                },
                                isMultiLine: false,
                                textInputType: TextInputType.number,
                                onTextChnage: (value) {
                                  context
                                      .read<AddPropertyBloc>()
                                      .add(AddPriceEvent(price: value));
                                },
                              ),
                            ],
                          ),
                        )),
                    // step 6
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, "Add Photos of the house"),
                          UploadPhoto(
                            ontTap: () {
                              context
                                  .read<AddPropertyBloc>()
                                  .add(SelectPhotosEvent());
                            },
                          ),
                          Expanded(
                              child: ListView.builder(
                            itemCount: state.images.length,
                            itemBuilder: (context, index) => Card(
                                elevation: 0.2,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ColorConstant.cardGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PropertyPhotoCard(
                                    image: state.images[index],
                                    ontap: () {
                                      context.read<AddPropertyBloc>().add(
                                          RemovePictureEvent(index: index));
                                    },
                                  ),
                                )),
                          ))
                        ],
                      ),
                    ),
                    //step 7
                    Container(
                        padding: EdgeInsets.all(15),
                        child: Form(
                          key: _agentFormKey,
                          child: Column(
                            spacing: 15,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              stepTitleText(context, "Agent Info"),
                              stepSutTitle(
                                  context,
                                  "Enter agent id if you don’t have click finish(optional)",
                                  false),
                              CustomTextField(
                                textEditingController: agentIdController,
                                hintText: "agent id",
                                surfixIcon: null,
                                isMultiLine: false,
                                validator: (value) {
                                  return null;
                                },
                                textInputType: TextInputType.text,
                                onTextChnage: (value) {
                                  if (value.isEmpty) {
                                    context
                                        .read<AddPropertyBloc>()
                                        .add(AdddAgentIdEvent(agentId: ''));
                                  } else {
                                    context
                                        .read<AddPropertyBloc>()
                                        .add(AdddAgentIdEvent(agentId: value));
                                  }
                                },
                              ),
                            ],
                          ),
                        ))
                  ],
                )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(
                            child: CustomButton(
                                onPressed: () {
                                  if (state.step != 0) {
                                    context
                                        .read<AddPropertyBloc>()
                                        .add(BackStepEvent());
                                  } else {
                                    context.goNamed('properties');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        color: ColorConstant.secondBtnColor),
                                    backgroundColor: Colors.white),
                                child: Text("Back",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: ColorConstant.secondBtnColor,
                                        )))),
                        Expanded(
                            child: CustomButton(
                                onPressed: () async {
                                  if (state.step == 0) {
                                    if (state.houseType.isEmpty) {
                                      _showErrorSnackBar(
                                          context, "Please select house type");
                                    } else {
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(NextStepEvent());
                                    }
                                  } else if (state.step == 1) {
                                    _houseFormKey.currentState!.validate();
                                    if (_houseFormKey.currentState!
                                        .validate()) {
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(NextStepEvent());
                                    }
                                  } else if (state.step == 2) {
                                    if (state.amenities.isEmpty) {
                                      _showErrorSnackBar(
                                          context, "Please select amenities");
                                    } else {
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(NextStepEvent());
                                    }
                                  } else if (state.step == 3) {
                                    _locationFormKey.currentState!.save();
                                    if (_locationFormKey.currentState!
                                        .validate()) {
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(NextStepEvent());
                                    }
                                  } else if (state.step == 4) {
                                    _priceFormKey.currentState!.save();
                                    if (_priceFormKey.currentState!
                                        .validate()) {
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(NextStepEvent());
                                    }
                                  } else if (state.step == 5) {
                                    if (state.images.isEmpty) {
                                      _showErrorSnackBar(
                                          context, "Please select images");
                                    } else {
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(NextStepEvent());
                                    }
                                  } else if (state.step == 6) {
                                    context
                                        .read<AddPropertyBloc>()
                                        .add(AddNewPropertyEvent());

                                    // context
                                    //     .read<AddPropertyBloc>()
                                    //     .add(NextStepEvent());
                                    // context
                                    //     .read<AddPropertyBloc>()
                                    //     .add(ResetEvent());

                                    //context.goNamed('properties');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        color: ColorConstant.primaryColor),
                                    backgroundColor:
                                        ColorConstant.primaryColor),
                                child: state is AddNewPropertyLoading
                                    ? loading
                                    : Text(state.step != 6 ? "Next" : "Finish",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Colors.white,
                                            ))))
                      ],
                    ))
              ],
            );
          },
          buildWhen: (previous, current) => previous != current,
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is AddNewPropertyErrorState) {
              _showErrorSnackBar(context, state.failure.message);
            } else if (state is AddNewPropertySuccess) {}
            pageController.jumpToPage(state.step);
          },
        ));
  }

  RichText stepSutTitle(BuildContext context, String title, bool isRequired) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold)),
      TextSpan(
          text: isRequired ? "*" : '(optional)',
          style: TextStyle(
              color: isRequired
                  ? ColorConstant.red
                  : ColorConstant.cardGrey.withValues(alpha: 0.5)))
    ]));
  }

  Text stepTitleText(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: ColorConstant.red,
    ));
  }
}

class CityDropDown extends StatelessWidget {
  const CityDropDown({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        return PopupMenuButton<String>(
          icon: Icon(Icons.arrow_drop_down),
          onSelected: (value) => onSelected(value),
          position: PopupMenuPosition.under,
          color: Colors.white,
          itemBuilder: (BuildContext context) {
            return List.generate(
              state.cities.length,
              (index) => PopupMenuItem(
                  value: state.cities[index].city,
                  child: Text(tr(state.cities[index].city))),
            );
          },
        );
      },
    );
  }
}
