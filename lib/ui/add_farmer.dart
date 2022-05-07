import 'package:farmer_app/core/models/farmer_data.dart';
import 'package:farmer_app/core/view_models/Farmer_data_viewmodel.dart';
import 'package:farmer_app/utils/colors.dart';
import 'package:farmer_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class AddFarmer extends StatefulWidget {
  static const String id = "add_farmer_screen";
  final FarmerData? farmerData;
  final bool isEditing;
  AddFarmer({Key? key, this.farmerData, required this.isEditing}) : super(key: key);

  @override
  State<AddFarmer> createState() => _AddFarmerState();
}

class _AddFarmerState extends State<AddFarmer> {
  final _formKey = GlobalKey<FormState>(); 
  final FocusNode _nameFocus = FocusNode();
  final nameController = TextEditingController();
  final FocusNode _addressFocus = FocusNode();
  final addressController = TextEditingController();
  final FocusNode _plotAreaFocus = FocusNode();
  final plotAreaController = TextEditingController();
  final FocusNode _cropFocus = FocusNode();
  final cropController = TextEditingController();
  final FocusNode _varietyFocus = FocusNode();
  final varietyController = TextEditingController();
  final plantingDateController = TextEditingController();
  final ageOfCropController = TextEditingController();
  AutovalidateMode autoValidate = AutovalidateMode.onUserInteraction;

  String _gender = "Male";
  String currentSelectedValue = "Wheat";
  DateTime selectedDate = DateTime.now();
  late FarmerDataViewModel farmerProvider;
  var cropList = [
    'Wheat',
    'Rice',
    'Moong',
    'Chana'
  ];

  @override
  void initState() {
    super.initState();
    farmerProvider = Provider.of<FarmerDataViewModel>(context, listen: false);
    farmerProvider.setIsEditing(widget.isEditing);
    if(widget.farmerData != null){
      FarmerData _farmer = widget.farmerData!;
      nameController.text = _farmer.fullName;
      _gender = _farmer.gender;
      currentSelectedValue = _farmer.crop;
      varietyController.text = _farmer.variety;
      plotAreaController.text = _farmer.plotArea.toString();
      plantingDateController.text = _farmer.plantingDate;
      ageOfCropController.text = _farmer.ageOfCrop.toString();
      addressController.text = _farmer.address;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text("Add New Farmer")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              widget.isEditing ? Image.asset('assets/${widget.farmerData!.crop}.jpg'): const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: autoValidate,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "Enter full name*";
                        } else if (val.trim().length < 3) {
                          return "At least 3 characters are required";
                        }
                        return null;
                      },
                      focusNode: _nameFocus,
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full name*',
                      ),
                      inputFormatters:[
                        FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z ]"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Gender", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Radio(
                          value: "Male", 
                          groupValue: _gender,
      
                          onChanged: (value){
                            setState(() {
                              _gender = value.toString();
                            });
                          }
                        ),
                        const Text("Male"),
                        Radio(value: "Female", groupValue: _gender, 
                          onChanged: (value){
                            setState(() {
                              _gender = value.toString();
                            });
                          }
                        ),
                        const Text("Female"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 4,
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    // labelStyle: textStyle,
                                    errorStyle: TextStyle(color: redAccentColor, fontSize: 16.0),
                                    hintText: 'Please select crop type',),
                                isEmpty: currentSelectedValue == '',
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: currentSelectedValue,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        currentSelectedValue = newValue!;
                                      });
                                    },
                                    items: cropList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Enter Plot Area*";
                              }
                              return null;
                            },
                            controller: plotAreaController,
                            decoration: const InputDecoration(
                              labelText: 'Plot Area*',
                            ),
                            inputFormatters:[
                              FilteringTextInputFormatter.deny(
                                RegExp("0-9"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "Enter Variety*";
                        } else if (val.trim().length < 2) {
                          return "At least 3 characters are required";
                        }
                        return null;
                      },
                      focusNode: _varietyFocus,
                      controller: varietyController,
                      decoration: const InputDecoration(
                        labelText: 'Variety',
                      ),
                      inputFormatters:[
                        FilteringTextInputFormatter.deny(
                          RegExp("A-Za-z "),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Enter Planting Date*";
                              }
                              return null;
                            },
                            controller: plantingDateController,
                            decoration: const InputDecoration(
                              labelText: 'Planting Date*',
                            ),
                            inputFormatters:[
                              FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z ]"),
                              ),
                            ],
                            onTap: ()=> _selectDate(context),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            enabled: false,
                            textInputAction: TextInputAction.done,
                            focusNode: _plotAreaFocus,
                            controller: ageOfCropController,
                            decoration: const InputDecoration(
                              labelText: 'Age of Crop(days)*',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 2,
                      maxLength: 100,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "Enter Address*";
                        } else if (val.trim().length < 3) {
                          return "At least 3 characters are required";
                        }
                        return null;
                      },
                      focusNode: _addressFocus,
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address*',
                      ),
                      inputFormatters:[
                        FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z ]"),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            autoValidate = AutovalidateMode.always;
             if (_formKey.currentState!.validate()) {
              FarmerData _farmer = FarmerData(
                fullName: nameController.text,
                gender: _gender,
                crop: currentSelectedValue,
                variety: varietyController.text,
                plotArea: double.parse(plotAreaController.text),
                plantingDate: plantingDateController.text,
                ageOfCrop: int.parse(ageOfCropController.text),
                address: addressController.text
              );
              print(_farmer);
              if(farmerProvider.getIsEditing){
                farmerProvider.updateFarmerInList(_farmer);
              }else{
                farmerProvider.addFarmerInList(_farmer);
              }
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(farmerProvider.getIsEditing ? 'Farmer updated' :'Farmer added')),
              );
            }
          },
          child: Text(farmerProvider.getIsEditing ? 'Update' : 'Submit'),
        ),
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        plantingDateController.text = formattedDate.format(picked);
        ageOfCropController.text = DateTime.now().difference(picked).inDays.toString();
      });
    }
  }
}