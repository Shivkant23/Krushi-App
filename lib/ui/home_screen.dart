import 'dart:ui';

import 'package:farmer_app/core/models/farmer_data.dart';
import 'package:farmer_app/core/view_models/Farmer_data_viewmodel.dart';
import 'package:farmer_app/ui/add_farmer.dart';
import 'package:farmer_app/ui/weather/weather_screen.dart';
import 'package:farmer_app/ui/widgets/farmer_card.dart';
import 'package:farmer_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<FarmerData> filteredListOfMovies = [];
  bool isFocused = false;
  final FocusNode _searchFocus = FocusNode();
  late FarmerDataViewModel farmerProvider;

  @override
  void initState() {
    super.initState();
    farmerProvider = Provider.of<FarmerDataViewModel>(context, listen: false);
    farmerProvider.setListOfFarmers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                      color: secondaryColor, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            focusNode: _searchFocus,
                            onChanged: (name)=> farmerProvider.farmerNameSearch(name),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Search Farmer',
                              border: InputBorder.none
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.cloud),
                onPressed: (){
                  Navigator.of(context).pushNamed(WeatherScreen.id);
                },
              ),
            ],
          )
        ),
        body: Consumer(
          builder: (context, FarmerDataViewModel farmers, child) {
            return ListView.builder(
              itemCount: farmers.getListOfFarmers.length,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index){
                FarmerData farmer = farmers.getListOfFarmers[index];
                return FarmerCard(farmer: farmer);
              }
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed(AddFarmer.id);
          },
        ),
      ),
    );
  }

  returnCard(FarmerData farmer){
    return Dismissible(
      key: Key('item${farmer.id}'),
      onDismissed: (DismissDirection direction) {
        farmerProvider.removeFarmer(farmer.id!);
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${farmer.fullName} dismissed')));
      },
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddFarmer(farmerData: farmer, isEditing: true,)));
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/${farmer.crop}.jpg"),
                      maxRadius: 40,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15,),
                          Text(
                            farmer.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(farmer.address)
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Crop : ", 
                      style: TextStyle(fontWeight: FontWeight.bold), 
                    ),
                    Text("${farmer.crop} (Variety: ${farmer.variety})", 
                      style: const TextStyle(fontWeight: FontWeight.w400), 
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Planting Date : ", 
                      style: TextStyle(fontWeight: FontWeight.bold), 
                    ),
                    Expanded(child: Text('${farmer.plantingDate} (Total days: ${farmer.ageOfCrop})')),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Plot Area : ", 
                      style: TextStyle(fontWeight: FontWeight.bold), 
                    ),
                    Expanded(child: Text(farmer.plotArea.toString())),
                    
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}