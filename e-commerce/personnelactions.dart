import 'dart:io';
import 'funcs.dart';
import 'main.dart';
import 'product.dart';
import 'user.dart';

enum SelectedPersonnelActions{PrintProductTable,ChangeNumberOfProduct,CustomerDebt}//+


extension PersonnelActionsExtension on SelectedPersonnelActions{
  takeAction(){
    switch (this){
      case SelectedPersonnelActions.ChangeNumberOfProduct:
      newPersonnelActions.changeNumberOfProduct();
      break;

      case SelectedPersonnelActions.CustomerDebt:
      newPersonnelActions.getCustomerDebt();
      break;

      case SelectedPersonnelActions.PrintProductTable:
      Funcs.printProductTable();
      break;
    }
  }
}


PersonnelActions newPersonnelActions = PersonnelActions();

class PersonnelActions{
  late SelectedPersonnelActions selectedPersonnelActions;
  
  actionInterface(){
    State personnelActionState = State.unselected;
    bool isLoggin = login(); 
    while(isLoggin && personnelActionState != State.exit){

      printActions();
      personnelActionState = getAction();
      if(personnelActionState == State.selected) selectedPersonnelActions.takeAction();
    }
  }

  //login
  bool login(){
    while(true){
      
      int personnelIndex = enterusername();
      if(personnelIndex == -1) return false;

      return enterPassword(personnelIndex);

    }
  }

  int enterusername(){
    while(true){
      print("for exit type exit");
      
      print("Enter username");
      personnels.forEach((element) {
        print(element.username);
      });
    

      String username = stdin.readLineSync() ?? "";
      if(username.toLowerCase() == "exit") return -1;
      
      for(var i  =0;i<personnels.length;i++){
        if(personnels[i].username == username){
          return  i;
        }
      }

      print("username not found. Try again");
    }
  }
  
  bool enterPassword(int personnelIndex){
    while(true){
      print("for exit type exit");
      print("Enter password");
      String password = stdin.readLineSync() ?? "";

      if(password.toLowerCase() == "exit") return false;

      if(personnels[personnelIndex].passwordChecker(password)) return true;
    }
  }


  printActions(){
    print("Select your Action");
    print("For print product table press 1");
    print("For change number of product press 2");
    print("For get customer debt press 3");
    print("For exit enter exit");
  }
  
  State getAction(){
    
    String? action = stdin.readLineSync();

    switch (action!.toLowerCase()){
      case "1":
      selectedPersonnelActions = SelectedPersonnelActions.PrintProductTable;
      return State.selected;

      case "2":
      selectedPersonnelActions = SelectedPersonnelActions.ChangeNumberOfProduct;
      return State.selected;

      case "3":
      selectedPersonnelActions = SelectedPersonnelActions.CustomerDebt;
      return State.selected;

      case "exit":
      return State.exit;

      default :{
        print("Enter valid action");
        return State.unselected;
      }
      
    }
    

  }




  //changenumber
  changeNumberOfProduct(){
    while(true){
      
      int productIndex = chooseProduct();
      if(productIndex == -1) break;
      if(productIndex < 0) continue;
      

      if(setNumberOfProduct(productIndex)) break;

    }
  }

  int chooseProduct(){
    Funcs.printProductTable();
    print("For exit type exit");
    print("Enter product name");
    String productname = stdin.readLineSync().toString();
    if(productname.toLowerCase() == "exit") return -1;

    for(var i =0;i<products.length;i++){
      if(products[i].productName == productname){
        return  i;
      }
    }
    print("Product not found");   
    return -2;

  }
  
  bool setNumberOfProduct(int productIndex){
    while(true){
      print("For exit type exit");
      print("Enter new product number");

      String action = stdin.readLineSync().toString();
      if(action.toLowerCase() == "exit") return true;

      int ? numberOfProduct = int.tryParse(action);
      
      if(numberOfProduct != null && numberOfProduct >= 0){
        products[productIndex].setnumberOfProduct(numberOfProduct);
        print("transaction completed successfully");
        return true;
      }

      else if(numberOfProduct == null){
        print("Only numbers allowed");
      }

      else{
        print("The number of products cannot be less than 0");
      }
    }
  }


  //getdebtinfo
  getCustomerDebt(){
    while(true){
      Funcs.printCustomerList();
  
      int customerIndex = choseCustomer();
      if(customerIndex == -1) break;
      if(customerIndex <0) continue;

      print("${customers[customerIndex].username} has a debt ${customers[customerIndex].totalDebt}");
    }
  }

  int choseCustomer(){
    print("For exit type exit");
    print("Enter Customer name");
    String? customername = stdin.readLineSync().toString();

    if(customername.toLowerCase() == "exit"){
      return -1;
    }

    for(var i =0;i<customers.length;i++){
      if(customers[i].username == customername){
        return  i;
      }
    }
    
    print("Customername not found");
    return -2;
    
  }
}
