import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: FittedBox(
                              child: Text('\$${transactions[index].amount}'),
                            ),
                          )),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(transactions[index].dateTime)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteTransaction(transactions[index].id),
                        color: Theme.of(context).errorColor,
                      ),
                    ));
              },
              itemCount: transactions.length,
            ),
    );
  }
}
