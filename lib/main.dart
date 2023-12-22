import 'package:flutter/material.dart';
import 'package:json/model/user_model.dart';
import 'package:json/service/user_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final UserService _service = UserService();
  bool? isLoading;

  List<UsersModelData?> users = [];

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.blue)),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('APİ den JSON Veri Çekme'),
          centerTitle: true,
        ),
        body: isLoading == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isLoading == true ?  ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        users[index]!.firstName! + users[index]!.lastName!),
                    subtitle: Text(users[index]!.email!),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(users[index]!.avatar!),
                    ),
                  );
                },
              ): const Center(
                child: Text("Bir sorun oluştu.."),
              ),
      ),
    );
  }
}