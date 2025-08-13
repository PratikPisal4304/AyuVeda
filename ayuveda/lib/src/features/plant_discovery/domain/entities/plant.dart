
// Represents the core properties of a plant in the app.
class Plant {
  final String id;
  final String commonName;
  final String scientificName;
  final String description;
  final String imageUrl;
  final Map<String, String> properties;
  final List<String> partsUsed;
  final List<String> ailmentsTreated;
  final String usage;
  final String warnings;

  const Plant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.description,
    required this.imageUrl,
    required this.properties,
    required this.partsUsed,
    required this.ailmentsTreated,
    required this.usage,
    required this.warnings,
  });
}