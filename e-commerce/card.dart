import 'dart:io';

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
