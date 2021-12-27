List<Product> products =[];
enum ProductType{Chips,Crakers,Cookies,SnackNuts,Chocolate,FruitSnacks,IceCream,Candy,PopCorn,Juice}

class Product{
  late String _productName;
  late int _listIndex; 

  late int _numberOfProduct;
  late double _priceOfProduct;


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
  int get listIndex => _listIndex; 
}


class Chips implements Product{
  ProductType productType = ProductType.Chips;
  String _productName;
  int _listIndex; 

  int _numberOfProduct;
  double _priceOfProduct;

  Chips(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);

  

  //getters
  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex;


  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  }

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Crakers implements Product{
  ProductType productType = ProductType.Crakers;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Crakers(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Cookies implements Product{
  ProductType productType = ProductType.Cookies;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Cookies(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class SnackNuts implements Product{
  ProductType productType = ProductType.SnackNuts;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  SnackNuts(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Chocolate implements Product{
  ProductType productType = ProductType.Chocolate;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Chocolate(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class FruitSnacks implements Product{
  ProductType productType = ProductType.FruitSnacks;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  FruitSnacks(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class IceCream implements Product{
  ProductType productType = ProductType.IceCream;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  IceCream(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Candy implements Product{
  ProductType productType = ProductType.Candy;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Candy(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class PopCorn implements Product{
  ProductType productType = ProductType.PopCorn;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  PopCorn(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}

class Juice implements Product{
  ProductType productType = ProductType.Juice;
  int _listIndex;
  int _numberOfProduct;
  double _priceOfProduct;
  String _productName;


  Juice(this._productName, this._listIndex,this._numberOfProduct,this._priceOfProduct);


  String get productName => _productName;
  int get numberOfProduct => _numberOfProduct;
  double get priceOfProduct => _priceOfProduct;
  int get listIndex => _listIndex; 

  @override
  void setnumberOfProduct(int numberOfProduct) {
    this._numberOfProduct = numberOfProduct;
  }

  @override
  void setpriceOfProduct(double priceOfProduct) {
    this._priceOfProduct = priceOfProduct;
  } 

  @override
  bool isThereEnoughProduct(int desiredAmount){
    if(desiredAmount<= _numberOfProduct){
      return true;
    } 
    else {
      print("There isn't enough products");
      return false;
    }
  }

  @override
  void productReduction(int amountToBeReduce) {
    _numberOfProduct -= amountToBeReduce;
  } 
}