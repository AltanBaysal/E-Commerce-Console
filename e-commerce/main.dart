import 'dart:io';

enum State {selected,exit,unselected} 

void main(List<String> args) {
  
  newObjectcreator.createAllObject();
  newInterface.Start();
  
}


Interface newInterface = Interface();
class Interface {
  late UserType selectedUserType;
  
  Start(){
    State loginState = State.unselected;

    while(loginState != State.exit){  
      printAction();
      loginState = getActions();

      if(loginState == State.selected) takeAction();
      print("");
    }
  }
  
  printAction(){
    print("Select your Action");
    print("For customer press 1");
    print("For personnel press 2");
    print("For enter tpye exit");
  }
  
  getActions(){
    
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
  
  takeAction(){
    switch(selectedUserType){
      case UserType.customer:
      newCustomeractions.actionInterface();
      break;

      case UserType.personnel:
      newPersonnelactions.actionInterface();
      break;
    }
  }

}


enum PaymentMethods{Card,Cash,Debt}
Customeractions newCustomeractions = Customeractions();
class Customeractions{
  late int indexofproduct; 
  late int desiredAmount;
  late int indexofcustomer;
  

  actionInterface(){
    bool islogin = login();
    while(islogin){

      printProductTable();
      indexofproduct = getNumber();
      if(indexofproduct == -1) break;
      
      desiredAmount = getdesiredAmount();
      
      if(products[indexofproduct].isThereEnoughProduct(desiredAmount)) {
        selectPaymentMethods();
      }
    }
  }

  bool login(){
    while(true){
      print("for exit type exit");
      print("Enter username");
      String username = stdin.readLineSync() ?? "";

      if(username.toLowerCase() == "exit") return false;

      List<Customer> personnel = customers.where((element) => element._username == username).toList();
      if(personnel.isNotEmpty){
        indexofcustomer =  personnel.first.index;
        return true;
      }
      print("Username not found. Try again");
    }
  }
  

  int getdesiredAmount(){
    while(true){
      print("Enter how many items you want to buy");  
      int? desiredamount = int.tryParse(stdin.readLineSync().toString());
    
      if(desiredamount == null){
        print("Only numbers allowed");
      }
      else if(desiredamount > 0){
        return desiredamount;
      }
    }
  }
 
  int  getNumber(){
    while(true){
      print("For exit type exit");
      print("Enter the product number you want to buy");  

      String? action = stdin.readLineSync().toString();
      if(action.toLowerCase() == "exit") return -1;

      int? number = int.tryParse(action);

      if(number == null){
        print("Only numbers allowed");
      }
      else if(products.length>=number && number > 0){
        return number-1;
      }else{
        print("enter valid number");
      }
    }
  }


  selectPaymentMethods(){
    double priceOfProduct = products[indexofproduct].priceOfProduct;;
    double bill = desiredAmount*priceOfProduct;

    while(true){
      PaymentMethods? selectedPaymentMethods;
      print("Amount to be paid $bill");
      print("Select a payment methods");
      print("for card press 1");
      print("for cash press 2  You have ${customers[indexofcustomer]._cash} cash");
      print("for debt press 3");

      int action = int.tryParse(stdin.readLineSync().toString()) ?? -1;

      switch (action){
        case 1:
          selectedPaymentMethods = PaymentMethods.Card;
        break;

        case 2:
          selectedPaymentMethods = PaymentMethods.Cash;
        break;

        case 3:
          selectedPaymentMethods = PaymentMethods.Debt;
        break;

        default :{
          print("Enter valid action");
        }
      }

      if(selectedPaymentMethods != null){
        if(buyProduct(selectedPaymentMethods,bill)) break;
      }

    }
  }

  bool buyProduct(PaymentMethods selectedPaymentMethods,double bill){
    
    switch (selectedPaymentMethods){
      case PaymentMethods.Card :{
        if(customers[indexofcustomer].payByCard(bill)){
          products[indexofproduct].productReduction(desiredAmount);
          return true;
        }
        return false;
      }
        
      case PaymentMethods.Cash:
        if(customers[indexofcustomer].payByCash(bill)){
          products[indexofproduct].productReduction(desiredAmount);
          return true;
        }
        return false;

      case PaymentMethods.Debt:
        if(customers[indexofcustomer].payByDebt(bill)){
          products[indexofproduct].productReduction(desiredAmount);
          return true;
        }
        return false;
    }
  }
}


enum PersonnelActions{PrintProductTable,ChangeNumberOfProduct,CustomerDebt}
Personnelactions newPersonnelactions = Personnelactions();
class Personnelactions{
  late PersonnelActions selectedPersonnelActions;

  actionInterface(){
    State personnelActionState = State.unselected;
    bool isLoggin = login();
    while(isLoggin && personnelActionState != State.exit){

      printActions();
      personnelActionState = getAction();

      if(personnelActionState == State.selected) takeAction();
    }
  }

  bool login(){
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
  
  printActions(){
    print("Select your Action");
    print("For print product table press 1");
    print("For change number of product press 2");
    print("For get customer debt press 3");
    print("For exit enter exit");
  }
  
  getAction(){
    
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

  takeAction(){
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


  //func
  changeNumberOfProduct(){
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
        print("Only numbers allowed");
        continue;
      }

      selectedproduct.first.setnumberOfProduct(numberOfProduct);
      break;
    }
  }

  getCustomerDebt(){
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
  
  
}



Objectcreator newObjectcreator = Objectcreator();
class Objectcreator{
  createAllObject(){
    customercreator("Customer1", 120);
    addCreditCard();

    personnelcreator("Personnel1", "123456");
    var i =0;
    ProductType.values.forEach((type) {
      i++;
      String productname = type.toString().split('.').elementAt(1);
      productcreator(type, productname, i, i*10);
    });
  }
  

  productcreator(ProductType productType,String productName,int numberOfProduct,double priceOfProduct){
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

  customercreator(String username,double cash){
    int listIndex = customers.length;
    Customer newcustomer = Customer(cash, username,listIndex);
    customers.add(newcustomer);
  }

  personnelcreator(String username,String password){
    int listIndex = personnels.length;
    Personnel newpersonnel = Personnel(username, listIndex, password);
    personnels.add(newpersonnel);
  }

  addCreditCard(){
    customers.forEach((element) {
      element.addCard(CardType.BankCard, 344541507145330, 1234, 500);
      element.addCard(CardType.CreditCard, 344541507145331, 1234, 700);
      element.addCard(CardType.CreditCard, 344541507145332, 1234, 800);
    });
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
  
  int selectCard(){
    while(true){
      cards.forEach((element) {
        print("${element.cardNumber} - ${element.balance} - ${element.cardType.toString().split('.').elementAt(1)}");
      });

      print("Enter credit card number");
      int? cardNumber = int.tryParse(stdin.readLineSync().toString());

      if(cardNumber == null){
        print("Only numbers allowed");
        continue;
      }

      List<Card> selectedCard = cards.where((element) => element._cardNumber == cardNumber).toList();
      
      if(selectedCard.isNotEmpty){
        return selectedCard.first._index;
      }else{
        print("Enter valid action");
      }

    }
  }

  bool payByCash(double bill){
    if(bill<=_cash){
      _cash -= bill;
      print("Transaction performed successfully");
      return true;
    }else{
      print("You don't have enough Cash to pay");
      return false;
    }
  }

  bool payByCard(double bill){
    int indexofCard = selectCard();
    return cards[indexofCard].buy(bill);
  }

  bool payByDebt(double bill){
    if(!isThereEnoughMoney(bill)){
      print("Transaction performed successfully");
      _totalDebt += bill;
      return true;
    }
    else{

      return false;
    }
  }


  bool isThereEnoughMoney(double bill){
    if(_cash >= bill){
      print("You have enough cash to pay");
      return true;
    }

    bool isThereEnoughMoneyCard = false;
    cards.forEach((element) {
      if(element.balance >= bill){
        isThereEnoughMoneyCard = true;
      }
    });
    if(isThereEnoughMoneyCard){
      print("You have enough money in your card to pay");
      return true;
    }

    return false;
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
  late CardType cardType;
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

  //geliştirmeli

  bool buy(double bill){
    while(true){
      print("For exit type exit");
      print("Enter pin");

      String? actions = stdin.readLineSync();
      if(actions == null){
        print("Enter valid action");
      }
      
      else if(actions.toLowerCase() == "exit"){
        return false;
      }
      else{
        int? pin = int.tryParse(actions);
        if(pin == null){
           print("Only numbers allowed");
        }
        
        else if(PasswordChecker(pin)){
          if(withdrawMoney(bill)){
            return true;
          }
          else{
            return false;
          }
        }
      }
    }
  }

  bool PasswordChecker(int passowrd){
    if(_pin == passowrd){
      wrongEntriesSetter(false);
      return true;
    }
    wrongEntriesSetter(true);
    return false;
  }
  
  bool withdrawMoney(double disbursement){
    if(disbursement<=this._balance){
      this._balance -=disbursement;
      print("Transaction performed successfully");
      return true;
    }
    else{
      print("You don't have enough money in your card to pay");
      return false;
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
  bool buy(double bill){
    while(true){
      print("For exit type exit");
      print("Enter pin");
      String? actions = stdin.readLineSync();
      if(actions == null){
        throw Exception("actions cant be null");
      }
      
      else if(actions.toLowerCase() == "exit"){
        return false;
      }
      else{
        int? pin = int.tryParse(actions);
        if(pin == null){
           print("Only numbers allowed");
        }

        else if(PasswordChecker(pin)){
          withdrawMoney(bill);
          return true;
        }

      }
    }
  }

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
  bool withdrawMoney(double disbursement){
    if(disbursement<=this._balance){
      this._balance -=disbursement;
      print("Transaction performed successfully");
      return true;
    }
    else{
      print("You don't have enough money in your card to pay");
      return false;
    }
  }

  @override
  void wrongEntriesSetter(bool isEntriesWrong) {
    
    if(isEntriesWrong){
      ++_wrongEntries;
      print("Wrong password");
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
  bool buy(double bill){
    while(true){
      print("For exit type exit");
      print("Enter pin");
      String? actions = stdin.readLineSync();
      if(actions == null){
        throw Exception("actions cant be null");
      }
      
      else if(actions.toLowerCase() == "exit"){
        return false;
      }
      else{
        int? pin = int.tryParse(actions);
        if(pin == null){
           print("Only numbers allowed");
        }

        else if(PasswordChecker(pin)){
          withdrawMoney(bill);
          return true;
        }

      }
    }
  }

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
  bool withdrawMoney(double disbursement){
    if(disbursement<=this._balance){
      this._balance -=disbursement;
      print("Transaction performed successfully");
      return true;
    }
    else{
      print("You don't have enough money in your card to pay");
      return false;
    }
  }

  @override
  void wrongEntriesSetter(bool isEntriesWrong) {
    
    if(isEntriesWrong){
      ++_wrongEntries;
      print("Wrong password");
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




//Product
printProductTable(){
  print("Product name - Product Price - Number of Prodcut");
  products.forEach((element) {
    print("${element.listIndex +1} - ${element.productName} - ${element.priceOfProduct} - ${element.numberOfProduct}");
  });
}

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
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
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
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}