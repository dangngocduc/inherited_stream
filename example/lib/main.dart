import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:inherited_stream/inherited_cubit.dart';

import 'progress_cubit.dart';
import 'package:inherited_stream/extension.dart';

import 'progress_cubit.dart';

void main() => runApp(MyApp());

/// Root Material App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

/// Home Page which manages the state of the [ValueStream].
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProgressCubit progressCubit = ProgressCubit(0.0);

  @override
  void dispose() {
    progressCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: InheritedCubit<double, ProgressCubit>(
              cubit: progressCubit,
              child: Builder(builder: (context) => Progress())
          ),
        ),

      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              final random = (Random().nextDouble() * 0.1);
              final value = progressCubit.state + random >= 1.0
                  ? 1.0
                  : progressCubit.state + random;
              progressCubit.add(value);
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.clear),
            onPressed: () => progressCubit.add(0),
          ),
        ],
      ),
    );
  }
}

/// StatelessWidget which renders a [CircularProgressIndicator] based
/// on the value of the [ProgressCubit].
class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        value: context.watch<double, ProgressCubit>(),
        strokeWidth: 8
    );
  }
}

