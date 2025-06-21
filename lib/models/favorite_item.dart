class FavoriteItem {
  final String id;
  final String title;
  final String? subtitle;
  final String imageUrl;
  final double price;
  final double? rating;
  final bool isLiked;
  final DateTime addedDate;

  FavoriteItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.price,
    this.rating,
    this.isLiked = true,
    DateTime? addedDate,
  }) : addedDate = addedDate ?? DateTime.now();

  // Convert to Map for storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'imageUrl': imageUrl,
        'price': price,
        'rating': rating,
        'isLiked': isLiked,
        'addedDate': addedDate.toIso8601String(),
      };

  // Create from Map (e.g., from database)
  factory FavoriteItem.fromJson(Map<String, dynamic> json) => FavoriteItem(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        imageUrl: json['imageUrl'],
        price: json['price']?.toDouble() ?? 0.0,
        rating: json['rating']?.toDouble(),
        isLiked: json['isLiked'] ?? true,
        addedDate: DateTime.parse(json['addedDate']),
      );

  // For immutable updates
  FavoriteItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imageUrl,
    double? price,
    double? rating,
    bool? isLiked,
    DateTime? addedDate,
  }) {
    return FavoriteItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      isLiked: isLiked ?? this.isLiked,
      addedDate: addedDate ?? this.addedDate,
    );
  }

  // Helper methods
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get formattedDate =>
      '${addedDate.day}/${addedDate.month}/${addedDate.year}';
}
