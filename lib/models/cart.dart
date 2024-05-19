import 'package:flutter/material.dart';
import 'package:tokosepatu/models/shoe.dart';

class Cart extends ChangeNotifier{
  //list untuk dijual
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Adidas',
      price: 300.000, 
      imagePath: 'assets/image/1.jpg', 
      description: 'Warna putih, size 40'),

      Shoe(
      name: 'Converse',
      price: 400.000, 
      imagePath: 'assets/image/2.jpg', 
      description: 'Warna hitam, size 39'),

      Shoe(
      name: 'Nike',
      price: 450.000, 
      imagePath: 'assets/image/3.jpg', 
      description: 'Warna hitam, size 39'),

      Shoe(
      name: 'Korean Style',
      price: 400.000, 
      imagePath: 'assets/image/5.jpg', 
      description: 'Warna putih, size 41'),

      Shoe(
      name: 'Sendal Hak',
      price: 200.000, 
      imagePath: 'assets/image/6.jpg', 
      description: 'Warna gold, size 40'),
  ];

  //list item di keranjang user
  List<Shoe> userCart = [];

  //dapatkan list untuk dijual
  List<Shoe> getShoeList (){
    return shoeShop;
  }

  //dapatkan keranjang
  List<Shoe> getUserCart (){
    return userCart;
  }

  //tambah item ke keranjang
  void addItemToCart(Shoe shoe){
    userCart.add(shoe);
    notifyListeners();
  }

  //remove item dari keranjang
  void removeItemToCart(Shoe shoe){
    userCart.remove(shoe);
    notifyListeners();
  }

  double calculateTotalPayment() {
    return double.parse(userCart.fold(0.0, (total, shoe) => total + shoe.price).toStringAsFixed(3));
  }

}