import 'dart:io';

enum State {selected,exit,unselected} 

enum PersonnelActions{PrintProductTable,ChangeNumberOfProduct,CustomerDebt}


//enum PaymentMethods{CreditCard,BankCard,Cash,Debt} //kullanımı yok

void main(List<String> args) {
  Objectcreator.createAllObject();
  Interface.Start();
}


//bu fonksiyonları statik mi yapmalıyım yoksa mainin içinde tanımlıyıp mı kullanmalıyım

class Interface {
  static late UserType selectedUserType;
  static late PersonnelActions selectedPersonnelActions;
  

  static Start(){
    State loginState = State.unselected;

    while(loginState != State.exit){  
      Interface.printAction();
      loginState = Interface.getActions();

      if(loginState == State.selected) takeAction();

      print("");
    }
  }
  
  static printAction(){
    print("Select your Action");
    print("For customer press 1");
    print("For personnel press 2");
    print("For enter tpye exit");
  }
  
  static getActions(){
    
    String? action = stdin.readLineSync();

    switch(action!.toLowerCase()){
      case "1" :
      selectedUserType = UserType.customer;
      return State.selected;

      case "2":
      selectedUserType = UserType.personnel;
      return State.selected;

      case "exit":
      return State.exit;

      default :{
        print("Enter valid action");
        return State.unselected;
      }
    }


  }
  
  static takeAction(){
    switch(selectedUserType){
      case UserType.customer:
      customerActions();
      break;

      case UserType.personnel:
      personnelActionInteface();
      break;
    }
  }


//Custermer funcs
  static customerActions(){
    
  }


//Personnel funcs
  static personnelActionInteface(){
    State personnelActionState = State.unselected;
    bool isLoggin = personnelLogin();
    while(isLoggin && personnelActionState != State.exit){

      personnelPrintActions();
      personnelActionState = personnelGetActions();

      if(personnelActionState == State.selected) takePersonnelAction();


    }
  }
  
  static personnelPrintActions(){
    print("Select your Action");
    print("For print product table press 1");
    print("For change number of product press 2");
    print("For get customer debt press 3");
    print("For exit enter exit");
  }
  
  static personnelGetActions(){
    
    String? action = stdin.readLineSync();

    switch (action!.toLowerCase()){
      case "1":
      selectedPersonnelActions = PersonnelActions.PrintProductTable;
      return State.selected;

      case "2":
      selectedPersonnelActions = PersonnelActions.ChangeNumberOfProduct;
      return State.selected;

      case "3":
      selectedPersonnelActions = PersonnelActions.CustomerDebt;
      return State.selected;

      case "exit":
      return State.exit;

      default :{
        print("Enter valid action");
        return State.unselected;
      }
      
    }
    

  }

  static takePersonnelAction(){
    switch (selectedPersonnelActions){
      case PersonnelActions.ChangeNumberOfProduct:
      changeNumberOfProduct();
      break;

      case PersonnelActions.CustomerDebt:
      getCustomerDebt();
      break;

      case PersonnelActions.PrintProductTable:
      printProductTable();
      break;
    }
  }


  static bool personnelLogin(){
    while(true){
      print("for exit type exit");
      print("Enter username");
      String username = stdin.readLineSync() ?? "";

      if(username.toLowerCase() == "exit") return false;

      List<Personnel> personnel = personnels.where((element) => element._username == username).toList();
      if(personnel.isEmpty){
        print("Username not found. Try again");
        continue;
      }

      print("for exit type exit");
      print("Enter password");
      String password = stdin.readLineSync() ?? "";
      if(password.toLowerCase() == "exit") return false;

      if(!personnel.first.passwordChecker(password)) continue;

      return true;
    }

  }

  

  //bu iki fonksiyonu while a koy
  static changeNumberOfProduct(){
    while(true){
      products.forEach((element) {
        print("${element.listIndex +1} - ${element.productName}");
      });

      print("Enter product name");
      String? productname = stdin.readLineSync();
      if(productname == null){
        print("Enter valid action");
        continue;        
      }

      List<Product> selectedproduct = products.where((element) => element.productName == productname).toList();
      if(selectedproduct.isEmpty){
        print("Product not found");
        continue;
      }
      
      print("Enter new product number");
      int ? numberOfProduct = int.tryParse(stdin.readLineSync().toString());
      if(numberOfProduct == null){
        print("just use numbers");
        continue;
      }

      selectedproduct.first.setnumberOfProduct(numberOfProduct);
      break;
    }
  }

  static getCustomerDebt(){
    while(true){
      customers.forEach((element) {
        print("${element.index +1} - ${element.username}");
      });

      print("Enter Customer name");
      String? customername = stdin.readLineSync();

      List<Customer> selectedcustomer = customers.where((element) => element._username == customername).toList();

      if(selectedcustomer.isEmpty){
        print("Customername not found\n");
        continue;
      }else{
        print("${selectedcustomer.first.username} has a debt ${selectedcustomer.first.totalDebt}");
        break;
      }

    }
  }
  
  static printProductTable(){
    print("Number - Product Name - Number Of Product - Price Of Product");

    products.forEach((element) {
      print("${element.listIndex+1} - ${element.productName} - ${element.numberOfProduct} - ${element.priceOfProduct}");
    });
  }
}







class Objectcreator{
  static createAllObject(){
    customercreator("Customer1", 120);
    Objectcreator.personnelcreator("Personnel1", "123456");

    var i =0;
    ProductType.values.forEach((type) {
      i++;
      String productname = type.toString().split('.').elementAt(1);
      Objectcreator.productcreator(type, productname, i, i*10);
    });
  }
  
  static productcreator(ProductType productType,String productName,int numberOfProduct,double priceOfProduct){
    int listIndex = products.length;

    switch(productType){
      case ProductType.Candy:{
        Candy newproduct = Candy(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Chips:{
        Chips newproduct = Chips(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Chocolate:{
        Chocolate newproduct = Chocolate(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Cookies:{
        Cookies newproduct = Cookies(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Crakers:{
        Crakers newproduct = Crakers(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.FruitSnacks:{
        FruitSnacks newproduct = FruitSnacks(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.IceCream:{
        IceCream newproduct = IceCream(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Juice:{
        Juice newproduct = Juice(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.PopCorn:{
        PopCorn newproduct = PopCorn(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.SnackNuts:{
        SnackNuts newproduct = SnackNuts(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
    }
  }

  static customercreator(String username,double cash){
    int listIndex = customers.length;
    Customer newcustomer = Customer(cash, username,listIndex);
    customers.add(newcustomer);
  }

  static personnelcreator(String username,String password){
    int listIndex = personnels.length;
    Personnel newpersonnel = Personnel(username, listIndex, password);
    personnels.add(newpersonnel);
  }

}






//User
enum UserType{customer,personnel}

class User{
  late String _username;
  late UserType _usertype;
  late int _index;

  String get username => _username;
  UserType get usertype => _usertype;
  int get index => _index;

}

List<Customer> customers =[];
class Customer implements User{
  
  String _username;
  UserType _usertype = UserType.customer;
  int _index;
  double _cash;
  double _totalDebt =0;

  List<Card> cards =[];
  

  String get username => _username;
  UserType get usertype => _usertype;
  int get index => _index;
  double get cash => _cash;
  double get totalDebt => _totalDebt;
  
  Customer(this._cash,this._username,this._index);

  void addCard(CardType cardType,int _cardNumber,int _pin,double _balance){
    int listIndex = cards.length;

    switch (cardType){
      case CardType.CreditCard:{
        CreditCard newCard = CreditCard(_cardNumber, _pin, _balance,listIndex);
        cards.add(newCard);
      }
      break;
      case CardType.BankCard :{
        BankCard newCard = BankCard(_cardNumber, _pin, _balance,listIndex);
        cards.add(newCard);
      }
      break;
    }
  }
  
}

List<Personnel> personnels = [];
class Personnel implements User{
  String _username;
  UserType _usertype = UserType.personnel;
  int _index;
  String _password;

  bool _isAccessBlocked = false;
  int _wrongEntries= 0;
  
  
  String get username => _username;
  UserType get usertype => _usertype;
  int get index => _index;
  bool get isCardBlocked => _isAccessBlocked;

  Personnel(this._username,this._index,this._password);

  bool passwordChecker(String password){
    if(_isAccessBlocked){
      print("your access blocked . You can't Login");
      return false;
    }
    
    if(this._password == password ){
      wrongEntriesSetter(false);
      return true;
    }else {
      print("Wrong password");
      wrongEntriesSetter(true);
      return false;
    }
  }
  
  void wrongEntriesSetter(bool isEntriesWrong) {
    if(isEntriesWrong){
      ++_wrongEntries;
      print("remaining entry ${3 - _wrongEntries}");
      if(_wrongEntries >= 3){
        _isAccessBlocked = true;
        print("Your access has blocked");
      }
    }
    else{
      _wrongEntries = 0;
    }
  }
}




//Cards 
enum CardType{CreditCard,BankCard}

class Card {
  late int _cardNumber;  
  late int _pin;
  late double _balance;
  late int _index;

  bool _isCardBlocked = false;

  int _wrongEntries= 0;


  //getter
  int get cardNumber => _cardNumber;
  int get pin => _pin;
  double get balance => _balance;
  bool get isCardBlocked => _isCardBlocked;
  int get index => _index;

  


  bool PasswordChecker(int passowrd){
    if(_pin == passowrd){
      wrongEntriesSetter(false);
      return true;
    }
    wrongEntriesSetter(true);
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
 
  void wrongEntriesSetter(bool isEntriesWrong) {
    if(isEntriesWrong){
      ++_wrongEntries;
      print("remaining entry ${3 - _wrongEntries}");
      if(_wrongEntries >= 3){
        _isCardBlocked = true;
        print("Your access has blocked");
      }
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
  int _index;

  bool _isCardBlocked = false;

  int _wrongEntries= 0;


  int get cardNumber => _cardNumber;
  int get pin => _pin;
  double get balance => _balance;
  bool get isCardBlocked => _isCardBlocked;
  int get index => _index;

  CreditCard(this._cardNumber,this._pin,this._balance,this._index);  

  @override
  bool PasswordChecker(int passowrd){
    if(_isCardBlocked){
      print("your access blocked . You can't Login");
      return false;
    }
    if(_pin == passowrd){
      wrongEntriesSetter(false);
      return true;
    }
    wrongEntriesSetter(true);
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
      print("remaining entry ${3 - _wrongEntries}");
      if(_wrongEntries >= 3){
        _isCardBlocked = true;
        print("Your access has blocked");
      }
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
  int _index;

  bool _isCardBlocked = false;

  int _wrongEntries= 0;


  int get cardNumber => _cardNumber;
  int get pin => _pin;
  double get balance => _balance;
  bool get isCardBlocked => _isCardBlocked;
  int get index => _index;


  BankCard(this._cardNumber,this._pin,this._balance,this._index);  

  @override
  bool PasswordChecker(int passowrd) {
    if(_isCardBlocked){
      print("your access blocked . You can't Login");
      return false;
    }

    if(_pin == passowrd){
      wrongEntriesSetter(false);
      return true;
    }
    wrongEntriesSetter(true);
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




//Product 
List<Product> products =[];
enum ProductType{Chips,Crakers,Cookies,SnackNuts,Chocolate,FruitSnacks,IceCream,Candy,PopCorn,Juice}

class Product{
  late String _productName;
  late int _listIndex; 

  late int _numberOfProduct;
  late double _priceOfProduct;


  //setter
  void setnumberOfProduct(int numberOfProduct){
    this._numberOfProduct = numberOfProduct;
  }

  void setpriceOfProduct(double priceOfProduct){
    this._priceOfProduct = priceOfProduct;
  }


  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  void productReduction(int amountToBeReduce){
    _numberOfProduct -= amountToBeReduce;
  }


  //getters
  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 
}


class Chips implements Product{
  ProductType productType = ProductType.Chips;
  String _productName;
  int _listIndex; 

  int _numberOfProduct;
  double _priceOfProduct;

  Chips(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);

  

  //getters
  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex;


  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  }

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Crakers implements Product{
  ProductType productType = ProductType.Crakers;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Crakers(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Cookies implements Product{
  ProductType productType = ProductType.Cookies;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Cookies(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class SnackNuts implements Product{
  ProductType productType = ProductType.SnackNuts;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  SnackNuts(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Chocolate implements Product{
  ProductType productType = ProductType.Chocolate;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Chocolate(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class FruitSnacks implements Product{
  ProductType productType = ProductType.FruitSnacks;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  FruitSnacks(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class IceCream implements Product{
  ProductType productType = ProductType.IceCream;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  IceCream(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Candy implements Product{
  ProductType productType = ProductType.Candy;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Candy(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class PopCorn implements Product{
  ProductType productType = ProductType.PopCorn;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  PopCorn(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Juice implements Product{
  ProductType productType = ProductType.Juice;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Juice(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount) {
    if(desiredAmount<= _numberOfProduct) return true;
    else return false;
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
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

