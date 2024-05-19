import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokosepatu/komponen/shoetile.dart';
import 'package:tokosepatu/models/cart.dart';
import 'package:tokosepatu/models/shoe.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  TextEditingController _controller = TextEditingController();
  List<Shoe> daftarSepatu = [];

  @override
  void initState() {
    super.initState();
    daftarSepatu = Provider.of<Cart>(context, listen: false).getShoeList();
  }

  //memperbarui daftar yang difilter berdasarkan kueri pencarian
  void perbaruipencarian(String kueri){
    setState(() {
      daftarSepatu = Provider.of<Cart>(context, listen: false).getShoeList().where((shoe) => shoe.name.toLowerCase().contains(kueri.toLowerCase())).toList();
    });
  }

  //tambah sepatu ke keranjang
  void addShoeToCart(Shoe shoe){
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);

    //success add
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Sukses Menambah!!!'),
      content: Text('Cek Keranjangmu'),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, value, child)=>
      Column(
        children: [
          //search
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              onChanged: (kueri) => perbaruipencarian(kueri),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20)
              ),
              hintText: 'Cari di sini...'
            )
            )
          ),
    
          SizedBox(height: 25,),
    
          //hot picks
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Produk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                
              ],
            ),
          ),
    
          SizedBox(height: 10,),
    
          //list untuk dijual
          Expanded(
            child: ListView.builder(
              itemCount: daftarSepatu.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
    
              //create a shoe
              Shoe shoe = daftarSepatu[index];
    
              //return the shoe
              return ShoeTile(
                shoe: shoe,
                onTap: () => addShoeToCart(shoe),
              );
            }),
          ),
    
          Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 25.0),
            child: Divider(
              color: Colors.white,
            ),
          )
          
        ],
      ),
    );
  }
}