class CurrentUser{
  String _phoneNumber;
  String _userId;
  String _address;
  String _image;


  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }
}