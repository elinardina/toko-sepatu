import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokosepatu/komponen/cartitem.dart';
import 'package:tokosepatu/models/cart.dart';
import 'package:tokosepatu/models/shoe.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

// Tambahkan enum untuk jenis penyortiran
enum Sortir {
  name,
  price,
}


// Tambahkan enum untuk opsi pengiriman
enum Pengiriman {
  standard,
  express,
}

class _CartPageState extends State<CartPage> {
  Sortir _currentSort = Sortir.name;
  Pengiriman _selectedDeliveryOption = Pengiriman.standard;

  void _sortCart() {
    Cart cart = Provider.of<Cart>(context, listen: false);

    switch (_currentSort) {
      case Sortir.name:
        cart.getUserCart().sort((a, b) => a.name.compareTo(b.name));
        break;
      case Sortir.price:
        cart.getUserCart().sort((a, b) => a.price.compareTo(b.price));
        break;
    }

    cart.notifyListeners();
  }

  void _showDeliveryOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Opsi Pengiriman'),
          content: Column(
            children: Pengiriman.values.map((Pengiriman option) {
              return ListTile(
                title: Text(option.toString()),
                onTap: () {
                  setState(() {
                    _selectedDeliveryOption = option;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void payNow() {
    Cart cart = Provider.of<Cart>(context, listen: false);
    double totalPayment = Provider.of<Cart>(context, listen: false).calculateTotalPayment();

    String deliveryOptionText = _selectedDeliveryOption == Pengiriman.standard
        ? 'Standard'
        : 'Express';

    // Konfirmasi pembayaran
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Pembayaran: Rp${totalPayment.toStringAsFixed(3)}'),
              SizedBox(height: 10),
              Text('Opsi Pengiriman: $deliveryOptionText'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                
                // Lakukan pembayaran jika dikonfirmasi
                cart.getUserCart().clear();
                cart.notifyListeners();
                Navigator.pop(context);
              },
              child: Text('Bayar'),
            ),
            TextButton(
              onPressed: () {
                // Batalkan jika tidak jadi bayar
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Consumer<Cart>(
    builder: (context, value, child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Keranjangku',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Row(
                children: [
                  // DropdownButton untuk memilih jenis penyortiran
                  DropdownButton<Sortir>(
                    value: _currentSort,
                    onChanged: (Sortir? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _currentSort = newValue;
                          _sortCart();
                        });
                      }
                    },
                    items: Sortir.values.map((Sortir sortType) {
                      return DropdownMenuItem<Sortir>(
                        value: sortType,
                        child: Text(sortType.toString()),
                      );
                    }).toList(),
                  ),
                  
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: value.getUserCart().length,
              itemBuilder: (context, index) {
                // Dapatkan sepatu individual
                Shoe individualShoe = value.getUserCart()[index];

                // Return item keranjang
                return CartItem(
                  shoe: individualShoe,
                );
              },
            ),
          ),

          GestureDetector(
                    onTap: _showDeliveryOptionsDialog,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text('Pilih Pengiriman:'),
                          SizedBox(width: 10),
                          Text(_selectedDeliveryOption.toString()),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 5,),
          // Tombol pengiriman di bawah tombol gestur detector
          GestureDetector(
            onTap: payNow,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Bayar Sekarang \n Rp${value.calculateTotalPayment().toStringAsFixed(3)}",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}