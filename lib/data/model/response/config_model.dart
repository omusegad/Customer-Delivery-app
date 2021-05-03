class ConfigModel {
  String _restaurantName;
  String _restaurantOpenTime;
  String _restaurantCloseTime;
  String _restaurantLogo;
  String _restaurantAddress;
  String _restaurantPhone;
  String _restaurantEmail;
  BaseUrls _baseUrls;
  String _currencySymbol;
  String _deliveryCharge;
  String _cashOnDelivery;
  String _digitalPayment;
  String _termsAndConditions;
  RestaurantLocationCoverage _restaurantLocationCoverage;
  double _minimumOrderValue;
  List<Branches> _branches;

  ConfigModel(
      {String restaurantName,
        String restaurantOpenTime,
        String restaurantCloseTime,
        String restaurantLogo,
        String restaurantAddress,
        String restaurantPhone,
        String restaurantEmail,
        BaseUrls baseUrls,
        String currencySymbol,
        String deliveryCharge,
        String cashOnDelivery,
        String digitalPayment,
        String termsAndConditions,
        RestaurantLocationCoverage restaurantLocationCoverage,
        double minimumOrderValue,
        List<Branches> branches}) {
    this._restaurantName = restaurantName;
    this._restaurantOpenTime = restaurantOpenTime;
    this._restaurantCloseTime = restaurantCloseTime;
    this._restaurantLogo = restaurantLogo;
    this._restaurantAddress = restaurantAddress;
    this._restaurantPhone = restaurantPhone;
    this._restaurantEmail = restaurantEmail;
    this._baseUrls = baseUrls;
    this._currencySymbol = currencySymbol;
    this._deliveryCharge = deliveryCharge;
    this._cashOnDelivery = cashOnDelivery;
    this._digitalPayment = digitalPayment;
    this._termsAndConditions = termsAndConditions;
    this._restaurantLocationCoverage = restaurantLocationCoverage;
    this._minimumOrderValue = minimumOrderValue;
    this._branches = branches;
  }

  String get restaurantName => _restaurantName;
  String get restaurantOpenTime => _restaurantOpenTime;
  String get restaurantCloseTime => _restaurantCloseTime;
  String get restaurantLogo => _restaurantLogo;
  String get restaurantAddress => _restaurantAddress;
  String get restaurantPhone => _restaurantPhone;
  String get restaurantEmail => _restaurantEmail;
  BaseUrls get baseUrls => _baseUrls;
  String get currencySymbol => _currencySymbol;
  String get deliveryCharge => _deliveryCharge;
  String get cashOnDelivery => _cashOnDelivery;
  String get digitalPayment => _digitalPayment;
  String get termsAndConditions => _termsAndConditions;
  RestaurantLocationCoverage get restaurantLocationCoverage => _restaurantLocationCoverage;
  double get minimumOrderValue => _minimumOrderValue;
  List<Branches> get branches => _branches;

  ConfigModel.fromJson(Map<String, dynamic> json) {
    _restaurantName = json['restaurant_name'];
    _restaurantOpenTime = json['restaurant_open_time'];
    _restaurantCloseTime = json['restaurant_close_time'];
    _restaurantLogo = json['restaurant_logo'];
    _restaurantAddress = json['restaurant_address'];
    _restaurantPhone = json['restaurant_phone'];
    _restaurantEmail = json['restaurant_email'];
    _baseUrls = json['base_urls'] != null
        ? new BaseUrls.fromJson(json['base_urls'])
        : null;
    _currencySymbol = json['currency_symbol'];
    _deliveryCharge = json['delivery_charge'];
    _cashOnDelivery = json['cash_on_delivery'];
    _digitalPayment = json['digital_payment'];
    _termsAndConditions = json['terms_and_conditions'];
    _restaurantLocationCoverage = json['restaurant_location_coverage'] != null
        ? new RestaurantLocationCoverage.fromJson(json['restaurant_location_coverage']) : null;
    _minimumOrderValue = json['minimum_order_value'] != null ? json['minimum_order_value'].toDouble() : 0;
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches.add(new Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_name'] = this._restaurantName;
    data['restaurant_open_time'] = this._restaurantOpenTime;
    data['restaurant_close_time'] = this._restaurantCloseTime;
    data['restaurant_logo'] = this._restaurantLogo;
    data['restaurant_address'] = this._restaurantAddress;
    data['restaurant_phone'] = this._restaurantPhone;
    data['restaurant_email'] = this._restaurantEmail;
    if (this._baseUrls != null) {
      data['base_urls'] = this._baseUrls.toJson();
    }
    data['currency_symbol'] = this._currencySymbol;
    data['delivery_charge'] = this._deliveryCharge;
    data['cash_on_delivery'] = this._cashOnDelivery;
    data['digital_payment'] = this._digitalPayment;
    data['terms_and_conditions'] = this._termsAndConditions;
    if (this._restaurantLocationCoverage != null) {
      data['restaurant_location_coverage'] = this._restaurantLocationCoverage.toJson();
    }
    data['minimum_order_value'] = this._minimumOrderValue;
    if (this._branches != null) {
      data['branches'] = this._branches.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BaseUrls {
  String _productImageUrl;
  String _customerImageUrl;
  String _bannerImageUrl;
  String _categoryImageUrl;
  String _reviewImageUrl;
  String _notificationImageUrl;
  String _restaurantImageUrl;
  String _deliveryManImageUrl;
  String _chatImageUrl;

  BaseUrls(
      {String productImageUrl,
        String customerImageUrl,
        String bannerImageUrl,
        String categoryImageUrl,
        String reviewImageUrl,
        String notificationImageUrl,
        String restaurantImageUrl,
        String deliveryManImageUrl,
        String chatImageUrl}) {
    this._productImageUrl = productImageUrl;
    this._customerImageUrl = customerImageUrl;
    this._bannerImageUrl = bannerImageUrl;
    this._categoryImageUrl = categoryImageUrl;
    this._reviewImageUrl = reviewImageUrl;
    this._notificationImageUrl = notificationImageUrl;
    this._restaurantImageUrl = restaurantImageUrl;
    this._deliveryManImageUrl = deliveryManImageUrl;
    this._chatImageUrl = chatImageUrl;
  }

  String get productImageUrl => _productImageUrl;
  String get customerImageUrl => _customerImageUrl;
  String get bannerImageUrl => _bannerImageUrl;
  String get categoryImageUrl => _categoryImageUrl;
  String get reviewImageUrl => _reviewImageUrl;
  String get notificationImageUrl => _notificationImageUrl;
  String get restaurantImageUrl => _restaurantImageUrl;
  String get deliveryManImageUrl => _deliveryManImageUrl;
  String get chatImageUrl => _chatImageUrl;

  BaseUrls.fromJson(Map<String, dynamic> json) {
    _productImageUrl = json['product_image_url'];
    _customerImageUrl = json['customer_image_url'];
    _bannerImageUrl = json['banner_image_url'];
    _categoryImageUrl = json['category_image_url'];
    _reviewImageUrl = json['review_image_url'];
    _notificationImageUrl = json['notification_image_url'];
    _restaurantImageUrl = json['restaurant_image_url'];
    _deliveryManImageUrl = json['delivery_man_image_url'];
    _chatImageUrl = json['chat_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image_url'] = this._productImageUrl;
    data['customer_image_url'] = this._customerImageUrl;
    data['banner_image_url'] = this._bannerImageUrl;
    data['category_image_url'] = this._categoryImageUrl;
    data['review_image_url'] = this._reviewImageUrl;
    data['notification_image_url'] = this._notificationImageUrl;
    data['restaurant_image_url'] = this._restaurantImageUrl;
    data['delivery_man_image_url'] = this._deliveryManImageUrl;
    data['chat_image_url'] = this._chatImageUrl;
    return data;
  }
}

class RestaurantLocationCoverage {
  String _longitude;
  String _latitude;
  double _coverage;

  RestaurantLocationCoverage(
      {String longitude, String latitude, double coverage}) {
    this._longitude = longitude;
    this._latitude = latitude;
    this._coverage = coverage;
  }

  String get longitude => _longitude;
  String get latitude => _latitude;
  double get coverage => _coverage;

  RestaurantLocationCoverage.fromJson(Map<String, dynamic> json) {
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _coverage = json['coverage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this._longitude;
    data['latitude'] = this._latitude;
    data['coverage'] = this._coverage;
    return data;
  }
}

class Branches {
  int _id;
  String _name;
  String _email;
  String _longitude;
  String _latitude;
  String _address;
  double _coverage;

  Branches(
      {int id,
        String name,
        String email,
        String longitude,
        String latitude,
        String address,
        double coverage}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._longitude = longitude;
    this._latitude = latitude;
    this._address = address;
    this._coverage = coverage;
  }

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get longitude => _longitude;
  String get latitude => _latitude;
  String get address => _address;
  double get coverage => _coverage;

  Branches.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _address = json['address'];
    _coverage = json['coverage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['longitude'] = this._longitude;
    data['latitude'] = this._latitude;
    data['address'] = this._address;
    data['coverage'] = this._coverage;
    return data;
  }
}