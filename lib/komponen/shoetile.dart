import 'package:flutter/material.dart';
import 'package:tokosepatu/models/shoe.dart';

// ignore: must_be_immutable
class ShoeTile extends StatelessWidget {
  Shoe shoe;
  void Function()? onTap;
  ShoeTile({super.key, required this.shoe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 25),
        width: 280,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
    
            //gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(shoe.imagePath)),
    
              SizedBox(height: 10,),
    
            //deskripsi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                shoe.description,
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.left
              ),
            ),

            SizedBox(height: 10,),
    
            //harga+detail
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      //nama
                      Text(shoe.name, style: 
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
            
                      SizedBox(height: 5,),
                      //harga
                      Text('\Rp. ${shoe.price.toStringAsFixed(3)}', style: 
                      TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.left,),
                    ],
                  ),
            
                  //tambah
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      ),
                      child: Icon(Icons.add, color: Colors.white,)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}