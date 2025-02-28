import 'package:flutter/material.dart';
import 'package:volpes/Resources/app_colors.dart';
import 'package:volpes/resources/height_width.dart';


class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key,});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {


  Widget _drawerTile(
      {required String title,
        required ImageIcon icon,
        required VoidCallback onTap,
        required int index
      }) {
    return ListTile(
      selectedTileColor: AppColors.primaryClr,
      leading: icon,
      minLeadingWidth: 30,
      title: Text(
        title,
        style:  TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right_sharp,
          color: Colors.grey,),
      onTap: onTap,
    );
  }


  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // addHeight(60),

          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              color: AppColors.primaryClr,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Obx((){
                  //   return  Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(15.0),
                  //       child: SizedBox(
                  //         height: 35,
                  //         width: 38,
                  //         child: CircleAvatar(
                  //           radius: 50, // Customize the size if needed
                  //           backgroundImage: userDetailsController.image.value != null
                  //               ? FileImage(userDetailsController.image.value!)
                  //               : AssetImage("assets/images/pic.png") as ImageProvider,
                  //           backgroundColor: Colors.transparent, // Optional, for styling
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }),
                  // addWidth(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Demoo", style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'system-ui;',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),),
                      giveHeight(3),
                      Text("demo@gmail.com", style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'system-ui;',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),),
                    ],
                  )
                ],
              ),
            ),
          ),
          // addHeight(30),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                _drawerTile(
                  title: 'Dashboard',
                  icon: const ImageIcon(
                    AssetImage("assets/images/dashboard.png"),
                    size: 18,
                    color: Colors.grey
                  ),
                  onTap: () {

                    Navigator.pop(context);

                  }, index: 0,
                ),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
