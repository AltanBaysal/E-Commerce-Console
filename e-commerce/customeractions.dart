import 'dart:io';
import 'funcs.dart';
import 'product.dart';
import 'user.dart';

enum PaymentMethods{Card,Cash,Debt}
Customeractions newCustomeractions = Customeractions();
class Customeractions{
  late int indexofproduct; 
  late int desiredAmount;
  late int indexofcustomer;
  


  actionInterface(){
    bool islogin = login();
    
    while(islogin){
      Funcs.printProductTable();

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

      var personnel = customers.where((element) => element.username == username).toList();
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
      print("for cash press 2  You have ${customers[indexofcustomer].cash} cash");
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
