import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';
import '../models/plant_model.dart';

// This is the concrete implementation of the PlantRepository.
// It depends on an instance of FirebaseFirestore.
class PlantRepositoryImpl implements PlantRepository {
  final FirebaseFirestore _firestore;

  // The constructor requires an instance of Firestore.
  PlantRepositoryImpl(this._firestore);

  @override
  Stream<List<Plant>> getAllPlants() {
    return _firestore.collection('plants').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PlantModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Stream<Plant> getPlantById(String id) {
    return _firestore.collection('plants').doc(id).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        throw Exception('Plant with ID $id not found');
      }
      return PlantModel.fromFirestore(snapshot);
    });
  }
}