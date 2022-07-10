import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/presentation/cart/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().requestPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            switch (state.status) {
              case CartStatus.empty:
                return const Center(child: Text('Nothing for now'));
              case CartStatus.bookAdded:
              case CartStatus.priceCalculated:
                return ListView.separated(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: state.books.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: Image.network(state.books[index].cover),
                          title: Text(state.books[index].title),
                          subtitle: Text("${state.books[index].price.round()}€"),
                        ),
                    separatorBuilder: (context, index) => const Divider());
            }
          },
        ),
        bottomSheet: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            switch (state.status) {
              case CartStatus.empty:
              case CartStatus.bookAdded:
                return Container();
              case CartStatus.priceCalculated:
                return BottomSheet(
                  builder: (context) => Container(
                    color: Colors.white70,
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.discount),
                          title: Row(
                            children: [
                              const Text('Discount: '),
                              Text(state.getDiscountMessage())
                            ],
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.price_check),
                          title: Text(state.getPriceMessage()),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('Buy')),
                        ),
                        Container(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  onClosing: () {},
                );
            }
          },
        ),
      );
}
