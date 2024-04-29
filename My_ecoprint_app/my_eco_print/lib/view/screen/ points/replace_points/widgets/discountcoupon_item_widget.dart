// ignore_for_file: camel_case_types, unnecessary_null_comparison, library_private_types_in_public_api, empty_catches

import 'package:my_eco_print/core/app_export.dart';

class ClothesScreen extends StatefulWidget {
  final int? offerId;
  final int? storeId;

  const ClothesScreen({Key? key, this.offerId, this.storeId}) : super(key: key);

  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  late OfferProvider offerProvider;

  @override
  void initState() {
    super.initState();
    offerProvider = OfferProvider();
    fetchData();
  }

  final ApiHelper _apiHelper = ApiHelper();
  Future<void> fetchData() async {
    await offerProvider.fetchData(widget.storeId, widget.offerId);

    if (offerProvider.offers.isNotEmpty) {
      final offer = offerProvider.offers[0];
      if (kDebugMode) {
        print("Offer ID: ${offer.id}, Description: ${offer.offerDescription}");
      }
    } else {
      if (kDebugMode) {
        print("No data available");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: ChangeNotifierProvider<OfferProvider>(
        create: (context) => offerProvider,
        child: Consumer<OfferProvider>(
          builder: (context, offerProvider, child) {
            if (offerProvider.offers.isEmpty) {
              return const Center(
                child: Text("No data available"),
              );
            }

            final offer = offerProvider.offers[0];

            return Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.v),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 5.v,
                ),
                decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.v),
                                  child: SizedBox(
                                    height: 40.v,
                                    width: 40.v,
                                    child: Container(
                                      height: 40.v,
                                      width: 40.v,
                                      padding: EdgeInsets.all(5.h),
                                      decoration:
                                          AppDecoration.fillGray.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder17,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: FutureBuilder(
                                          future: _apiHelper
                                              .getProfilePictureCompany(
                                                  offer.companyId.toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else if (snapshot.hasData) {
                                              Uint8List? imageData =
                                                  snapshot.data;
                                              if (imageData != null) {
                                                return Image.memory(
                                                  imageData,
                                                  width: 150.h,
                                                  height: 150.v,
                                                  fit: BoxFit.cover,
                                                );
                                              } else {
                                                // Handle the case when imageData is null
                                                return const Text(
                                                    'No image available');
                                              }
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, bottom: 40),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${offer.numberDiscount.toString()}%',
                                            style:
                                                theme.textTheme.headlineSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      offer.offerDescription != null
                          ? offer.offerDescription.toString()
                          : 'No description available',
                      style: theme.textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                    if (offer.numberPoint != null)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: paint(
                                textDirection: textDirection,
                                additionalText: offer.numberPoint.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class OfferProvider with ChangeNotifier {
  List<Offer> _offers = [];

  List<Offer> get offers => _offers;

  Future<void> fetchData(int? storeId, int? offerId) async {
    if (storeId == null || offerId == null) {
      if (kDebugMode) {
        print('Error: storeId or offerId is null');
      }
      return;
    }

    try {
      if (kDebugMode) {
        print('storeId: $storeId, offerId: $offerId');
      }
      _offers =
          await StoreController().getOfferByStoreAndOfferId(storeId, offerId);
      notifyListeners();
    } catch (e) {}
  }
}
