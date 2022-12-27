



import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../core/utils/app_colors.dart';
import '../json/contact_json.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({ Key? key }) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }
  Widget getAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.greyColor,
      title: Text("Contacts",style: TextStyle(
        fontSize: 20,
        color: AppColors.white,fontWeight: FontWeight.w500
      ),),
      leading: IconButton(onPressed: null, icon: Text("Sort",style: TextStyle(
        fontSize: 16,
        color: AppColors.primary,fontWeight: FontWeight.w500
      ),)),
      actions: [
        IconButton(onPressed: null, icon: Icon(LineIcons.plus,color: AppColors.primary,))
      ],
    );
  }
  Widget getBody(){

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.greyColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: AppColors.white
                      ),cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(LineIcons.search,color: AppColors.white.withOpacity(0.3),),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: AppColors.white.withOpacity(0.3),fontSize: 17
                        )
                      ),

                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          getSectionIcons(),
          getContactLists()
        ],
      ),
    );
  }
  Widget getSectionIcons(){
    List icons = [
      {
        "icon": LineIcons.mapMarker,
        "label" : "Find People Nearby"
      },
      {
        "icon": LineIcons.userPlus,
        "label" : "Invite Friends"
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: List.generate(icons.length , (index) {
          return Column(
            children: [
              Row(
                children: [
                  Icon(icons[index]['icon'],color: AppColors.primary,size: 28,),
                  SizedBox(width: 20,),
                  Text(icons[index]['label'],style: TextStyle(
                    fontSize: 16,color: AppColors.primary,fontWeight: FontWeight.w500
                  ),)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Divider(
                  thickness: 1,
                  color: AppColors.white.withOpacity(0.15),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
  Widget getContactLists(){
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: List.generate(contact_data.length, (index) {
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(contact_data[index]['img']),
                  ),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact_data[index]['name'],style: TextStyle(
                        fontSize: 17,color: AppColors.white,fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 2,),
                       Text(contact_data[index]['is_online'] ? "online" : contact_data[index]['seen'],style: TextStyle(
                        fontSize: 13,color: contact_data[index]['is_online'] ?AppColors.primary : AppColors.white.withOpacity(0.5),fontWeight: FontWeight.w500
                      ),),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Divider(
                  thickness: 1,
                  color:AppColors.white.withOpacity(0.15)
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}