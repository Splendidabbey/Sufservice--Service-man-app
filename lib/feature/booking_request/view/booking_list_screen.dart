import 'package:demandium_serviceman/common/widgets/no_data_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';


class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key}) ;

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
        appBar:  MainAppBar(title: 'booking_requests'.tr,color: Theme.of(context).primaryColor),
      body: GetBuilder<BookingRequestController>(
        builder: (bookingListController){

          return RefreshIndicator(
            backgroundColor: Theme.of(context).colorScheme.surface,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
            onRefresh: () async{
              Get.find<BookingRequestController>().getBookingList(bookingListController.bookingStatusState.name.toLowerCase(),1);
            },
            child: CustomScrollView(
              controller:bookingListController.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPersistentHeader(delegate: BookingListMenu(),pinned: true,floating: false,),

                !bookingListController.isFirst? bookingListController.bookingList.isEmpty ?
                SliverToBoxAdapter(child: SizedBox(
                  height: Get.height * 0.75,
                  child: NoDataScreen(
                    type: NoDataType.booking,
                    text: '${'no'.tr} ${bookingListController.bookingStatusState.name.toLowerCase()=='all'?'':
                    bookingListController.bookingStatusState.name.toLowerCase().tr.toLowerCase()} ${"request_right_now".tr}',

                  ),
                )) : SliverToBoxAdapter(
                  child: Column(
                  children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: bookingListController.bookingList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (con, index){
                            return BookingRequestItem(bookingRequestModel:bookingListController.bookingList[index]);
                          }
                      ),
                      bookingListController.isLoading ?
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                          child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)) : const SizedBox(),
                    ],
                  ),
                ) :const SliverToBoxAdapter(child: BookingRequestItemShimmer()),
              ],
            ),
          );
        },
      )
    );
  }
}




