import 'dart:convert';
import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/resources/api_urls.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import 'package:volpes/resources/custom_loader.dart';
import 'package:volpes/store%20pages/plugin_demo_quiz.dart';
import 'package:volpes/store%20pages/quiz_component/common_button.dart';
import 'package:volpes/store%20pages/quiz_questions_page.dart';
import 'package:volpes/store%20pages/test_result_page.dart';
import '../models/admin_quiz_user_list.dart';
import '../resources/height_width.dart';
import 'leader_board_page.dart';

class TakeQuizScreen extends StatefulWidget {
  const TakeQuizScreen({super.key});

  @override
  State<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  Map<String, String> challengerMap = {};
  Map<String, String> challengeMap = {};
 List<String> challengerList = [];
 List<String> challengesList = [];
 String? selectedChallengerID;
 String? selectedChallengeID;

  QuizUserListModel? quizUserListModel;
  Repositories repository = Repositories();
      getQuizUserList(){
        repository.getApi(url: ApiUrls.getQuizUserList).then((value){
          quizUserListModel = QuizUserListModel.fromJson(jsonDecode(value));
          challengerMap.clear();
          challengerList.clear();
          challengeMap.clear();
          challengesList.clear();

          for (var person in quizUserListModel!.success!.salespersons!) {
            String fullName = "${person.firstName ?? ""} ${person.lastName ?? ""}".trim();
            String id = person.iD.toString();

            challengerMap[fullName] = id;
            challengerList.add(fullName);
          }

          for (var person in quizUserListModel!.success!.categories!) {
            String fullName = person.category.toString();
            String id = person.id.toString();
            challengeMap[fullName] = id;
            challengesList.add(fullName);
          }
          // challengerList= quizUserListModel!.success!.salespersons!.map((person)=>"${person.firstName ?? ""} ${person.lastName ?? ""}").toList();
          // challengesList= quizUserListModel!.success!.categories!.map((person)=> person.category ?? "").toList();
          setState(() {});
        });
      }

@override
  void initState() {
    super.initState();
    getQuizUserList();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body:
      quizUserListModel != null ?
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              giveHeight(10),
              Center(
                child: Image.asset(
                  "assets/images/v_logo.png",
                  height: height*.1,
                  width: width*.45,
                ),
              ),
              giveHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonCommon(title: 'TEST RESULTS', onTapp: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                      return TestResultPage();
                    }));

                  }),
                  buttonCommon(title: 'LEADERBOARD', onTapp: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                      return LeaderBoardPage();
                    }));
                  }),
                ],
              ),
              giveHeight(10),
              Center(child: Text("Quiz",style: textHeading.copyWith(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),)),
              giveHeight(10),
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(color: Colors.black26),
              //     color: Colors.white,
              //   ),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //       isExpanded: true,
              //       value: selectedChallenger,
              //       hint: Padding(
              //         padding: EdgeInsets.symmetric(vertical: 10),
              //         child: Text(
              //           'Select Challenger',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 14,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //       icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
              //       dropdownColor: Colors.white, // Background color of dropdown
              //       items: challengers.map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(vertical: 8),
              //             child: Text(
              //               value,
              //               style: TextStyle(fontSize: 14, color: Colors.black),
              //             ),
              //           ),
              //         );
              //       }).toList(),
              //       onChanged: (newValue) {
              //         setState(() {
              //           selectedChallenger = newValue!;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              CustomDropdown<String>(
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: Colors.black26),
                  closedBorderRadius: BorderRadius.circular(5),
                  expandedBorder: Border.all(color: Colors.black26),
                  expandedBorderRadius: BorderRadius.circular(5),
                  expandedFillColor: Colors.white,

                  headerStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13),
                  listItemStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13, fontWeight: FontWeight.w400,),

                  hintStyle: TextStyle(
                    color: AppColors.primaryClr,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                hintText: 'Select Challenger',
                items: challengerList,
                excludeSelected: false,
                onChanged: (value) {
                  selectedChallengerID = challengerMap[value];
                  log('Selected Challenger Name: $selectedChallengerID');
                },
              ),
              giveHeight(10),
              CustomDropdown<String>(
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: Colors.black26),
                  closedBorderRadius: BorderRadius.circular(5),
                  expandedBorder: Border.all(color: Colors.black26),
                  expandedBorderRadius: BorderRadius.circular(5),
                  expandedFillColor: Colors.white,

                  headerStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13),
                  listItemStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13, fontWeight: FontWeight.w400,),

                  hintStyle: TextStyle(
                    color: AppColors.primaryClr,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                hintText: 'Select Challenge',
                items: challengesList,
                excludeSelected: false,
                onChanged: (value) {
                  selectedChallengeID = challengeMap[value];
                  String task = value.toString();
                  log('Selected Challenge ID: $selectedChallengeID');
                  log('Selected Challenge Name: $task');
                },
              ),

              giveHeight(15),
              Text("RULES OF ENGAGEMENT",style: textHeading.copyWith(fontWeight: FontWeight.w500,fontSize: 15,color:AppColors.primaryClr),),
              giveHeight(5),
              Text("1. You must answer all the question in quiz.",style: textHeading.copyWith(fontWeight: FontWeight.w400,fontSize: 13,color:AppColors.primaryClr),),
              giveHeight(3),
              Text("2. The highest scoring person in store wins\n     a chocolate.",style: textHeading.copyWith(fontWeight: FontWeight.w400,fontSize: 13,color:AppColors.primaryClr),),
              giveHeight(3),
              Text("3. Don't forget to submit your quiz.",style: textHeading.copyWith(fontWeight: FontWeight.w400,fontSize: 13,color:AppColors.primaryClr),),
              giveHeight(30),
              Center(child: startQuiz(title: 'START CHALLENGE', onTapp: () {

                Navigator.push(context,MaterialPageRoute(builder: (BuildContext){
                  return DemoQuiz(challengerID: selectedChallengerID.toString(), challengeID: selectedChallengeID.toString());
                //   QuizQuestionScreen(challengerID: selectedChallengerID.toString(), challengeID: selectedChallengeID.toString());
                }));
              }, context: context)
              ),
            ],
          ),
        ),
      ):Center(child: threeArchedCircle(color: AppColors.primaryClr, size: 25)),
    );
  }
}
