import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import './user_transaction.dart';

class NewTransaction extends StatefulWidget {
  /* String titleInput = '';
  String amountInput = '';*/
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      //Widget property gives access to your state's widget
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    //For closing the bottom sheet after entering the amount
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      //Adding text input
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              //title Input
              autocorrect: true,
              autofocus: true,
              decoration: InputDecoration(labelText: 'Title'),
              /* onChanged: (String input) {
                        //Fired on every keystroke
                        this.titleInput = input;
                      },*/
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            // SizedBox(height: 10),
            TextField(
              //amount Input
              autocorrect: true,
              autofocus: true,
              decoration: InputDecoration(labelText: 'Amount'),
              /* onChanged: (String input) {
                        //Fired on every keystroke
                        this.amountInput = input;
                      },*/
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //Used for submitting data when enter is pressed
              onSubmitted: (_) =>
                  submitData(), //Note the use of underscore here
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(15),
              ),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('No Date Chosen!'),
                  //SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: presentDatePicker,
                    child: Text(selectedDate == DateTime.now()
                        ? 'Choose Date!'
                        : 'Picked Date:${DateFormat.yMd().format(selectedDate)}'),
                    style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: Colors.lightBlue[100],
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              //Add transaction Button
              onPressed: () => submitData(),
              style: OutlinedButton.styleFrom(
                primary: Colors.blue[900], //Used for changing text color
                backgroundColor: Colors.lightBlue[100],
              ),
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
