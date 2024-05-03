import "dart:async";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:provider_wslc_statemanagement/providers/counterprovider.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CounterProvider();
      },
      child: MaterialApp(
        title: "Counter App with Provider State Management",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const CounterAppTwo(),
      ),
    );
  }
}

class CounterAppTwo extends StatefulWidget {
  const CounterAppTwo({super.key});

  @override
  State<CounterAppTwo> createState() => _CounterAppTwoState();
}

class _CounterAppTwoState extends State<CounterAppTwo> {
  @override
  void initState() {
    super.initState();
    final counter = Provider.of<CounterProvider>(context, listen: false);
    print("Timer");
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        counter.increment();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// By applying listen: false, only Consumer widget will rebuild every time as shown below
    /// otherwise build() method will call every time in case of listen: true (by default)
    final counter = Provider.of<CounterProvider>(context, listen: false);
    print("Build Method called");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Counter App with Provider",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CounterProvider>(
        builder: (context, value, child) {
          /// Here, only below Text() widget will rebuilding...
          print("Consumer...");
          return Center(
            child: Text(
              value.count.toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counter.increment();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 20.0),
          FloatingActionButton(
            onPressed: () {
              counter.decrement();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.remove, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 20.0),
          FloatingActionButton(
            onPressed: () {
              counter.setZero();
            },
            backgroundColor: Colors.brown,
            child:
                const Icon(Icons.lock_clock, color: Colors.white, size: 30.0),
          ),
        ],
      ),
    );
  }
}
