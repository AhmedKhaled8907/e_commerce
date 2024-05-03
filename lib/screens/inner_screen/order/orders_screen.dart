import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/screens/inner_screen/order/orders_widget.dart';
import 'package:e_commerce/widgets/custom_empty_bag.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitleText(
            label: 'Placed orders',
            fontSize: 24,
          ),
        ),
        body: isEmptyOrders
            ? const CustomEmptyBag(
                imagePath: Assets.imagesBagOrder,
                title: "No orders has been placed yet",
                subtitle: "",
              )
            : ListView.separated(
                itemCount: 15,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidget(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}
