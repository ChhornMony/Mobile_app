// user_model.dart
import 'package:flutter/foundation.dart';

@immutable
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final DateTime? birthDate;
  final UserAddress? primaryAddress;
  final List<PaymentMethod> paymentMethods;
  final List<UserAddress> addresses;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.birthDate,
    this.primaryAddress,
    this.paymentMethods = const [],
    this.addresses = const [],
    required this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  String get initials {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}';
    } else if (email.isNotEmpty) {
      return email[0].toUpperCase();
    }
    return '?';
  }

  factory User.empty() {
    return User(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      createdAt: DateTime.now(),
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String?,
        profileImageUrl: json['profileImageUrl'] as String?,
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json['birthDate'] as String)
            : null,
        primaryAddress: json['primaryAddress'] != null
            ? UserAddress.fromJson(
                json['primaryAddress'] as Map<String, dynamic>)
            : null,
        paymentMethods: json['paymentMethods'] != null
            ? List<PaymentMethod>.from(
                (json['paymentMethods'] as List).map(
                  (x) => PaymentMethod.fromJson(x as Map<String, dynamic>),
                ),
              )
            : const [],
        addresses: json['addresses'] != null
            ? List<UserAddress>.from(
                (json['addresses'] as List).map(
                  (x) => UserAddress.fromJson(x as Map<String, dynamic>),
                ),
              )
            : const [],
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
      );
    } catch (e) {
      throw FormatException('Failed to parse User: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'birthDate': birthDate?.toIso8601String(),
      'primaryAddress': primaryAddress?.toJson(),
      'paymentMethods': paymentMethods.map((x) => x.toJson()).toList(),
      'addresses': addresses.map((x) => x.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    DateTime? birthDate,
    UserAddress? primaryAddress,
    List<PaymentMethod>? paymentMethods,
    List<UserAddress>? addresses,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      birthDate: birthDate ?? this.birthDate,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      addresses: addresses ?? this.addresses,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode;
  }
}

@immutable
class UserAddress {
  final String id;
  final String label;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final bool isDefault;

  const UserAddress({
    required this.id,
    required this.label,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });

  String get fullAddress => '$street, $city, $state $postalCode, $country';

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'] as String,
      label: json['label'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'isDefault': isDefault,
    };
  }

  UserAddress copyWith({
    String? id,
    String? label,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    bool? isDefault,
  }) {
    return UserAddress(
      id: id ?? this.id,
      label: label ?? this.label,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserAddress && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum PaymentCardType {
  visa,
  mastercard,
  americanExpress,
  discover,
  other,
}

@immutable
class PaymentMethod {
  final String id;
  final PaymentCardType cardType;
  final String lastFourDigits;
  final String cardHolderName;
  final DateTime expiryDate;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.cardType,
    required this.lastFourDigits,
    required this.cardHolderName,
    required this.expiryDate,
    this.isDefault = false,
  });

  String get formattedCardNumber => '•••• •••• •••• $lastFourDigits';

  String get formattedExpiryDate =>
      '${expiryDate.month.toString().padLeft(2, '0')}/${expiryDate.year.toString().substring(2)}';

  String get cardTypeName {
    switch (cardType) {
      case PaymentCardType.visa:
        return 'VISA';
      case PaymentCardType.mastercard:
        return 'MasterCard';
      case PaymentCardType.americanExpress:
        return 'American Express';
      case PaymentCardType.discover:
        return 'Discover';
      default:
        return 'Card';
    }
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] as String,
      cardType: _parseCardType(json['cardType'] as String),
      lastFourDigits: json['lastFourDigits'] as String,
      cardHolderName: json['cardHolderName'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  static PaymentCardType _parseCardType(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
        return PaymentCardType.visa;
      case 'mastercard':
        return PaymentCardType.mastercard;
      case 'americanexpress':
        return PaymentCardType.americanExpress;
      case 'discover':
        return PaymentCardType.discover;
      default:
        return PaymentCardType.other;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardType': cardType.name,
      'lastFourDigits': lastFourDigits,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate.toIso8601String(),
      'isDefault': isDefault,
    };
  }

  PaymentMethod copyWith({
    String? id,
    PaymentCardType? cardType,
    String? lastFourDigits,
    String? cardHolderName,
    DateTime? expiryDate,
    bool? isDefault,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      cardType: cardType ?? this.cardType,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentMethod && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
