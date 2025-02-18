import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';


class BookingDetails extends StatefulWidget{
  final String bookingId;
  final String bookingStatus;
  final String? fromPage;
  final String subcategoryId;
  const BookingDetails( {
    super.key,required this.bookingId,
    required this.bookingStatus,
    this.fromPage,
    required this.subcategoryId
  }) ;

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}
class _BookingDetailsState extends State<BookingDetails> with SingleTickerProviderStateMixin {

  TabController? controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(vsync: this, length: 2);
    Get.find<BookingDetailsController>().getBookingDetailsData(widget.bookingId);
    Get.find<BookingDetailsController>().pickPhotoEvidence(isRemove:true, isCamera: false);
    Get.find<BookingDetailsController>().setBookingDetailsContent = null;
    Get.find<BookingDetailsController>().setBookingDetailsModel = null;
    controller?.addListener(() {
      if(controller?.index == 0){
        Get.find<BookingDetailsController>().updateServicePageCurrentState(
            BookingDetailsTabControllerState.bookingDetails
        );
      }else{
        Get.find<BookingDetailsController>().updateServicePageCurrentState(
            BookingDetailsTabControllerState.status
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController){

        bool showChattingButton = ( (bookingDetailsController.bookingDetailsContent != null) && (bookingDetailsController.bookingDetailsContent?.bookingStatus == "pending"
            || bookingDetailsController.bookingDetailsContent?.bookingStatus == "accepted" || bookingDetailsController.bookingDetailsContent?.bookingStatus == "ongoing" )
            && (bookingDetailsController.bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails)
            && (bookingDetailsController.bookingDetailsContent!.serviceman !=null || bookingDetailsController.bookingDetailsContent!.customer != null));

        return CustomPopScopeWidget(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: CustomAppBar(
              title: 'booking_details'.tr,
              onBackPressed: (){
                if(widget.fromPage == 'fromNotification'){
                  Get.offAllNamed(RouteHelper.getInitialRoute());
                }else{
                  Get.back();
                }
              },
            ),
            body: Column(
              children: [
                Container(
                  height: 45, width: Get.width,
                  color: Theme.of(context).colorScheme.surface,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: TabBar(
                    unselectedLabelColor:Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
                    indicatorColor: Theme.of(context).primaryColor,
                    controller: controller,
                    labelColor: Theme.of(context).primaryColorLight,
                    labelStyle:  ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    labelPadding: EdgeInsets.zero,
                    onTap: (int? index) {
                      switch (index) {
                        case 0:
                          bookingDetailsController.updateServicePageCurrentState(
                              BookingDetailsTabControllerState.bookingDetails
                          );
                          break;
                        case 1:
                          bookingDetailsController.updateServicePageCurrentState(
                              BookingDetailsTabControllerState.status
                          );
                        break;
                      }
                    },
                    tabs: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.5,child: Tab(text: 'booking_details'.tr)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.5, child: Tab(text: 'status'.tr)),
                    ],
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: const [
                      BookingDetailsWidget(),
                      BookingStatus(),
                    ],
                  )
                ),
              ],
            ),

            floatingActionButton:  showChattingButton ? Container(
              height: 50, width: 50, margin: const EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                elevation: 0.0, backgroundColor: Theme.of(context).primaryColor,
                onPressed: ()=> Get.bottomSheet( const CreateChannelDialog()),
                child: Icon(Icons.message_rounded,color: light.cardColor,),
              ),
            ) : null,

          ),
        );
      },
    );
  }
}

