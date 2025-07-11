import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuantifyIncrementDecrement extends StatelessWidget {
  final int currentNumber;
  final Function() onAdd;
  final Function() onRemove;
  const QuantifyIncrementDecrement({
    super.key,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 2.5, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: onRemove, icon: Icon(Iconsax.minus)),
          const SizedBox(width: 10),
          Text(
            "${currentNumber}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          IconButton(onPressed: onAdd, icon: Icon(Iconsax.add)),
        ],
      ),
    );
  }
}
