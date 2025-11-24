import 'package:flutter/material.dart';
import 'package:project1/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  List<ExpensesItem> overallExpenseList = []; // Store all expenses

  @override
  void initState() {
    super.initState();
    // Initialize the list with three default expenses
    overallExpenseList = [
      ExpensesItem(name: 'Groceries', amount: '50.00'),
      ExpensesItem(name: 'Transportation', amount: '20.00'),
      ExpensesItem(name: 'Dinner', amount: '30.00'),
    ];
  }

  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Expense Amount',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: 'Expense Name',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    final newExpense = ExpensesItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
    );
    overallExpenseList.add(newExpense);
    clear();
    Navigator.pop(context); // Close the dialog
    setState(() {}); // Trigger a rebuild to update the UI
  }

  void cancel() {
    clear();
    Navigator.pop(context); // Close the dialog
  }

  double getTotalExpenses() {
    double total = 0;
    for (var expense in overallExpenseList) {
      total += double.tryParse(expense.amount) ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Expenses Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.purple],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Total Expenses:',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '\$${getTotalExpenses().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 75),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: overallExpenseList.length,
                    itemBuilder: (context, itemCount) {
                      final expense = overallExpenseList[itemCount];
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    expense.name,
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    '\$${expense.amount}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => removeExpense(itemCount),
                                icon: Icon(Icons.delete,
                                    color:
                                        const Color.fromARGB(255, 230, 15, 0)),
                              ),
                            ],
                          ),
                          Divider(
                            height: 10,
                            thickness: 2.5,
                            color: Colors.black,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: ElevatedButton(
                    onPressed: addNewExpense,
                    child: const Text('Add Expense'),
                    style: ElevatedButton.styleFrom(
                     // primary: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeExpense(int index) {
    overallExpenseList.removeAt(index);
    setState(() {});
  }
}
