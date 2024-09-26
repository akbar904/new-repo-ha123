
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders AnimalText with initial state Cat', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});

	group('AnimalCubit', () {
		late AnimalCubit animalCubit;
		
		setUp(() {
			animalCubit = AnimalCubit();
		});
		
		blocTest<AnimalCubit, AnimalState>(
			'emits Dog state after toggleAnimal is called',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(text: 'Dog', icon: Icons.person)],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits Cat state after toggleAnimal is called twice',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal();
				cubit.toggleAnimal();
			},
			expect: () => [
				AnimalState(text: 'Dog', icon: Icons.person),
				AnimalState(text: 'Cat', icon: Icons.access_time),
			],
		);
	});

	group('AnimalText', () {
		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			await tester.pumpWidget(BlocProvider(
				create: (_) => AnimalCubit(),
				child: MaterialApp(home: AnimalText()),
			));
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after tap', (WidgetTester tester) async {
			await tester.pumpWidget(BlocProvider(
				create: (_) => AnimalCubit(),
				child: MaterialApp(home: AnimalText()),
			));
			await tester.tap(find.text('Cat'));
			await tester.pump();
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
