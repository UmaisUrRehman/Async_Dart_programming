import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const AsyncLearningApp());
}

class AsyncLearningApp extends StatelessWidget {
  const AsyncLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Async Dart Learning',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const AsyncDemoScreen(),
    );
  }
}

class AsyncDemoScreen extends StatefulWidget {
  const AsyncDemoScreen({super.key});

  @override
  State<AsyncDemoScreen> createState() => _AsyncDemoScreenState();
}

class _AsyncDemoScreenState extends State<AsyncDemoScreen> {
  String futureResult = "Not Started";
  String asyncAwaitResult = "Not Started";
  String errorResult = "No Error Yet";

  final List<String> streamValues = [];

  StreamSubscription<int>? subscription;

  /// -----------------------------------------
  /// FUTURE DEMO
  /// -----------------------------------------
  Future<String> fetchFutureData() {
    return Future.delayed(
      const Duration(seconds: 3),
          () => "Future completed successfully!",
    );
  }

  Future<void> runFutureExample() async {
    setState(() {
      futureResult = "Loading...";
    });

    String result = await fetchFutureData();

    setState(() {
      futureResult = result;
    });
  }

  /// -----------------------------------------
  /// ASYNC AWAIT DEMO
  /// -----------------------------------------
  Future<void> runAsyncAwaitExample() async {
    setState(() {
      asyncAwaitResult = "Processing...";
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      asyncAwaitResult =
      "Task completed using async/await";
    });
  }

  /// -----------------------------------------
  /// STREAM DEMO
  /// -----------------------------------------
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(
        const Duration(seconds: 1),
      );

      yield i;
    }
  }

  void startStream() {
    streamValues.clear();

    subscription?.cancel();

    subscription = numberStream().listen(
          (value) {
        setState(() {
          streamValues.add(
            "Received Value: $value",
          );
        });
      },
      onDone: () {
        setState(() {
          streamValues.add("Stream Closed");
        });
      },
    );
  }

  /// -----------------------------------------
  /// TRY CATCH DEMO
  /// -----------------------------------------
  Future<void> runErrorExample() async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
      );

      throw Exception(
        "Server Connection Failed",
      );
    } catch (e) {
      setState(() {
        errorResult = e.toString();
      });
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Widget buildCard({
    required String title,
    required String content,
    required VoidCallback onPressed,
    required String buttonText,
  }) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Async Programming in Dart",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            /// FUTURE
            buildCard(
              title: "Future Example",
              content: futureResult,
              buttonText: "Run Future",
              onPressed: runFutureExample,
            ),

            /// ASYNC AWAIT
            buildCard(
              title: "Async / Await Example",
              content: asyncAwaitResult,
              buttonText: "Run Async Await",
              onPressed: runAsyncAwaitExample,
            ),

            /// ERROR HANDLING
            buildCard(
              title: "Try Catch Example",
              content: errorResult,
              buttonText: "Generate Error",
              onPressed: runErrorExample,
            ),

            /// STREAM
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Stream Example",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: startStream,
                      child: const Text(
                        "Start Stream",
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      height: 250,
                      width: double.infinity,
                      padding:
                      const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                        BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        itemCount:
                        streamValues.length,
                        itemBuilder:
                            (context, index) {
                          return ListTile(
                            leading:
                            const Icon(
                              Icons.stream,
                            ),
                            title: Text(
                              streamValues[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Learning Objectives:\n"
                  "• Future\n"
                  "• Async/Await\n"
                  "• Stream\n"
                  "• Try-Catch Error Handling\n"
                  "• Real-time UI Updates",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}