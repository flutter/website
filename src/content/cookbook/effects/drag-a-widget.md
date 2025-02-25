---
title: Drag a UI element
description: How to implement a draggable UI element.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/effects/drag_a_widget"?>

Drag and drop is a common mobile app interaction.
As the user long presses (sometimes called _touch & hold_)
on a widget, another widget appears beneath the
user's finger, and the user drags the widget to a
final location and releases it.
In this recipe, you'll build a drag-and-drop interaction
where the user long presses on a choice of food,
and then drags that food to the picture of the customer who
is paying for it.

The following animation shows the app's behavior:

![Ordering the food by dragging it to the person](/assets/images/docs/cookbook/effects/DragAUIElement.gif){:.site-mobile-screenshot}

This recipe begins with a prebuilt list of menu items and
a row of customers.
The first step is to recognize a long press
and display a draggable photo of a menu item.

## Press and drag

Flutter provides a widget called [`LongPressDraggable`][]
that provides the exact behavior that you need to begin
a drag-and-drop interaction. A `LongPressDraggable`
widget recognizes when a long press occurs and then 
displays a new widget near the user's finger.
As the user drags, the widget follows the user's finger.
`LongPressDraggable` gives you full control over the 
widget that the user drags.

Each menu list item is displayed with a custom
`MenuListItem` widget.

<?code-excerpt "lib/main.dart (MenuListItem)" replace="/^child: //g;/^\),$/)/g"?>
```dart
MenuListItem(
  name: item.name,
  price: item.formattedTotalItemPrice,
  photoProvider: item.imageProvider,
)
```

Wrap the `MenuListItem` widget with a `LongPressDraggable` widget.

<?code-excerpt "lib/main.dart (LongPressDraggable)" replace="/^return //g;/^\),$/)/g"?>
```dart
LongPressDraggable<Item>(
  data: item,
  dragAnchorStrategy: pointerDragAnchorStrategy,
  feedback: DraggingListItem(
    dragKey: _draggableKey,
    photoProvider: item.imageProvider,
  ),
  child: MenuListItem(
    name: item.name,
    price: item.formattedTotalItemPrice,
    photoProvider: item.imageProvider,
  ),
);
```

In this case, when the user long presses on the
`MenuListItem` widget, the `LongPressDraggable`
widget displays a `DraggingListItem`.
This `DraggingListItem` displays a photo of the
selected food item, centered beneath 
the user's finger.

The `dragAnchorStrategy` property is set to
[`pointerDragAnchorStrategy`][].
This property value instructs `LongPressDraggable`
to base the `DraggableListItem`'s position on the 
user's finger. As the user moves a finger,
the `DraggableListItem` moves with it.

Dragging and dropping is of little use if no information
is transmitted when the item is dropped.
For this reason, `LongPressDraggable` takes a `data` parameter. 
In this case, the type of `data` is `Item`,
which holds information about the 
food menu item that the user pressed on.

The `data` associated with a `LongPressDraggable`
is sent to a special widget called `DragTarget`,
where the user releases the drag gesture.
You'll implement the drop behavior next.

## Drop the draggable

The user can drop a `LongPressDraggable` wherever they choose,
but dropping the draggable has no effect unless it's dropped
on top of a `DragTarget`. When the user drops a draggable on
top of a `DragTarget` widget, the `DragTarget` widget 
can either accept or reject the data from the draggable.

In this recipe, the user should drop a menu item on a
`CustomerCart` widget to add the menu item to the user's cart.

<?code-excerpt "lib/main.dart (CustomerCart)" replace="/^return //g;/^\),$/)/g"?>
```dart
CustomerCart(
  hasItems: customer.items.isNotEmpty,
  highlighted: candidateItems.isNotEmpty,
  customer: customer,
);
```

Wrap the `CustomerCart` widget with a `DragTarget` widget.

<?code-excerpt "lib/main.dart (DragTarget)" replace="/^child: //g;/^\),$/)/g"?>
```dart
DragTarget<Item>(
  builder: (context, candidateItems, rejectedItems) {
    return CustomerCart(
      hasItems: customer.items.isNotEmpty,
      highlighted: candidateItems.isNotEmpty,
      customer: customer,
    );
  },
  onAcceptWithDetails: (details) {
    _itemDroppedOnCustomerCart(item: details.data, customer: customer);
  },
)
```

The `DragTarget` displays your existing widget and
also coordinates with `LongPressDraggable` to recognize
when the user drags a draggable on top of the `DragTarget`.
The `DragTarget` also recognizes when the user drops
a draggable on top of the `DragTarget` widget.

When the user drags a draggable on the `DragTarget` widget,
`candidateItems` contains the data items that the user is dragging.
This draggable allows you to change what your widget looks
like when the user is dragging over it. In this case,
the `Customer` widget turns red whenever any items are dragged above the 
`DragTarget` widget. The red visual appearance is configured with the 
`highlighted` property within the `CustomerCart` widget.

When the user drops a draggable on the `DragTarget` widget,
the `onAcceptWithDetails` callback is invoked. This is when you get
to decide whether or not to accept the data that was dropped.
In this case, the item is always accepted and processed. 
You might choose to inspect the incoming item to make a
different decision. 

Notice that the type of item dropped on `DragTarget`
must match the type of the item dragged from `LongPressDraggable`.
If the types are not compatible, then 
the `onAcceptWithDetails` method isn't invoked.

With a `DragTarget` widget configured to accept your
desired data, you can now transmit data from one part
of your UI to another by dragging and dropping.

In the next step,
you update the customer's cart with the dropped menu item.

## Add a menu item to a cart

Each customer is represented by a `Customer` object,
which maintains a cart of items and a price total.

<?code-excerpt "lib/main.dart (CustomerClass)"?>
```dart
class Customer {
  Customer({required this.name, required this.imageProvider, List<Item>? items})
    : items = items ?? [];

  final String name;
  final ImageProvider imageProvider;
  final List<Item> items;

  String get formattedTotalItemPrice {
    final totalPriceCents = items.fold<int>(
      0,
      (prev, item) => prev + item.totalPriceCents,
    );
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
```

The `CustomerCart` widget displays the customer's photo,
name, total, and item count based on a `Customer` instance.

To update a customer's cart when a menu item is dropped,
add the dropped item to the associated `Customer` object.

<?code-excerpt "lib/main.dart (AddCart)"?>
```dart
void _itemDroppedOnCustomerCart({
  required Item item,
  required Customer customer,
}) {
  setState(() {
    customer.items.add(item);
  });
}
```

The `_itemDroppedOnCustomerCart` method is invoked in
`onAcceptWithDetails()` when the user drops a menu item on a
`CustomerCart` widget. By adding the dropped item to the 
`customer` object, and invoking `setState()` to cause a
layout update, the UI refreshes with the new customer's
price total and item count.

Congratulations! You have a drag-and-drop interaction
that adds food items to a customer's shopping cart.

## Interactive example

Run the app:

* Scroll through the food items.
* Press and hold on one with your
  finger or click and hold with the
  mouse.
* While holding, the food item's image
  will appear above the list.
* Drag the image and drop it on one of the
  people at the bottom of the screen.
  The text under the image updates to
  reflect the charge for that person.
  You can continue to add food items
  and watch the charges accumulate.

<!-- Start DartPad -->

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter drag a widget hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExampleDragAndDrop(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

const List<Item> _items = [
  Item(
    name: 'Spinach Pizza',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: NetworkImage(
      'https://docs.flutter.dev'
      '/cookbook/img-files/effects/split-check/Food1.jpg',
    ),
  ),
  Item(
    name: 'Veggie Delight',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: NetworkImage(
      'https://docs.flutter.dev'
      '/cookbook/img-files/effects/split-check/Food2.jpg',
    ),
  ),
  Item(
    name: 'Chicken Parmesan',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: NetworkImage(
      'https://docs.flutter.dev'
      '/cookbook/img-files/effects/split-check/Food3.jpg',
    ),
  ),
];

@immutable
class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});

  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}

class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {
  final List<Customer> _people = [
    Customer(
      name: 'Makayla',
      imageProvider: const NetworkImage(
        'https://docs.flutter.dev'
        '/cookbook/img-files/effects/split-check/Avatar1.jpg',
      ),
    ),
    Customer(
      name: 'Nathan',
      imageProvider: const NetworkImage(
        'https://docs.flutter.dev'
        '/cookbook/img-files/effects/split-check/Avatar2.jpg',
      ),
    ),
    Customer(
      name: 'Emilio',
      imageProvider: const NetworkImage(
        'https://docs.flutter.dev'
        '/cookbook/img-files/effects/split-check/Avatar3.jpg',
      ),
    ),
  ];

  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnCustomerCart({
    required Item item,
    required Customer customer,
  }) {
    setState(() {
      customer.items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        'Order Food',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 36,
          color: const Color(0xFFF64209),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [Expanded(child: _buildMenuList()), _buildPeopleRow()],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildMenuItem(item: item);
      },
    );
  }

  Widget _buildMenuItem({required Item item}) {
    return LongPressDraggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoProvider: item.imageProvider,
      ),
      child: MenuListItem(
        name: item.name,
        price: item.formattedTotalItemPrice,
        photoProvider: item.imageProvider,
      ),
    );
  }

  Widget _buildPeopleRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Row(children: _people.map(_buildPersonWithDropZone).toList()),
    );
  }

  Widget _buildPersonWithDropZone(Customer customer) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: DragTarget<Item>(
          builder: (context, candidateItems, rejectedItems) {
            return CustomerCart(
              hasItems: customer.items.isNotEmpty,
              highlighted: candidateItems.isNotEmpty,
              customer: customer,
            );
          },
          onAcceptWithDetails: (details) {
            _itemDroppedOnCustomerCart(item: details.data, customer: customer);
          },
        ),
      ),
    );
  }
}

class CustomerCart extends StatelessWidget {
  const CustomerCart({
    super.key,
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Customer customer;
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final textColor = highlighted ? Colors.white : Colors.black;

    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8 : 4,
        borderRadius: BorderRadius.circular(22),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 46,
                  height: 46,
                  child: Image(
                    image: customer.imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                customer.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: hasItems ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      customer.formattedTotalItemPrice,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${customer.items.length} item${customer.items.length != 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: textColor,
                        fontSize: 12,
                      ),
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

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  });

  final String name;
  final String price;
  final ImageProvider photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: isDepressed ? 115 : 120,
                    width: isDepressed ? 115 : 120,
                    child: Image(image: photoProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85,
            child: Image(image: photoProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

@immutable
class Item {
  const Item({
    required this.totalPriceCents,
    required this.name,
    required this.uid,
    required this.imageProvider,
  });
  final int totalPriceCents;
  final String name;
  final String uid;
  final ImageProvider imageProvider;
  String get formattedTotalItemPrice =>
      '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
}

class Customer {
  Customer({required this.name, required this.imageProvider, List<Item>? items})
    : items = items ?? [];

  final String name;
  final ImageProvider imageProvider;
  final List<Item> items;

  String get formattedTotalItemPrice {
    final totalPriceCents = items.fold<int>(
      0,
      (prev, item) => prev + item.totalPriceCents,
    );
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
```

[`pointerDragAnchorStrategy`]: {{site.api}}/flutter/widgets/pointerDragAnchorStrategy.html
[`LongPressDraggable`]: {{site.api}}/flutter/widgets/LongPressDraggable-class.html
