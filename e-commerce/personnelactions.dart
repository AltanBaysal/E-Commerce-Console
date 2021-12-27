import 'dart:io';
import 'funcs.dart';
import 'main.dart';
import 'product.dart';
import 'user.dart';

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

  //login
  bool login(){
    while(true){
      
      int personnelIndex = enterUsername();
      if(personnelIndex == -1) return false;

      return enterPassword(personnelIndex);

    }
  }

  int enterUsername(){
    while(true){
      print("for exit type exit");
      print("Enter username");

      String username = stdin.readLineSync() ?? "";

      if(username.toLowerCase() == "exit") return -1;

      List<Personnel> selectedpersonnel = personnels.where((element) => element.username == username).toList();

      if(selectedpersonnel.isNotEmpty){
        return selectedpersonnel.first.index;
      }
      print("Username not found. Try again");
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
      Funcs.printProductTable();
      break;
    }
  }


  //changenumber
  changeNumberOfProduct(){
    while(true){
      
      int productIndex = chooseProduct();
      if(productIndex == -2) break;
      if(productIndex < 0) continue;
      

      if(setNumberOfProduct(productIndex)){
        break;
      }
    }
  }

  int chooseProduct(){
    Funcs.printProductTable();
    print("For exit type exit");
    print("Enter product name");
    String? productname = stdin.readLineSync();

    if(productname == null){
      print("Enter valid action");
      return -1;
    }
    else{
      List<Product> selectedproduct = products.where((element) => element.productName == productname).toList();
      if(selectedproduct.isNotEmpty){
        return selectedproduct.first.listIndex;
      }

      else{
        print("Product not found");
      return -1;
      }
    }

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
      if(customerIndex == -2) break;
      if(customerIndex < 0) continue;

     
      print("${customers[customerIndex].username} has a debt ${customers[customerIndex].totalDebt}");
      
    }
  }

  int choseCustomer(){
    print("For exit type exit");
    print("Enter Customer name");
    String? customername = stdin.readLineSync();

    if(customername == null){
      print("");
      return -1;
    }

    if(customername.toLowerCase() == "exit"){
      return -2;
    }

    List<Customer> selectedcustomer = customers.where((element) => element.username == customername).toList();

    if(selectedcustomer.isNotEmpty){
      return selectedcustomer.first.index;
    }
    
    print("Customername not found\n");
    return -1;
    
  }
}
