class Automobile {
  final String name;
  final String model;
  final String date;
  final String brand;
  final String imageURL;

  Automobile(this.name, this.brand, this.model, this.date, this.imageURL);

  factory Automobile.fromJson(Map<String, dynamic> json) {
    return Automobile(
        json["name"],
        json["model"],
        json["date"],
        json["brand"],
        json["imageURL"],
    );
  }
}