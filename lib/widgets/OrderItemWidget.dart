import 'package:apo_delivery/data/Order.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  OrderItem({super.key, required this.order});

  Order order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/Order',
          arguments: {'order': widget.order},
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        height: 90,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black26,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.3),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        'ORDEN NO. ${widget.order.orderId} | ${widget.order.orderDateTime}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'CONFIRMADA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(17),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
