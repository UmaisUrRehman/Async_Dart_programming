import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const AsyncLearningApp());
}

/// ============================================================
/// MAIN APP
/// ============================================================

class AsyncLearningApp extends StatelessWidget {
  const AsyncLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dart Asynchronous Programming',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const AsyncLearningScreen(),
    );
  }
}

/// ============================================================
/// MAIN SCREEN
/// ============================================================

class AsyncLearningScreen extends StatefulWidget {
  const AsyncLearningScreen({super.key});

  @override
  State<AsyncLearningScreen> createState() =>
      _AsyncLearningScreenState();
}

class _AsyncLearningScreenState
    extends State<AsyncLearningScreen> {
  // ----------------------------------------------------------
  // FUTURE VARIABLES
  // ----------------------------------------------------------

  String futureOutput = 'Press "Run Future" to start.';
  bool futureLoading = false;

  // ----------------------------------------------------------
  // ASYNC/AWAIT VARIABLES
  // ----------------------------------------------------------

  String asyncOutput =
      'Press "Run Async/Await" to start.';
  bool asyncLoading = false;

  // ----------------------------------------------------------
  // STREAM VARIABLES
  // ----------------------------------------------------------

  final List<String> streamOutput = [];

  StreamSubscription<int>? streamSubscription;

  bool streamRunning = false;

  // ----------------------------------------------------------
  // ERROR HANDLING VARIABLES
  // ----------------------------------------------------------

  String errorOutput =
      'No error has been generated yet.';
  bool errorLoading = false;

  // ==========================================================
  // FUTURE EXAMPLE
  // ==========================================================

  Future<String> fetchUserData() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    return 'User data received successfully!';
  }

  Future<void> runFutureExample() async {
    setState(() {
      futureLoading = true;
      futureOutput = 'Waiting for Future to complete...';
    });

    final result = await fetchUserData();

    if (!mounted) return;

    setState(() {
      futureLoading = false;
      futureOutput = result;
    });
  }

  // ==========================================================
  // ASYNC / AWAIT EXAMPLE
  // ==========================================================

  Future<String> performLogin() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return 'Login operation completed successfully!';
  }

  Future<void> runAsyncAwaitExample() async {
    setState(() {
      asyncLoading = true;
      asyncOutput = 'Processing login...';
    });

    final result = await performLogin();

    if (!mounted) return;

    setState(() {
      asyncLoading = false;
      asyncOutput = result;
    });
  }

  // ==========================================================
  // STREAM EXAMPLE
  // ==========================================================

  Stream<int> numberStream() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(
        const Duration(seconds: 1),
      );

      yield i;
    }
  }

  void startStream() {
    streamSubscription?.cancel();

    setState(() {
      streamOutput.clear();
      streamRunning = true;
      streamOutput.add('Stream started...');
    });

    streamSubscription = numberStream().listen(
          (value) {
        if (!mounted) return;

        setState(() {
          streamOutput.add(
            'Received value: $value',
          );
        });
      },
      onError: (error) {
        if (!mounted) return;

        setState(() {
          streamOutput.add(
            'Stream error: $error',
          );
        });
      },
      onDone: () {
        if (!mounted) return;

        setState(() {
          streamOutput.add(
            'Stream completed successfully.',
          );

          streamRunning = false;
        });
      },
    );
  }

  // ==========================================================
  // TRY-CATCH ERROR HANDLING
  // ==========================================================

  Future<void> runErrorHandlingExample() async {
    setState(() {
      errorLoading = true;
      errorOutput = 'Executing operation...';
    });

    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );

      // Intentionally generate an error
      throw Exception(
        'Server connection failed!',
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorLoading = false;
        errorOutput =
        'Error caught successfully:\n$error';
      });
    }
  }

  // ==========================================================
  // RESET ALL
  // ==========================================================

  void resetAll() {
    streamSubscription?.cancel();

    setState(() {
      futureOutput =
      'Press "Run Future" to start.';
      futureLoading = false;

      asyncOutput =
      'Press "Run Async/Await" to start.';
      asyncLoading = false;

      streamOutput.clear();
      streamRunning = false;

      errorOutput =
      'No error has been generated yet.';
      errorLoading = false;
    });
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  // ==========================================================
  // SECTION HEADER
  // ==========================================================

  Widget sectionHeader({
    required String number,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // OUTPUT BOX
  // ==========================================================

  Widget outputBox({
    required String output,
    required bool loading,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'OUTPUT',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 5),
                if (loading)
                  const Row(
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('Processing...'),
                    ],
                  )
                else
                  Text(
                    output,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ACTION BUTTON
  // ==========================================================

  Widget actionButton({
    required String text,
    required VoidCallback? onPressed,
    required IconData icon,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // FEATURE CARD
  // ==========================================================

  Widget featureCard({
    required Widget child,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );
  }

  // ==========================================================
  // BUILD UI
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Async Programming in Dart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: resetAll,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ==================================================
            // INTRODUCTION
            // ==================================================

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.code,
                      size: 50,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Dart Asynchronous Programming',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Interactive learning demonstration of '
                          'Future, async/await, Stream, and '
                          'try-catch error handling.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // FUTURE
            // ==================================================

            featureCard(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  sectionHeader(
                    number: '1',
                    title: 'Future',
                    description:
                    'A Future represents a value that '
                        'will become available later. '
                        'This example simulates fetching '
                        'user data from a server.',
                  ),

                  const SizedBox(height: 16),

                  actionButton(
                    text: 'Run Future',
                    icon: Icons.play_arrow,
                    onPressed:
                    futureLoading
                        ? null
                        : runFutureExample,
                  ),

                  const SizedBox(height: 12),

                  outputBox(
                    output: futureOutput,
                    loading: futureLoading,
                    icon: Icons.cloud_download,
                  ),
                ],
              ),
            ),

            // ==================================================
            // ASYNC / AWAIT
            // ==================================================

            featureCard(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  sectionHeader(
                    number: '2',
                    title: 'Async / Await',
                    description:
                    'The async keyword allows a function '
                        'to perform asynchronous work, while '
                        'await waits for a Future to complete '
                        'without blocking the application.',
                  ),

                  const SizedBox(height: 16),

                  actionButton(
                    text: 'Run Async / Await',
                    icon: Icons.play_arrow,
                    onPressed:
                    asyncLoading
                        ? null
                        : runAsyncAwaitExample,
                  ),

                  const SizedBox(height: 12),

                  outputBox(
                    output: asyncOutput,
                    loading: asyncLoading,
                    icon: Icons.sync,
                  ),
                ],
              ),
            ),

            // ==================================================
            // STREAM
            // ==================================================

            featureCard(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  sectionHeader(
                    number: '3',
                    title: 'Stream',
                    description:
                    'A Stream provides multiple asynchronous '
                        'values over time. This example emits '
                        'numbers from 1 to 10, one value per second.',
                  ),

                  const SizedBox(height: 16),

                  actionButton(
                    text: streamRunning
                        ? 'Stream Running...'
                        : 'Start Stream',
                    icon: Icons.play_arrow,
                    onPressed:
                    streamRunning
                        ? null
                        : startStream,
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    height: 260,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                      BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: streamOutput.isEmpty
                        ? const Center(
                      child: Text(
                        'Stream output will appear here.',
                      ),
                    )
                        : ListView.builder(
                      itemCount:
                      streamOutput.length,
                      itemBuilder:
                          (context, index) {
                        final message =
                        streamOutput[index];

                        final bool completed =
                        message.contains(
                          'completed',
                        );

                        return Padding(
                          padding:
                          const EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Icon(
                                completed
                                    ? Icons.check_circle
                                    : Icons.arrow_forward,
                                size: 18,
                                color: completed
                                    ? Colors.green
                                    : Colors.blue,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  message,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // TRY-CATCH
            // ==================================================

            featureCard(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  sectionHeader(
                    number: '4',
                    title: 'Error Handling',
                    description:
                    'The try-catch mechanism allows an '
                        'application to catch exceptions and '
                        'handle errors without crashing.',
                  ),

                  const SizedBox(height: 16),

                  actionButton(
                    text: 'Generate Test Error',
                    icon: Icons.warning_amber,
                    onPressed:
                    errorLoading
                        ? null
                        : runErrorHandlingExample,
                  ),

                  const SizedBox(height: 12),

                  outputBox(
                    output: errorOutput,
                    loading: errorLoading,
                    icon: Icons.error_outline,
                  ),
                ],
              ),
            ),

            // ==================================================
            // LEARNING SUMMARY
            // ==================================================

            Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Learning Summary',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    summaryItem(
                      icon: Icons.schedule,
                      title: 'Future',
                      description:
                      'Handles a single value available later.',
                    ),

                    summaryItem(
                      icon: Icons.sync,
                      title: 'Async / Await',
                      description:
                      'Makes asynchronous code easier to read.',
                    ),

                    summaryItem(
                      icon: Icons.stream,
                      title: 'Stream',
                      description:
                      'Handles multiple values over time.',
                    ),

                    summaryItem(
                      icon: Icons.error_outline,
                      title: 'Try-Catch',
                      description:
                      'Handles exceptions safely.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Dart Asynchronous Programming • Flutter Learning Project',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SUMMARY ITEM
  // ==========================================================

  Widget summaryItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}