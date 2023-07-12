import 'package:flutter/material.dart';
import 'package:flutter_practice/stateful_widget.dart';
import 'package:flutter_practice/user.dart';
import 'package:flutter_practice/widgets/user_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

//Provider
final nameProvider = Provider((ref) => 'Ali Muazzam');

//StateProvider
final dynamicNameProvider = StateProvider((ref) => 'Ali Muazzam');

//UserStateNotifier
final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, User>(
        (ref) => UserStateNotifier());

//ChangeNotifier
final userChangeNotifierProvider =
    ChangeNotifierProvider<UserChangeNotifier>((ref) => UserChangeNotifier());

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  initState() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = ref.read(nameProvider);
    return MaterialApp(
      title: 'Flutter Demo $name',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo $name'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // For state notifier
  textUpdateOnSubmit(WidgetRef ref, String name) {
    ref.read(userStateNotifierProvider.notifier).updateName(name);
  }

  // For change notifier
  textUpdateViaChangeNotifierOnSubmit(WidgetRef ref, String email) {
    //we don't need notifier in changeNotifier
    ref.read(userChangeNotifierProvider).updateEmail(email);

    //and secondly this the only provider which is mutable
    final user = ref.read(userChangeNotifierProvider).user;
    ref.read(userChangeNotifierProvider).user = user.copyWith(email: email);
    // ref.read(userChangeNotifierProvider).user = User('', '', 0, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const DummyStateFulWidget(),
            TextField(
              onSubmitted: (value) => textUpdateOnSubmit(ref, value),
            ),
            Consumer(
              builder: (context, ref, child) {
                var user = ref.watch(userStateNotifierProvider);
                print('rebuilt a mini widget');
                return Text(user.name);
              },
            ),
            TextField(
              onSubmitted: (value) =>
                  textUpdateViaChangeNotifierOnSubmit(ref, value),
            ),
            Consumer(
              builder: (context, ref, child) {
                var user = ref.watch(userChangeNotifierProvider);
                print('rebuilt a mini widget');
                return Text(user.user.email);
              },
            ),
            const UserDetails(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
