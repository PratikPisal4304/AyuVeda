import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/plant.dart';

class PlantModel extends Plant {
  const PlantModel({
    required super.id,
    required super.commonName,
    required super.scientificName,
    required super.description,
    required super.imageUrl,
    required super.properties,
    required super.partsUsed,
    required super.ailmentsTreated,
    required super.usage,
    required super.warnings,
  });

  // Factory constructor to create a PlantModel from a Firestore document
  factory PlantModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PlantModel(
      id: doc.id,
      commonName: data['commonName'] ?? 'Unknown',
      scientificName: data['scientificName'] ?? 'Unknown',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      // Safely casting map values to string
      properties: Map<String, String>.from(data['properties'] ?? {}),
      // Safely casting list values to string
      partsUsed: List<String>.from(data['partsUsed'] ?? []),
      ailmentsTreated: List<String>.from(data['ailmentsTreated'] ?? []),
      usage: data['usage'] ?? '',
      warnings: data['warnings'] ?? '',
    );
  }
}