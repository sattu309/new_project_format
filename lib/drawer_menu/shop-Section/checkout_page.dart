import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_texts_style.dart';
import '../../common_repository/common_api_method.dart';
import '../../controllers/cart_controller.dart';
import '../../models/admin_quiz_user_list.dart';
import '../../resources/height_width.dart';
import 'cart_common_format.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final checkoutController = Get.put(CartController());
  final countryController = TextEditingController(text: "SOUTH AFRICA",);
  bool selectedAddress = false;
  bool selectedNewsLetter = false;
  bool selectedSMS = false;
  String? selectedPaymentMethod;
  Country selectedCountry = Country.parse('ZA');
  final challengerKey = GlobalKey<FormState>();
  final provinceKey = GlobalKey<FormState>();

  String selectPerson = "";
  String selectedProvince = "";
  QuizUserListModel? quizUserListModel;
  Repositories repository = Repositories();
  // getQuizUserList(){
  //   repository.getApi(url: ApiUrls.getQuizUserList).then((value){
  //     quizUserListModel = QuizUserListModel.fromJson(jsonDecode(value));
  //     // challengerMap.clear();
  //     // challengerList.clear();
  //     // challengeMap.clear();
  //     // challengesList.clear();
  //     //
  //     // for (var person in quizUserListModel!.success!.salespersons!) {
  //     //   String fullName = "${person.firstName ?? ""} ${person.lastName ?? ""}".trim();
  //     //   String id = person.iD.toString();
  //     //
  //     //   challengerMap[fullName] = id;
  //     //   challengerList.add(fullName);
  //     // }
  //     // salesPersonList= quizUserListModel!.success!.salespersons!.map((person)=>"${person.firstName ?? ""} ${person.lastName ?? ""}").toList();
  //     // challengesList= quizUserListModel!.success!.categories!.map((person)=> person.category ?? "").toList();
  //     setState(() {});
  //   });
  // }
  @override
  void initState() {
    super.initState();
    // getQuizUserList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkoutController.getCHECKOUTData();
      checkoutController.getData();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customerAppBar(context, "Checkout"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize:  MaterialTapTargetSize.shrinkWrap,
                    activeColor: AppColors.primaryClr,
                    value: selectedAddress,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedAddress = value ?? false;
                        log(selectedAddress.toString());
                      });
                    },
                  ),
                  Text(
                    "SHIP TO CUSTOMER @${checkoutController.checkoutModel.value.success!.shippingamount.toString()}.00",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.red),
                  ),
                ],
              ),
              giveHeight(4),
              Text(selectedAddress ? "DELIVERY DETAILS" :"CUSTOMER DETAILS",style: userText,),
              giveHeight(10),
              Text("CONTACT DETAILS",style: textHeading,),
              giveHeight(4),
              selectedAddress ?
              Column(
                children: [
                  CustomTextField1(
                    hint: "Customer Email Address",
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter your email '),
                      EmailValidator(errorText: "Please enter the valid email")
                    ]).call,
                  ),
                  giveHeight(8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            countryListTheme: CountryListThemeData(
                              searchTextStyle: TextStyle(color: AppColors.titleClr),
                              textStyle: TextStyle(color: AppColors.primaryClr),
                              bottomSheetHeight: 500, // set the height you want
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            context: context,
                            showPhoneCode: true, // This shows +27 or other country codes next to flag
                            onSelect: (Country country) {
                              setState(() {
                                selectedCountry = country;
                              });
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(selectedCountry.flagEmoji),
                              SizedBox(width: 8),
                              Text('+${selectedCountry.phoneCode}',style: userText,),
                              Icon(Icons.arrow_drop_down),

                            ],
                          ),
                        ),
                      ),
                      giveWidth(8),
                      Expanded(child: CustomTextField1(
                        hint: "Customer Phone Number",
                      ))
                    ],
                  ),
                  giveHeight(8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField1(
                          hint: "Customer First Name",
                        ),
                      ),
                      giveWidth(8),
                      Expanded(
                        child: CustomTextField1(
                          keyboardType: TextInputType.emailAddress,
                          hint: "Customer Last Name",
                        ),
                      ),
                    ],
                  ),

                ],
              ):
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField1(
                          hint: "Customer First Name",
                        ),
                      ),
                      giveWidth(8),
                      Expanded(
                        child: CustomTextField1(
                          keyboardType: TextInputType.emailAddress,
                          hint: "Customer Last Name",
                        ),
                      ),
                    ],
                  ),
                  giveHeight(8),
                  CustomTextField1(
                    hint: "Customer Email Address",
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter your email '),
                      EmailValidator(errorText: "Please enter the valid email")
                    ]).call,
                  ),
                  giveHeight(8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            countryListTheme: CountryListThemeData(
                              searchTextStyle: TextStyle(color: AppColors.titleClr),
                              textStyle: TextStyle(color: AppColors.primaryClr),
                              bottomSheetHeight: 500, // set the height you want
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            context: context,
                            showPhoneCode: true, // This shows +27 or other country codes next to flag
                            onSelect: (Country country) {
                              setState(() {
                                selectedCountry = country;
                              });
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(selectedCountry.flagEmoji),
                              SizedBox(width: 8),
                              Text('+${selectedCountry.phoneCode}',style: userText,),
                              Icon(Icons.arrow_drop_down),

                            ],
                          ),
                        ),
                      ),
                      giveWidth(8),
                      Expanded(child: CustomTextField1(
                        hint: "Customer Phone Number",
                      ))
                    ],
                  ),
                ],
              ),

              giveHeight(15),
              Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize:  MaterialTapTargetSize.shrinkWrap,
                    activeColor: AppColors.primaryClr,
                    value: selectedNewsLetter,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedNewsLetter = value ?? false;
                        log(selectedNewsLetter.toString());
                      });
                    },
                  ),
                  Text(
                    "Subscribe to Volpes Newsletter ",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                ],
              ),
              Row(
                children: [
                  Checkbox(
                    materialTapTargetSize:  MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    activeColor: AppColors.primaryClr,
                    value: selectedSMS,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedSMS = value ?? false;
                        log(selectedSMS.toString());
                      });
                    },
                  ),
                  Text(
                    "Subscribe to SMS",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                ],
              ),
              giveHeight(7),
              // hide section
              selectedAddress ?
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("STREET ADDRESS",style: userText,),
                    giveHeight(7),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField1(
                            hint: "Street Number",
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Please enter your email '),
                              EmailValidator(errorText: "Please enter the valid email")
                            ]).call,
                          ),
                        ),
                        giveWidth(8),
                        Expanded(
                          child: CustomTextField1(
                            hint: "Street Name",
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Please enter your email '),
                              EmailValidator(errorText: "Please enter the valid email")
                            ]).call,
                          ),
                        ),
                      ],
                    ),
                    giveHeight(7),
                 Row(
                   children: [
                     Expanded(
                       child: CustomTextField1(
                         hint: "Your Suburb",
                         validator: MultiValidator([
                           RequiredValidator(errorText: 'Please enter your email '),
                           EmailValidator(errorText: "Please enter the valid email")
                         ]).call,
                       ),
                     ),
                     giveWidth(8),
                     Expanded(
                       child: CustomTextField1(
                         hint: "Town / City",
                         validator: MultiValidator([
                           RequiredValidator(errorText: 'Please enter your email '),
                           EmailValidator(errorText: "Please enter the valid email")
                         ]).call,
                       ),
                     ),
                   ],
                 ),
                    giveHeight(7),
                    CustomTextField1(
                      controller: countryController,
                      hint: "",
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your email '),
                        EmailValidator(errorText: "Please enter the valid email")
                      ]).call,
                    ),
                    giveHeight(7),
                    CustomTextField1(
                      hint: "Postal / Code",
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your email '),
                        EmailValidator(errorText: "Please enter the valid email")
                      ]).call,
                    ),
                    giveHeight(7),
                    Form(
                      key: provinceKey,
                      child: SizedBox(
                        height: 48,
                        child: CustomDropdown<String>(
                          decoration: CustomDropdownDecoration(
                            closedBorder: Border.all(color: Colors.black26),
                            closedBorderRadius: BorderRadius.circular(5),
                            expandedBorder: Border.all(color: Colors.black26),
                            expandedBorderRadius: BorderRadius.circular(5),
                            expandedFillColor: Colors.white,
                            headerStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13),
                            listItemStyle: TextStyle(color: AppColors.primaryClr, fontSize: 13, fontWeight: FontWeight.w400,),

                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          hintText: 'Select a province',
                          items: checkoutController.provinceList,
                          excludeSelected: false,
                          onChanged: (value) {
                            selectedProvince = value!;
                            log(' selectedProvince Name: $selectedProvince');
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an challenger';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ):SizedBox(),

              giveHeight(10),
              Text("SALES AGENT",style: userText,),
              giveHeight(7),
              Form(
                key: challengerKey,
                child: SizedBox(
                  height: 48,
                  child: CustomDropdown<String>(
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
                    hintText: 'Select Sales Person',
                    items: checkoutController.salesPersonList,
                    excludeSelected: false,
                    onChanged: (value) {
                      selectPerson = checkoutController.selectedId[value]!;
                      log('Selected Challenger Name: $selectPerson');
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an challenger';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              giveHeight(20),
              Obx(() {
                double shippingAmount = double.tryParse(checkoutController.checkoutModel.value.success!.shippingamount.toString()) ?? 0;
                double cartTotal = double.tryParse(checkoutController.cartTotal.value.toString()) ?? 0;
                double totalAmount = shippingAmount + cartTotal;
                double vatAmt = ((cartTotal * 0.15) / 1.15);

                if (checkoutController.isDataLoading.value) {
                  Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryClr,
                      ));
                }
                if (checkoutController.cartModel.value.success!.products!.isEmpty) {
                  return Center(child: Text("Cart is Empty",style: userText,));
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text("YOUR ORDER",style: userText,)),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: checkoutController
                              .cartModel.value.success!.products!.length,
                          itemBuilder: (BuildContext context, index) {
                            final cartData = checkoutController
                                .cartModel.value.success!.products![index];
                            final imgPath = checkoutController
                                .cartModel.value.success!.imagepath
                                .toString();
                            final imgUrl = cartData.image.toString();
                            final img = "${imgPath + imgUrl}";
                            final price = cartData.price.toString();
                            final salePrice = cartData.saleprice.toString();
                            return
                              cartFormat(img, cartData, salePrice, context);
                          }),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("SUBTOTAL",style: userText,),
                            Text("R${checkoutController.cartTotal.value.toString()}",style: userText,),
                          ],
                        ),
                      ),
                      if(checkoutController.cartModel.value.success!.discountAmount != 0)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Discount",style: userText,),
                            Text("R${checkoutController.cartModel.value.success!.discountAmount.toString()}",style: userText.copyWith(color: Colors.red,fontSize: 15),),
                          ],
                        ),
                      ),
                      if(selectedAddress)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("SHIPPING",style: userText,),
                            Text("R${shippingAmount}",style: userText,),
                          ],
                        ),
                      ),
                      selectedAddress ?
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TOTAL",style: userText.copyWith(color: AppColors.primaryClr),),
                            Text("R${totalAmount}",style: userText.copyWith(color: AppColors.primaryClr,fontSize: 16),),
                          ],
                        ),
                      ):
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TOTAL",style: userText.copyWith(color: AppColors.primaryClr),),
                            Text("R${cartTotal}",style: userText.copyWith(color: AppColors.primaryClr,fontSize: 16),),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text("(Includes R${vatAmt.toStringAsFixed(2)} VAT) ",style: userText,)
                      ],),
                      ...List.generate(checkoutController.checkoutModel.value.success!.paymentModes!.length, (index){
                          final payMethod = checkoutController.checkoutModel.value.success!.paymentModes![index];
                        return
                        Row(
                          children: [
                              addRadioButton1(payMethod.value.toString()),
                            Text(payMethod.title.toString(),style: userText,)
                          ],
                        );
                      })

                    ],
                  ),
                );
              }),




            ],
          ),
        ),
      ),
    );
  }
  Row addRadioButton1(String btnValue1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<dynamic>(
          hoverColor: const Color(0xFF0074D9),
          activeColor: AppColors.primaryClr,
          value: btnValue1,
          groupValue: selectedPaymentMethod,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value;
              log(selectedPaymentMethod!);
            });
          },
        ),
      ],
    );
  }
}
