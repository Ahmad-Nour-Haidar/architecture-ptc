
import 'package:architecture_ptc/core/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import '../data/enums/toast_status.dart';
import '../domain/error_handler/message.dart';
import '../domain/error_handler/network_exceptions.dart';
import '../helper/helpers.dart';
import '../utils/color_manager.dart';
// import 'styles_manager.dart';



class Constants {
  static const int spalshDelay = 5;
  static const int spalshDelayAppName = 200;

  static loading(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                alignment: Alignment.center,
                width:  MediaQuery.of(context).size.width  * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8)),
                child:
                const CircularProgressIndicator(
                  color: ColorManager.primary,
                )
            ),
          );
        },
        barrierDismissible: false

    );
    FocusScope.of(context).unfocus();
  }



  static selectData(
      {required BuildContext context,
      required TextEditingController controller}) async {
    DateTime selectedDate = DateTime.now();
    var newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
      //todo
      // builder: (context, child) {
      //   return Theme(
      //     data: appTheme().copyWith(
      //         textTheme: TextTheme(
      //           overline: getRegularStyle(
      //               fontSize: 16.sp
      //           ),
      //          caption: getRegularStyle(
      //              fontSize: 14.sp
      //          ),
      //           button: getRegularStyle(
      //               fontSize: 16.sp
      //           ),
      //
      //
      //
      //         )
      //     ),
      //     child: child!,
      //   );
      // }
    );

    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      controller
        ..text = DateFormat('yyyy-MM-dd','en').format(selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: controller.text.length, affinity: TextAffinity.upstream));
    }
  }


  static showTOAST(BuildContext context, {String? textToast,String? title, ToastStatus? status}){
    showToastWidget(
        duration:const Duration(seconds: 5),
        ToastWidget(
          title:formatText(title??status??ToastStatus.success),
          description: textToast??'',
          icon: ToastStatus.failure!=status?Icons.info:ToastStatus.success==status?Icons.check_circle:null,
          color:ToastStatus.failure!=status?ColorManager.success:ColorManager.error,
        ),
        context: context,
        position: StyledToastPosition.top
    );
  }




  static SHOWLOADINGINDECATOR() {
    return const Center(
      child: CircularProgressIndicator(
      ),
    );}

  static emptyWidget(context,{text='No Data Yet!'})=>SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie.asset(AssetsManager.emptyIcon),
          Text(text,style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.bold
          ),),
        ],
      ));
  static onSuccess(BuildContext context, {String? message,String? title}){
    showTOAST(context,textToast:message,title: title,status: ToastStatus.success);
  }
  static onFailure(BuildContext context, {String? message,String? title}){
    showTOAST(context,textToast: MessageApi.findTextToast(message??''),title: title,status: ToastStatus.failure);

  }
  static onNetworkFailure(BuildContext context, {NetworkExceptions? networkException,String? title}){
    onFailure(context,message:
        NetworkExceptions.getErrorMessage(networkException),title: title);
    // BlocProvider.of<AdvanceCubit>(context).failureAdvance(context, networkException);


  }
}
