import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_arkamaya/api/api_service.dart';
import 'package:pt_arkamaya/provider/create_user_provider.dart';
import 'package:pt_arkamaya/utils/result_state.dart';


class CreateUserPage extends StatefulWidget {
  static const routeName = '/create_user_page';

  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}
TextEditingController nameController = TextEditingController();
String name = '';
TextEditingController jobController = TextEditingController();
String job = '';

class _CreateUserPageState extends State<CreateUserPage> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => CreateUserProvider(apiService: ApiService()),
      child: Builder(builder: (context) {
        return Consumer<CreateUserProvider>(
          builder: (context,state,_){
            return RefreshIndicator(
              onRefresh: (){
                return context.read<CreateUserProvider>().fetchCreateUser(
                    name, job);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Buat User Baru"),
                ),
                body: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: [Column(
                      children: [
                        const Center(
                          child: Text("Menambah User"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                            ),
                            onChanged: (String value){
                              setState(() {
                                name = value;
                              });
                            }
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                            controller: jobController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Job',
                            ),
                            onChanged: (String value){

                              setState(() {
                                job = value;
                              });


                            }
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton(
                            backgroundColor: const Color.fromRGBO(100, 92, 187, 1),
                            onPressed: () {

                              if(name.isEmpty && job.isEmpty){
                                const snackBar = SnackBar(content: Text('Name dan Job Belum Terisi'));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else if(name.isEmpty){
                                const snackBar = SnackBar(content: Text('Nama Belum Terisi'));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else if(job.isEmpty){
                                const snackBar = SnackBar(content: Text('Job Belum Terisi'));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else if(state.state == ResultState.error){

                                const snackBar = SnackBar(content: Text('Gangguan Jaringan Silakan Swipe Untuk Refresh'));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{

                                context.read<CreateUserProvider>().fetchCreateUser(
                                    name, job);
                                const snackBar = SnackBar(content: Text('Anda Berhasil Menambahkan User'));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);


                              }





                            },
                            child: const Icon(Icons.person_add)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Nama: ${state.result?.name}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Job: ${state.result?.job}")
                      ],
                    ),
              ]
                  ),
                ),
              ),
            );
          }

        );
      }),
    );
  }
}
