import 'dart:io';

enum CardType{CreditCard,BankCard} 

class Card {
  CardType cardType;
  int _cardNumber;  
  int _pin;
  double _balance;

  Card(this._cardNumber,this._pin,this._balance,this.cardType);

  bool _isCardBlocked = false;
  int _wrongEntries= 0;


  //getter
  int get cardNumber => _cardNumber;
  int get pin => _pin;
  double get balance => _balance;
  bool get isCardBlocked => _isCardBlocked;



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
          return withdrawMoney(bill);
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


class CreditCard extends Card{
  CreditCard(int _cardNumber,int _pin,double _balance,) :super(_cardNumber,_pin,_balance,CardType.CreditCard);  
}

class BankCard extends Card{
  BankCard(int _cardNumber,int _pin,double _balance,) :super(_cardNumber,_pin,_balance,CardType.BankCard); 
}


extension CardExtension on CardType{
  Card cardCreate(int _cardNumber,int _pin,double _balance,){
    switch(this){
      case CardType.CreditCard:{
        return CreditCard(_cardNumber, _pin, _balance);
      }
      case CardType.BankCard:{
        return BankCard(_cardNumber, _pin, _balance);
      }
    }
  }

}
