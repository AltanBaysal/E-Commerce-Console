import 'dart:io';
import 'card.dart';
import 'customerActions.dart';
import 'personnelActions.dart';

enum UserType{customer,personnel}

extension ExtensionUserType on UserType{
  userChooser(){
    switch(this){
      case UserType.customer:
      newCustomerActions.actionInterface();
      break;

      case UserType.personnel:
      newPersonnelActions.actionInterface();
      break;
    }
  }
}


class User{
  String _username;
  UserType _usertype;

  User(this._username,this._usertype);

  String get username => _username;
  UserType get usertype => _usertype;
}

List<Customer> customers =[];
class Customer extends User{
  double _cash;

  double _totalDebt =0;
  List<Card> cards =[];
  
  double get cash => _cash;
  double get totalDebt => _totalDebt;
  
  Customer(this._cash,String _username) :super(_username,UserType.customer);


  void addCard(CardType cardType,int _cardNumber,int _pin,double _balance){
    cards.add(cardType.cardCreate(_cardNumber, _pin, _balance));
  }

  int selectCard(){
    while(true){
      printCardList();
      print("For exit type exit");
      print("Enter credit card number");
      String action = stdin.readLineSync().toString();
      if(action.toLowerCase() == "exit") return -1;

      int? cardNumber = int.tryParse(action);
      if(cardNumber == null){
        print("Only numbers allowed");
        continue;
      }

      for(var i =0;i<cards.length;i++){
        if(cards[i].cardNumber == cardNumber){
          return  i;
        }
      }
    
      print("Enter valid action");
    }
  }

  printCardList(){
    cards.forEach((element) {
        print("${element.cardNumber} - ${element.balance} - ${element.cardType.toString().split('.').elementAt(1)}");
    });
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
    if(indexofCard == -1) return false;
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
class Personnel extends User{
  String _password;

  bool _isAccessBlocked = false;
  int _wrongEntries= 0;

  
  bool get isCardBlocked => _isAccessBlocked;

  Personnel(this._password,String _username) : super(_username,UserType.personnel);

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
