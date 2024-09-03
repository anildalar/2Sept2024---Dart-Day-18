//1 Import aread
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

//THis module will provide the defination for jsonDecode() jsonEncode()
import 'dart:convert'; // Import this package for JSON decoding

//Entry function
//
//
/*
ReturnType function(){
  //Function Body
  //Every statement is terminated by semi-colon;
  //Every function may return some
}
*/
void main() async {
  await dotenv.load(fileName: ".env"); // Load .env file

  print('Hello Anil');
  var ceo1 = Anil();
  runApp(ceo1);
}

class Anil extends StatelessWidget {
  //1. Property/Variable/State
  //var name = "Anil"; // StatelessWidget is a Immuutable class

  //2. Constructor
  Anil() {
    print("Hello from Anil Constructor");
  }

  //3. Method/Function
  @override // @override Annotation is not mandatory
  //ReturnType method(VariableType formalArgument){ FunctionBody }
  Widget build(BuildContext context) {
    //Every method may return something

    //I have to return an object of WidgetClass
    var ceo2 = MaterialApp(
      home: MyClass(),
    );
    return ceo2;
  }
}

//1. Class Defination
class MyClass extends StatefulWidget {
  //1. Property/Variable/State

  //2. Constructor

  //3. Method
  @override // @override Annotation is not mandatory
  //ReturnType method(VariableType Variable/FormalArgumetn){ FunctionBody}
  State<MyClass> createState() {
    //Every function may return someintg
    return _MyClassState();
  }
}

class _MyClassState extends State<MyClass> {
  //1. Property/Variable/State
  var name = "Anil"; // "String"
  var favFruits = []; //[List]

  //2. Constrcturo

  //3. Method
  initState() {
    //super.initState();
    print('Hello from initState');

    // I want to call the api after the page reload
    //2 method Calling
    getMyFavFruits();
  }

  //1. Method defination
  Future<void> getMyFavFruits() async {
    //async = paretn
    // I want to call the api here
    // await = child
    var baseUrl = dotenv.get('BASE_URL');
    print(baseUrl);
    var response = await http.get(Uri.parse('${baseUrl}/api/fav-fruits'));

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      print('The datatype of response.body is: ${response.body.runtimeType}');

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var fruitsData = jsonResponse['data'];

      // Extract fruit names and update favFruits list
      setState(() {
        favFruits = fruitsData
            .map<String>((fruit) => fruit['attributes']['name'])
            .toList();
      });

      print('Favorite Fruits: $favFruits');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: favFruits.length,
            itemBuilder: (context, index) =>
                ListTile(title: Text(favFruits[index]))));
  }
}
