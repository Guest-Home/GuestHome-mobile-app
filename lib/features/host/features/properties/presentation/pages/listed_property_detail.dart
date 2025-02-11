
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/common/upload_photo_widget.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/properties_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import '../../../../../../core/utils/get_location.dart';
import '../widgets/house_type_card.dart';
import '../widgets/property_photo_card.dart';
import 'add_properties.dart';

class ListedPropertyDetail extends StatefulWidget {
  const ListedPropertyDetail({super.key, required this.propertyEntity});

  final PropertyEntity propertyEntity;

  @override
  State<ListedPropertyDetail> createState() => _ListedPropertyDetailState();
}

class _ListedPropertyDetailState extends State<ListedPropertyDetail> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController addressNmaeController;
  late TextEditingController cityController;
  late TextEditingController priceController;
  late TextEditingController roomController;
  late TextEditingController unitController;
  late double lat;
  late double long;
  late MapController mapController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.propertyEntity.title);
    descriptionController =
        TextEditingController(text: widget.propertyEntity.description);
    addressNmaeController =
        TextEditingController(text: widget.propertyEntity.specificAddress);
    cityController = TextEditingController(text: widget.propertyEntity.city);
    priceController =
        TextEditingController(text: widget.propertyEntity.price.toString());
    roomController = TextEditingController(
        text: widget.propertyEntity.numberOfRoom.toString());
    unitController = TextEditingController();
    lat = double.parse(widget.propertyEntity.latitude);
    long = double.parse(widget.propertyEntity.longitude);
    mapController = MapController();
    context.read<AmenitiesBloc>().add(GetAmenityEvent());


  }


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    addressNmaeController.dispose();
    cityController.dispose();
    priceController.dispose();
    roomController.dispose();
    unitController.dispose();
    mapController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AddPropertyBloc>().add(ResetEvent());
    context.read<AmenitiesBloc>().add(ResetAmenityEvent());
  }

  @override
  Widget build(BuildContext context) {
    addPropertyAmenity();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Listed Property",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: AppBarBackButton(
            route: "properties",
          ),
          scrolledUnderElevation: 0,
        ),
        body: BlocConsumer<AddPropertyBloc, AddPropertyState>(
            listener: (context, state) {
              if (state is DeletePropertyLoading) {
                _deletingDialog(context, "deleting property");
              } else if (state is DeletePropertySuccess) {
                context.pop();
                context.read<PropertiesBloc>().add(GetPropertiesEvent());
                context.goNamed('properties');
                showSuccessSnackBar(context, "property deleted");
              } else if (state is AddNewPropertyErrorState) {
                context.read<AddPropertyBloc>().add(ResetEvent());
                context.pop();
              } else if (state is UpdatePropertyLoading) {
                lodingDialog(context);
                // _deletingDialog(context, "updating property");
              } else if (state is UpdatePropertySuccess) {
                context.pop();
                context.read<PropertiesBloc>().add(GetPropertiesEvent());
                context.goNamed('properties');
                showSuccessSnackBar(context, "property updated");
              } else if (state is UpdatePropertyErrorState){
                context.pop();
                showErrorSnackBar(context, state.failure.message);
              }
            },
            buildWhen: (previous, current) => previous != current,
            listenWhen: (previous, current) => previous != current,
            builder: (context, state) => Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton(
                                color: Colors.white,
                                popUpAnimationStyle: AnimationStyle(),
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorConstant.secondBtnColor)),
                                  child: Row(
                                    children: [
                                      Text(
                                        tr("Menu"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      Icon(Icons.arrow_drop_down_sharp)
                                    ],
                                  ),
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: ColorConstant.red,
                                          size: 18,
                                        ),
                                        Text(
                                         tr("Delete House"),
                                          style: TextStyle(
                                              color: ColorConstant.red),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                                onSelected: (value) {
                                  if (value == 'delete') {
                                    _showDeleteDialog(
                                        context, widget.propertyEntity.id);
                                  }
                                },
                              )
                            ],
                          ),
                          // typeof house
                          Card(
                            elevation: 0.2,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: ColorConstant.cardGrey)),
                            child: ListTile(
                              title: sectionTitle(
                                  context, "${tr('What type of house do you host')}?"),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 60,
                                  children: [
                                    Expanded(
                                        child: state.houseType.isEmpty
                                            ? HouseTypeCard(
                                                iconData: houseTypeIcons[widget
                                                    .propertyEntity
                                                    .typeofHouse]!,
                                                title:tr(widget
                                                    .propertyEntity.typeofHouse),
                                                isSelected: true,
                                              )
                                            : HouseTypeCard(
                                                iconData: houseTypeIcons[
                                                    state.houseType]!,
                                                title: state.houseType,
                                                isSelected: true,
                                              )),
                                    GestureDetector(
                                      onTap: () {
                                        _showHouseTypeDialog(context);
                                      },
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          spacing: 4,
                                          children: [
                                            Icon(
                                              Icons.change_circle_outlined,
                                              color: ColorConstant.primaryColor,
                                            ),
                                            Text(tr("Change Type"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorConstant
                                                            .primaryColor))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // about the house
                          Card(
                              elevation: 0.2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: ColorConstant.cardGrey)),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    sectionTitle(context, tr('About the house')),
                                    Text(
                                     tr("Edit"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      subSectionText(tr('Registered house name')),
                                      CustomTextField(
                                        hintText: 'title',
                                        textEditingController: nameController,
                                        surfixIcon: null,
                                        isMultiLine: false,
                                        onTextChnage: (value) {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter house name';
                                          }
                                          return null;
                                        },
                                        textInputType: TextInputType.text,
                                        prifixIcon: null,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      subSectionText(
                                          tr("Description of the house")),
                                      CustomTextField(
                                          surfixIcon: null,
                                          isMultiLine: true,
                                          onTextChnage: (value) {},
                                          textInputType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter house description';
                                            }
                                            return null;
                                          },
                                          prifixIcon: null,
                                          textEditingController:
                                              descriptionController,
                                          hintText: 'description'),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          // House Amenities
                          Card(
                            elevation: 0.2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: ColorConstant.cardGrey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 10,
                                children:[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      sectionTitle(context,tr("House amenities")),
                                      Text(
                                         tr("Edit"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                              TextDecoration.underline),
                                        ),

                                    ],
                                  ),
                                  BlocBuilder<AmenitiesBloc, AmenitiesState>(
                                        builder: (context, amState) {
                                          if(amState is AmenityLoadingState){
                                            return loadingIndicator();
                                          }
                                          return  GridView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2, // Number of columns
                                                childAspectRatio:
                                                1, // Aspect ratio of each item
                                                crossAxisSpacing:
                                                4, // Spacing between columns
                                                mainAxisSpacing: 4,
                                                mainAxisExtent: 55),
                                            itemCount: amState.amenities.length, // Number of HouseTypeCard items
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  context.read<AddPropertyBloc>().add(
                                                      AddAmenityEvent(amenityName:amState.amenities[index].amenity));
                                                },
                                                child: HouseTypeCard(
                                                  iconData: amenitiesIcon[
                                                  amState.amenities[index].amenity]!,
                                                  title: tr(amState.amenities[index].amenity),
                                                  isSelected:state.amenities.contains(amState.amenities[index].amenity)

                                              ),
                                              ); // Replace with your actual card widget
                                            },

                                          );

                                        }),
                                ]

                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          //location
                          Card(
                              elevation: 0.2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: ColorConstant.cardGrey)),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    sectionTitle(context, tr('Location')),
                                    Text(
                                      tr("Edit"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.4,
                                              width: MediaQuery.of(context).size.width,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: FlutterMap(
                                                    mapController: mapController,
                                                    options: MapOptions(
                                                        initialZoom: 14,
                                                        onTap: (tapPosition, point) {
                                                          setState(() {
                                                            lat = point.latitude;
                                                            long = point.longitude;
                                                          });
                                                        },
                                                        backgroundColor: ColorConstant.cardGrey
                                                            .withValues(
                                                            alpha: 0.6),
                                                        initialCenter:
                                                        LatLng(lat, long)),
                                                    children: [
                                                      TileLayer(
                                                        urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                        userAgentPackageName:'dev.fleaflet.flutter_map.example',
                                                        // Plenty of other options available!
                                                      ),
                                                      MarkerLayer(
                                                        markers: [
                                                          Marker(
                                                            point:
                                                            LatLng(lat, long),
                                                            width: 50,
                                                            height: 50,
                                                            child: SvgPicture.asset(
                                                              'assets/icons/marker.svg',
                                                              semanticsLabel:
                                                              "marker",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                              )),
                                          Positioned(
                                            bottom: 10,
                                            left:30,
                                            right: 30,
                                            child: CustomButton(
                                                onPressed: ()async{
                                                  final loc = await GetLocation().gatePosition();
                                                  setState(() {
                                                    lat = loc.latitude;
                                                    long = loc.longitude;
                                                  });
                                                   mapController.move(LatLng(lat,long), 15);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                  ColorConstant.primaryColor,
                                                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                                        ],
                                      ),

                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.location_pin,
                                                size: 15,
                                                color: ColorConstant
                                                    .secondBtnColor,
                                              ),
                                              Text(
                                                'Change House Location',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: ColorConstant
                                                            .primaryColor),
                                              ),
                                            ],
                                          ),
                                      ),
                                      SizedBox(height: 5),
                                      subSectionText(tr("Known or address name of the place")),
                                      CustomTextField(
                                        hintText: 'known address name',
                                        textEditingController:
                                            addressNmaeController,
                                        surfixIcon: null,
                                        isMultiLine: false,
                                        onTextChnage: (value) {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter location';
                                          }
                                          return null;
                                        },
                                        textInputType: TextInputType.text,
                                        prifixIcon: null,
                                      ),
                                      SizedBox(height: 5),
                                      subSectionText(tr("Name of the city")),
                                      CustomTextField(
                                        readOnly: true,
                                        hintText: tr(widget.propertyEntity.city),
                                        textInputType: TextInputType.text,
                                        textEditingController: cityController,
                                        surfixIcon: SizedBox(
                                          child:CityDropDown(onSelected: (value) {
                                            cityController.text =tr(value);
                                            context
                                                .read<AddPropertyBloc>()
                                                .add(AddCityEvent(city: value));
                                          }),
                                        ),
                                        isMultiLine: false,
                                        onTextChnage: (value) {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please select city';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          //price
                          Card(
                              elevation: 0.2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: ColorConstant.cardGrey)),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    sectionTitle(context, tr('Price')),
                                    Text(
                                      tr("Edit"),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      subSectionText(
                                          "${tr('How many rooms do you have with the same price')}?"),
                                      CustomTextField(
                                        hintText: 'no room',
                                        textEditingController: roomController,
                                        surfixIcon: null,
                                        isMultiLine: false,
                                        onTextChnage: (value) {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter number of houses';
                                          }
                                          return null;
                                        },
                                        textInputType: TextInputType.number,
                                        prifixIcon: null,
                                      ),
                                      SizedBox(height: 5),
                                      subSectionText("Price"),
                                      CustomTextField(
                                        hintText: 'price',
                                        textEditingController: priceController,
                                        surfixIcon: TextButton.icon(
                                          iconAlignment: IconAlignment.end,
                                          onPressed: () {
                                            getCurrency(context);
                                          },
                                          label: Text(
                                            unitController.text.isEmpty
                                                ? widget.propertyEntity.unit
                                                : unitController.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          icon: Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                        ),
                                        isMultiLine: false,
                                        onTextChnage: (value) {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter price';
                                          }
                                          return null;
                                        },
                                        textInputType: TextInputType.number,
                                        prifixIcon: null,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          // photo
                          Card(
                              elevation: 0.2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: ColorConstant.cardGrey)),
                              child: ListTile(
                                title: sectionTitle(context, tr('House Photo')),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    spacing: 10,
                                    children: [
                                      UploadPhoto(
                                        ontTap: () {
                                          context
                                              .read<AddPropertyBloc>()
                                              .add(SelectPhotosEvent());
                                        },
                                      ),
                                      //  photo
                                      SizedBox(
                                          width: double.infinity,
                                          child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: EdgeInsets.all(10),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      childAspectRatio: 1,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      mainAxisExtent: 60),
                                              itemCount: widget.propertyEntity
                                                  .houseImage.length,
                                              itemBuilder: (context, index) {
                                                return PropertyPhotoDetail(
                                                  image: widget.propertyEntity
                                                      .houseImage[index].image,
                                                  ontap: () {},
                                                );
                                              })),

                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.images.length,
                                        itemBuilder: (context, index) => Card(
                                            elevation: 0.2,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: ColorConstant
                                                        .cardGrey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: PropertyPhotoCard(
                                                image: state.images[index],
                                                ontap: () {
                                                  context
                                                      .read<AddPropertyBloc>()
                                                      .add(RemovePictureEvent(
                                                          index: index));
                                                },
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(17),
                        child: Row(
                          spacing: 10,
                          children: [
                            Expanded(
                                child: CustomButton(
                                    onPressed: () {
                                      _showDialog(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        foregroundColor: Colors.white,
                                        side: BorderSide(
                                            color:
                                                ColorConstant.secondBtnColor),
                                        backgroundColor: Colors.white),
                                    child: Text(tr("Cancel"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  ColorConstant.secondBtnColor,
                                            )))),
                            Expanded(
                                child: CustomButton(
                                    onPressed: () {
                                      _formKey.currentState!.save();
                                      if (_formKey.currentState!.validate()) {
                                        if (
                                        widget.propertyEntity.typeofHouse !=
                                                state.houseType ||
                                            widget.propertyEntity.subDescription !=
                                                state.amenities ||
                                            widget.propertyEntity.title !=
                                                nameController.text ||
                                            widget.propertyEntity.description !=
                                                descriptionController.text ||
                                            widget.propertyEntity
                                                    .specificAddress !=
                                                addressNmaeController.text ||
                                            widget.propertyEntity.city !=
                                                cityController.text ||
                                            widget.propertyEntity.price
                                                    .toString() !=
                                                priceController.text ||
                                            widget.propertyEntity.numberOfRoom
                                                    .toString() !=
                                                roomController.text) {
                                            context.read<AddPropertyBloc>().add(
                                                  UpdatePropertyEvent(
                                                      propertyEntity: {
                                                    'title': nameController.text,
                                                    'description': descriptionController.text,
                                                    'city': cityController.text,
                                                    'typeofHouse': state.houseType.isEmpty? widget.propertyEntity.typeofHouse : state.houseType,
                                                    if (widget.propertyEntity.latitude != lat.toString())
                                                      'latitude': lat,
                                                    if (widget.propertyEntity.longitude != long.toString())
                                                      'longitude': long,
                                                    'price': priceController.text,
                                                    'unit': unitController.text.isEmpty
                                                        ? widget.propertyEntity.unit
                                                        : unitController.text,
                                                    'number_of_room': roomController.text,
                                                    'sub_description':state.amenities.join(','),
                                                    'specificAddress': addressNmaeController.text
                                                  },
                                                      id: widget
                                                          .propertyEntity.id));
                                        }
                                      }

                                      //  context.goNamed('properties');
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        side: BorderSide(
                                            color: ColorConstant.primaryColor),
                                        backgroundColor:
                                            ColorConstant.primaryColor),
                                    child: Text(tr("Save Changes"),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ))))
                          ],
                        ))
                  ],
                ))));
  }



  void getCurrency(BuildContext context) {
    return showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        setState(() {
          unitController.text = currency.code;
        });
      },
    );
  }

  Text subSectionText(String title) => Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstant.inActiveColor),
      );
  Text sectionTitle(BuildContext context, String title) {
    return Text(tr(title),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 15,
            color: ColorConstant.secondBtnColor,
            fontWeight: FontWeight.w700));
  }
  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(0),
        content: SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorConstant.cardGrey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${tr("Delete House")}?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.cancel_outlined,
                      size: 15,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(tr("This can’t be undone")),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actionsPadding: EdgeInsets.all(10),
        actions: [
          CustomButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  elevation: 0,
                  side: BorderSide(
                      color:
                          ColorConstant.secondBtnColor.withValues(alpha: 0.5)),
                  backgroundColor: Colors.white),
              child: Text(tr("Cancel"),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorConstant.secondBtnColor,
                      ))),
          CustomButton(
              onPressed: () {
                context
                    .read<AddPropertyBloc>()
                    .add(DeletePropertyEvent(id: id));
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.only(left: 4, right: 4),
                  backgroundColor: ColorConstant.red),
              child: Text(tr("Delete House"),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      )))
        ],
      ),
    );
  }
  void _deletingDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(15),
        content: SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loadingWithPrimary,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showHouseTypeDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  padding: EdgeInsets.all(10),
                  child: BlocBuilder<PropertyTypeBloc, PropertyTypeState>(
                      builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                         tr("Change House type"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: ColorConstant.secondBtnColor,
                                  fontWeight: FontWeight.w700),
                        ),
                        Expanded(
                            child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  childAspectRatio:
                                      1, // Aspect ratio of each item
                                  crossAxisSpacing:
                                      4, // Spacing between columns
                                  mainAxisSpacing: 4,
                                  mainAxisExtent: 56),
                          itemCount: state.propertyTypes
                              .length, // Number of HouseTypeCard items
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<PropertyTypeBloc>().add(
                                    SelectPropertyType(propertyType: state.propertyTypes[index]));
                              },
                              child: HouseTypeCard(
                                iconData: houseTypeIcons[
                                    state.propertyTypes[index].propertyType]!,
                                title:tr(state.propertyTypes[index].propertyType),
                                isSelected: state.selectedPropertyType ==
                                        state.propertyTypes[index]
                                    ? true
                                    : false,
                              ),
                            ); // Replace with your actual card widget
                          },
                        )),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      side: BorderSide(
                                          color: ColorConstant.secondBtnColor),
                                      backgroundColor: Colors.white),
                                  child: Text(
                                    tr("Cancel"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstant.secondBtnColor,
                                        ),
                                  )),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    context.read<AddPropertyBloc>().add(
                                        AddHouseTypeEvent(
                                            houseTYpe: state
                                                .selectedPropertyType!
                                                .propertyType));
                                    context.pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor:
                                          ColorConstant.primaryColor),
                                  child: Text(
                                    tr("Select"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                  )),
                            )
                          ],
                        )
                      ],
                    );
                  })),
            ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(0),
        content: SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorConstant.cardGrey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${tr("Discard Unsaved Changes")}?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.cancel_outlined,
                      size: 15,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(tr("This can’t be undone")),
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.all(10),
        actions: [
          CustomButton(
              onPressed: () {
                context.pop();
                context.pop();
                context.read<AddPropertyBloc>().add(ResetEvent());
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  elevation: 0,
                  side: BorderSide(
                      color:
                          ColorConstant.secondBtnColor.withValues(alpha: 0.5)),
                  backgroundColor: Colors.white),
              child: Text(tr("Discard"),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorConstant.secondBtnColor,
                      ))),
          CustomButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.only(left: 4, right: 4),
                  backgroundColor: ColorConstant.primaryColor),
              child: Text(tr("NO"),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      )))
        ],
      ),
    );
  }

  void addPropertyAmenity() {
    if(widget.propertyEntity.subDescription!=null){
      widget.propertyEntity.subDescription?.forEach((element) {
      context.read<AddPropertyBloc>().add(
      AddAmenityEvent(amenityName:element));
      });
    }

  }
}

class PropertyPhotoDetail extends StatelessWidget {
  const PropertyPhotoDetail({
    super.key,
    required this.image,
    required this.ontap,
  });
  final String? image;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: CachedNetworkImage(
            imageUrl: image!,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
        ));
  }
}
