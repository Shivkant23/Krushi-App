

import 'package:farmer_app/core/models/farmer_data.dart';
import 'package:farmer_app/core/services/db_helper.dart';
import 'package:flutter/cupertino.dart';

class FarmerDataViewModel extends ChangeNotifier{
  final dbHelper = DatabaseHelper.instance;

  List<FarmerData> _tempFarmers = [
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
  List<FarmerData> _listOfFarmers = [];
  List<FarmerData> _templistOfFarmers = [];
  List<FarmerData> get getListOfFarmers => _listOfFarmers;
  bool isEditing = false;
  bool get getIsEditing => isEditing;

  void setIsEditing(bool edit){
    isEditing = edit;
    notifyListeners();
  }

  Future<List<FarmerData>> setListOfFarmers()async{
    await dbHelper.insertSudoData(_tempFarmers);
    var asd = await dbHelper.queryAllRows();
    asd.map((e) => _listOfFarmers.add(FarmerData.fromJson(e))).toList();
    _templistOfFarmers = _listOfFarmers;
    notifyListeners();
    return _listOfFarmers;
  }

  void addFarmerInList(FarmerData farmer)async{
    try {
      int returnFarmerId = await dbHelper.insert(farmer);
      if(returnFarmerId != null){
        farmer.id = returnFarmerId;
        _listOfFarmers.add(farmer);
      }
      _templistOfFarmers = _listOfFarmers;
    } catch (e) {
      print("e");
    }
    notifyListeners();
  }

  void updateFarmerInList(FarmerData farmer)async{
    try {
      int returnFarmerId = await dbHelper.update(farmer);
      if(returnFarmerId != null){
          _listOfFarmers[_listOfFarmers.indexWhere((element) => element.fullName == farmer.fullName)] = farmer;
      }
      _templistOfFarmers = _listOfFarmers;
    } catch (e) {
      print("e");
    }
    notifyListeners();
  }

  void removeFarmer(int farmerId)async{
    try {
      int returnFarmerId = await dbHelper.delete(farmerId);
      if(returnFarmerId != null){
        _listOfFarmers.removeWhere((item) => item.id == farmerId);
      }
      _templistOfFarmers = _listOfFarmers;
    } catch (e) {
      print("e");
    }
    notifyListeners();
  }
  

  void farmerNameSearch(String name) {
    if (name.isEmpty) {
      _listOfFarmers = _templistOfFarmers;
    } else {
      _listOfFarmers = _templistOfFarmers
          .where((element) =>
              element.fullName.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}