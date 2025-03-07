import 'package:just_eat/Objects/Databse.dart';
import 'package:just_eat/Objects/Food.dart';

class Resturant{
  String _image;
  String _name;
  String _address;
  String _desc;
  List<Food> _menus;
  static List<Resturant> _allResturants;


  Resturant(this._image, this._name, this._address, this._desc);

  String get getImage{
    return this._image;
  }

  String get getName{
    return this._name;
  }

  String get getAddress{
    return this._address;
  }

  String get getDesc{
    return this._desc;
  }

  set setMenu(List<Food> foodList){
    this._menus = foodList;
  }

  get getMenu{
    return this._menus;
  }

  static set _setAllResturants(List<Resturant> resturants){
    if (_allResturants == null){
      _allResturants = resturants;
    }
    
  }

  static get getAllResturants{
    return _allResturants;
  }
}