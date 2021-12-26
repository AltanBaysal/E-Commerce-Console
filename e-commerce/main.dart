import 'dart:io';

enum LoginState {customer,personel,exit,unselected} //?
enum UserType{customer,personel} 


void main(List<String> args) {
  Interface.createAllObject();

  Interface.Star();
}



//bu fonksiyonları statik mi yapmalıyım yoksa mainin içinde tanımlıyıp mı kullanmalıyım

class Interface {
  static Star(){
    LoginState loginState = LoginState.unselected;

    while(loginState != LoginState.exit){  
      Interface.printAction();
      loginState = Interface.getActions();

      if(loginState != LoginState.exit && loginState != LoginState.unselected) takeAction(loginState);
      

    }
  }

  static printAction(){
    print("Select your Action");
    print("For customer press 1");
    print("For personel press 2");
    print("For exit tpye exit");
  }
  
  static getActions(){
    
    String? action = stdin.readLineSync();

    switch(action!.toLowerCase()){
      case "1" :
      return LoginState.customer;

      case "2":
      return LoginState.personel;

      case "exit":
      return LoginState.exit;

      default :{
        print("Enter valid action");
        return LoginState.unselected;
      }
    }


  }
  
  static takeAction(LoginState loginState){
    if(loginState == LoginState.customer){
      print("Customer");
    }
    else{
      print("Personel");
    }
  }



  static createAllObject(){
    for(var i=1;i<11;i++){
      Objectcreator.productcreator("productName$i", i, i*10);
    }
  }
}



class Objectcreator{
  static productcreator(String productName,int numberOfProduct,double priceOfProduct){
    int listIndex = products.length;
    Product newProduct = Product(productName, listIndex, numberOfProduct, priceOfProduct);
    products.add(newProduct);
  }

}





List<Product> products =[];
class Product{
  String _productName;
  int _listIndex; 

  int _numberOfProduct;
  double _priceOfProduct;

  Product(this._productName,this._listIndex,this._numberOfProduct,this._priceOfProduct);


  //setter
  void setnumberOfProduct(int numberOfProduct){
    this._numberOfProduct = numberOfProduct;
  }

  void setpriceOfProduct(double priceOfProduct){
    this._priceOfProduct = priceOfProduct;
  }


  //getters
  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 
}