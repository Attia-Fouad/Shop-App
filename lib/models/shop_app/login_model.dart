class ShopLoginModel
{
  bool? status;
  String? message;
  UserData? data ;
  ShopLoginModel.fromJson(json)
  {
    status= json['status'];
    message= json['message'];
    data= json['data'] !=null?UserData.fromJson(json['data']) : null;
  }
}

class UserData
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;
  String? token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.image,
  //   this.point,
  //   this.credit,
  //   this.token,
  // });


 // named constructor
  UserData.fromJson(json)
  {
    id= json['id'];
    name= json['name'];
    email= json['email'];
    phone= json['phone'];
    image= json['image'];
    point= json['point'];
    credit= json['credit'];
    token= json['token'];
  }


}


