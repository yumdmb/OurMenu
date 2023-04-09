import 'package:flutter/material.dart';
import 'package:mini_marketplace_app/features/cart/bloc/cart_bloc.dart';
import 'package:mini_marketplace_app/features/cart/model/models.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.myCart,
  }) : super(key: key);

  final CartItem cartItem;
  final CartBloc myCart;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dismissible(
      key: Key('${cartItem.item.id}'),
      onDismissed: (direction) {
        myCart.add(CartEventRemoveItem(cartItem: cartItem));
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("${cartItem.item.title} remove from cart"),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: "Undo",
                onPressed: () => myCart.add(const CartEventUndoRemoveItem()),
              ),
            ),
          );
      },
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(cartItem.item.image),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.red,
                    borderRadius:
                        const BorderRadius.horizontal(left: Radius.circular(4)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cartItem.item.title, style: textTheme.titleMedium),
                    Text('RM${cartItem.item.price}',
                        style: textTheme.titleLarge),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Total : ${cartItem.count}",
                              style: textTheme.bodyMedium),
                          Text(
                              "Total : RM${cartItem.item.price * cartItem.count}",
                              style: textTheme.bodyLarge),
                        ],
                      ),
                    ),
                    // const VerticalDivider(),
                    // IconButton(
                    //   onPressed: () => myCart.add(CartEventRemoveItem(item: cartItem)),
                    //   icon: const Icon(Icons.delete),
                    // ),
                    const VerticalDivider(indent: 0, endIndent: 0),
                    Checkbox(
                      value: cartItem.selected,
                      onChanged: (value) => myCart.add(CartEventSelectItem(
                          select: value!, cartItemId: cartItem.item.id)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
