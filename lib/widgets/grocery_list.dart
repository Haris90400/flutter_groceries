import 'package:flutter/material.dart';
import 'package:flutter_groceries/data/dummy_items.dart';
import 'package:flutter_groceries/widgets/new_item.dart';
import 'package:flutter_groceries/models/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];
  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget _activeWidget = Center(
      child: Text(
        'Your Grocery List is Empty!..',
        style: Theme.of(context).textTheme.titleLarge!,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _groceryItem.isEmpty
          ? _activeWidget
          : ListView.builder(
              itemCount: _groceryItem.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: ValueKey(_groceryItem[index].id),
                  onDismissed: (direction) {
                    _removeItem(_groceryItem[index]);
                  },
                  child: ListTile(
                    title: Text(
                      _groceryItem[index].name,
                    ),
                    leading: Container(
                        height: 26,
                        width: 26,
                        color: _groceryItem[index].category.color),
                    trailing: Text(
                      _groceryItem[index].quantity.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
