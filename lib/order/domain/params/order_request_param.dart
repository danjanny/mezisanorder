class OrderRequestParam {
  final String? customerName;
  final String? phoneNumber;
  final String? email;
  final String? shippingAddress;
  final String? location;
  final String? product;
  final String? productDescription;
  final String? dueDate;
  final String? orderDate;
  final String? progressStatus;
  final String? image1;
  final String? mimeType1;
  final String? image2;
  final String? mimeType2;

  OrderRequestParam(
      {this.customerName,
        this.phoneNumber,
        this.email,
        this.shippingAddress,
        this.location,
        this.product,
        this.productDescription,
        this.dueDate,
        this.orderDate,
        this.progressStatus,
        this.image1,
        this.mimeType1,
        this.image2,
        this.mimeType2});

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'email': email,
      'shippingAddress': shippingAddress,
      'location': location,
      'product': product,
      'productDescription': productDescription,
      'dueDate': dueDate,
      'orderDate': orderDate,
      'progressStatus': progressStatus,
      'image1': image1,
      'mimeType1': mimeType1,
      'image2': image2,
      'mimeType2': mimeType2,
    };
  }
}