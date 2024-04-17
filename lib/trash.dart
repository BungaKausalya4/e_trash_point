class Trash {
  final int trashId;
  final int poin;
  final String trashName;
  final String imageURL;
  bool isSelected;

  Trash(
      {required this.trashId,
        required this.poin,
        required this.trashName,
        required this.imageURL,
        required this.isSelected});

  //List of Trash data
  static List<Trash> trashList = [
    Trash(
        trashId: 0,
        poin: 4,
        trashName: 'Big Plastic Bottle',
        imageURL: 'assets/images/botolBesar.png',
        isSelected: false),
    Trash(
        trashId: 1,
        poin: 3,
        trashName: 'Small Bottle',
        imageURL: 'assets/images/botolKecil.png',
        isSelected: false),

    Trash(
        trashId: 2,
        poin: 1,
        trashName: 'Small Plastic Glass',
        imageURL: 'assets/images/gelasplastik.png',
        isSelected: false),

    Trash(
        trashId: 3,
        poin: 2,
        trashName: 'Can',
        imageURL: 'assets/images/kaleng.png',
        isSelected: false),

  ];


  //Get the cart items
  static List<Trash> addedToCartTrash(){
    List<Trash> _selectedTrash = Trash.trashList;
    return _selectedTrash.where((element) => element.isSelected == true).toList();
  }
}