import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:sorteos_app/helpers/helper.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  Widget build(BuildContext context) {
    var textStyleTitle = TextStyle(
        color: Colors.deepPurple.shade400,
        fontSize: 25,
        fontWeight: FontWeight.bold);

    final TextEditingController _textEditingController =
        TextEditingController();

    final strokeStyle = OutlineInputBorder(
        borderSide: new BorderSide(
            style: BorderStyle.solid,
            width: 2.5,
            color: Colors.deepPurple.shade400));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: Container(
        margin: EdgeInsets.all(10),
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
                      floatingLabelStyle: TextStyle(
                          fontSize: 25, color: Colors.deepPurple.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Icon(
                        Icons.card_giftcard_rounded,
                        color: Colors.deepPurple.shade400,
                      ),
                      labelStyle: TextStyle(fontSize: 20),
                      hintStyle: TextStyle(fontSize: 20),
                      hintText: 'What is being raffled?'),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          focusedBorder: strokeStyle,
                          labelText: 'Date',
                          floatingLabelStyle: TextStyle(
                              fontSize: 25, color: Colors.deepPurple.shade400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.deepPurple.shade400,
                          ),
                          labelStyle: TextStyle(fontSize: 20),
                          hintStyle: TextStyle(fontSize: 20),
                          hintText: _textEditingController.text == ''
                              ? 'When finishes the raffle?'
                              : _textEditingController.text),
                      onTap: () async {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // Show Date Picker Here
                        await _selectDate(context);

                        if (selectedDate != null) {
                          print(
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}");
                          _textEditingController.text =
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 3),
        lastDate: DateTime(DateTime.now().year + 5));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
