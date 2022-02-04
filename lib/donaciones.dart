import 'package:flutter/material.dart';

class Donaciones extends StatefulWidget {
  final donativos;
  final double cantidadDonada;

  Donaciones({Key? key, required this.donativos, required this.cantidadDonada}) : super(key: key);

  @override
  State<Donaciones> createState() => _DonacionesState();
}

class _DonacionesState extends State<Donaciones> {

  Widget imagenGracias(){
    return widget.donativos["metaCumplida"]?Image.asset("gracias.png"):Container();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Donativos optenidos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("paypal.png"),
              trailing: Text("${widget.donativos["paypal"] ?? 0.0}", style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 22,),
            ListTile(
              leading: Image.asset("tarjeta-de-credito.png"),
              trailing: Text("${widget.donativos["tarjeta"] ?? 0.0}", style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 22,),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money),
              trailing: Text("${widget.donativos["acumulado"] ?? 0.0}", style: TextStyle(fontSize: 20),),
            ),
            imagenGracias(),
          ],
        ),
      )
    );
  }
}