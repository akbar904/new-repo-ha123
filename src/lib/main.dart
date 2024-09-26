
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/animal_cubit.dart';
import 'widgets/animal_text.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: BlocProvider(
				create: (_) => AnimalCubit(),
				child: Scaffold(
					appBar: AppBar(
						title: Text('Animal Switcher'),
					),
					body: Center(
						child: AnimalText(),
					),
				),
			),
		);
	}
}
