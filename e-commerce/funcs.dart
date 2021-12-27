import 'product.dart';
import 'user.dart';

class Funcs{
  static printProductTable(){
    print("Product name - Product Price - Number of Prodcut");
    products.forEach((element) {
    print("${element.listIndex +1} - ${element.productName} - ${element.priceOfProduct} - ${element.numberOfProduct}");
  });


}
  
  static printCustomerList(){
    customers.forEach((element) {
        print("${element.index +1} - ${element.username}");
    });
  }
}