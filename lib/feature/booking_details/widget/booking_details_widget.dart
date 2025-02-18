import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';



class BookingDetailsWidget extends StatefulWidget{
  const BookingDetailsWidget({super.key}) ;

  @override
  State<BookingDetailsWidget> createState() => _BookingDetailsWidgetState();
}

class _BookingDetailsWidgetState extends State<BookingDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController){
        bool showDeliveryConfirmImage = bookingDetailsController.showPhotoEvidenceField;
        ConfigModel? configModel = Get.find<SplashController>().configModel;
        final bookingDetails = bookingDetailsController.bookingDetailsContent;

        int isGuest = bookingDetails?.isGuest ?? 0;
        bool isPartial =  (bookingDetails !=null && bookingDetails.partialPayments !=null && bookingDetails.partialPayments!.isNotEmpty) ? true : false ;
        String bookingStatus = bookingDetails?.bookingStatus ?? "";

      return bookingDetailsController.bookingDetailsContent == null ?
        const BookingDetailsShimmer() : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SingleChildScrollView(
              controller: bookingDetailsController.scrollController,
              child: Column(
                children: [
                  const SizedBox(height:Dimensions.paddingSizeSmall),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                      boxShadow: Get.find<ThemeController>().darkTheme ? null : shadow,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                        vertical: Dimensions.paddingSizeSmall),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${"booking".tr} # ${bookingDetailsController.bookingDetailsContent!.readableId}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: ubuntuMediumHigh.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)
                                ),
                                const SizedBox(height: Dimensions.paddingSizeSmall,),
                                (bookingDetailsController.bookingDetailsContent?.bookingStatus!="canceled")?
                                GestureDetector(
                                  onTap: () async {
                                    _checkPermission(() async {
                                      if(bookingDetailsController.bookingDetailsContent!.serviceAddress!=null){
                                        Get.dialog(const CustomLoader(),barrierDismissible: false);
                                        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
                                          MapUtils.openMap(
                                              double.tryParse(bookingDetailsController.bookingDetailsContent!.serviceAddress!.lat!) ?? 23.8103,
                                              double.tryParse(bookingDetailsController.bookingDetailsContent!.serviceAddress!.lon!) ?? 90.4125,
                                              position.latitude ,
                                              position.longitude);
                                        });
                                        Get.back();
                                      }else{
                                        showCustomSnackBar("service_address_not_found".tr);
                                      }
                                    });
                                   },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeDefault,
                                        vertical: Dimensions.paddingSizeExtraSmall+2
                                    ),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                        color:Colors.grey.withOpacity(0.2)
                                    ),
                                    child: Center(
                                      child: Text("view_on_map".tr,
                                        style:ubuntuMediumLow.copyWith(
                                          color: ColorResources.buttonTextColorMap['accepted'],
                                        ),
                                      ),
                                    ),
                                  ),
                                ): Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeDefault,
                                      vertical: Dimensions.paddingSizeExtraSmall
                                  ),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                      color:Colors.grey.withOpacity(0.2)
                                  ),
                                  child: Center(
                                    child: Text("canceled".tr,
                                      style:ubuntuMediumLow.copyWith(
                                        color: ColorResources.buttonTextColorMap['canceled'],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if(configModel?.content?.serviceManCanEditBooking == 1 && bookingDetailsController.providerServicemanCanEditBooking == 1)
                            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                              child: CustomButton(height: 35,btnTxt: "edit".tr, icon: Icons.edit,
                                onPressed: (!isPartial && (bookingStatus == "accepted" || bookingStatus == "ongoing")
                                    && ((isGuest == 1 && bookingDetailsController.bookingDetailsContent?.paymentMethod != "cash_after_service") ? false : true))  ? (){
                                Get.to(()=> const BookingEditScreen());
                              }: null,fontSize: Dimensions.fontSizeSmall
                                ,),
                            )),

                            Column(
                              children: [
                                CustomButton(
                                  height: 35,
                                  width: 75,
                                  fontSize: Dimensions.fontSizeSmall,
                                  btnTxt: "invoice".tr,
                                  onPressed: () async {
                                    Get.dialog(const CustomLoader(), barrierDismissible: false);
                                    String languageCode = Get.find<LocalizationController>().locale.languageCode;
                                    String uri = "${AppConstants.baseUrl}${AppConstants.invoiceUrl}${bookingDetails?.id}/$languageCode";
                                    if (kDebugMode) {
                                      print("Uri : $uri");
                                    }
                                    await _launchUrl(Uri.parse(uri));
                                    Get.back();
                                    // var pdfFile = await PdfInvoiceApi.generate(
                                    //     bookingDetailsController.bookingDetailsContent!,
                                    //     bookingDetailsController.invoiceItems,
                                    //     bookingDetailsController
                                    // );
                                    // PdfApi.openFile(pdfFile);

                                  },
                                ),
                              ],
                            )
                          ]
                        ),
                        if(bookingDetailsController.bookingDetailsContent?.bookingStatus!="canceled")
                        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                          child: RichText(text:  TextSpan(text: '${'booking_status'.tr}:   ',
                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault-1,
                                color:Theme.of(context).textTheme.bodyLarge!.color,),
                              children: [
                                TextSpan(text: bookingDetailsController.bookingDetailsContent!.bookingStatus!.tr,
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault-1,
                                        color: ColorResources.buttonTextColorMap[bookingDetailsController.bookingDetailsContent!.bookingStatus],
                                        decoration: TextDecoration.none)
                                ),
                              ]),
                          ),
                        ),

                        const BookingInformationView(),

                      ],
                    ),
                  ),

                  BookingSummeryView(bookingDetailsContent: bookingDetailsController.bookingDetailsContent!),

                  const BookingDetailsProviderInfo(),

                  const BookingDetailsCustomerInfo(),


                  bookingDetailsController.bookingDetailsContent?.photoEvidenceFullPath != null &&  bookingDetailsController.bookingDetailsContent!.photoEvidenceFullPath!.isNotEmpty ?
                  Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Text('completed_service_picture'.tr,  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: ListView.builder(
                          controller: bookingDetailsController.completedServiceImagesScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount:  bookingDetailsController.bookingDetailsContent?.photoEvidenceFullPath?.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: bookingDetailsController.bookingDetailsContent?.photoEvidenceFullPath?[index] ?? "",
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.to(ImageDetailScreen(
                                        imageList: bookingDetailsController.bookingDetailsContent?.photoEvidenceFullPath ?? [],
                                        index: index,
                                        appbarTitle: 'completed_service_picture'.tr,

                                      ),
                                      );
                                    },
                                    child: CustomImage(
                                      image: bookingDetailsController.bookingDetailsContent?.photoEvidenceFullPath?[index]??"",
                                      height: 70, width: 120,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ):
                  const SizedBox(),

                  Get.find<SplashController>().configModel?.content?.bookingImageVerification == 1 && showDeliveryConfirmImage && bookingDetailsController.bookingDetailsContent?.bookingStatus != 'completed' ? Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('completed_service_picture'.tr,  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: bookingDetailsController.pickedPhotoEvidence.length+1,
                          itemBuilder: (context, index) {
                            XFile? file = index == bookingDetailsController.pickedPhotoEvidence.length ? null : bookingDetailsController.pickedPhotoEvidence[index];
                            if(index < 5 && index == bookingDetailsController.pickedPhotoEvidence.length) {
                              return InkWell(
                                onTap: () {
                                  Get.bottomSheet(CameraButtonSheet(bookingId: bookingDetails?.id ?? "",));
                                },
                                child: Container(
                                  height: 60, width: 70, alignment: Alignment.center, decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                ),
                                  child:  Icon(Icons.camera_alt_sharp, color: Theme.of(context).primaryColor, size: 32),
                                ),
                              );
                            }
                            return file != null ? Container(
                              margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              ),
                              child: Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  child: GetPlatform.isWeb ? Image.network(
                                    file.path, width: 120, height: 70, fit: BoxFit.cover,
                                  ) : Image.file(
                                    File(file.path), width: 120, height: 70, fit: BoxFit.cover,
                                  ),
                                ),
                              ]),
                            ) : const SizedBox();
                          },
                        ),
                      ),
                    ]),
                  ) : const SizedBox(),

                  const SizedBox(height:Dimensions.paddingSizeExtraLarge),
                ],
              ),
            ),),
            bookingDetailsController.bookingDetailsContent?.bookingStatus == "accepted" ||  bookingDetailsController.bookingDetailsContent?.bookingStatus == "ongoing" ?
            SafeArea(child: StatusChangeDropdownButton(bookingId: bookingDetailsController.bookingDetailsContent?.id??"",)): const SizedBox(),
          ],
      );
      },
    );
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(const PermissionDialog());
    }else {
      onTap();
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double destinationLatitude, double destinationLongitude, double userLatitude, double userLongitude) async {
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}








