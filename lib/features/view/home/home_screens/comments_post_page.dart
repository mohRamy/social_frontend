import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/features/view/home/home_ctrl/home_ctrl.dart';

import '../../../../core/widgets/widgets.dart';


class CommentsPostScreen extends GetView<HomeCtrl> {

  final String uidPost;
  
  CommentsPostScreen({
    Key? key, 
    required this.uidPost,
  }) : super(key: key);

  
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Comentarios', fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: .8),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            onPressed: ()=> Navigator.pop(context), 
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87 )
          ),
        ),
        body: Form(
          key: _keyForm,
          child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    itemCount: 9,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                          padding: const EdgeInsets.only(top: 5.0, right: 5.0, bottom: 5.0),
                          // color: Colors.green,
                          child: Row(
                            children: [
                
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                // backgroundImage: NetworkImage(Environment.baseUrl+ snapshot.data![i].avatar),
                              ),
                              const SizedBox(width: 10.0),
                              
                              Flexible(
                                flex: 2,  
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, 
                                  crossAxisAlignment: CrossAxisAlignment.start, 
                                  children: [
                                    TextCustom(text: "username", fontSize: 16, fontWeight: FontWeight.w500),
                                    Text("comment"),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(50),
                                        
                                          // child:  isLike == 1
                                          // ? const Icon(Icons.favorite_rounded, size: 19, color: Colors.red)
                                          child : const Icon(Icons.favorite_border_rounded, size: 19),
                                        ),
                                        // TextCustom(text: timeago.format(createdAt, locale: 'en_short'), fontSize: 14),
                                      ],
                                    )
                                    // add dots to show this is a longer text
                                  ],
                                ),
                              ),
          
                              
                              
                            ],
                          ),
                        ),
                    ),
                  ),
                ),
              
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xff1F2128),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(18.0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: TextField(
                              controller: controller.commentController,
                              style: GoogleFonts.roboto(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(left: 10.0),
                                hintText: 'Enter your commnet',
                                hintStyle: GoogleFonts.roboto(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            // if( _keyForm.currentState!.validate() ){
                            //   postBloc.add(OnAddNewCommentEvent(widget.uidPost, _commentController.text.trim()));
                            // }
                          }, 
                          icon: const Icon(Icons.send_rounded, color: Colors.white, size: 28 )
                        )
                      ],
                    ),
                  ),
                ),
          
          
              ],
            ),
          ),
        
      
    );
  }
}