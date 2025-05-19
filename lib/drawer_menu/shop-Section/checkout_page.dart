import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/common_appbar_drawer.dart';
import 'package:volpes/drawer_menu/shop-Section/thanks_you_screen.dart';
import 'package:volpes/resources/app_colors.dart';
import 'package:volpes/resources/common_button.dart';
import 'package:volpes/resources/common_texts_style.dart';
import '../../common_repository/common_api_method.dart';
import '../../controllers/cart_controller.dart';
import '../../models/admin_quiz_user_list.dart';
import '../../repositories/place_order_repo.dart';
import '../../resources/custom_loader.dart';
import '../../resources/height_width.dart';
import 'cart_common_format.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final checkoutController = Get.put(CartController());
  final cusFNameController = TextEditingController();
  final cusLNameController = TextEditingController();
  final customerEmailController = TextEditingController();
  final customerPhoneController = TextEditingController();

  final emailController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetNumberController = TextEditingController();
  final streetNameController = TextEditingController();
  final suburbController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  final countryController = TextEditingController(
    text: "SOUTH AFRICA",
  );
  bool isLoading = false;
  bool selectedAddress = false;
  bool selectedNewsLetter = false;
  bool selectedSMS = false;
  String? selectedPaymentMethod;
  Country selectedCountry = Country.parse('ZA');
  final formGlobalKey = GlobalKey<FormState>();
  final challengerKey = GlobalKey<FormState>();
  final provinceKey = GlobalKey<FormState>();
  double forApiDiscount = 0;
  String selectPerson = "";
  String selectedProvince = "";
  QuizUserListModel? quizUserListModel;
  Repositories repository = Repositories();
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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            key: formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                      "SHIP TO CUSTOMER @${(checkoutController.checkoutModel.value.success!.shippingamount.toString() ?? 0.0)}.00",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.red),
                    ),
                  ],
                ),
                giveHeight(4),
                Text(
                  selectedAddress ? "DELIVERY DETAILS" : "CUSTOMER DETAILS",
                  style: userText,
                ),
                giveHeight(10),
                Text(
                  "CONTACT DETAILS",
                  style: textHeading,
                ),
                giveHeight(4),
                selectedAddress
                    ? Column(
                        children: [
                          CustomTextField1(
                            controller: emailController,
                            hint: "Customer Email Address",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'This field is required'),
                              EmailValidator(
                                  errorText: "This field is required")
                            ]).call,
                          ),
                          giveHeight(8),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                    countryListTheme: CountryListThemeData(
                                      searchTextStyle:
                                          TextStyle(color: AppColors.titleClr),
                                      textStyle: TextStyle(
                                          color: AppColors.primaryClr),
                                      bottomSheetHeight:
                                          500, // set the height you want
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    context: context,
                                    showPhoneCode:
                                        true, // This shows +27 or other country codes next to flag
                                    onSelect: (Country country) {
                                      setState(() {
                                        selectedCountry = country;
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(selectedCountry.flagEmoji),
                                      SizedBox(width: 8),
                                      Text(
                                        '+${selectedCountry.phoneCode}',
                                        style: userText,
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                              giveWidth(8),
                              Expanded(
                                  child: CustomTextField1(
                                controller: phoneController,
                                hint: "Customer Phone Number",
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'This field is required'),
                                ]).call,
                              ))
                            ],
                          ),
                          giveHeight(8),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField1(
                                  controller: fNameController,
                                  hint: "Customer First Name",
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'This field is required'),
                                  ]).call,
                                ),
                              ),
                              giveWidth(8),
                              Expanded(
                                child: CustomTextField1(
                                  controller: lNameController,
                                  keyboardType: TextInputType.emailAddress,
                                  hint: "Customer Last Name",
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'This field is required'),
                                  ]).call,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField1(
                                  controller: cusFNameController,
                                  hint: "Customer First Name",
                                ),
                              ),
                              giveWidth(8),
                              Expanded(
                                child: CustomTextField1(
                                  controller: cusLNameController,
                                  keyboardType: TextInputType.emailAddress,
                                  hint: "Customer Last Name",
                                ),
                              ),
                            ],
                          ),
                          giveHeight(8),
                          CustomTextField1(
                            controller: customerEmailController,
                            hint: "Customer Email Address",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please enter your email '),
                              EmailValidator(
                                  errorText: "Please enter the valid email")
                            ]).call,
                          ),
                          giveHeight(8),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                    countryListTheme: CountryListThemeData(
                                      searchTextStyle:
                                          TextStyle(color: AppColors.titleClr),
                                      textStyle: TextStyle(
                                          color: AppColors.primaryClr),
                                      bottomSheetHeight:
                                          500, // set the height you want
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    context: context,
                                    showPhoneCode:
                                        true, // This shows +27 or other country codes next to flag
                                    onSelect: (Country country) {
                                      setState(() {
                                        selectedCountry = country;
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(selectedCountry.flagEmoji),
                                      SizedBox(width: 8),
                                      Text(
                                        '+${selectedCountry.phoneCode}',
                                        style: userText,
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                              giveWidth(8),
                              Expanded(
                                  child: CustomTextField1(
                                controller: customerPhoneController,
                                hint: "Customer Phone Number",
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'This field is required'),
                                ]).call,
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
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                selectedAddress
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                            Text(
                              "STREET ADDRESS",
                              style: userText,
                            ),
                            giveHeight(7),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField1(
                                    controller: streetNumberController,
                                    hint: "Street Number",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'This field is required'),
                                    ]).call,
                                  ),
                                ),
                                giveWidth(8),
                                Expanded(
                                  child: CustomTextField1(
                                    controller: streetNameController,
                                    hint: "Street Name",
                                  ),
                                ),
                              ],
                            ),
                            giveHeight(7),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField1(
                                    controller: suburbController,
                                    hint: "Your Suburb",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'This field is required'),
                                    ]).call,
                                  ),
                                ),
                                giveWidth(8),
                                Expanded(
                                  child: CustomTextField1(
                                    controller: cityController,
                                    hint: "Town / City",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'This field is required'),
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
                                RequiredValidator(
                                    errorText: 'This field is required'),
                              ]).call,
                            ),
                            giveHeight(7),
                            CustomTextField1(
                              controller: postalCodeController,
                              hint: "Postal / Code",
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'This field is required'),
                              ]).call,
                            ),
                            giveHeight(7),
                            Form(
                              key: provinceKey,
                              child: SizedBox(
                                height: 48,
                                child: CustomDropdown<String>(
                                  decoration: CustomDropdownDecoration(
                                    closedBorder:
                                        Border.all(color: Colors.black26),
                                    closedBorderRadius:
                                        BorderRadius.circular(5),
                                    expandedBorder:
                                        Border.all(color: Colors.black26),
                                    expandedBorderRadius:
                                        BorderRadius.circular(5),
                                    expandedFillColor: Colors.white,
                                    headerStyle: TextStyle(
                                        color: AppColors.primaryClr,
                                        fontSize: 13),
                                    listItemStyle: TextStyle(
                                      color: AppColors.primaryClr,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
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
                                      return 'Please Select a province';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),

                giveHeight(10),
                Text(
                  "SALES AGENT",
                  style: userText,
                ),
                giveHeight(7),
                Form(
                  key: challengerKey,
                  child: SizedBox(
                    // height: 48,
                    child: CustomDropdown<String>(
                      decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.black26),
                        closedBorderRadius: BorderRadius.circular(5),
                        expandedBorder: Border.all(color: Colors.black26),
                        expandedBorderRadius: BorderRadius.circular(5),
                        expandedFillColor: Colors.white,
                        headerStyle: TextStyle(
                            color: AppColors.primaryClr, fontSize: 13),
                        listItemStyle: TextStyle(
                          color: AppColors.primaryClr,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
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
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Sales Person';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                giveHeight(20),
                Obx(() {
                  double shippingAmount = double.tryParse(checkoutController
                          .checkoutModel.value.success!.shippingamount
                          .toString()) ??
                      0;
                  double discountAmount = double.tryParse(checkoutController
                          .cartModel.value.success!.discountAmount
                          .toString()) ??
                      0;
                  if (checkoutController.cartModel.value.success!.discData !=
                      null) {
                    forApiDiscount = (checkoutController
                            .cartModel.value.success!.discData as List)
                        .fold(0.0,
                            (sum, item) => sum + (item['discount'] as double));
                  }
                  double cartTotal = double.tryParse(
                          checkoutController.cartTotal.value.toString()) ??
                      0;
                  double totalAmount = shippingAmount + cartTotal;
                  double vatAmt = ((cartTotal * 0.15) / 1.15);

                  if (checkoutController.isDataLoading.value) {
                    Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryClr,
                    ));
                  }
                  if (checkoutController
                      .cartModel.value.success!.products!.isEmpty) {
                    return Center(
                        child: Text(
                      "Cart is Empty",
                      style: userText,
                    ));
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                        Center(
                          child: isLoading
                              ? threeArchedCircle(
                                  color: AppColors.primaryClr, size: 30)
                              : SizedBox(), // Keep height fixed when loader is hidden
                        ),
                        Center(
                            child: Text(
                          "YOUR ORDER",
                          style: userText,
                        )),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: checkoutController
                                .cartModel.value.success!.products!.length,
                            itemBuilder: (BuildContext context, index) {
                              final cartData = checkoutController
                                  .cartModel.value.success!.products![index];
                              final imgPath = checkoutController
                                  .cartModel.value.success!.imagepath
                                  .toString();
                              final imgUrl = cartData.image.toString();
                              final img = imgPath + imgUrl;
                              final salePrice = cartData.saleprice.toString();
                              return cartFormat(
                                  img, cartData, salePrice, context);
                            }),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SUBTOTAL",
                                style: userText,
                              ),
                              Text(
                                "R${checkoutController.cartTotal.value.toString()}",
                                style: userText,
                              ),
                            ],
                          ),
                        ),
                        if (checkoutController
                                .cartModel.value.success!.discountAmount !=
                            0)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount",
                                  style: userText,
                                ),
                                Text(
                                  "R${discountAmount.toStringAsFixed(2)}",
                                  style: userText.copyWith(
                                      color: Colors.red, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        if (selectedAddress)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SHIPPING",
                                  style: userText,
                                ),
                                Text(
                                  "R$shippingAmount",
                                  style: userText,
                                ),
                              ],
                            ),
                          ),
                        selectedAddress
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "TOTAL",
                                      style: userText.copyWith(
                                          color: AppColors.primaryClr),
                                    ),
                                    Text(
                                      "R${totalAmount}",
                                      style: userText.copyWith(
                                          color: AppColors.primaryClr,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "TOTAL",
                                      style: userText.copyWith(
                                          color: AppColors.primaryClr),
                                    ),
                                    Text(
                                      "R${cartTotal}",
                                      style: userText.copyWith(
                                          color: AppColors.primaryClr,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "(Includes R${vatAmt.toStringAsFixed(2)} VAT) ",
                                style: userText.copyWith(
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        ...List.generate(
                            checkoutController.checkoutModel.value.success!
                                .paymentModes!.length, (index) {
                          final payMethod = checkoutController.checkoutModel
                              .value.success!.paymentModes![index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  addRadioButton1(payMethod.value.toString()),
                                  Text(
                                    payMethod.title.toString(),
                                    style: userText,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        giveHeight(30),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: CommonAppButtonGreen(
                            title: "PLACE ORDER",
                            onPressed: () {
                              print(forApiDiscount);
                              final billAddressData = checkoutController
                                  .checkoutModel.value.success!.billaddress;
                              if (formGlobalKey.currentState!.validate() &&
                                  challengerKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                placeOrderREpo(
                                  email: emailController.text.isEmpty
                                      ? billAddressData!.email.toString()
                                      : emailController.text,
                                  phone: phoneController.text.isEmpty
                                      ? billAddressData!.phone.toString()
                                      : phoneController.text,
                                  phoneCode: '+27',
                                  fName: fNameController.text.isEmpty
                                      ? billAddressData!.fname.toString()
                                      : fNameController.text,
                                  lName: lNameController.text.isEmpty
                                      ? billAddressData!.lname.toString()
                                      : lNameController.text,
                                  companyName: '',
                                  vat: "",
                                  city: cityController.text.isEmpty
                                      ? billAddressData!.city.toString()
                                      : cityController.text,
                                  address1: streetNumberController.text.isEmpty
                                      ? billAddressData!.address1.toString()
                                      : streetNumberController.text,
                                  address2: streetNameController.text.isEmpty
                                      ? billAddressData!.address2.toString()
                                      : streetNameController.text,
                                  suburb: suburbController.text.isEmpty
                                      ? billAddressData!.suburb.toString()
                                      : suburbController.text,
                                  country: "SOUTH AFRICA",
                                  postCode: postalCodeController.text.isEmpty
                                      ? billAddressData!.postcode.toString()
                                      : postalCodeController.text,
                                  province: selectedProvince.isEmpty
                                      ? billAddressData!.province.toString()
                                      : selectedProvince,
                                  custFName: cusFNameController.text,
                                  custLName: cusLNameController.text,
                                  custEmail: customerEmailController.text,
                                  custPHone: customerPhoneController.text,
                                  custPhoneCode: '+27',
                                  storeInStock: '',
                                  shipToCust: selectedAddress ? '1' : '0',
                                  newsLetter1: selectedNewsLetter ? "1" : "0",
                                  smsSUB: selectedSMS ? "1" : "0",
                                  shipStoreId: '',
                                  deliveryAdd: '',
                                  bEmail: billAddressData!.email.toString(),
                                  bPhone: billAddressData.phone.toString(),
                                  bPhoneCode:
                                      billAddressData.phonecode.toString(),
                                  bFName: billAddressData.fname.toString(),
                                  bLName: billAddressData.lname.toString(),
                                  bCompanyName:
                                      billAddressData.companyname.toString(),
                                  bAddres1: billAddressData.address1.toString(),
                                  bAddres2: billAddressData.address2.toString(),
                                  bSuburb: billAddressData.suburb.toString(),
                                  bCity: billAddressData.city.toString(),
                                  bCountry: billAddressData.country.toString(),
                                  bPostCode:
                                      billAddressData.postcode.toString(),
                                  bProvince:
                                      billAddressData.province.toString(),
                                  comPoptDisp: '',
                                  sameBillShip: '0',
                                  newLetter2: '0',
                                  smsSub2: '0',
                                  compoptDispStore: '',
                                  salesPerson: selectPerson,
                                  prdTotalAmt: cartTotal.toString(),
                                  totalAmt: cartTotal.toString(),
                                  shipAmt: selectedAddress
                                      ? shippingAmount.toString()
                                      : '0',
                                  discount: forApiDiscount.toString(),
                                  discountString: checkoutController
                                      .cartModel.value.success!.discountString
                                      .toString(),
                                  couponAmt: '',
                                  couponId: '',
                                  coupon: '',
                                  payMent: selectedPaymentMethod.toString(),
                                  context: context,
                                ).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (value.orderid != null) {
                                    Get.offAll(() => ThanksYouScreen(
                                          cartTotal: cartTotal.toString(),
                                          payMethod:
                                              selectedPaymentMethod.toString(),
                                          orderId: value.orderid.toString(),
                                        ));
                                  }
                                }).catchError((e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                            },
                            isArrow: false,
                            color: Colors.green,
                          ),
                        ),
                        giveHeight(30),
                      ],
                    ),
                  );
                }),
              ],
            ),
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
