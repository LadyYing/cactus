class Mplumose{

  ///// Field //////////
   String? image, image1, image2, image3, image4, image5, image6, image7, image8, image9,
          botname, comname, oname, des, propagation, sun, water, soil, fertilizer, pest;
 
  //// Method ////
  Mplumose ( 
    this.image, this.image1, this.image2, this.image3, this.image4, 
    this.image5, this.image6, this.image7, this.image8, this.image9,
    this.botname, this.comname,  this.oname, this.des, this.propagation, 
    this.sun, this.water, this.soil, this.fertilizer, this.pest,
  );

  Mplumose.fromMap(Map <String?, dynamic> map) {
    image = map['image'];
    image = map['image1'];
    image2 = map['image2'];
    image3 = map['image3'];
    image4 = map['image4'];
    image5 = map['image5'];
    image6 = map['image6'];
    image7 = map['image7'];
    image8 = map['image8'];
    image9 = map['image9'];
    botname = map['botname'];
    comname = map['comname'];
    oname = map['oname'];
    des = map['des'];
    propagation = map['propagation'];
    sun = map['sun'];
    water = map['water'];
    soil = map['soil'];
    fertilizer = map['fertilizer'];
    pest = map['pest'];
  }
}
