import 'dart:async';
import 'package:electronic_final_project/check_out/summery_widget.dart';
import 'package:electronic_final_project/controller/order.dart';
import 'package:electronic_final_project/controller/product_provider.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/address.dart';
import 'package:electronic_final_project/model/order.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OrderCheckoutPage extends StatefulWidget {
  final Position location;
  
  OrderCheckoutPage(this.location, {Key? key}) : super(key: key);

  @override
  _OrderCheckoutPageState createState() => _OrderCheckoutPageState();
}

class _OrderCheckoutPageState extends State<OrderCheckoutPage> {
  int activeStep = 0;
  int upperBound = 4;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: getVerticalSize(88),
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomAppBar(
                      height: getVerticalSize(60),
                      centerTitle: true,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(left: 8, right: 11),
                            child: Row(
                              children: [
                                AppbarImage(
                                  height: getSize(24),
                                  width: getSize(24),
                                  svgPath: ImageConstant.imgArrowleftBlueGray900,
                                  margin: getMargin(left: 10, top: 5),
                                  onTap: () {
                                    onTapArrowleft(context);
                                  },
                                ),
                                AppbarTitle(
                                  text: "Order Summary",
                                  margin: getMargin(left: 113, top: 5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                
                  children: [
                    IconStepper(
                      icons: [
                        Icon(Icons.location_on_rounded,color: Color.fromARGB(255, 238, 194, 129)),
                        Icon(Icons.location_city,color: Color.fromARGB(255, 238, 194, 129)),
                        Icon(Icons.payment_rounded,color: Color.fromARGB(255, 238, 194, 129)),
                        Icon(Icons.summarize,color: Color.fromARGB(255, 238, 194, 129)),
                      ],
                      enableNextPreviousButtons: false,
                      lineLength: 35,
                      activeStep: activeStep,
                      onStepReached: (index) {
                        setState(() {
                          activeStep = index;
                        });
                      },
                      lineColor: Color.fromARGB(255, 192, 195, 196), 
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: activeStep,
                        children: [
                          GoogleMapStep(widget.location),
                         
                          AddressFormStep(),
                          PaymentMethodStep(),
                          SummeryWidget(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        previousButton(),
                        nextButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


 Widget nextButton() {
  return ElevatedButton(
    onPressed: () {
      var productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      switch (activeStep) {
        case 0:
          setState(() {
            activeStep++;
          });
          break;
        case 1:
          if (productProvider.keyForm.currentState!.validate()) {
            setState(() {
              activeStep++;
            });
          }
          break;
        case 2:
          setState(() {
            activeStep++;
          });
          break;
        case 3:
          OrderController()
              .create(Order(
                products: productProvider.selectedProducts,
                address: productProvider.address!,
                payment_method_id: productProvider.payment_method_id,
                total: productProvider.total,
                tax_amount: productProvider.tax_amount,
                total_price: productProvider.total,
                sub_total: productProvider.sub_total,
               
          ))
              .then((value) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Done");
          }).catchError((ex) {
            EasyLoading.dismiss();
            EasyLoading.showError(ex.toString());
          });
          break;
      }
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.orange,
      onPrimary: Colors.white,
    ),
    child: Text('Next'),
  );
}

Widget previousButton() {
  return ElevatedButton(
    onPressed: () {
      if (activeStep > 0) {
        setState(() {
          activeStep--;
        });
      }
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.orange,
      onPrimary: Colors.white,
    ),
    child: Text('Prev'),
  );
}



  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }


  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      default:
        return 'Introduction';
    }
  }
}

class GoogleMapStep extends StatefulWidget {
  Position location;

  GoogleMapStep(this.location, {super.key});

  @override
  State<GoogleMapStep> createState() => _GoogleMapStepState();
}

class _GoogleMapStepState extends State<GoogleMapStep> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _initalPostion;
  late LatLng _requiredLocation;

  @override
  void initState() {
    super.initState();
    _initalPostion = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return mapWidget();
  }

  Widget mapWidget() {
    double mapWidth = MediaQuery.of(context).size.width;
    double mapHeight = MediaQuery.of(context).size.height - 215;
    return Stack(alignment: Alignment(0.0, 0.0), children: <Widget>[
      Container(
          width: mapWidth,
          height: mapHeight,
          child: GoogleMap(
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            initialCameraPosition: _initalPostion,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition position) {
              _requiredLocation = position.target;
            },
            onCameraIdle: () {
              _getAddressFromLatLng();
            },
          )),
      Positioned(
        top: (mapHeight - 50) / 2,
        right: (mapWidth - 50) / 2,
        child: Icon(
          Icons.location_on,
          size: 50,
          color: Colors.red,
        ),
      ),
    ]);
  }

  Future<void> _getAddressFromLatLng() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _requiredLocation.latitude, _requiredLocation.longitude);

    Placemark first = placemarks.first;

    Address address = Address(
  latitude: _requiredLocation.latitude,
  longitude: _requiredLocation.longitude,
  country: first.country!,
  city: first.locality!,
  area: first.subLocality!,
  street: first.street!,
  buildingNo: "",
);

    address.latitude = _requiredLocation.latitude;
    address.longitude = _requiredLocation.longitude;
    address.country = first.country!;
    address.city = first.locality!;
    address.area = first.subLocality!;
    address.street = first.street!;
    address.buildingNo = "";

    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.updateAddress(address);
  }
}

class AddressFormStep extends StatelessWidget {
  AddressFormStep({Key? key}) : super(key: key);

  final _controllerCountry = TextEditingController();
  final _controllerCity = TextEditingController();
  final _controllerArea = TextEditingController();
  final _controllerStreet = TextEditingController();
  final _controllerBuilding = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return formWidget(productProvider);
      },
    );
  }

  Widget formWidget(ProductProvider productProvider) {
    _controllerCountry.text = productProvider.address?.country ?? '';
    _controllerCity.text = productProvider.address?.city ?? '';
    _controllerArea.text = productProvider.address?.area ?? '';
    _controllerStreet.text = productProvider.address?.street ?? '';
    _controllerBuilding.text = productProvider.address?.buildingNo ?? '';

    return Container(
      padding: EdgeInsets.only(top: 100 ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: productProvider.keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controllerCountry,
                decoration: InputDecoration(
                  hintText: "Country",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerCity,
                decoration: InputDecoration(
                  hintText: "City",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerArea,
                decoration: InputDecoration(
                  hintText: "Area",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerStreet,
                decoration: InputDecoration(
                  hintText: "Street",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controllerBuilding,
                decoration: InputDecoration(
                  hintText: "Building No.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PaymentMethodStep extends StatelessWidget {
  const PaymentMethodStep({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ProductProvider productProvier, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 100,bottom: 20),
        child: Container(
          child: Column(
   
            children: [
              Container(
                width: double.infinity, 
                child: Card(
                  child: ListTile(
                    onTap: () {
                      productProvier.updatePaymentMethod(1);
                    },
                    leading: Icon(
                      Icons.attach_money_outlined,
                      color: Colors.orange,
                    ),
                    title: Text("Cash On Delivery"),
                    trailing: Radio<int>(
                      value: 1,
                      groupValue: productProvier.payment_method_id,
                      onChanged: (value) {
                        productProvier.updatePaymentMethod(value!);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity, 
              
                child: Card(
                  child: ListTile(
                    onTap: () {
                      productProvier.updatePaymentMethod(2);
                    },
                    leading: Icon(
                      Icons.payment,
                      color: Colors.orange,
                    ),
                    title: Text("Debit Cart"),
                    trailing: Radio<int>(
                      value: 2,
                      groupValue: productProvier.payment_method_id,
                      onChanged: (value) {
                        productProvier.updatePaymentMethod(value!);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


class SummeryStep extends StatelessWidget {
  const SummeryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ProductProvider productProvier, child) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Summery",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _addressWidget(productProvier),
        const SizedBox(height: 20),
        SummeryWidget()
      ]);
    });
  }
}

Widget _addressWidget(ProductProvider productProvier) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Delivery Address",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Country",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            productProvier.address!.country,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "City",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            productProvier.address!.city,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Area",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            productProvier.address!.area,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Street",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            productProvier.address!.street,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Building No.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            productProvier.address!.buildingNo,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      )
    ],
  );
}
 void onTapArrowleft(BuildContext context) {
    Navigator.of(context).pop();
  }
  