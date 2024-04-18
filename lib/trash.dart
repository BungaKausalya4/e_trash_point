class Trash {
  final int trashId;
  final int poin;
  final String trashName;
  final String imageURL;
  final String description;
  bool isSelected;

  Trash({
    required this.trashId,
    required this.poin,
    required this.trashName,
    required this.imageURL,
    required this.description,
    required this.isSelected,
  });

  // List of Trash data
  static List<Trash> trashList = [
    Trash(
      trashId: 0,
      poin: 4,
      trashName: 'Big Plastic Bottle',
      imageURL: 'assets/images/botolBesar.png',
      description: 'Big Plastic Bottle is a large plastic bottle typically used for storing beverages or other liquids. Recycling these bottles helps reduce plastic waste.',
      isSelected: false,
    ),
    Trash(
      trashId: 1,
      poin: 3,
      trashName: 'Small Bottle',
      imageURL: 'assets/images/botolKecil.png',
      description: 'Small Bottle is a compact plastic bottle commonly used for individual beverage servings. It is recyclable and should be disposed of properly.',
      isSelected: false,
    ),
    Trash(
      trashId: 2,
      poin: 1,
      trashName: 'Small Plastic Glass',
      imageURL: 'assets/images/gelasplastik.png',
      description: 'Small Plastic Glass refers to disposable plastic cups or glasses used for drinks. Proper disposal and recycling are important to reduce environmental impact.',
      isSelected: false,
    ),
    Trash(
      trashId: 3,
      poin: 2,
      trashName: 'Can',
      imageURL: 'assets/images/kaleng.png',
      description: 'Can refers to metal containers usually made of aluminum or steel. Recycling cans helps conserve resources and reduce waste.',
      isSelected: false,
    ),
  ];

  // Get the selected items (added to cart) from trashList
  static List<Trash> addedToCartTrash() {
    return trashList.where((element) => element.isSelected).toList();
  }
}
