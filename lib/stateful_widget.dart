import 'package:flutter/material.dart';
import 'package:flutter_practice/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DummyStateFulWidget extends ConsumerStatefulWidget {
  const DummyStateFulWidget({super.key});

  @override
  ConsumerState<DummyStateFulWidget> createState() =>
      _DummyStateFulWidgetState();
}

class _DummyStateFulWidgetState extends ConsumerState<DummyStateFulWidget> {
  late String name;
  final starsController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // name = ref.read(dynamicNameProvider.notifier).state;
  }

  void dynamicNameUpdateOnTap() {
    String val = starsController.text;
    ref.read(dynamicNameProvider.notifier).update((state) => val);
  }

  @override
  Widget build(BuildContext context) {
    name = ref.watch(dynamicNameProvider);
    print('rebuilt dummy stateful widget');
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Names of Stars'),
            const SizedBox(
              width: 10.0,
            ),
            Column(children: [Text(name), const Text('Sarah muazzam')]),
          ],
        ),
        TextField(
          controller: starsController,
          onTapOutside: (event) => dynamicNameUpdateOnTap(),
        ),
      ],
    );
  }
}
