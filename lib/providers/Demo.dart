import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main()
{
  runApp(const MyApp());
}
class Counter with ChangeNotifier
{
  int _count = 0;

  void increment()
  {
    _count++;
    notifyListeners();
  }
  void decrement()
  {
    _count--;
    notifyListeners();
  }
}
class MyApp extends StatelessWidget
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Counter();
      },
      child: MaterialApp(
        title: "Provider Counter App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const HomePage(),
      ),
    );
  }
}
class HomePage extends StatelessWidget
{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    print("Build method called...");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider CounterApp"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Counter Value",
              style: Theme.of(context).textTheme.apply(fontSizeFactor: 1.1).headlineLarge,
            ),
            const SizedBox(height: 40.0),
            Text("${counter._count}",
                style: Theme.of(context).textTheme.apply(fontSizeFactor: 2.1).headlineLarge),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NextScreen();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(350.0,50.0),
                backgroundColor: Colors.blue,
              ),
              child: Text("Go to next page",
                style: Theme.of(context).textTheme.apply(displayColor: Colors.white).headlineLarge,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              counter.increment();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(width: 20.0),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              counter.decrement();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
class NextScreen extends StatelessWidget
{
  const NextScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    print("Build Method called in NextScreen...");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("This is the Counter Value below : ",
              style: Theme.of(context).textTheme.apply(fontSizeFactor: 1.0).headlineSmall,
            ),
            const SizedBox(height: 30.0),
            Text("${counter._count}",
              style: Theme.of(context).textTheme.apply(fontSizeFactor: 2.2).headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}