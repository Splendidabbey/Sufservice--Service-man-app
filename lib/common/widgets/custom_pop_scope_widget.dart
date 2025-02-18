

import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class CustomPopScopeWidget extends StatefulWidget {
  final Widget child;
  final Function()? onPopInvoked;
  const CustomPopScopeWidget({super.key, required this.child, this.onPopInvoked});

  @override
  State<CustomPopScopeWidget> createState() => _CustomPopScopeWidgetState();
}

class _CustomPopScopeWidgetState extends State<CustomPopScopeWidget> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: ResponsiveHelper.isWeb() ? true : Navigator.canPop(context),
      onPopInvoked: (didPop) {
        if(widget.onPopInvoked != null && context.mounted ) {
          widget.onPopInvoked!();
        }else if( !Navigator.canPop(context) && context.mounted && widget.onPopInvoked == null){
          Get.offAllNamed(RouteHelper.getInitialRoute());
        }
      },
      child: widget.child,
    );
  }
}