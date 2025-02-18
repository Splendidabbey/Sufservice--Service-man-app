import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';

class CreateChannelDialog extends StatefulWidget {


  const CreateChannelDialog({super.key,});
  @override
  State<CreateChannelDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<CreateChannelDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.webMaxWidth,
      padding: const EdgeInsets.only(
          left: Dimensions.paddingSizeDefault,
          bottom: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      child: GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){

        String titleText = "";

        if(bookingDetailsController.bookingDetailsContent!.provider !=null && bookingDetailsController.bookingDetailsContent!.customer !=null){
          titleText = "make_conversation_with_customer_and_provider";
        } else if(bookingDetailsController.bookingDetailsContent!.provider !=null){
          titleText = "make_conversation_with_provider";
        }
        else if(bookingDetailsController.bookingDetailsContent!.customer !=null){
          titleText = "make_conversation_with_customer";
        }
        return GetBuilder<ConversationController>(
            builder: (conversationController) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () => Get.back(),
                          child: const Padding(
                            padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
                            child: Icon(Icons.close),
                          )),
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.paddingSizeDefault, top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.paddingSizeDefault,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(titleText.tr, style: ubuntuMedium,),
                              const SizedBox(height: Dimensions.paddingSizeLarge,),

                              GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
                                return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed:(){
                                          Get.back();
                                          String providerId = Get.find<BookingDetailsController>().bookingDetailsContent!.provider!.userId!;
                                          String refId = Get.find<BookingDetailsController>().bookingDetailsContent!.id!;
                                          String name = Get.find<BookingDetailsController>().bookingDetailsContent?.provider?.companyName??"";
                                          String phone = Get.find<BookingDetailsController>().bookingDetailsContent?.provider?.companyPhone??"";
                                          String image = Get.find<BookingDetailsController>().bookingDetailsContent?.provider?.logoFullPath ??"";
                                          Get.find<ConversationController>().createChannel(providerId, refId,name: name,image: image,phone: phone.tr,userType: "provider");
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
                                          padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeLarge ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
                                        ),
                                        child: Text(
                                          'provider'.tr, textAlign: TextAlign.center,
                                          style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.paddingSizeLarge),

                                      bookingDetailsController.bookingDetailsContent!.customer!=null?
                                      TextButton(
                                        onPressed:(){
                                          Get.back();
                                          String customerId = Get.find<BookingDetailsController>().bookingDetailsContent!.customer!.id!;
                                          String refId = Get.find<BookingDetailsController>().bookingDetailsContent!.id!;
                                          String name =
                                              "${Get.find<BookingDetailsController>().bookingDetailsContent?.customer?.firstName ?? ""}"
                                              " ${Get.find<BookingDetailsController>().bookingDetailsContent?.customer?.lastName ?? ""}";
                                          String image = Get.find<BookingDetailsController>().bookingDetailsContent?.customer?.profileImageFullPath ?? "";
                                          String phone = Get.find<BookingDetailsController>().bookingDetailsContent?.customer?.phone??"";
                                          Get.find<ConversationController>().createChannel(customerId, refId,name: name,image: image,phone: phone.tr,userType: "customer");

                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
                                          padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeLarge ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
                                        ),
                                        child: Text(
                                          'customer'.tr, textAlign: TextAlign.center,
                                          style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                                        ),
                                      ):const SizedBox(),

                                    ]);
                              }),
                              const SizedBox(height: Dimensions.paddingSizeLarge),
                              const SizedBox(height: Dimensions.paddingSizeLarge),
                            ]),
                      ),
                    ],
                ),
              );
            },
        );
      }),
    );
  }
}

