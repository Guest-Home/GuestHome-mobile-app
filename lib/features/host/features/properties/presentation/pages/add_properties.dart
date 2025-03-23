import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/core/utils/validator.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/city/city_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/properties_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/widgets/property_photo_card.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/apiConstants/api_url.dart';
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
  late MapController mapController;

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
    mapController = MapController();
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
    mapController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarBackButton(
            route: "properties",
          ),
        ),
        body:BlocConsumer<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            addressNmaeController.text=state.specificAddress;
            return Column(
              children: [
                Expanded(
                    child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //step1
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(
                              context, "${tr('What type of house do you host')}?"),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: BlocBuilder<PropertyTypeBloc,
                                PropertyTypeState>(
                              builder: (context, pState) {
                                if (pState is PropertyTypeLoadingState) {
                                  return SizedBox(
                                      height: 150,
                                      child: Center(
                                          child: CupertinoActivityIndicator()));
                                }
                                if (pState.propertyTypes.isNotEmpty) {
                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            mainAxisExtent: 100),
                                    itemCount: pState.propertyTypes.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        context.read<PropertyTypeBloc>().add(
                                            SelectPropertyType(propertyType: pState.propertyTypes[index]));
                                        context.read<AddPropertyBloc>().add(
                                            AddHouseTypeEvent(
                                                houseTYpe:
                                                pState.propertyTypes[index].propertyType));
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 100),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color:state.houseType==pState.propertyTypes[index].propertyType
                                                      ? ColorConstant
                                                          .primaryColor
                                                      : Colors.white,
                                            )),
                                        child: HouseTypeCard(
                                          image: houseTypeIcons[pState
                                              .propertyTypes[index]
                                              .propertyType]!,
                                          title: pState.propertyTypes[index]
                                              .propertyType,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                      height: 150,
                                      child: Center(
                                          child: CupertinoActivityIndicator()));
                                }
                              },
                            ),
                          )
                        ].animate().fade(),
                      ),
                    ),
                    // step 2
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _houseFormKey,
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 15,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              stepTitleText(context, tr('About the house')),
                              SizedBox(
                                height: 5,
                              ),
                              stepSutTitle(
                                  context, tr("Registered house name"), true),
                              CustomTextField(
                                textEditingController: nameController,
                                hintText: "eg: Diamond Guest House",
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
                              SizedBox(
                                height: 5,
                              ),
                              stepSutTitle(
                                  context, tr("Description of the house"), true),
                              CustomTextField(
                                textEditingController: descriptionController,
                                hintText: "eg: Diamond Guest House",
                                surfixIcon: null,
                                isMultiLine: true,
                                textInputType: TextInputType.multiline,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter house description';
                                  }
                                  return null;
                                },
                                onTextChnage: (value) {
                                  context.read<AddPropertyBloc>().add(
                                      AddDescriptionEvent(description: value));
                                },
                              ),
                            ].animate().fade(),
                          ),
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
                          stepTitleText(context, tr('Add amenities')),
                          Expanded(
                              child: BlocBuilder<AmenitiesBloc, AmenitiesState>(
                            builder: (context, state) {
                              if (state is AmenityLoadingState) {
                                return SizedBox(
                                    height: 150,
                                    child: Center(
                                        child: CupertinoActivityIndicator()));
                              }
                              if (state.amenities.isNotEmpty) {
                                return GridView.builder(
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            mainAxisExtent: 100),
                                    itemCount: state.amenities.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () {
                                            context.read<AmenitiesBloc>().add(
                                                SelectAmenityEvent(
                                                    amenity: state
                                                        .amenities[index]));
                                            context.read<AddPropertyBloc>().add(
                                                AddAmenityEvent(
                                                    amenityName: state
                                                        .amenities[index]
                                                        .amenity));
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 100),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: state.selectedAmenity
                                                            .contains(
                                                                state.amenities[
                                                                    index])
                                                        ? ColorConstant
                                                            .primaryColor
                                                        : Colors.white)),
                                            child: AmenitieTypeCard(
                                              icon: amenitiesIcon[state
                                                  .amenities[index].amenity]!,
                                              title:tr(state
                                                  .amenities[index].amenity),
                                            ),
                                          ),
                                        ));
                              } else {
                                return SizedBox(
                                    height: 150,
                                    child: Center(
                                        child: CupertinoActivityIndicator()));
                              }
                            },
                          ))
                        ].animate().fade(),
                      ),
                    ),
                    // step 4
                    Container(
                        padding: EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _locationFormKey,
                            child: Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                stepTitleText(context,tr("Location")),
                                Stack(children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: BlocBuilder<AddPropertyBloc,
                                        AddPropertyState>(
                                      buildWhen: (previous, current) =>
                                          previous.latitude != current.latitude||
                                              previous.longitude != current.longitude,
                                      builder: (context, state) {
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          mapController.move(LatLng(state.latitude, state.longitude), 15);});
                                        return RepaintBoundary(
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: FlutterMap(
                                                  mapController: mapController,
                                                  options: MapOptions(
                                                      initialZoom: 15,
                                                      onTap: (tapPosition,
                                                          point) {
                                                        context.read<AddPropertyBloc>()
                                                            .add(SelectLocationEvent(
                                                                lat: point
                                                                    .latitude,
                                                                long: point
                                                                    .longitude));
                                                      },
                                                      backgroundColor:
                                                          ColorConstant
                                                              .cardGrey
                                                              .withValues(
                                                                  alpha: 0.6),
                                                      initialCenter: LatLng(
                                                          state.latitude,
                                                          state.longitude)),
                                                  children: [
                                                    TileLayer(
                                                      urlTemplate:
                                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                      userAgentPackageName:
                                                          'dev.fleaflet.flutter_map.example',
                                                      // Plenty of other options available!
                                                    ),
                                                    MarkerLayer(
                                                      markers: [
                                                        Marker(
                                                          point: LatLng(
                                                              state.latitude,
                                                              state.longitude),
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/location-pin.svg',
                                                            semanticsLabel:
                                                                "marker",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ])),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: MediaQuery.of(context).size.width / 2 - 100,
                                    right:
                                        MediaQuery.of(context).size.width / 2 -
                                            100,
                                    child: CustomButton(
                                        onPressed: () {
                                          context.read<AddPropertyBloc>().add(GetLocationEvent());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              ColorConstant.primaryColor,
                                          padding: EdgeInsets.all(0),
                                        ),
                                        child: Text(tr("Use current location"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                  )
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                stepSutTitle(context,
                                    tr("Known or address name of the place"), true),
                                CustomTextField(
                                  textEditingController: addressNmaeController,
                                  hintText: "e.g: Gurd Shola beside tele",
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
                                SizedBox(
                                  height: 5,
                                ),
                                stepSutTitle(context,
                                    tr("Please select the city"), true),
                                    CustomTextField(
                                    readOnly: true,
                                    textEditingController: cityController,
                                    hintText: state.city,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter city name';
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.text,
                                    surfixIcon: CityDropDown(onSelected: (value) {
                                      cityController.text =tr(value);
                                      context.read<AddPropertyBloc>().add(AddCityEvent(city: value));
                                    }),

                                    isMultiLine: false,
                                    onTextChnage: (value) {
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(AddCityEvent(city: value));
                                    },
                                  )


                              ].animate().fade(),
                            ),
                          ),
                        )),
                    // step 5
                    Container(
                        padding: EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _priceFormKey,
                            child: Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                stepTitleText(context, tr("Price")),
                                SizedBox(
                                  height: 5,
                                ),
                                stepSutTitle(
                                    context,
                                    tr("How many rooms do you have with the same price"),
                                    true),
                                CustomTextField(
                                  textEditingController: roomController,
                                  hintText: "eg: 4",
                                  surfixIcon: null,
                                  isMultiLine: false,
                                  inputFormatter: [FilteringTextInputFormatter.digitsOnly], // Restricts input to digits
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !Validation.numberValidation(value)) {
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
                                SizedBox(
                                  height: 5,
                                ),
                                stepSutTitle(context, tr('Enter the price'), true),
                                CustomTextField(
                                  textEditingController: priceController,
                                  hintText: "eg: 500",
                                  inputFormatter: [FilteringTextInputFormatter.digitsOnly], // Restricts input to digits
                                  surfixIcon: TextButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    onPressed: () {
                                      getCurrency(context);
                                    },
                                    label: Text(
                                      state.unit,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !Validation.numberValidation(value)) {
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
                              ].animate().fade(),
                            ),
                          ),
                        )),
                    // step 6
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, tr("Add photo of the house")),
                          SizedBox(
                            height: 5,
                          ),
                          UploadPhoto(
                            ontTap:state.totalImageSize<=10?
                                () {
                              context
                                  .read<AddPropertyBloc>()
                                  .add(SelectPhotosEvent());
                            }:(){},
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 5,
                            children: [
                            Text("Total Image Size",style: Theme.of(context).textTheme.bodySmall,),
                            Text("${state.totalImageSize.toStringAsFixed(2)} MB",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w700
                            ),)
                          ],),
                          Expanded(
                              child: ListView.builder(
                            itemCount: state.images.length,
                            itemBuilder: (context, index) =>  Card(
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
                            ),
                          )
                        ].animate().fade(),
                      ),
                    ),
                    //step 7
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Form(
                          key: _agentFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                stepTitleText(context, tr("Agent info")),
                                SizedBox(
                                  height: 5,
                                ),
                                stepSutTitle(
                                    context,
                                    "${tr("Enter agent id if you don't have click finish")}(optional)",
                                    false),
                                if (!state.agentSelected)
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
                                      if (value.isNotEmpty) {
                                        context.read<AddPropertyBloc>().add(
                                            GetAgentEvent(
                                                agentId: int.parse(
                                                    agentIdController.text)));
                                      }
                                    },
                                  ),
                                if (state.agentSelected)
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                              color: ColorConstant.cardGrey)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            spacing: 6,
                                            children: [
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    ColorConstant.cardGrey,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  ApiUrl.baseUrl +
                                                      state.agentPEntity
                                                          .profilePicture!,
                                                  headers: {
                                                    'Authorization':
                                                        'Bearer ${state.token}'
                                                  },
                                                ),
                                              ),
                                              Text(
                                                  "${state.agentPEntity.user!.firstName!} ${state.agentPEntity.user!.lastName!}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: ColorConstant
                                                              .secondBtnColor,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                              Text(
                                                state.agentPEntity.id.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: ColorConstant
                                                            .secondBtnColor
                                                            .withValues(
                                                                alpha: 0.6)),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                context
                                                    .read<AddPropertyBloc>()
                                                    .add(SelectAgentEvent(
                                                        selected: false));
                                                context
                                                    .read<AddPropertyBloc>()
                                                    .add(AdddAgentIdEvent(
                                                        agentId: ''));
                                                context.read<AddPropertyBloc>().add(
                                                    (RemoveSelectedAgentEvent()));
                                                agentIdController.text = '';
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: ColorConstant.red,
                                              ))
                                        ],
                                      )),
                                SizedBox(
                                  height: 5,
                                ),
                                if (state is GetAgentLoading)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [CupertinoActivityIndicator()],
                                  ),
                                if (state.agentPEntity.id != null &&
                                    !state.agentSelected)
                                  SizedBox(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<AddPropertyBloc>().add(
                                            SelectAgentEvent(selected: true));
                                        context.read<AddPropertyBloc>().add(
                                            AdddAgentIdEvent(
                                                agentId: state.agentPEntity.id
                                                    .toString()));
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: ColorConstant
                                                      .secondBtnColor,
                                                  width: 1.2)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                spacing: 7,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        ColorConstant.cardGrey,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                      ApiUrl.baseUrl +
                                                          state.agentPEntity
                                                              .profilePicture!,
                                                      headers: {
                                                        'Authorization':
                                                            'Bearer ${state.token}'
                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                      "${state.agentPEntity.user!.firstName!} ${state.agentPEntity.user!.lastName!}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color: ColorConstant
                                                                  .secondBtnColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ],
                                              ),
                                              Text(
                                                state.agentPEntity.id.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color: ColorConstant
                                                            .secondBtnColor
                                                            .withValues(
                                                                alpha: 0.6)),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )
                              ].animate().fade(),
                            ),
                          ),
                        ))
                  ],
                )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(
                            child: CustomButton(
                                onPressed: () {
                                  if (state.step != 0) {
                                    if(state is AddNewPropertyLoading){
                                    }else{
                                      context
                                          .read<AddPropertyBloc>()
                                          .add(BackStepEvent());
                                    }

                                  } else {
                                    context.goNamed('properties');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    side: BorderSide(
                                        color: ColorConstant.secondBtnColor),
                                    backgroundColor: Colors.white),
                                child: Text(tr("back"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstant.secondBtnColor,
                                        )))),
                        Expanded(
                            child: CustomButton(
                                onPressed: () async {
                                  if (state.step == 0) {
                                    if (state.houseType.isEmpty) {
                                      showErrorSnackBar(
                                          context, "Please select house type");
                                    } else {
                                      context.read<AddPropertyBloc>().add(NextStepEvent());
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
                                      showErrorSnackBar(
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
                                      showErrorSnackBar(
                                          context, "Please select images");
                                    }
                                    else {
                                      if(state.totalImageSize<=10){
                                         context.read<AddPropertyBloc>().add(NextStepEvent());
                                      }else{
                                        showErrorSnackBar(
                                            context, "Total image size must be 10 MB please remove some images");
                                      }

                                    }
                                  } else if (state.step == 6) {
                                    if(state is AddNewPropertyLoading){

                                    }else{
                                      context.read<AddPropertyBloc>().add(AddNewPropertyEvent());
                                    }

                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    side: BorderSide(
                                        color: ColorConstant.primaryColor),
                                    backgroundColor:
                                        ColorConstant.primaryColor),
                                child: state is AddNewPropertyLoading
                                    ? loading
                                    : Text(state.step != 6 ? tr("next") : tr("Finish"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ))))
                      ],
                    ))
              ].animate().fade(),
            );
          },
          buildWhen: (previous, current) => previous != current,
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is AddNewPropertyErrorState) {
              showErrorSnackBar(context, state.failure.message);
            } else if (state is AddNewPropertySuccess) {
              context.read<AddPropertyBloc>().add(NextStepEvent());
              context.read<AddPropertyBloc>().add(ResetEvent());
              context.read<PropertiesBloc>().add(GetPropertiesEvent());
              context.goNamed('properties');
              showSuccessSnackBar(context, "property created");
            }
            pageController.jumpToPage(state.step);
          },
        ),
);
  }

  void getCurrency(BuildContext context) {
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        context
            .read<AddPropertyBloc>()
            .add((AddUnitEvent(unit: currency.code)));
      },
    );
  }

  RichText stepSutTitle(BuildContext context, String title, bool isRequired) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 14)),
      TextSpan(
          text: isRequired ? " *" : '(optional)',
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
          .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}

class CityDropDown extends StatelessWidget {
  const CityDropDown({
    super.key,
    required this.onSelected,
    this.hintText
  });

  final ValueChanged<String> onSelected;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        return DropdownButtonFormField(
          borderRadius: BorderRadius.circular(10),
          isExpanded: true,
          elevation: 0,
          hint:Text(tr(hintText??"Addis Ababa")),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorConstant.cardGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorConstant.cardGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorConstant.cardGrey),
            ),
          ),
          items:List.generate(
            state.cities.length,
                (index) => DropdownMenuItem(
              value: state.cities[index].city,
              child: Text(tr(state.cities[index].city)),
            ),
          ),
          onChanged:(value) => onSelected(value!),);
      },
    );
  }
}
