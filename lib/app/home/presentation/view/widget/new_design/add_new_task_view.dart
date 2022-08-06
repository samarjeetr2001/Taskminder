import 'package:flutter/material.dart';
import 'package:todotimer/app/home/presentation/home_controller.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';

class AddNewTaskView extends StatefulWidget {
  final HomeController controller;
  final TextEditingController titleTextController;
  final TextEditingController descriptionTextController;
  const AddNewTaskView(
      {Key? key,
      required this.controller,
      required this.titleTextController,
      required this.descriptionTextController})
      : super(key: key);

  @override
  State<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends State<AddNewTaskView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task",
                style: AppTheme.textStyleTitle
                    .copyWith(fontSize: CoreAppTheme.fontSizeExtraLarge),
              ),
              SizedBox(height: 40),
              Text(
                'Title',
                style: AppTheme.textStyleNormal,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration:
                    AppTheme.boxDecorationNormal.copyWith(color: Colors.white),
                child: TextFormField(
                  controller: widget.titleTextController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: AppTheme.textStyleNormal,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration:
                    AppTheme.boxDecorationNormal.copyWith(color: Colors.white),
                child: TextFormField(
                  controller: widget.descriptionTextController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  // MaterialButton(
  //               onPressed: () {
  //                 if (durationTextController.text.isNotEmpty) {
  //                   if (dropdownValue == 0) {
  //                     if (double.parse(durationTextController.text) < 1 ||
  //                         double.parse(durationTextController.text) > 10) {
  //                       Fluttertoast.showToast(
  //                         msg:
  //                             "   Invalid Duration!  Valid range is 1 to 10 minutes ",
  //                         toastLength: Toast.LENGTH_SHORT,
  //                         gravity: ToastGravity.BOTTOM,
  //                       );
  //                       return;
  //                     }
  //                   } else {
  //                     if (double.parse(durationTextController.text) < 1 ||
  //                         double.parse(durationTextController.text) > 10 * 60) {
  //                       Fluttertoast.showToast(
  //                         msg:
  //                             " Invalid Duration!  Valid range is 1 to 600 seconds ",
  //                         toastLength: Toast.LENGTH_SHORT,
  //                         gravity: ToastGravity.BOTTOM,
  //                       );
  //                       return;
  //                     }
  //                   }
  //                 }
  //                 if (titleTextController.text.isNotEmpty &&
  //                     durationTextController.text.isNotEmpty) {
  //                   widget.controller.createTask(
  //                     task: new TaskEntity(
  //                       id: getRandomString(11),
  //                       title: titleTextController.text,
  //                       description: descriptionTextController.text,
  //                       createdDate: DateTime.now(),
  //                       status: Status.TODO,
  //                       durationInSec: double.parse(
  //                         dropdownValue == 0
  //                             ? (double.parse(durationTextController.text) * 60)
  //                                 .toString()
  //                             : durationTextController.text,
  //                       ),
  //                     ),
  //                   );
  //                   Navigator.pop(context);
  //                 } else {
  //                   Fluttertoast.showToast(
  //                     msg: "  Title and Duration fields are compulsory  ",
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     gravity: ToastGravity.BOTTOM,
  //                   );
  //                 }
  //               },
  //               child: Container(
  //                 margin: EdgeInsets.only(
  //                     left: MediaQuery.of(context).size.width * 0.25),
  //                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                 decoration: AppTheme.boxDecorationListTile
  //                     .copyWith(color: CoreAppTheme.primaryColor),
  //                 width: 120,
  //                 child: Center(
  //                   child: Text(
  //                     "Add",
  //                     style: AppTheme.textStyleNormal
  //                         .copyWith(color: CoreAppTheme.backgroundColor),
  //                   ),
  //                 ),
  //               ),
  //             )





    //  SizedBox(height: 20),
    //           Text(
    //             'Duration',
    //             style: AppTheme.textStyleNormal,
    //           ),
    //           SizedBox(height: 10),
    //           Container(
    //             padding: EdgeInsets.symmetric(horizontal: 8),
    //             decoration:
    //                 AppTheme.boxDecorationNormal.copyWith(color: Colors.white),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                     child: TextFormField(
    //                   controller: durationTextController,
    //                   keyboardType: TextInputType.number,
    //                   decoration: InputDecoration(border: InputBorder.none),
    //                 )),
    //                 Container(
    //                   height: 30,
    //                   padding: EdgeInsets.symmetric(horizontal: 8),
    //                   decoration: AppTheme.boxDecorationNormal
    //                       .copyWith(color: Colors.white),
    //                   child: DropdownButton<int>(
    //                     underline: SizedBox(),
    //                     value: dropdownValue,
    //                     items: <int>[0, 1].map((int value) {
    //                       return DropdownMenuItem<int>(
    //                         value: value,
    //                         child: Text(
    //                           value == 0 ? 'minutes' : 'seconds',
    //                           style: AppTheme.textStyleNormal
    //                               .copyWith(fontSize: 14),
    //                         ),
    //                       );
    //                     }).toList(),
    //                     onChanged: (value) {
    //                       setState(() {
    //                         dropdownValue = value!;
    //                       });
    //                     },
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
             