import 'package:app_casipractica/donaciones.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int? _selectedRadio;
  double? paypalTotal;
  String dropDownValue = '100';
  double percent = 0.0;
  double totalAcumulado = 0.0;
  double totalAcumuladoPaypal = 0.0;
  double totalAcumuladoTarjeta = 0.0;

  var _radioGroupValues = {
    0:"Paypal",
    1:"Tarjeta",
  };
  
  var assetsRadioValues = {
    0: "paypal.png",
    1: "tarjeta-de-credito.png",
  };

  var itemDropDown = [
    '100',
    '350',
    '850',
    '1000',
    '9999',
  ];

  @override
  Widget build(BuildContext context) {
    return homePageMain(context);
  }

  radioGroupGenerator(){
    return _radioGroupValues.entries.map((item) => ListTile(
      leading: Image.asset(assetsRadioValues[item.key]!,
      height: 44,
      width: 44,),
      title: Text("${item.value}", textAlign: TextAlign.left,),
      trailing: Radio(value: item.key, 
      groupValue: _selectedRadio, 
      onChanged: (int? newSelectedRadio){
        _selectedRadio = newSelectedRadio!;
        setState(() {
        });
      },
      ),
    )).toList();
  }


  Scaffold homePageMain(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title:Text("Doncaiones"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: [
          ListTile(
            title: Text("Es para una buena causa", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0),),
            subtitle: Text("Elija modo de donativo", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0), ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: 
              radioGroupGenerator()
            ),
          ),
          SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text("Cantidad a donar:", textAlign: TextAlign.left,),
                trailing: Column(
                  children: [
                    DropdownButton(
                        
                      // Initial Value
                      value: dropDownValue,
                        
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),    
                        
                      // Array list of items
                      items: itemDropDown.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) { 
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Column(
                children: [
                  LinearPercentIndicator(
                    lineHeight: 25.0,
                    backgroundColor: Colors.purpleAccent,
                    animation: true,
                    animateFromLastPercent: true,
                    percent: totalAcumulado/10000 > 1.0? 1.0: totalAcumulado/10000,
                    progressColor: Colors.purple,
                    center: Text(
                      (totalAcumulado/100).toString() + "%",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(1500, 35)
                    ),
                    onPressed: (){
                      setState(() {
                        totalAcumulado += double.parse(dropDownValue);
                        totalAcumuladoPaypal += _selectedRadio == 0? double.parse(dropDownValue): 0.0;
                        totalAcumuladoTarjeta += _selectedRadio == 1? double.parse(dropDownValue): 0.0;
                      });
                    }, 
                    child: Text("Donar")
                  ),
                ],
              )
            ],
          ),

        ],      
      ),
    ),
    floatingActionButton: FloatingActionButton(
      tooltip: "Donaciones",
      child: Icon(Icons.arrow_circle_down),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
          builder: (context) => Donaciones(
            donativos: {
              "paypal":totalAcumuladoPaypal,
              "tarjeta":totalAcumuladoTarjeta, 
              "acumulado":totalAcumulado, "metaCumplida":totalAcumulado >= 10000? true: false}, 
              cantidadDonada: double.parse(dropDownValue))),
        );
        setState(() {
        });
      },
    ),
  );
  }
}