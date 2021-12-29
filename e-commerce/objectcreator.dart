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
      String productName = type.toString().split('.').elementAt(1);
      productcreator(type, productName, i, i*10);
    });
  }
  
  productcreator(ProductType productType,String productName,int numberOfProduct,double priceOfProduct){
    products.add(productType.ProductCreator(productName, numberOfProduct, priceOfProduct));
  }

  customercreator(String username,double cash){
    Customer newCustomer = Customer(cash, username);
    customers.add(newCustomer);
  }

  personnelcreator(String username,String password){
    Personnel newPersonnel = Personnel(password,username);
    personnels.add(newPersonnel);
  }

  addCreditCard(){
    customers.forEach((element) {
      element.addCard(CardType.BankCard, 344541507145330, 1234, 500);
      element.addCard(CardType.CreditCard, 344541507145331, 1234, 700);
      element.addCard(CardType.CreditCard, 344541507145332, 1234, 800);
    });
  }
}
