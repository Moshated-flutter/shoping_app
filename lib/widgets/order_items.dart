// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:shoping_app/providers/orders_providers.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Orderwidget extends StatefulWidget {
  final OrderItems order;
  Orderwidget(this.order);

  @override
  State<Orderwidget> createState() => _OrderwidgetState();
}

class _OrderwidgetState extends State<Orderwidget> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('yyyy/MM/dd hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              icon: const Icon(Icons.expand_more),
            ),
          ),
          if (expanded)
            Column(
              children: [
                const Divider(),
                Container(
                  height: min(widget.order.products.length * 30 + 10, 450),
                  child: ListView(
                      children: widget.order.products
                          .map((e) => Card(
                                color: Colors.lightBlue,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${e.amount}x \$${e.price}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList()),
                ),
              ],
            )
        ],
      ),
    );
  }
}
