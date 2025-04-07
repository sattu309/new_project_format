import 'dart:convert';
import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/resources/height_width.dart';

import '../../common_repository/common_api_method.dart';
import '../../models/package_content_model.dart';
import '../../models/sales_person_model.dart';
import '../../repositories/login_repo.dart';
import '../../resources/api_urls.dart';
import '../../store pages/quiz_component/common_button.dart';

class PackageContent extends StatefulWidget {
  const PackageContent({super.key});

  @override
  State<PackageContent> createState() => _PackageContentState();
}

class _PackageContentState extends State<PackageContent>  with TickerProviderStateMixin {
    final commentController = TextEditingController();
  late TabController tabController;
    bool isLoading = false;
  Map<String, String> challengerMap = {};
  List<String> challengerList = [];
  String? selectedChallengerID;
  Repositories repositories = Repositories();
  PackageContentModel? packageContentModel;
  getReceivedList(){
    repositories.getApi(url: ApiUrls.getReceivedList).then((value){
      packageContentModel = PackageContentModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  SalesPersonModel? salesPersonModel;
  Repositories repository = Repositories();
  getSalesPersonList(){
    repository.getApi(url: ApiUrls.getQuizUserList).then((value){
      salesPersonModel = SalesPersonModel.fromJson(jsonDecode(value));
      challengerList= salesPersonModel!.success!.salespersons!.map((person)=>"${person.firstName ?? ""} ${person.lastName ?? ""}").toList();

      // challengerMap.clear();
      // challengerList.clear();
      //
      //
      // for (var person in salesPersonModel!.success!.salespersons!) {
      //   String fullName = "${person.firstName ?? ""} ${person.lastName ?? ""}".trim();
      //   String id = person.iD.toString();
      //
      //   challengerMap[fullName] = id;
      //   challengerList.add(fullName);
      // }

      setState(() {});
    });
  }
  TextEditingController dateController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: currentDate.subtract(const Duration(days: 365 * 50)),
      lastDate: currentDate.add(const Duration(days: 365 * 50)),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      setState(() {
        dateController.text = formattedDate; // Assign to controller
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReceivedList();
    getSalesPersonList();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return
      Scaffold(
        appBar: customerAppBar(context, "Package Content"),
        body:
            packageContentModel != null ?
        NestedScrollView(
            headerSliverBuilder: (_, __){
              return [
                    SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:10,vertical: 10),
                      child:
                      Column(
                        children: [
                          giveHeight(10),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                // color: Colors.grey[300], // Background color for unselected tabs
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: AppColors.primaryClr,
                                indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                                // indicatorSize: TabBarIndicatorSize.tab,
                                labelStyle: TextStyle(fontSize: 10),
                                controller: tabController,
                                labelColor: AppColors.primaryClr,
                                unselectedLabelColor: Colors.black87,
                                tabs: [
                                  Tab(text: "TO BE RECEIVED FROM DC"),
                                  Tab(text: "RECEIVED IN STORE"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ];
            },
            body:
            TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: tabController,
              children: [
                (packageContentModel!.stockpending != null && packageContentModel!.stockpending!.isNotEmpty == true) ?
                ListView.builder(
                    itemCount: packageContentModel!.stockpending!.length,
                    itemBuilder: (BuildContext context,index){
                  final data1 = packageContentModel!.stockpending![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5),
                        // border: Border.all(color: Colors.grey.shade200)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Package Count".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                        Text(
                                          data1.packageCount!= null ? data1.packageCount.toString():"-",
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 13,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Package Content".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),// Space between label and value
                                      Text(data1.storecomment.toString(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),



                              ],
                            ),
                            giveHeight(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Store Comment".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                        Text(data1.storecomment!= null?data1.storecomment.toString():"-",
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 13,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sales Person".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),// Space between label and value
                                      Text(data1.salesPerson.toString(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                            giveHeight(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                      if(data1.description!= null)// Space between label and value
                                        Text(data1.description.toString(),
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: 13,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),


                            giveHeight(20),
                            Align(
                              alignment: Alignment.center,
                              child: buttonCommon1(title: 'UPDATE', context:context,onTapp: () {
                                showAlertBox();

                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }):Center(child: Text("No Data Available",style: userText,),),
                (packageContentModel!.stockreceived != null && packageContentModel!.stockreceived!.isNotEmpty == true) ?
                ListView.builder(
                    itemCount: packageContentModel!.stockreceived!.length,
                    itemBuilder: (BuildContext context, index){
                      final data = packageContentModel!.stockreceived![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5),
                        // border: Border.all(color: Colors.grey.shade200)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Issued On".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1), // Space between label and value
                                      Text(
                                          data.createdAt != null
                                              ? DateFormat('yyyy-MM-dd').format(DateTime.parse(data.createdAt.toString()))
                                              : "",
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Received On".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1), // Space between label and value
                                      Text(
                                        data.updatedAt != null
                                            ? DateFormat('yyyy-MM-dd').format(DateTime.parse(data.updatedAt.toString()))
                                            : "",
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            giveHeight(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sales Person".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),// Space between label and value
                                      Text(data.salesPerson.toString(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Store Comment".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),// Space between label and value
                                      Text(data.storecomment.toString(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            giveHeight(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Package Count".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                      Text(
                                        data.packageCount!= null ? data.packageCount.toString():"-",
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Package Content".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1), // Space between label and value
                                      Text(data.packageContent.toString(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            giveHeight(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Align Row children to the start
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically from the top
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 1), // Space between label and value
                                      Text(data.description.toString(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }):Center(child: Text("No Data Available",style: userText,),),

              ],
            )
        ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 30),)

      );
  }
  showAlertBox() {
    final key1= GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              child: Form(
                key: key1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("UPDATE PACAKGE CONTENT",style: textHeading.copyWith(color: AppColors.primaryClr,fontSize: 14),),
                       IconButton(
                         onPressed: () {
                           Navigator.pop(context);
                         }, icon: Icon(Icons.clear,color: AppColors.primaryClr,),)

                     ],
                   ),
                    const Divider(
                      height: 0,
                      color: Colors.grey,
                    ),
                    giveHeight(15),
                    Text("Update Date",style: textHeading,),
                    giveHeight(4),
                    GestureDetector(
                      onTap: () {
                        selectDate(context);
                      },
                      child: AbsorbPointer( // Prevents manual keyboard input
                        child: CustomTextField1(
                          hint: "Date",
                          controller: dateController,
                          suffix: Icon(Icons.date_range, color: AppColors.primaryClr),
                        ),
                      ),
                    ),
                    giveHeight(8),
                    Text("Sales Person",style: textHeading,),
                    SizedBox(
                      height: 55, // Increase height to prevent text clipping
                      child: CustomDropdown<String>(
                        decoration: CustomDropdownDecoration(
                          closedBorder: Border.all(color: Colors.black26),
                          closedBorderRadius: BorderRadius.circular(5),
                          expandedBorder: Border.all(color: Colors.black26),
                          expandedBorderRadius: BorderRadius.circular(5),
                          expandedFillColor: Colors.white,
                          headerStyle: TextStyle(
                            color: AppColors.primaryClr,
                            fontSize: 14, // Slightly increase font size if needed
                          ),
                          listItemStyle: TextStyle(
                            color: AppColors.primaryClr,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: TextStyle(
                            color: AppColors.primaryClr,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        hintText: 'Sales person',
                        items: challengerList,
                        excludeSelected: false,
                        onChanged: (value) {
                          selectedChallengerID = value;
                          log('Selected person Name: $selectedChallengerID');
                        },
                      ),
                    ),

                    giveHeight(8),
                    Text("Comment",style: textHeading,),
                    giveHeight(4),
                    CustomTextField1(
                      controller: commentController,
                      hint: "Comment",
                    ),
                    giveHeight(20),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: buttonCommon(title: "UPDATE", onTapp: (){
                            if(key1.currentState!.validate()){
                              updatePackageContent(
                                  stockId: packageContentModel!.stockpending!.first.id.toString(),
                                  salesPerson: selectedChallengerID.toString(),
                                  storeComment: commentController.text,
                                  updateDate: dateController.text,
                                  context: context).then((value){
                                    if(value.success != null){
                                      getReceivedList();
                                      dateController.clear();
                                      commentController.clear();
                                      selectedChallengerID = "";
                                      Navigator.pop(context);
                                    }
                              });
                            }
                        })),

                  ],
                ),
              ),
            ),
          );
        });
  }

}
