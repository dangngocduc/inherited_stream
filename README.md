# Inherited Stream

[![Pub](https://img.shields.io/pub/v/inherited_stream.svg)](https://pub.dev/packages/inherited_stream)
[![build](https://github.com/felangel/inherited_stream/workflows/build/badge.svg)](https://github.com/felangel/inherited_stream/actions)
[![coverage](https://raw.githubusercontent.com/felangel/inherited_stream/main/coverage_badge.svg)](https://github.com/felangel/inherited_stream/actions)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

An InheritedWidget for Streams, which updates its dependencies when the Stream emits.

## Usage

### Create an Cubit

```dart
class ProgressCubit extends Cubit<double> {
  static const TAG = 'ProgressCubit';
  ProgressCubit(double state) : super(state);
  
  void add(double value) {
    emit(value);
  }
}
```
### Insert into the Widget Tree

```dart
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
```

### Register Dependant(s)

```dart
class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: context.watch<double, ProgressCubit>(), 
      strokeWidth: 8,
    );
  }
}

```
