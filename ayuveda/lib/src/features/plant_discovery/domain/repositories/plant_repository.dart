import '../entities/plant.dart';

// This abstract class defines the contract for our plant data source.
// The domain layer depends on this, not on the actual implementation.
abstract class PlantRepository {
  /// Fetches a list of all Ayurvedic plants.
  /// Returns a [Stream] of [List<Plant>] to provide real-time updates.
  Stream<List<Plant>> getAllPlants();

  /// Fetches a single plant by its unique [id].
  /// Returns a [Stream] of [Plant] for real-time updates on a specific plant.
  Stream<Plant> getPlantById(String id);
}