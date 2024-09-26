
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:animal_switcher/models/animal_model.dart';

void main() {
	group('AnimalModel', () {
		test('should create an AnimalModel instance with given text and icon', () {
			final animal = AnimalModel(text: 'Cat', icon: Icons.access_time);
			expect(animal.text, 'Cat');
			expect(animal.icon, Icons.access_time);
		});

		test('should serialize AnimalModel to JSON', () {
			final animal = AnimalModel(text: 'Dog', icon: Icons.person);
			final json = animal.toJson();
			expect(json['text'], 'Dog');
			expect(json['icon'], Icons.person.codePoint);
		});

		test('should deserialize AnimalModel from JSON', () {
			final json = {'text': 'Cat', 'icon': Icons.access_time.codePoint};
			final animal = AnimalModel.fromJson(json);
			expect(animal.text, 'Cat');
			expect(animal.icon, Icons.access_time);
		});
	});
}
