import 'package:flutter/material.dart';
import 'package:just_eat/Constants/c.dart';


class Food{
  String _image; //= C.imageLink+'ok.jpg';
  String _name;// = ' Bath';
  // int _quantity;
  int _price;

  Food(this._image,this._name,this._price);
  
  String getImage(){
    return _image;
  }

  String getName(){
    return _name;
  }

  // int getQuantity(){
  //   return _quantity;
  // }

  int getPrice(){
    return _price;
  }
}