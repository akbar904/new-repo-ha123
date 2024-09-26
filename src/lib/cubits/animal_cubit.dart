
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../models/animal_model.dart';

class AnimalState {
	final String text;
	final IconData icon;

	const AnimalState({required this.text, required this.icon});
}

class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(const AnimalState(text: 'Cat', icon: Icons.access_time));

	void toggleAnimal() {
		if (state.text == 'Cat') {
			emit(const AnimalState(text: 'Dog', icon: Icons.person));
		} else {
			emit(const AnimalState(text: 'Cat', icon: Icons.access_time));
		}
	}
}
