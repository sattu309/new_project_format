import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_table_cell_method.dart';
import 'package:volpes/resources/custom_loader.dart';
import '../../../common_repository/common_api_method.dart';
import '../../../resources/api_urls.dart';
import '../../../resources/common_texts_style.dart';
import '../../../resources/height_width.dart';
import '../drawer_menu/admin menu files/common_appbar_drawer.dart';
import '../models/test_result_model.dart';

class TestResultPage extends StatefulWidget {
  const TestResultPage({super.key});
  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  final ScrollController _controller = ScrollController();
  Repositories repositories = Repositories();
  TestResultModel? testResultModel;
  getTestResultData(){
    repositories.getApi(url: ApiUrls.testResultUrl).then((value){
      testResultModel = TestResultModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getTestResultData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customerAppBar(context, "Test Result"),
      body:
      testResultModel != null ?
      (testResultModel!.success!.isNotEmpty == true)?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              testResultModel!.success!.isNotEmpty == true ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(15),
                    1:FlexColumnWidth(20),
                    2:FlexColumnWidth(20),
                    3:FlexColumnWidth(10),
                    4:FlexColumnWidth(10),
                    5:FlexColumnWidth(10),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("SALE PERSON",isHeader: true),
                          tableCell("CHALLENGE NAME",isHeader: true),
                          tableCell("CHALLENGE DATE",isHeader: true),
                          tableCell("MARKS",isHeader: true),
                          tableCell("%",isHeader: true),
                          tableCell("VIEW RESULT",isHeader: true),
                        ]
                    )
                  ],
                ),
              ):SizedBox(),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Scrollbar(
                    thickness: 3,
                    thumbVisibility: true,
                    controller: _controller,

                    child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount: testResultModel!.success!.length,
                        itemBuilder: (context, index){
                          final tabData = testResultModel!.success![index];
                          final obtained = double.parse(tabData.markobtained.toString());
                          final total = double.parse(tabData.totalmarks.toString());
                          final markPercentage = (obtained / total) * 100;
                          return
                            topStoreShopperTableData(
                                salePerson: "${tabData.firstName.toString()} ${tabData.lastName.toString()}",
                                challengeName: tabData.category.toString(),
                                challengeDate: tabData.startedOn.toString(),
                                marks: "${tabData.markobtained.toString()}/${tabData.totalmarks.toString()}",
                                percent: markPercentage.toStringAsFixed(2),
                                viewResult: '',
                                index: index
                            );

                        }),
                  ),
                ),
              ),
              giveHeight(10),


            ],
          ),
        ),
      )
          :Center(child: Text("No Record Found",style: userText,),)
          :Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25),),
    );
  }
  Table topStoreShopperTableData({
    required String salePerson,
    required String challengeName,
    required String challengeDate,
    required String marks,
    required String percent,
    required String viewResult,
    int? index
  }) {
    return Table(
      columnWidths: {
        0:FlexColumnWidth(15),
        1:FlexColumnWidth(20),
        2:FlexColumnWidth(20),
        3:FlexColumnWidth(10),
        4:FlexColumnWidth(10),
        5:FlexColumnWidth(10),
      },
      children: [
        TableRow(children: [
          tableCell(salePerson, rowIndex: index),
          tableCell(challengeName, rowIndex: index,),
          tableCell(challengeDate , rowIndex: index),
          tableCell(marks , rowIndex: index),
          tableCell(percent , rowIndex: index),
          // tableCell(viewResult , rowIndex: index),
          Icon(Icons.picture_as_pdf,color: Colors.red,size: 15,)

        ]),
      ],
    );
  }

}
