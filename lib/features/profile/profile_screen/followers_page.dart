import 'package:flutter/material.dart';

import '../../../core/widgets/widgets.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(
              text: 'Seguidores', letterSpacing: .8, fontSize: 19),
          elevation: 0,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              )),
        ),
        body: const SafeArea(
          // child:  Column(
          //         children: const [
          //           ShimmerFrave(),
          //           SizedBox(height: 10.0),
          //           ShimmerFrave(),
          //           SizedBox(height: 10.0),
          //           ShimmerFrave(),
          //         ],
          //       )
          //     :
          child: _ListFollowers(),
        ));
  }
}

class _ListFollowers extends StatelessWidget {
  const _ListFollowers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: 4,
        itemBuilder: (context, i) {
          return InkWell(
            borderRadius: BorderRadius.circular(10.0),
            splashColor: Colors.grey[300],
            // onTap: () => Navigator.push(context, routeSlide(page: ProfileAnotherUserPage(idUser: follow[i].uidUser))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.amber,
                        // backgroundImage: NetworkImage(Environment.baseUrl + follow[i].avatar),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(text: "follow[i].username", fontSize: 16),
                          TextCustom(
                              text: "follow[i].fullname",
                              color: Colors.grey,
                              fontSize: 15)
                        ],
                      ),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 0,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        splashColor: Colors.blue[50],
                        // onTap: () => userBloc.add(OnDeletefollowersEvent(follow[i].uidUser)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 17.0, vertical: 6.0),
                          child: TextCustom(text: 'Eliminar', fontSize: 16),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
