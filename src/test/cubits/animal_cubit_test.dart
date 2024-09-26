
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is AnimalState with Cat', () {
			expect(animalCubit.state.text, 'Cat');
			expect(animalCubit.state.icon, Icons.access_time);
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState with Dog] when toggleAnimal is called',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				isA<AnimalState>().having((state) => state.text, 'text', 'Dog').having((state) => state.icon, 'icon', Icons.person),
			],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState with Cat] when toggleAnimal is called twice',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal(); // First toggle to Dog
				cubit.toggleAnimal(); // Second toggle back to Cat
			},
			expect: () => [
				isA<AnimalState>().having((state) => state.text, 'text', 'Dog').having((state) => state.icon, 'icon', Icons.person),
				isA<AnimalState>().having((state) => state.text, 'text', 'Cat').having((state) => state.icon, 'icon', Icons.access_time),
			],
		);
	});
}
