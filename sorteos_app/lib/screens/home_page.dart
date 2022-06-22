import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sorteos_app/models/sorteo.dart';

class HomeScreen extends StatelessWidget {
  final raffles = [
    Sorteo(1, "Moto electrica", DateTime(2022, 6, 10), "fb"),
    Sorteo(1, "Coche", DateTime(2022, 6, 10), "twt"),
    Sorteo(1, "Iphone 14", DateTime(2022, 6, 10), "ig"),
    Sorteo(1, "Pack chocolates", DateTime(2022, 6, 10), "fb"),
    Sorteo(1, "Otra cosa", DateTime(2022, 6, 10), "twt"),
    Sorteo(1, "Sorteo madison", DateTime(2022, 6, 10), "ig"),
    Sorteo(1, "Pepino", DateTime(2022, 6, 10), "lol"),
    Sorteo(1, "Entrada discoteca", DateTime(2022, 6, 10), "ig"),
    Sorteo(1, "Vipaso en cocoa", DateTime(2022, 6, 10), "fb"),
    Sorteo(1, "Pico de madera", DateTime(2022, 6, 10), "twt"),
    Sorteo(1, "4g de Hashesh", DateTime(2022, 6, 10), "lol"),
  ];

  @override
  Widget build(BuildContext context) {
    var textStyleTitle = TextStyle(
        color: Colors.deepPurple.shade400,
        fontSize: 25,
        fontWeight: FontWeight.bold);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, 'add'),
        label: Text(
          "Add",
          style: TextStyle(color: Colors.deepPurple.shade400, fontSize: 16),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.deepPurple.shade400,
        ),
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        title: Text(
          'RAFFLE STATS',
          style: textStyleTitle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,

        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () => Navigator.pushNamed(context, 'add'),
        //       icon: Icon(
        //         Icons.add,
        //         color: Colors.black54,
        //       )),
        // ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: raffles.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (_, index) {
          final raffle = raffles[index];
          return _RaffleItem(
            type: raffle.type,
            title: raffle.title,
            date: raffle.getDateToString(), //APUNTAR TYPE DEL OBJETO RAFFLE
          );
        },
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}

class _RaffleItem extends StatelessWidget {
  _RaffleItem(
      {Key? key, required this.type, required this.title, required this.date})
      : super(key: key);
  final String type;
  final String title;
  final String date;

  Color primaryColor = Colors.white;
  Color secondaryColor = Colors.black87;
  Color textColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    primaryColor = _selectColor(type, 200);
    secondaryColor = _selectColor(type, 600);
    textColor = _selectTextColor(type);

    var textStyleTitle =
        TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold);

    var textStyleSubtitle =
        TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w400);
    return Card(
      color: primaryColor,
      elevation: 4,
      child: ListTile(
        title: Text(
          '$title',
          style: textStyleTitle,
        ),
        subtitle: Text('$date', style: textStyleSubtitle),
        trailing: Icon(
          Icons.chevron_right,
        ),
        leading: ImageIcon(
          AssetImage(_selectIcon(type)),
          color: secondaryColor,
          size: 45,
        ),
        onTap: () {},
      ),
    );
  }
}

Color _selectColor(String type, int shade) {
  switch (type) {
    case 'ig':
      return Colors.teal[shade]!;

    case 'twt':
      return Colors.blue[shade]!;

    case 'fb':
      return Colors.indigo[shade]!;

    default:
      if (shade == 200) {
        return Colors.grey[300]!;
      } else {
        return Colors.black87;
      }
  }
}

Color _selectTextColor(String type) {
  switch (type) {
    case 'ig':
      return Colors.white;

    case 'twt':
      return Colors.white;

    case 'fb':
      return Colors.white;

    default:
      return Colors.black87;
  }
}

String _selectIcon(String type) {
  switch (type) {
    case 'ig':
      return 'assets/instagram.png';

    case 'twt':
      return 'assets/twitter.png';

    case 'fb':
      return 'assets/facebook.png';
    default:
      return 'assets/default_raffle.png';
  }
}
