import 'package:flutter/material.dart';

class CountersFunctionScreen extends StatefulWidget {
  const CountersFunctionScreen({super.key});

  @override
  State<CountersFunctionScreen> createState() => _CountersFunctionScreenState();
}

class _CountersFunctionScreenState extends State<CountersFunctionScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Functions"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  counter = 0;
                });
              },
              icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              counter.toString(),
              style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).primaryColor),
            ),
            Text(
              'click${(counter == 1) ? '' : 's'}',
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomFAB(
            icon: Icons.plus_one_rounded,
            onPressed: () {
              setState(() {
                counter++;
              });
            },
          ),
          const SizedBox(height: 10),
          CustomFAB(
            icon: Icons.refresh_rounded,
            onPressed: () {
              setState(() {
                counter = 0;
              });
            },
          ),
          const SizedBox(height: 10),
          CustomFAB(
            icon: Icons.exposure_minus_1_rounded,
            onPressed: () {
              if (counter != 0) {
                setState(() {
                  counter--;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomFAB({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      enableFeedback: true,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
