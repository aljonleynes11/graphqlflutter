import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';
import 'repository/graphql_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(create: (context)=>HomeBloc(graphql: GraphQLService()),
      child: MyHomePage(title : 'testapp'),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeBloc homeBloc;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(FetchHomeEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context,state){
        if(state is HomeLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(state is HomeLoaded){
          return Center(child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
              for(var country in state.country.countries)
              Container(
                padding: EdgeInsets.all(10),
                child: Text(country.name + ' - ' + country.capital.toString()),)
            ],),
          ),);
        }
        else if(state is HomeError){
          return Center(child: Text(state.message));
        }
        else{
          return Center(child: Text('else'));
        }
      },)

    );
  }
}
