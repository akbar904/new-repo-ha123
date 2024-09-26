
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/widgets/animal_text.dart';

// Mock Cubit for testing
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalText Widget', () {
		late MockAnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon by default', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(text: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: mockAnimalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalText(),
						),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon when state changes', (WidgetTester tester) async {
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([
					AnimalState(text: 'Cat', icon: Icons.access_time),
					AnimalState(text: 'Dog', icon: Icons.person),
				]),
				initialState: AnimalState(text: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: mockAnimalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalText(),
						),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
