class Variant {
  String? id;
  String? name;

  String? typeId;
  String? value;
  int? priceChange;

  Variant(
    this.id,
    this.name,
    this.typeId,
    this.value,
    this.priceChange,
  );

  factory Variant.fromJson(Map<String, dynamic> jsonmapObject) {
    return Variant(
      jsonmapObject['id'],
      jsonmapObject['name'],
      jsonmapObject['type_id'],
      jsonmapObject['value'],
      jsonmapObject['price_change'],
    );
  }
}
