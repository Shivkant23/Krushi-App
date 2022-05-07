import 'package:farmer_app/core/models/farmer_data.dart';
import 'package:farmer_app/ui/add_farmer.dart';
import 'package:flutter/material.dart';

class FarmerCard extends StatelessWidget {
  FarmerData farmer;
  FarmerCard({Key? key, required this.farmer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}