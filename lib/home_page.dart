import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_example/home_page_controller.dart';

import 'home_states.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController();
  late final ReactionDisposer disposer;
  @override
  void initState() {
    super.initState();
    disposer = reaction<HomeState>(
      (_) => controller.state,
      (state) {
        if (state is HomeLoadingState) {
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else if (state is HomeErrorState) {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const Center(
                child: Text('opss deu erro'),
              );
            },
          );
        } else if (state is HomeSuccessState) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(builder: (context) {
              return Text(
                '${controller.counter}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
