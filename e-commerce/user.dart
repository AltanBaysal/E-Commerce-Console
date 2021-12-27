import 'dart:io';
import 'card.dart';

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

      List<Card> selectedCard = cards.where((element) => element.cardNumber == cardNumber).toList();
      
      if(selectedCard.isNotEmpty){
        return selectedCard.first.index;
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
