class Food{
  String _image;
  String _name;
  int _price;

  Food(this._image, this._name, this._price);

  String get getImage{
    return this._image;
  }

  String get getName{
    return this._name;
  }

  int get getPrice{
    return this._price;
  }
}