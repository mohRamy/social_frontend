import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/core/utils/app_colors.dart';

import '../../../core/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(
          text: 'Frave social',
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: AppColors.bgColor,
          isTitle: true,
        ),
        elevation: 0,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              // onPressed:()=> Navigator.pushAndRemoveUntil(context, routeSlide(page: const AddPostPage()), (_) => false);

              icon: SvgPicture.asset('assets/svg/add_rounded.svg', height: 32)),
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              // onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const NotificationsPage()), (_) => false),
              icon: SvgPicture.asset('assets/svg/notification-icon.svg',
                  height: 26)),
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              // onPressed: () => Navigator.push(context, routeSlide(page: const ListMessagesPage())),
              icon: SvgPicture.asset('assets/svg/chat-icon.svg', height: 24)),
        ],
      ),
      body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              
              const _ListHistories(),
    
              const SizedBox(height: 5.0),


                  // if( snapshot.data != null && snapshot.data!.isEmpty){
                  //   return _ListWithoutPosts();
                  // }

                  
                  //!snapshot.hasData
                  // ? Column(
                  //     children: const [
                  //       ShimmerFrave(),
                  //       SizedBox(height: 10.0),
                  //       ShimmerFrave(),
                  //       SizedBox(height: 10.0),
                  //       ShimmerFrave(),
                  //     ],
                  //   )
                  // : 
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (_, i) => const _ListViewPosts(),
                    )
                  
            
              
              
    
            ],
          ),
        ),
    );
  }
}

class _ListHistories extends StatelessWidget {

  const _ListHistories({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 90,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
           InkWell(
                // onTap: () => Navigator.push(context, routeSlide(page: const AddStoryPage())),
                child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Colors.pink,
                              Colors.amber
                            ]
                          )
                        ),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //   image: NetworkImage(Environment.baseUrl + state.user!.image.toString() )
                            // )
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextCustom(text: "state.user!.username", fontSize: 15)
                    ],
                ),
              ),
              
          

          const SizedBox(width: 10.0),
          SizedBox(
            height: 90,
            width: size.width,
            child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, i) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        
                        // onTap: () => Navigator.push(context, routeFade(page: ViewStoryPage(storyHome:  snapshot.data![i]))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                     begin: Alignment.topCenter,
                                      colors: [
                                        Colors.pink,
                                        Colors.amber
                                      ]
                                  )
                                ),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: NetworkImage(Environment.baseUrl + snapshot.data![i].avatar )
                                    // )
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextCustom(text: 'snapshot.data![i].username', fontSize: 15)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              
            
          )

        ],
      ),
    );
  }
}

class _ListViewPosts extends StatelessWidget {

  // final Post posts;

  const _ListViewPosts({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    // final postBloc = BlocProvider.of<PostBloc>(context);

    // final List<String> listImages = posts.images.split(',');
    final time =  "22";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        height: 350,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.green
        ),
        child: Stack(
          children: [
    
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CarouselSlider.builder(
                itemCount: 3,                 
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  height: 350,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: false,
                ),
                itemBuilder: (context, i, realIndex) 
                  => Container(
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: NetworkImage(Environment.baseUrl+ listImages[i])
                        // )
                      ),
                  ), 
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // CircleAvatar(
                              //   backgroundImage: NetworkImage(Environment.baseUrl + posts.avatar),
                              // ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(text: "posts.username", color: Colors.white, fontWeight: FontWeight.w500 ),
                                  TextCustom(text: time, fontSize: 15, color: Colors.white ),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 25)
                          )
                          
                        ],
                      ),
                    ],
                  ),
    
                  Positioned(
                    bottom: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: 45,
                      width: size.width * .9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            color: Colors.white.withOpacity(0.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        const InkWell(
                                          // onTap: () => postBloc.add( OnLikeOrUnLikePost(posts.postUid, posts.personUid) ),
                                          child: 
                                            Icon(Icons.favorite_outline_rounded, color: Colors.white),
                                        ),
                                        const SizedBox(width: 8.0),
                                        InkWell(
                                          onTap: () {},
                                          child: const TextCustom(text:"fdfg", fontSize: 16, color: Colors.white)
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 20.0),
                                    TextButton(
                                      onPressed: (){},
                                      // onPressed: () => Navigator.push(
                                      //   context, 
                                      //   routeFade(page: CommentsPostPage(uidPost: posts.postUid))
                                      // ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/svg/message-icon.svg', color: Colors.white),
                                          const SizedBox(width: 5.0),
                                          const TextCustom(text: "sddsd", fontSize: 16, color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){},
                                      icon: SvgPicture.asset('assets/svg/send-icon.svg', height: 24, color: Colors.white)
                                    ),
                                    IconButton(
                                      onPressed: (){},
                                      // onPressed: () => postBloc.add(OnSavePostByUser( posts.postUid )),
                                      icon: const Icon(Icons.bookmark_border_rounded, size: 27, color: Colors.white)
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
