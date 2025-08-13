import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/plant_providers.dart';

class PlantDetailScreen extends ConsumerWidget {
  final String plantId;

  const PlantDetailScreen({
    super.key,
    required this.plantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider for the specific plant using its ID
    final plantAsyncValue = ref.watch(plantByIdProvider(plantId));

    return Scaffold(
      appBar: AppBar(),
      body: plantAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (plant) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plant Name
                Text(
                  plant.commonName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  plant.scientificName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),

                // Plant Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    plant.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),

                // Description Section
                Text("Description", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(plant.description),
                const Divider(height: 40),

                // Properties Section
                Text("Properties", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                ...plant.properties.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '${entry.key}: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: entry.value),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}