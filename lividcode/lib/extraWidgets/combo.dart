import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lividcode/baseClasses/stat.dart';

class ComboWidget extends StatefulWidget {
  statType type;
  String user;
  String id;
  ComboWidget(this.type, this.user, this.id);

  @override
  _ComboWidgetState createState() => _ComboWidgetState();
}

class _ComboWidgetState extends State<ComboWidget> {
  List<DropdownMenuItem<String>> dropDownMenuItems;
  String currentStat;

  @override
  void initState() {
    dropDownMenuItems = getDropDownMenuItems();
    for (var d in dropDownMenuItems) {
      if (d.value == statToFullName(widget.type))
        currentStat = statToFullName(widget.type);
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: DropdownButton(
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
      widget.type = statFromFullName(currentStat);
      if (widget.id != null && widget.user != null)
        Firestore.instance
            .collection('users')
            .document(widget.user)
            .collection('DoingTasks')
            .document(widget.id)
            .updateData({'type': statToString(widget.type)});
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    for (String stat in allStats) {
      items.add(DropdownMenuItem(value: stat, child: Text(stat)));
    }
    return items;
  }
}
