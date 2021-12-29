import 'commonExtensions.dart';
import 'user.dart';
import 'dart:io';

Interface newInterface = Interface();

class Interface {
  late UserType selectedUserType;
  
  Start(){
    while(true){  
      printAction();

      String action = stdin.readLineSync().toString();
      if(action == "exit") break;
      UserType? selectedUserType= action.selectUser();


      if(selectedUserType != null) selectedUserType.userChooser();
      
      print("");
    }
  }
  
  printAction(){
    print("Select your Action");
    print("For customer press 1");
    print("For personnel press 2");
    print("For enter tpye exit");
  }
  
}


