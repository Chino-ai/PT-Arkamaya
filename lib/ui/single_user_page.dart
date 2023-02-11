import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_arkamaya/provider/single_user_provider.dart';
import 'package:pt_arkamaya/api/api_service.dart';
import '../utils/result_state.dart';

class SingleUserPage extends StatelessWidget {
  static const routeName = 'ui/single_user_page';
  final String id;

  const SingleUserPage({Key? key, required this.id}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SingleUserProvider(apiService: ApiService(), id: id),
      child: Builder(
          builder: (context) {
            return Scaffold(
                appBar: AppBar(title: const Text("Detail User"),),
                body: Consumer<SingleUserProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else {
                        if (state.state == ResultState.hasData) {
                          var user = state.result?.data;
                          return Container(
                            width: 220,
                            height: 220,
                            margin: EdgeInsets.only(left: 100, top: 30),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    //color of shadow
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                border: Border.all(
                                    width: 2.0,
                                    style: BorderStyle.solid), //Border.all
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                )

                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  Image.network("${user?.avatar}"),
                                  const SizedBox(height: 10,),
                                  Text("${user?.firstName} ${user?.lastName}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 10,),
                                  Text("${user?.email}"),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          );
                        } else if (state.state == ResultState.error) {
                          return Material(child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                const Text("Gangguan Jaringan"),
                                const SizedBox(height: 10,),
                                const Text('Tekan Tombol Refresh'),
                                const SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed:(){context.read<SingleUserProvider>().fetchSingleUser();}  ,
                                  child: Icon(Icons.refresh),
                                )
                              ],
                            ),
                          ));
                        } else {
                          return const Material(child: Text(''));
                        }
                      }
                    }

                )
            );
          }
      ),
    );
  }

}
