import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/cubit/my_cubit.dart';
import 'package:test_app/user.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  List<User> users = [];
  User user = User();
  @override
  void initState() {
    // BlocProvider.of<MyCubit>(context).emitGetAllUsers();
    // BlocProvider.of<MyCubit>(context).emitGetUser(7434359);
    // BlocProvider.of<MyCubit>(context).createNewUser(User(
    //     email: "boshra@gmail.com",
    //     name: "boshra",
    //     gender: "female",
    //     status: "active"));
    BlocProvider.of<MyCubit>(context).delteUser(7436334);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screan', style: TextStyle(color: Colors.black)),
      ),
      body: Column(children: [
        // BlocBuilder<MyCubit, MyState>(
        //   builder: (context, state) {
        //     if (state is GetAllUsers) {
        //       users = state.users;
        //       return ListView.builder(
        //         shrinkWrap: true,
        //         padding: const EdgeInsets.all(8),
        //         itemCount: users.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           return Container(
        //             height: 50,
        //             color: Colors.amber,
        //             child: Center(
        //               child: Text(
        //                 users[index].name ?? 'No name found',
        //                 style: const TextStyle(fontSize: 20),
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     } else {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
        BlocBuilder<MyCubit, MyState>(
          builder: (context, state) {
            if (state is DeleteUser) {
              // user = state.deleteuser;
              return Container(
                height: 50,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    state.deleteuser.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      ]),
    );
  }
}
