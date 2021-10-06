import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions have been added',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
              ],
            )
          : ListView.builder(
              //itembuilder function is called by flutter
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                      iconSize: 30.0,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
                /*
                return Flexible(
                  fit: FlexFit.tight,
                  child: Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${transactions[index].amount.toStringAsFixed(2)} \$',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            /* style: TextStyle(
                        fontSize: 18,
                      ),*/
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat()
                                .add_yMMMd()
                                .format(transactions[index].date),
                            //tx.date.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                );
             */
              },
              itemCount: transactions.length,
            ),
    );
  }
}
