import 'customerActions.dart';
import 'personnelActions.dart';
import 'user.dart';

extension StringExtension on String{
  selectPaymentMethod(){
    switch (this){
      case "1":
        return PaymentMethods.Card;

      case "2":
        return PaymentMethods.Cash;

      case "3":
        return PaymentMethods.Debt;

      default :{
        print("Enter valid action");
      }
    }
  }

  UserType? selectUser(){
     switch(this){
      case "1" :
      return UserType.customer;


      case "2":
      return UserType.personnel;


      default :{
        print("Enter valid action");
      }
    }
  }

  SelectedPersonnelActions? selectAction(){
    switch (this){
      case "1":
      return SelectedPersonnelActions.PrintProductTable;

      case "2":
      return SelectedPersonnelActions.ChangeNumberOfProduct;

      case "3":
      return SelectedPersonnelActions.CustomerDebt;

      default :{
        print("Enter valid action");
      }
      
    }
  }
}
