import 'package:flutter/material.dart';

import 'package:sorteos_app/helpers/helper.dart';

import '../helpers/notifications_service.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _inputFollowController = new TextEditingController();
  final chipList = [];
  DateTime selectedDate = DateTime.now();
  String _fecha = "";
  int _selected = 4;
  Color _backgroundColor = Colors.white;
  Color _iconColor = Colors.deepPurple.shade400;
  Color _textColor = Colors.deepPurple.shade400;

  Widget build(BuildContext context) {
    var textStyleTitle =
        TextStyle(color: _textColor, fontSize: 25, fontWeight: FontWeight.bold);
    final strokeStyle = OutlineInputBorder(
        borderSide: new BorderSide(
            style: BorderStyle.solid, width: 2.5, color: _iconColor));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 35,
          ),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ADD A RAFFLE',
          style: textStyleTitle,
        ),
        centerTitle: true,
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: _backgroundColor),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: strokeStyle,
                      labelText: 'Title',
                      floatingLabelStyle:
                          TextStyle(fontSize: 25, color: _iconColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Icon(
                        Icons.card_giftcard_rounded,
                        color: _iconColor,
                      ),
                      labelStyle: TextStyle(fontSize: 20),
                      hintStyle: TextStyle(fontSize: 20),
                      hintText: 'What is being raffled?'),
                ),
                SizedBox(height: 20),
                _crearFecha(),
                SizedBox(height: 20),
                TextField(
                    controller: _inputFollowController,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {},
                    decoration: InputDecoration(
                        focusedBorder: strokeStyle,
                        labelText: 'Follows',
                        floatingLabelStyle:
                            TextStyle(fontSize: 25, color: _iconColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(
                          Icons.alternate_email_outlined,
                          color: _iconColor,
                        ),
                        helperText: "Press Enter to add a user",
                        labelStyle: TextStyle(fontSize: 20),
                        hintStyle: TextStyle(fontSize: 20),
                        hintText: 'Who have you followed?'),
                    onSubmitted: (text) {
                      if (text != '') {
                        if (text.length < 20) {
                          chipList.add(text); // Append Text to the list
                          _inputFollowController.clear(); // Clear the Text area
                          setState(() {});
                        } else if (text.length > 20) {
                          NotificationsService.showSnackBar(
                              "Max length is 20 characters");
                          setState(() {});
                          _inputFollowController.text = text;
                        }
                      } else {
                        NotificationsService.showSnackBar(
                            "Please add some text");
                        setState(() {});
                      }
                    }),
                Container(
                  height: chipList.length == 0 ? 0 : 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chipList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Chip(
                          onDeleted: () {
                            chipList.removeAt(index);
                            setState(() {});
                          },
                          deleteIcon: Icon(
                            Icons.close,
                            color: _iconColor,
                          ),
                          label: Text("${chipList[index]}"),
                          labelStyle: TextStyle(color: _textColor),
                          backgroundColor: _buttonBackgroundColorPicker(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                _iconRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _iconRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _icon(4, "no"),
        _icon(2, "fb"),
        _icon(3, "twt"),
        _icon(1, "ig"),
      ],
    );
  }

  Widget _crearFecha() {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          labelText: 'Date',
          floatingLabelStyle: TextStyle(fontSize: 25, color: _iconColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(
            Icons.calendar_today_outlined,
            color: _iconColor,
          ),
          labelStyle: TextStyle(fontSize: 20),
          hintStyle: TextStyle(fontSize: 20),
          hintText: 'When is being raffled?'),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      locale: Locale('es', 'ES'),
      initialDate: new DateTime.now(),
      firstDate: new DateTime(DateTime.now().year - 4),
      lastDate: new DateTime(DateTime.now().year + 4),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _iconColor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: _iconColor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: _iconColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _fecha = "${picked.day}/${picked.month}/${picked.year}";
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _icon(int index, String type) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: _selected == index
          ? _buttonBackgroundColorPicker()
          : Colors.transparent,
      foregroundColor: Colors.black26,
      child: IconButton(
        onPressed: () => setState(
          () {
            _selected = index;
            _selectColor(type, 400);
          },
        ),
        iconSize: 40,
        icon: ImageIcon(
          AssetImage(_selectIcon(type)),
          color: _selected == index ? _selectColor(type, 400) : null,
          size: 45,
        ),
      ),
    );
  }

  Color _buttonBackgroundColorPicker() {
    if (_backgroundColor == Colors.white) {
      return Colors.black12;
    } else {
      return Colors.white24;
    }
  }

  Color _selectColor(String type, int shade) {
    switch (type) {
      case 'ig':
        _backgroundColor = Colors.pink.shade100;
        _iconColor = Colors.pink.shade400;
        _textColor = Colors.pink.shade400;
        return Colors.pink[shade]!;

      case 'twt':
        _backgroundColor = Colors.blue.shade100;
        _iconColor = Colors.blue.shade400;
        _textColor = Colors.blue.shade400;
        return Colors.blue[shade]!;

      case 'fb':
        _backgroundColor = Colors.indigo.shade100;
        _iconColor = Colors.indigo.shade400;
        _textColor = Colors.indigo.shade400;
        return Colors.indigo[shade]!;

      default:
        if (shade == 200) {
          _backgroundColor = Colors.white;
          _iconColor = Colors.deepPurple.shade400;
          _textColor = Colors.deepPurple.shade400;
          return Colors.grey[300]!;
        } else {
          _backgroundColor = Colors.white;
          _iconColor = Colors.deepPurple.shade400;
          _textColor = Colors.deepPurple.shade400;
          return Colors.deepPurple.shade400;
        }
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
}
