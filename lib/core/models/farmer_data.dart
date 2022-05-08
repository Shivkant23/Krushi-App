class FarmerData{
  int? id;
  late String fullName;
  late String gender;
  late String address;
  late double plotArea;
  late String crop;
  late String variety;
  late String plantingDate;
  late int ageOfCrop;

  FarmerData({
    this.id,
    required this.fullName,
    required this.gender,
    required this.address,
    required this.plotArea,
    required this.crop,
    required this.variety,
    required this.plantingDate,
    required this.ageOfCrop
  });

  FarmerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    gender = json['gender'];
    address = json['address'];
    plotArea = json['plotArea'];
    crop = json['crop'];
    variety = json['variety'];
    plantingDate = json['plantingDate'];
    ageOfCrop = json['ageOfCrop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['address'] = address;
    data['plotArea'] = plotArea;
    data['crop'] = crop;
    data['variety'] = variety;
    data['plantingDate'] = plantingDate;
    data['ageOfCrop'] = ageOfCrop;
    return data;
  }
}