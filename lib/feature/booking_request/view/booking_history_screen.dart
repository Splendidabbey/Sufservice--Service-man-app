import 'package:demandium_serviceman/common/widgets/no_data_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';


class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key}) ;
  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar:  MainAppBar(title: 'booking_history'.tr,color: Theme.of(context).primaryColor),
        body: GetBuilder<BookingRequestController>(
          builder: (bookingRequestController){
            return RefreshIndicator(
              backgroundColor: Theme.of(context).colorScheme.surface,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
              onRefresh: () async{
                bookingRequestController.getBookingHistory(
                    bookingRequestController.bookingHistoryStatus[bookingRequestController.bookingHistorySelectedIndex],1
                );
              },
              child:
              CustomScrollView(
               controller: bookingRequestController.bookingHistoryScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(delegate: BookingHistorySectionMenu(),pinned: true,floating: false,),
                  bookingRequestController.isFirst ?
                  const SliverToBoxAdapter(child: BookingRequestItemShimmer()) :
                  bookingRequestController.bookingHistoryList.isEmpty ?
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Get.height * 0.75,
                      child: NoDataScreen(
                        type: NoDataType.booking,
                        text: '${'no'.tr} ${bookingRequestController.bookingHistoryStatus[bookingRequestController.bookingHistorySelectedIndex]=='All'?'booking'.tr.toLowerCase():
                        bookingRequestController.bookingHistoryStatus[bookingRequestController.bookingHistorySelectedIndex].toLowerCase().tr.toLowerCase()} ${"request_right_now".tr}',
                      ),
                    ),
                  ) :
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        bookingRequestController.bookingHistoryList.isNotEmpty?
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: bookingRequestController.bookingHistoryList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (con, index){
                              return BookingRequestItem(bookingRequestModel: bookingRequestController.bookingHistoryList[index]);
                            }):const SizedBox(),
                        bookingRequestController.isLoading ? CircularProgressIndicator(color: Theme.of(context).primaryColor,):const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),  ///////
            );
          },
        )
    );
  }
}


