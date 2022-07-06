import 'package:carismatic/constants/constant.dart';

class SearchModel {
  late String name;
  late String model;
  late String date;
  late String brand;

  SearchModel({required this.name, required this.model, required this.date,required this.brand});
}

List<SearchModel> searchData =[
  SearchModel(
      name: "The 2020 BMW 5 Series",
      model: "5 Series",
      brand: "BMW",
      date: "2020-04-17"
  ),
  SearchModel(
      name: "The 2020 BMW 4 Series",
      model: "4 Series",
      brand: "BMW",
      date: "2020-04-17"
  ),
  SearchModel(
      name: "2020 Mercedes-Benz GLA 250",
      model: "GLA 250",
      brand: "Mercedes-Benz",
      date: "2020-04-17"
  ),
  SearchModel(
      name: "2020 Mercedes-Benz CLA 250",
      model: "CLA 250",
      brand: "Mercedes-Benz",
      date: "2020-04-17"
  )

];