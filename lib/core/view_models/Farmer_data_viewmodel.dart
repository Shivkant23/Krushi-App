

import 'package:farmer_app/core/models/farmer_data.dart';
import 'package:flutter/cupertino.dart';

class FarmerDataViewModel extends ChangeNotifier{
  List<FarmerData> _listOfFarmers = [
    FarmerData(
      fullName: "Shivkant Sawarkar",
      gender: "Male",
      address: "Pune",
      plotArea: 3.12,
      crop: "Wheat",
      variety: "Malvani",
      plantingDate: "24-5-2022",
      ageOfCrop: 123
    ),
    FarmerData(
      fullName: "Akash Sawarkar",
      gender: "Male",
      address: "Mumbai",
      plotArea: 5.12,
      crop: "Rice",
      variety: "Basmati",
      plantingDate: "25-5-2022",
      ageOfCrop: 50
    ),
    FarmerData(
      fullName: "Akshay Sawarkar",
      gender: "Male",
      address: "Amravti",
      plotArea: 10.12,
      crop: "Rice",
      variety: "Masuri",
      plantingDate: "28-5-2022",
      ageOfCrop: 75
    ),
    FarmerData(
      fullName: "Amita Sawarkar",
      gender: "Female",
      address: "Nagpur",
      plotArea: 13.12,
      crop: "Moong",
      variety: "Chapha",
      plantingDate: "31-5-2022",
      ageOfCrop: 100
    ),
  ];
  List<FarmerData> _tempFarmers = [];
  List<FarmerData> get getListOfFarmers => _listOfFarmers;
  bool isEditing = false;
  bool get getIsEditing => isEditing;

  void setIsEditing(bool edit){
    isEditing = edit;
    notifyListeners();
  }

  void setListOfFarmers(){
    _tempFarmers = _listOfFarmers;
    notifyListeners();
  }

  void addFarmerInList(FarmerData farmer){
    _listOfFarmers.add(farmer);
    _tempFarmers = _listOfFarmers;
    notifyListeners();
  }

  void updateFarmerInList(FarmerData farmer){
    _listOfFarmers[_listOfFarmers.indexWhere((element) => element.fullName == farmer.fullName)] = farmer;
    notifyListeners();
  }

  void removeFarmer(FarmerData farmer){
    _listOfFarmers.removeWhere((item) => item.fullName == farmer.fullName);
    notifyListeners();
  }
  

  void farmerNameSearch(String name) {
    if (name.isEmpty) {
      _listOfFarmers = _tempFarmers;
    } else {
      _listOfFarmers = _tempFarmers
          .where((element) =>
              element.fullName.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}