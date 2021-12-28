import 'product.dart';
import 'user.dart';

class Funcs{
  static printProductTable(){
    print("Product name - Product Price - Number of Prodcut");
    var i = 0;
    products.forEach((element) {
      i++;
      print("${i} - ${element.productName} - ${element.priceOfProduct} - ${element.numberOfProduct}");
    });


}
  
  static printCustomerList(){
    var i =0;
    customers.forEach((element) {
      i++;
      print("${i} - ${element.username}");
    });
  }
}