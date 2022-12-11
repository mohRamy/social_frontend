
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/core/utils/dimensions.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 10.0),
          children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: TextField(
                    // controller: _searchController,
                    onChanged: (value) {
                      // if(value.isNotEmpty) {
                      //   postBloc.add( OnIsSearchPostEvent( true ) );
                      //   userService.searchUsers(value);
                      // }else{
                      //   postBloc.add( OnIsSearchPostEvent( false ) );
                      // }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar un amigo',
                      hintStyle: GoogleFonts.roboto(fontSize: 17),
                      suffixIcon: const Icon(Icons.search_rounded)
                    ),
                  ),
                ),
              ),
            
            const SizedBox(height: 10.0),
            
            const _GridPostSearch(),
                    
                
                ]
            )

          
        
      ),
    );
  }
}

class _GridPostSearch extends StatelessWidget {

  const _GridPostSearch({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          mainAxisExtent: 170
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 9,
        itemBuilder: (context, i) {

          // final List<String> listImages =posts[i].images.split(',');

          return GestureDetector(
              onTap: () {},
              // onLongPress: () => modalShowPost(context, post: posts[i]),
              child: Container(
                alignment: Alignment.center,
                decoration:const  BoxDecoration(
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: NetworkImage(Environment.baseUrl + listImages.first)
                  // )
                )
              ),
            );
        }
      );
  }
}