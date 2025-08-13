import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/plant_providers.dart';
import 'plant_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the allPlantsProvider. Riverpod will rebuild this widget
    // when the stream emits new data (loading, data, or error).
    final plantsAsyncValue = ref.watch(allPlantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AyuVeda'),
      ),
      // The .when() method is the cleanest way to handle async states.
      body: plantsAsyncValue.when(
        // State 1: Data is successfully loaded
        data: (plants) {
          if (plants.isEmpty) {
            return const Center(
              child: Text('No plants found in the database.'),
            );
          }
          return ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return ListTile(
                title: Text(plant.commonName),
                subtitle: Text(plant.scientificName, style: const TextStyle(fontStyle: FontStyle.italic)),
                // We'll add navigation to the detail screen here later
                onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PlantDetailScreen(plantId: plant.id),
    ),
  );
}, 
              );
            },
          );
        },
        // State 2: Data is currently loading
        loading: () => const Center(child: CircularProgressIndicator()),
        // State 3: An error occurred
        error: (error, stackTrace) => Center(
          child: Text('An error occurred: $error'),
        ),
      ),
    );
  }
}