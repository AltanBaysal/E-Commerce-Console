import 'card.dart';
import 'product.dart';
import 'user.dart';

Objectcreator newObjectcreator = Objectcreator();
class Objectcreator{
  createAllObject(){
    customercreator("Customer1", 120);
    addCreditCard();

    personnelcreator("Personnel1", "123456");
    var i =0;
    ProductType.values.forEach((type) {
      i++;
      String productname = type.toString().split('.').elementAt(1);
      productcreator(type, productname, i, i*10);
    });
  }
  

  productcreator(ProductType productType,String productName,int numberOfProduct,double priceOfProduct){
    int listIndex = products.length;

    switch(productType){
      case ProductType.Candy:{
        Candy newproduct = Candy(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Chips:{
        Chips newproduct = Chips(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Chocolate:{
        Chocolate newproduct = Chocolate(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Cookies:{
        Cookies newproduct = Cookies(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Crakers:{
        Crakers newproduct = Crakers(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.FruitSnacks:{
        FruitSnacks newproduct = FruitSnacks(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.IceCream:{
        IceCream newproduct = IceCream(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.Juice:{
        Juice newproduct = Juice(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.PopCorn:{
        PopCorn newproduct = PopCorn(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
      case ProductType.SnackNuts:{
        SnackNuts newproduct = SnackNuts(productName, listIndex, numberOfProduct, priceOfProduct);
        products.add(newproduct);
      }
      break;
    }
  }

  customercreator(String username,double cash){
    int listIndex = customers.length;
    Customer newcustomer = Customer(cash, username,listIndex);
    customers.add(newcustomer);
  }

  personnelcreator(String username,String password){
    int listIndex = personnels.length;
    Personnel newpersonnel = Personnel(username, listIndex, password);
    personnels.add(newpersonnel);
  }

  addCreditCard(){
    customers.forEach((element) {
      element.addCard(CardType.BankCard, 344541507145330, 1234, 500);
      element.addCard(CardType.CreditCard, 344541507145331, 1234, 700);
      element.addCard(CardType.CreditCard, 344541507145332, 1234, 800);
    });
  }
}
