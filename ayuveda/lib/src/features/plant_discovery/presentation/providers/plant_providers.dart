import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/plant_repository_impl.dart';
import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';

// 1. Provider for the Firestore instance
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// 2. Provider for the PlantRepository implementation
// This uses the firestoreProvider to create an instance of our repository
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return PlantRepositoryImpl(firestore);
});

// 3. StreamProvider to get all plants
// The UI will watch this provider to get a real-time list of plants
final allPlantsProvider = StreamProvider<List<Plant>>((ref) {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.getAllPlants();
});

// 4. StreamProvider.family to get a single plant by its ID
// The ".family" modifier allows us to pass a parameter (the plant's ID)
final plantByIdProvider = StreamProvider.family<Plant, String>((ref, id) {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.getPlantById(id);
});