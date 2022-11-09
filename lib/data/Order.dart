class Order {
  double total = 0;

  double get getTotal => total;

  set setTotal(double total) => this.total = total;

  String clientLastName = '';

  String get getClientLastName => clientLastName;

  set setClientLastName(String clientLastName) =>
      this.clientLastName = clientLastName;

  String clientName = '';

  String get getClientName => clientName;

  set setClientName(String clientName) => this.clientName = clientName;

  String phone = '';

  String get getPhone => phone;

  set setPhone(String phone) => this.phone = phone;

  double longitude = 0;

  double get getLongitude => longitude;

  set setLongitude(double longitude) => this.longitude = longitude;

  double tax = 0;

  double get getTax => tax;

  set setTax(double tax) => this.tax = tax;

  List items = [];

  List get getItems => items;

  set setItems(List items) => this.items = items;

  String oldOrder = '';

  String get getOldOrder => oldOrder;

  set setOldOrder(String oldOrder) => this.oldOrder = oldOrder;

  String municipalityName = '';

  String get getMunicipalityName => municipalityName;

  set setMunicipalityName(String municipalityName) =>
      this.municipalityName = municipalityName;

  double delivery = 0;

  double get getDelivery => delivery;

  set setDelivery(double delivery) => this.delivery = delivery;

  String paymentTypeName = '';

  String get getPaymentTypeName => paymentTypeName;

  set setPaymentTypeName(String paymentTypeName) =>
      this.paymentTypeName = paymentTypeName;

  String notes = '';

  String get getNotes => notes;

  set setNotes(String notes) => this.notes = notes;

  int status = 0;

  int get getStatus => status;

  set setStatus(int status) => this.status = status;

  String sectorName = '';

  get getSectorName => sectorName;

  set setSectorName(sectorName) => this.sectorName = sectorName;

  double subtotal = 0;

  double get getSubtotal => subtotal;

  set setSubtotal(double subtotal) => this.subtotal = subtotal;

  int orderId = 0;

  int get getOrderId => orderId;

  set setOrderId(int orderId) => this.orderId = orderId;

  String orderDateTime = '';

  String get getOrderDateTime => orderDateTime;

  set setOrderDateTime(String orderDateTime) =>
      this.orderDateTime = orderDateTime;

  String address = '';

  String get getAddress => address;

  set setAddress(String address) => this.address = address;

  double tip = 0;

  double get getTip => tip;

  set setTip(double tip) => this.tip = tip;

  String binnacle = '';

  String get getBinnacle => binnacle;

  set setBinnacle(String binnacle) => this.binnacle = binnacle;

  double latitude = 0;

  double get getLatitude => latitude;

  set setLatitude(double latitude) => this.latitude = latitude;

  int deliveryStatus = 0;

  get getDeliveryStatus => deliveryStatus;

  set setDeliveryStatus(deliveryStatus) => this.deliveryStatus = deliveryStatus;
}
