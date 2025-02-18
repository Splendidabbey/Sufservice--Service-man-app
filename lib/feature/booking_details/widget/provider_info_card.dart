import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';

class BookingDetailsProviderInfo extends StatelessWidget {
  const BookingDetailsProviderInfo({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      return Column( crossAxisAlignment: CrossAxisAlignment.start ,children: [

        Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault , vertical: Dimensions.paddingSizeDefault),
          child: Text("provider_info".tr,style:ubuntuMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight) ,
          ),
        ),


        BottomCard(
          name: bookingDetailsController.bookingDetailsContent?.provider?.companyName ?? "",
          phone: bookingDetailsController.bookingDetailsContent?.provider?.companyPhone ?? "",
          image:  bookingDetailsController.bookingDetailsContent?.provider?.logoFullPath ??"",
        ),

      ]);
    });
  }
}
