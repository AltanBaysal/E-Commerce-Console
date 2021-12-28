import 'dart:io';
import 'funcs.dart';
import 'product.dart';
import 'user.dart';

enum PaymentMethods{Card,Cash,Debt}

extension PaymentExtention on PaymentMethods{
  bool buyProduct(double bill,int indexOfCustomer,int desiredAmount,int indexOfProduct){

    switch (this){
      case PaymentMethods.Card :{
        if(customers[indexOfCustomer].payByCard(bill)){
          products[indexOfProduct].productReduction(desiredAmount);
          return true;
        }
        return false;
      }
        
      case PaymentMethods.Cash:{
        if(customers[indexOfCustomer].payByCash(bill)){
          products[indexOfProduct].productReduction(desiredAmount);
          return true;
        }
        return false;
      }
        
      case PaymentMethods.Debt:{
        if(customers[indexOfCustomer].payByDebt(bill)){
          products[indexOfProduct].productReduction(desiredAmount);
          return true;
        }
        return false;
      }
    }
  }
}


CustomerActions newCustomerActions = CustomerActions();

class CustomerActions{
  late int indexOfProduct; 
  late int desiredAmount;
  late int indexOfCustomer;
  

  actionInterface(){
    bool isLogin = login();
    
    while(isLogin){
      Funcs.printProductTable();

      indexOfProduct = getNumber();
      if(indexOfProduct == -1) break;
      
      while(true){
        desiredAmount = getDesiredAmount();

        if(products[indexOfProduct].isThereEnoughProduct(desiredAmount)) {
          selectPaymentMethods();
          break;
        }
      }
    }
  }

  bool login(){
    while(true){
      print("for exit type exit");
      print("Enter username");
      String username = stdin.readLineSync() ?? "";

      if(username.toLowerCase() == "exit") return false;

      //username bulunmadığında badstate hatası veriyor null döndüremiyorum çözemedim :(
      indexOfCustomer = -1;
      for(var i =0;i<customers.length;i++){
        if(customers[i].username == username){
          indexOfCustomer = i;
          return true;
        }
      }

      print("username not found. Try again");
    }
  }


  int getDesiredAmount(){
    while(true){
      print("Enter how many items you want to buy");  
      int? desiredAmount = int.tryParse(stdin.readLineSync().toString());
    
      if(desiredAmount == null){
        print("Only numbers allowed");
      }
      else if(desiredAmount > 0){
        return desiredAmount;
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
    double priceOfProduct = products[indexOfProduct].priceOfProduct;;
    double bill = desiredAmount*priceOfProduct;

    while(true){
      PaymentMethods? selectedPaymentMethods;
      print("Amount to be paid $bill");
      print("Select a payment methods");
      print("for card press 1");
      print("for cash press 2  You have ${customers[indexOfCustomer].cash} cash");
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


  bool buyProduct(PaymentMethods selectedPaymentMethod,double bill){
    return selectedPaymentMethod.buyProduct(bill, indexOfCustomer, desiredAmount, indexOfProduct);
  }

}

