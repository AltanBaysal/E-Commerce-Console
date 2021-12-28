List<Product> products =[];
enum ProductType{Chips,Crakers,Cookies,SnackNuts,Chocolate,FruitSnacks,IceCream,Candy,PopCorn,Juice}

extension ProductExtension on ProductType{
  Product ProductCreator(String productName,int numberOfProduct,double priceOfProduct){
    switch(this){
      case ProductType.Candy:{
        return Candy(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.Chips:{
        return Chips(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.Chocolate:{
        return Chocolate(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.Cookies:{
        return Cookies(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.Crakers:{
        return Crakers(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.FruitSnacks:{
        return FruitSnacks(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.IceCream:{
        return IceCream(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.Juice:{
        return Juice(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.PopCorn:{
        return PopCorn(productName, numberOfProduct, priceOfProduct);
      }
      case ProductType.SnackNuts:{
        return SnackNuts(productName, numberOfProduct, priceOfProduct);
      }
    }
  }
}


class Product{
  String _productName;

  int _numberOfProduct;
  double _priceOfProduct;

  Product(this._productName,this._numberOfProduct,this._priceOfProduct);


  //setter
  void setnumberOfProduct(int numberOfProduct){
    this._numberOfProduct = numberOfProduct;
  }

  void setpriceOfProduct(double priceOfProduct){
    this._priceOfProduct = priceOfProduct;
  }


  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  void productReduction(int amountToBeReduce){
    _numberOfProduct -= amountToBeReduce;
  }


  //getters
  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
}


class Chips extends Product{
  Chips(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class Crakers extends Product{
  Crakers(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class Cookies extends Product{
  Cookies(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class SnackNuts extends Product{
  SnackNuts(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class Chocolate extends Product{
  Chocolate(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class FruitSnacks extends Product{
  FruitSnacks(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class IceCream extends Product{
  IceCream(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class Candy extends Product{
  Candy(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class PopCorn extends Product{
  PopCorn(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}

class Juice extends Product{
  Juice(String _productName,int _numberOfProduct,double _priceOfProduct):super(_productName,_numberOfProduct,_priceOfProduct);
}