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
import '../models/leader_board_model.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});
  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  final ScrollController _controller = ScrollController();
  Repositories repositories = Repositories();
  LeaderBoardModel? leaderBoardModel;
  getLeaderBoardData(){
    repositories.getApi(url: ApiUrls.leaderBoardList).then((value){
      leaderBoardModel = LeaderBoardModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getLeaderBoardData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customerAppBar(context, "Leader Board"),
      body:
      leaderBoardModel != null ?
      (leaderBoardModel!.success!.isNotEmpty == true)?
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leaderBoardModel!.success!.isNotEmpty == true ?
              SizedBox(
                width: width,
                child: Table(
                  columnWidths: {
                    0:FlexColumnWidth(4.2),
                    1:FlexColumnWidth(3.2),
                    2:FlexColumnWidth(2.5),
                    3:FlexColumnWidth(5),
                  },

                  children: [
                    TableRow(
                        children: [
                          tableCell("STORE",isHeader: true),
                          tableCell("QUIZ ATTEMPTED",isHeader: true),
                          tableCell("AVG. RESULT",isHeader: true),
                          tableCell("TOP QUIZ CHALLENGERS",isHeader: true),
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
                        itemCount: leaderBoardModel!.success!.length,
                        itemBuilder: (context, index){
                          final tabData = leaderBoardModel!.success![index];
                          return
                            topStoreShopperTableData(
                                store: tabData.storename.toString(),
                                quizAttemped: tabData.totattempts.toString(),
                                avgResult: tabData.avgRight.toString(),
                                quizChallenger: tabData.topleader.toString(),
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
    required String store,
    required String quizAttemped,
    required String avgResult,
    required String quizChallenger,
    int? index
  }) {
    return Table(
      columnWidths: {
        0:FlexColumnWidth(4.2),
        1:FlexColumnWidth(3.2),
        2:FlexColumnWidth(2.5),
        3:FlexColumnWidth(5),
      },
      children: [
        TableRow(children: [
          tableCell(store, rowIndex: index),
          tableCell(quizAttemped, rowIndex: index),
          tableCell(avgResult , rowIndex: index),
          tableCell(quizChallenger , rowIndex: index),


        ]),
      ],
    );
  }

}
