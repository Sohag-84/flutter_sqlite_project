import 'package:flutter/material.dart';
import 'package:flutter_sqlite_project/database_helper.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sqlite"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(onPressed: () async{
                int i = await DatabaseHelper.instance.insert(
                    {DatabaseHelper.comlumnName : "Raiyan"}
                );
                print("id = $i");

              }, child: const Text("Insert",style: TextStyle(color: Colors.white),),color: Colors.blueGrey,),


              FlatButton(onPressed: () async{
                List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
                print("Query rows : $queryRows");

              }, child: const Text("Query",style: TextStyle(color: Colors.white),),color: Colors.green),


              FlatButton(onPressed: () async{
                int updatedId = await  DatabaseHelper.instance.update({
                  DatabaseHelper.comlumnName: "Injamul",
                  DatabaseHelper.columnId: 2
                });
                print("Updated Id : $updatedId");

              }, child: const Text("Update",style: TextStyle(color: Colors.white),),color: Colors.lightBlue),


              FlatButton(onPressed: (){}, child: const Text("Delete",style: TextStyle(color: Colors.white),),color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
