import 'dart:io';

enum LoginState {customer,personel,exit,unselected}

void main(List<String> args) {
  LoginState loginState;

  while(true){ 
    Interface.printActions();
    loginState = Interface.getActions();

    print(loginState);
    print("");

    if(loginState == LoginState.exit) break;

  }
}


//bu fonksiyonları statik mi yapmalıyım yoksa mainin içinde tanımlıyıp mı kullanmalıyım

class Interface {
  static printActions(){
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
}






class Product{
  String _productName;
  int _listIndex; 

  int _numberOfProduct;
  double _priceOfProduct;

  Product(this._numberOfProduct,this._productName,this._priceOfProduct,this._listIndex);


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