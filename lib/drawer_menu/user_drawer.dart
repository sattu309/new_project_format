
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/common_repository/common_api_method.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/sale_by_product.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/sales_overview_page.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/sales_payment_method.dart';
import 'package:volpes/drawer_menu/admin%20menu%20files/tfg_moeny_page.dart';
import 'package:volpes/drawer_menu/stores%20menu%20files/feedback_form.dart';
import 'package:volpes/drawer_menu/stores%20menu%20files/package_content_page.dart';
import 'package:volpes/drawer_menu/stores%20menu%20files/shop_screen.dart';
import 'package:volpes/drawer_menu/stores%20menu%20files/store_menus_list.dart';
import 'package:volpes/resources/height_width.dart';

import '../controllers/main_controller.dart';
import '../controllers/user_details_controller.dart';
import '../resources/methods.dart';
import 'stores menu files/vm_section.dart';
import 'admin menu files/cc_furniture_rugs.dart';
import 'admin menu files/cif_subscription_page.dart';
import 'admin menu files/top_10_list/c&c_shoppers.dart';
import 'admin menu files/top_10_list/cc_sales_store.dart';
import 'admin menu files/top_10_list/retail_shopper(50).dart';
import 'admin menu files/top_10_list/retail_shopper.dart';
import 'admin menu files/top_10_list/sales_person_list(10).dart';
import 'admin menu files/top_10_list/store_shopper.dart';
import 'admin menu files/top_10_list/store_shoppers(OVERALL).dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({
    super.key,
  });

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final mainController = Get.put(MainHomeController());
  final userDetailsController = Get.put(UserDetailsController());

  var drawerRoutes = [
    'Top 10 Retail Shoppers',
    'Top 10 Store Shoppers',
    'Top 10 C & C Shoppers',
    'Top 10 C & C Sales Per Store',
    'Top 10 Store Shoppers\n(Overall)',
    'Top 10 Sales Persons',
    'Top 50 Retail Shoppers\n(Overall)',
  ];
  var navigationRoutes = [
        () => Get.to(() => RetailShopper()),
        () => Get.to(() => StoreShopper()),
        () => Get.to(() => CCShoppers()),
        () => Get.to(() => CCSalesStore()),
        () => Get.to(() => StoreShopperOverAll()),
        () => Get.to(() => SalesPersonList()),
        () => Get.to(() => RetailsShoppersList()),
  ];
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: AppColors.primaryClr,
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: 50),
            color: AppColors.primaryClr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                giveHeight(10),
                Image.asset(
                  "assets/images/app_icon.png",
                  height: 55,
                  width: 55,
                ),
                giveHeight(10),
                Image.asset(
                  "assets/images/v_logo.png",
                  height: 50,
                  width: 130,
                  color: Colors.white,
                ),
                // Text(
                //   "VOLPES",
                //   style: TextStyle(
                //     letterSpacing: 4,
                //     fontSize: 23,
                //     fontFamily: 'system-ui;',
                //     color: Colors.white,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // giveHeight(4),
                // Text(
                //   "THE HOME OF LINEN",
                //   style: TextStyle(
                //     fontSize: 8,
                //     fontFamily: 'system-ui;',
                //     color: Colors.white,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                giveHeight(7),
                Text(
                  "Welcome ${userDetailsController.userName.value}",
                  style: TextStyle(
                    letterSpacing: 0,
                    fontSize: 14,
                    fontFamily: 'system-ui;',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

              ],
            ),
          ),
          // stores menu
          if(userDetailsController.userRoles.value == "store")
            Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                _drawerTile1(title: 'Dashboard', icon: Icons.home, onTap: (){
                  Navigator.pop(context);
                  mainController.onItemTap(0);
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Take Quiz', icon: Icons.quiz, onTap: (){
                  Navigator.pop(context);
                  mainController.onItemTap(1);
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Product Knowledge', icon: Icons.quiz, onTap: (){
                    Get.to(()=>StoreMenusList());
                }),

                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'VM Section', icon: Icons.quiz, onTap: (){
                  Get.to(()=>VmSectionPage());
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Receiving', icon: Icons.quiz, onTap: (){
                  Get.to(()=>PackageContent());
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Recommendations', icon: Icons.quiz, onTap: (){
                  Get.to(()=>FeedbackForm());
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Notifications', icon: Icons.add_alert, onTap: (){
                  Navigator.pop(context);
                  mainController.onItemTap(3);
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),

                _drawerTile1(title: '#LoveMyStore', icon: Icons.dynamic_feed_sharp, onTap: (){
                  Navigator.pop(context);
                  mainController.onItemTap(2);
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Shop', icon: Icons.store, onTap: (){
                  Get.to(()=>HomePage());
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Latest Catalogue', icon: Icons.new_releases_outlined, onTap: (){
                  Navigator.pop(context);
                  openPdf(pdfUrl: "https://joom.ag/9FMd");
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Blog', icon: Icons.new_releases_outlined, onTap: (){
                  Navigator.pop(context);

                  openPdf(pdfUrl: "https://www.volpes.co.za/blog");
                }),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 8.0,top: 10.0,bottom: 10.0),
                        child: GestureDetector(
                          onTap: (){
                            Repositories repo = Repositories();
                            repo.logOutUser();
                          },
                          child: Row(
                            children: [
                              ImageIcon(
                                size: 20,
                                AssetImage("assets/images/turn-off.png",),color:Colors.white,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Logout",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
         ] )),



        if(userDetailsController.userRoles.value == "admin")
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                _drawerTile1(title: 'Dashboard', icon: Icons.home, onTap: () => Navigator.pop(context)),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'My TFG Money', icon: Icons.attach_money, onTap: () => Get.to(() => TFGMoney()),),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Sales Overview', icon: Icons.bar_chart, onTap: () => Get.to(() => SalesOverviewPage())),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Sales By Payment Method', icon: Icons.payment, onTap: () => Get.to(() => SalesPaymentMethod())),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Sales By Product', icon: Icons.shopping_cart, onTap: () => Get.to(() => SaleByProduct())),
                const Divider(height: 0, color: Colors.grey),

                Padding(
                  padding: const EdgeInsets.only(left: 4,right: 3,top: 5,bottom: 5),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      collapsedIconColor: Colors.white,
                     minTileHeight: 10,
                      iconColor:  Colors.white,

                      leading: Icon(size: 20,Icons.payment, color: Colors.white,),
                      title: Text(
                        'Top 10',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white,),
                      ),
                      children: List.generate(drawerRoutes.length, (index) {
                      return _nestedDrawerTile(drawerRoutes[index], navigationRoutes[index],index);
                    }),
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'C & C Furniture and Rugs', icon: Icons.chair, onTap: () => Get.to(() => CCFurnitureRugs())),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                _drawerTile1(title: 'Store CIF Subscriptions', icon: Icons.store, onTap: () => Get.to(() => CifSubscriptionPage())),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 8.0,top: 10.0,bottom: 10.0),
                  child: GestureDetector(
                    onTap: (){
                      Repositories repo = Repositories();
                      repo.logOutUser();
                    },
                    child: Row(
                      children: [
                        ImageIcon(
                          size: 18,
                          AssetImage("assets/images/turn-off.png",),color:Colors.white,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Logout",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),


                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
      giveHeight(20)

        ],
      ),
    );
  }

  Widget _drawerTile1({required String title, required IconData icon, required VoidCallback onTap, bool isLogout = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
          ),
          child: Row(
            // Color(0xff0000000).withOpacity(0.6)
            children: [
              Icon(icon, size: 20, color:Colors.white ,),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nestedDrawerTile(String title, VoidCallback onTap, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 40, top: 5, bottom: 7),

      child: InkWell(
        onTap:onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            const Divider(
              height: 0,
              color: Colors.grey,
            ),
            giveHeight(3),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Row(children: [
                  Icon(Icons.payment, size: 18, color: Colors.white,),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ),
            // giveHeight(3),
            // if (index != drawerRoutes.length - 1)
            //   const Divider(height: 0, color: Colors.grey),


          ],
        ),
      ),
    );
  }
}
