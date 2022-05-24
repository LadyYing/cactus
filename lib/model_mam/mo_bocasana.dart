class MBocasana {
  ///// Field //////////
   String image, image1, image2, image3, image4, image5, image6, image7, image8, image9,
          botname, comname, oname, des, propagation, sun, water, soil, fertilizer, pest;
 
  //// Method ////
  MBocasana ({
    required this.image, required this.image1, required this.image2, required this.image3, required this.image4, 
    required this.image5, required this.image6, required this.image7, required this.image8, required this.image9,
    required this.botname, required this.comname,  required this.oname, required this.des, required this.propagation, 
    required this.sun,  required this.water, required this.soil, required this.fertilizer, required this.pest,
  });

  Map <String, dynamic> toJson() => {
    image:    'image',
    image1:   'image1',
    image2:   'image2',
    image3:   'image3',
    image4:   'image4',
    image5:   'image5',
    image6:   'image6',
    image7:   'image7',
    image8:   'image8',
    image9:   'image9',
    botname:  'botname',
    comname:  'comname',
    oname:    'oname',
    des:      'des',
    propagation:  'propagation',
    sun:      'sun',
    water:    'water',
    soil:     'soil',
    fertilizer:   'fertilizer',
    pest:     'pest',
  };

  factory MBocasana.formJson (Map<String, dynamic> json) => 
    MBocasana(
      image:    json['image'], 
      image1:   json['image1'], 
      image2:   json['image2'], 
      image3:   json['image3'], 
      image4:   json['image4'], 
      image5:   json['image5'], 
      image6:   json['image6'], 
      image7:   json['image7'], 
      image8:   json['image8'], 
      image9:   json['image9'], 
      botname:  json['botname'], 
      comname:  json['comname'], 
      oname:    json['oname'], 
      des:      json['des'], 
      propagation:  json['propagation'], 
      sun:      json['sun'], 
      water:    json['water'], 
      soil:     json['soil'], 
      fertilizer:   json['fertilize'],
      pest:     json['pest'],
    );

  static fromJson(m) {}
}