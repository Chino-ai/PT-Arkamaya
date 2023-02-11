import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_arkamaya/model/list_user.dart';
import 'package:pt_arkamaya/provider/list_user_provider.dart';
import 'package:pt_arkamaya/ui/about_page.dart';
import 'package:pt_arkamaya/ui/create_user_page.dart';
import 'package:pt_arkamaya/widget/user_card.dart';

import '../utils/result_state.dart';



class ListPage extends StatelessWidget {
  static const routeName = '/list_user_page';
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return RefreshIndicator(
            onRefresh: (){return context.read<ListUserProvider>().fetchListUser();},
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Daftar User"),
                actions: [
                  IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, CreateUserPage.routeName);
                      },
                      icon: const Icon(Icons.person_add)
                  ),

                  IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AboutPage.routeName);
                      },
                      icon: const Icon(Icons.description)
                  ),
                ],
              ),
              body: ListView(
                  children: [Consumer<ListUserProvider>(
                    builder: (context, state, _) {
                      if(state.state == ResultState.loading){
                        return const Center(child: CircularProgressIndicator());
                      }else{
                        if(state.state == ResultState.hasData){
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: state.result?.data.length,
                            itemBuilder: (context, index) {
                              var user =  state.result?.data[index];
                              return UserCard(user!);
                            },
                          );
                        }else if (state.state == ResultState.noData){
                          return Center(
                            child: Material(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(height: 10,),
                                  Text("Daftar User tidak ada"),
                                  SizedBox(height: 10,),
                                  Text('Lakukan Swipe untuk Refresh'),
                                ],
                              ),
                            ),
                          );
                        }else if(state.state == ResultState.error){
                          return Material(child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(height: 10,),
                                Text("Gangguan Jaringan"),
                                SizedBox(height: 10,),
                                Text('Lakukan Swipe untuk Refresh'),
                              ],
                            ),
                          ));
                        }else{
                          return const Material(child: Text(''));
                        }
                      }
                    },
                  ),
                  ]
              ),
            ),
          );
        }
    );
  }
}



