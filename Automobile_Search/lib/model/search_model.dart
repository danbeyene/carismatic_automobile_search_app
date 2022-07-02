import 'package:carismatic/constants/constant.dart';

class SearchModel {
  late String name;
  late String model;
  late String date;
  late String brand;
  late String imageURL;

  SearchModel({required this.name, required this.brand, required this.model, required this.date, required this.imageURL});
}

List<SearchModel> searchData =[
  SearchModel(
      name: "The 2020 BMW 5 Series",
      model: "5 Series",
      imageURL: "https://cdn.dlron.us/static/dealer-12223/Buyers_Guide/2019bmw5seriesbuyersguide.jpg",
      brand: "BMW",
      date: "2020-04-17"
  ),
  SearchModel(
      name: "The 2020 BMW 4 Series",
      model: "4 Series",
      imageURL: "https://cdn.dlron.us/static/dealer-12223/Buyers_Guide/20204seriesbuyersguide.jpg",
      brand: "BMW",
      date: "2020-04-17"
  ),
  SearchModel(
      name: "2020 Mercedes-Benz GLA 250",
      model: "GLA 250",
      imageURL: "https://cdn.dlron.us/static/dealer-12724/2019/GLA_250_Buyers_Guide_Edit.png",
      brand: "Mercedes-Benz",
      date: "2020-04-17"
  ),
  SearchModel(
      name: "2020 Mercedes-Benz CLA 250",
      model: "CLA 250",
      imageURL: "https://cdn.dlron.us/static/dealer-12724/images/2020_CLA_250_coupe_buyers_guide_edit.jpg",
      brand: "Mercedes-Benz",
      date: "2020-04-17"
  )

];