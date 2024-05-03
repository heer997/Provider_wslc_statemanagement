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
      create: (create) {
        return CounterProvider();
      },
      child: MaterialApp(
        title: "Provider Counter App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const CounterAppProvider(),
      ),
    );
  }
}

class CounterAppProvider extends StatefulWidget {
  const CounterAppProvider({super.key});

  @override
  State<CounterAppProvider> createState() {
    return CounterAppProviderState();
  }
}

class CounterAppProviderState extends State<CounterAppProvider> {
  @override
  Widget build(BuildContext context) {
    print("Build method called...");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Counter App with Provider",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().increment();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 20.0),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().decrement();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.remove, color: Colors.white, size: 30.0),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().setZero();
            },
            backgroundColor: Colors.brown,
            child:
                const Icon(Icons.lock_clock, color: Colors.white, size: 30.0),
          ),
        ],
      ),
      body: Consumer<CounterProvider>(
        builder: (context, value, child) {
          return Center(
            child: Text(
              value.count.toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0),
            ),
          );
        },
      ),
    );
  }
}
