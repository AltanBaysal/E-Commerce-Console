import 'customeractions.dart';
import 'main.dart';
import 'personnelactions.dart';
import 'user.dart';
import 'dart:io';

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


