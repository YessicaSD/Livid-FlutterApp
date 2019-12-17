import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/stat.dart';

class ComboWidget extends StatefulWidget {
  @override
  _ComboWidgetState createState() => _ComboWidgetState();
}

class _ComboWidgetState extends State<ComboWidget> {
  List<DropdownMenuItem<String>> dropDownMenuItems;
  String currentStat;

  @override
  void initState() {
    dropDownMenuItems = getDropDownMenuItems();
    currentStat = dropDownMenuItems[0].value;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: new DropdownButton(
          value: currentStat,
          items: dropDownMenuItems,
          onChanged: changedDropDownItem,
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedStat) {
    setState(() {
      currentStat = selectedStat;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String stat in allStats) {
      items.add(new DropdownMenuItem(value: stat, child: new Text(stat)));
    }
    return items;
  }
}
