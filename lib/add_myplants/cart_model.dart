class CartModel {
  ///// Field //////////
  String? image, botname, comname, oname;
 
  //// Method ////
  CartModel ({this.image, this.botname, this.comname, this.oname});

  Map <String?, dynamic> toJson() => {
    image:    'image',
    botname:  'botname',
    comname:  'comname',
    oname:    'oname',
  };

  CartModel.fromMap(Map <String?, dynamic> map) {
    image = map['image'];
    botname = map['botname'];
    comname = map['comname'];
    oname = map['oname'];
  }

  static Future<List<CartModel>> loadData() async {
    return Future.delayed(const Duration(seconds:3), () {
      return[
        CartModel(
          image: 'https://firebasestorage.googleapis.com/v0/b/cuctus2022.appspot.com/o/Cactus%2FMPlumose%2FMP1.jpg?alt=media&token=e0b97429-f264-4f06-a764-1942a75c79ac', 
          botname: 'Mammillaria plumosa F.A.C.Weber',
          comname: 'Feather Cactus',
          oname: 'แมมขนนก',
        ),
      ];    
    });
  }
}


