class Gift {
  final int giftId;
  final int poin;
  late final String size;
  final String giftName;
  final String imageURL;
  bool isSelected;

  Gift(
      {required this.giftId,
        required this.poin,
        required this.giftName,
        required this.size,
        required this.imageURL,
        required this.isSelected});

  //List of Gift data
  static List<Gift> giftList = [
    Gift(
        giftId: 0,
        poin: 100,
        giftName: 'T-Shirt',
        size: 'XL',
        imageURL: 'assets/images/t-shirt.png',
        isSelected: false),
    Gift(
        giftId: 1,
        poin: 30,
        giftName: 'Notebook',
        size: 'A4',
        imageURL: 'assets/images/book.png',
        isSelected: false),

    Gift(
        giftId: 2,
        poin: 50,
        giftName: 'Totebag',
        size: '30x40 CM',
        imageURL: 'assets/images/bag.png',
        isSelected: false),

  ];

  //Get the cart items
  static List<Gift> addedToCartGift(){
    List<Gift> _selectedGift = Gift.giftList;
    return _selectedGift.where((element) => element.isSelected == true).toList();
  }
}