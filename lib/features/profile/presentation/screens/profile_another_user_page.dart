import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/widgets.dart';



class ProfileAnotherUserPage extends StatefulWidget {
  final String idUser;

  const ProfileAnotherUserPage({Key? key, required this.idUser}) : super(key: key);

  @override
  State<ProfileAnotherUserPage> createState() => _ProfileAnotherUserPageState();
}


class _ProfileAnotherUserPageState extends State<ProfileAnotherUserPage> {

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _BodyUser(),
            
          
        
      ),
    );
  }
}

class _BodyUser extends StatelessWidget {


  const _BodyUser({ Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [

          _CoverAndProfile(),
          const SizedBox(height: 10.0),
          _UsernameAndDescription(),
          const SizedBox(height: 30.0),
          _PostAndFollowingAndFollowers(),
          const SizedBox(height: 30.0),
          const _BtnFollowAndMessage(
            isFriend: 3, 
            uidUser:'dfdf',
            isPendingFollowers: 4,
            username: 'ere',
            avatar: 'dfd',
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 46,
            child: Column(
              children: [
                const Icon(Icons.grid_on_rounded, size: 30),
                const SizedBox(height: 5.0),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                )
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          _ListFotosAnotherProfile(
            // posts: responseUserSearch.postsUser, 
            // isPrivate: responseUserSearch.anotherUser.isPrivate,
            // isFriend: responseUserSearch.isFriend,
          ),

      ],
    );
  }
}


class _ListFotosAnotherProfile extends StatelessWidget {

  

  const _ListFotosAnotherProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child:  GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisExtent: 170
          ),
          itemCount: 4,
          itemBuilder: (context, i) {

          final List<String> listImages = ['4','4'];

          return InkWell(
            onTap: () {} ,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   // image: NetworkImage(Environment.baseUrl + listImages.first)
                // )
              ),
            ),
          );
        },
      )
    // :
    //  SizedBox(
    //   height: 100,
    //   child: Row(
    //     children: [
    //       const Icon(Icons.lock_outline_rounded, size: 40),
    //       const SizedBox(width: 10.0),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: const [
    //           TextCustom(text: 'Esta cuenta es privada', fontWeight: FontWeight.w500),
    //           TextCustom(text: 'Sigue esta cuenta para poder ver sus fotos.', color: Colors.grey, fontSize: 16),
    //         ],
    //       )
    //     ],
    //   ),
    // )
    );
  }
}


class _BtnFollowAndMessage extends StatelessWidget {

  final int isFriend;
  final int isPendingFollowers;
  final String uidUser;
  final String username;
  final String avatar;

  const _BtnFollowAndMessage({ 
    Key? key, 
    required this.isFriend, 
    required this.uidUser, 
    required this.isPendingFollowers,
    required this.username,
    required this.avatar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 43,
          width: size.width * .5,
          decoration: BoxDecoration(
            color: isFriend == 1 || isPendingFollowers == 1 ? Colors.white : AppColors.primary,
            border: Border.all(color:  isFriend == 1 || isPendingFollowers == 1 ? Colors.grey : Colors.white),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: isPendingFollowers == 0 
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0) )
              ),
              child: TextCustom(
                text: isFriend == 1 ? 'Siguiendo' : 'Seguir', 
                fontSize: 20, 
                color: isFriend == 1 ? Colors.black : Colors.white
              ),
              onPressed: (){
                if( isFriend == 1 ){
                  
                }else{
                  
                }
              }, 
            )
          : TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0) )
              ),
              child: const TextCustom(text: 'Pendiente', fontSize: 20, color: Colors.black),
              onPressed: (){
                
              }, 
            )
        ),
        Container(
          height: 43,
          width: size.width * .4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0) )
            ),
            child: const TextCustom(text: 'Mensaje', fontSize: 20),
            onPressed: (){},
            // onPressed: () 
            //   => Navigator.push(
            //       context, 
            //       routeFade(page: ChatMessagesPage(uidUserTarget: uidUser, usernameTarget: username, avatarTarget: avatar))
            //   ), 
          ),
        )
      ],
    );
  }
}


class _PostAndFollowingAndFollowers extends StatelessWidget {


  const _PostAndFollowingAndFollowers({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        width: size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextCustom(text: '343',  fontSize: 22, fontWeight: FontWeight.w500),
                    const TextCustom(text: 'Post',  fontSize: 17, color: Colors.grey),
                  ],
                ),
                Column(
                  children: [
                    TextCustom(text: '343',  fontSize: 22, fontWeight: FontWeight.w500),
                    const TextCustom(text: 'Siguiendo', fontSize: 17, color: Colors.grey),
                  ],
                ),
                Column(
                  children: [
                    TextCustom(text: '3434',  fontSize: 22, fontWeight: FontWeight.w500),
                    const TextCustom(text: 'Seguidores', fontSize: 17, color: Colors.grey),
                  ],
                ),
                
              ],
            ),
          ],
        ),
      );
  }
}


class _UsernameAndDescription extends StatelessWidget {


  const _UsernameAndDescription({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child:TextCustom(text: 'user.username' , fontSize: 22, fontWeight: FontWeight.w500 )
        ),
        const SizedBox(height: 5.0),
        Center(
          child: TextCustom(text: 'user.description', fontSize: 17, color: Colors.grey)
        ),
      ],
    );
  }
}


class _CoverAndProfile extends StatelessWidget {


  const _CoverAndProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 200,
      width: size.width,
      child: Stack(
        children: [

          SizedBox(
            height: 170,
            width: size.width,
            child:Container(
                  height: 170,
                  width: size.width,
                  color: Colors.blueGrey[200],
                )
          ),

          Positioned(
            bottom: 28,
            child: Container(
              height: 20,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: size.width,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle
                ),
                child: Container(), 
                // CircleAvatar(
                //   backgroundImage: NetworkImage( Environment.baseUrl + user.image )
                // ),
              ),
            ),
          ),

          Positioned(
            right: 0,
            child: IconButton(
              onPressed: (){},
              // onPressed: () => modalOptionsAnotherUser(context),
              icon: const Icon(Icons.dashboard_customize_outlined, color: Colors.white ),
            )
          ),

          Positioned(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white ),
            )
          ),


        ],
      ),
    );
  }
}


class _LoadingDataUser extends StatelessWidget {

  const _LoadingDataUser({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: const [
          CustomShimmer(),
          SizedBox(height: 10.0),
          CustomShimmer(),
          SizedBox(height: 10.0),
          CustomShimmer(),
          SizedBox(height: 10.0),
          CustomShimmer(),
        ], 
      );
  }
}


