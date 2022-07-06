class Automobile {
  final String name;
  final String model;
  final String date;
  final String brand;

  Automobile(this.name,this.model, this.date, this.brand);

  factory Automobile.fromJson(Map<String, dynamic> json) {
    return Automobile(
        json["name"],
        json["model"],
        json["date"],
        json["brand"],
    );
  }
}