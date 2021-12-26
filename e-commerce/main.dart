import 'dart:io';

enum LoginState {selected,exit,unselected} 

enum UserType{customer,personel} 
late UserType selectedUserType;

enum CardType{CreditCard,BankCard}

void main(List<String> args) {
  
  Interface.createAllObject();

  Interface.Start();
}


//bu fonksiyonları statik mi yapmalıyım yoksa mainin içinde tanımlıyıp mı kullanmalıyım

class Interface {
  static Start(){
    LoginState loginState = LoginState.unselected;

    while(loginState != LoginState.exit){  
      Interface.printAction();
      loginState = Interface.getActions();

      if(loginState == LoginState.selected) takeAction();

      print("");
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
      selectedUserType = UserType.customer;
      return LoginState.selected;

      case "2":
      selectedUserType = UserType.personel;
      return LoginState.selected;

      case "exit":
      return LoginState.exit;

      default :{
        print("Enter valid action");
        return LoginState.unselected;
      }
    }


  }
  
  static takeAction(){
    switch(selectedUserType){
      case UserType.customer:
      print("customer");
      break;

      case UserType.personel:
      print("personel");
      break;
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



//User
abstract class User{

}

List<Customer> customers =[];
class Customer implements User{
  UserType usertype = UserType.customer;
  double cash;

  Customer(this.cash);
}

List<Personel> personels = [];
class Personel implements User{
  UserType usertype = UserType.personel;

}

/*
mixin enterPassword{
  late int _pin; 
  
  bool PasswordChecker(int passowrd){
    if(_pin == passowrd){
      return true;
    }
    return false;
  }
}*/





//Cards
class Card {
  late int _cardNumber;  
  late int _pin;
  late double _balance;

  bool _isCardBlocked = false;

  int _wrongEntries= 0;


  //getter
  int get cardNumber => _cardNumber;
  int get pin => _pin;
  double get balance => _balance;
  bool get isCardBlocked => _isCardBlocked;

  


  bool PasswordChecker(int passowrd){
    if(_pin == passowrd){
      return true;
    }
    return false;
  }
  
  void withdrawMoney(int disbursement){
    if(disbursement<=this._balance){
      this._balance -=disbursement;
    }
    else{
      print("You don't have enough money in your card to pay");
    }
  }
 
  void wrongEntriesSetter(bool isEntriesWrong){
    if(isEntriesWrong){
      ++_wrongEntries;
      if(_wrongEntries >= 3) _isCardBlocked = true;
    }
    else{
      _wrongEntries = 0;
    }
    
  }

}

class CreditCard implements Card{
  CardType cardType = CardType.CreditCard;

  int _cardNumber;
  int _pin;
  double _balance;

  bool _isCardBlocked = false;

  int _wrongEntries= 0;


  int get cardNumber => _cardNumber;
  int get pin => _pin;
  double get balance => _balance;
  bool get isCardBlocked => _isCardBlocked;

  CreditCard(this._cardNumber,this._pin,this._balance);  

  @override
  bool PasswordChecker(int passowrd) {
    if(_pin == passowrd){
      return true;
    }
    return false;
  }

  @override
  void withdrawMoney(int disbursement) {
    if(disbursement<=this._balance){
      this._balance -=disbursement;
    }
    else{
      print("You don't have enough money in your card to pay");
    }
  }

  @override
  void wrongEntriesSetter(bool isEntriesWrong) {
    if(isEntriesWrong){
      ++_wrongEntries;
      if(_wrongEntries >= 3) _isCardBlocked = true;
    }
    else{
      _wrongEntries = 0;
    }
  }
}

class BankCard implements Card{
  CardType cardType = CardType.BankCard;
  int _cardNumber;
  int _pin;
  double _balance;

  bool _isCardBlocked = false;

  int _wrongEntries= 0;


  int get cardNumber => _cardNumber;
  int get pin => _pin;
  double get balance => _balance;
  bool get isCardBlocked => _isCardBlocked;

  BankCard(this._cardNumber,this._pin,this._balance);  

  @override
  bool PasswordChecker(int passowrd) {
    if(_pin == passowrd){
      return true;
    }
    return false;
  }

  @override
  void withdrawMoney(int disbursement) {
    if(disbursement<=this._balance){
      this._balance -=disbursement;
    }
    else{
      print("You don't have enough money in your card to pay");
    }
  }

  @override
  void wrongEntriesSetter(bool isEntriesWrong) {
    if(isEntriesWrong){
      ++_wrongEntries;
      if(_wrongEntries >= 3) _isCardBlocked = true;
    }
    else{
      _wrongEntries = 0;
    }
  }
}




//Products
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





/*
  int? takePin(){
    print("Enter card pin");
    int? pin = int.parse(stdin.readLineSync().toString());
  }
  
  void wrongEntriescounter(){
    _wrongEntries++;
    print("${3-_wrongEntries} giriş hakkınız kaldı");
    if(_wrongEntries>=3){
      this._isCardBlocked = true;
    }
  }
  
  void _actiondefray(){
    while(!_isCardBlocked){
      int? pin = takePin();

      if(pin == null){

        print("Only number allowed");
        wrongEntriescounter();

      }else if(PasswordChecker(pin)){
        
      } 
    }
  }
  
  void defray(){
    if(!_isCardBlocked){
      _actiondefray();
    }else{
      print("You cannot perform this operation because your card is blocked");
    }
  }*/

