import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/random_number_bloc.dart';
import 'bloc/random_number_event.dart';
import 'custom_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(AppView()),
    storage: storage,
  );
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomNumberGeneratorPage(),
    );
  }
}

class RandomNumberGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RandomNumberBloc>(
      create: (_) => RandomNumberBloc(),
      child: RandomNumberView(),
    );
  }
}

class RandomNumberView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Container(
        decoration: BoxDecoration(color: ThemeData().primaryColor),
        child: Center(
          child: BlocBuilder<RandomNumberBloc, int>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$state',
                      style: textTheme.headline2?.copyWith(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(
                    height: 50,
                  ),
                  Button(
                    title: "Random Number",
                    action: () {
                      context
                          .read<RandomNumberBloc>()
                          .add(GenerateRandomNumber(max: 20, min: 1));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    title: "Reset",
                    action: () {
                      context.read<RandomNumberBloc>().add(ResetRandomNumber());
                      HydratedBlocOverrides.current?.storage.clear();
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
