class Automobile {
  final String name;
  final String model;
  final String date;
  final String brand;
  final String imageURL;
  final int price;

  Automobile(this.name, this.brand, this.model, this.date, this.imageURL, this.price);

  factory Automobile.fromJson(Map<String, dynamic> json) {
    return Automobile(
        json["name"],
        json["model"],
        json["date"],
        json["brand"],
        json["imageURL"],
        json["price"]
    );
  }
}