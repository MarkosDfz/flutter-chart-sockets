
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 1),
    Band(id: '2', name: 'Soad', votes: 2),
    Band(id: '3', name: 'Black Sabath', votes: 3),
    Band(id: '4', name: 'Nagrumn', votes: 4),
    Band(id: '5', name: 'Atis', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'BandNames',
          style: TextStyle( color: Colors.black87 ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( context, i ) => _bandListTile( bands[i] )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        onPressed: addNewBand
      ),
   );
  }

  Widget _bandListTile( Band band ) {
    return Dismissible(
      key: Key( band.id ),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ) {
        print( direction );
      },
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text( 'Delete Band',
            style: TextStyle( color: Colors.white ),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            band.name.substring( 0, 2 )
          ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text( band.name ),
        trailing: Text( '${ band.votes }',
          style: TextStyle( fontSize: 20.0 ),
        ),
        onTap: () {
          print( band.name );
        },
      ),
    );
  }

  addNewBand() {

    final textCtrl = new TextEditingController();

    if ( Platform.isAndroid ) {
      return showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text( 'New band name' ),
            content: TextField(
              controller: textCtrl,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text( 'Add' ),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: ()  => addBandToList( textCtrl.text ),
              )
            ],
          );
        }
      );
    }

    showCupertinoDialog(
      context: context,
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text( 'New band name' ),
          content: CupertinoTextField(
            controller: textCtrl,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text( 'Add' ),
              onPressed: ()  => addBandToList( textCtrl.text ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text( 'Dismiss' ),
              onPressed: ()  => Navigator.pop( context ),
            )
          ],
        );
      }
    );

  }

  void addBandToList( String name ) {

    if ( name.length > 1 ) {
      this.bands.add(
        new Band( id: DateTime.now().toString(), name: name, votes: 0 )
      );
      setState(() {});
    }

    Navigator.pop( context );

  }

}