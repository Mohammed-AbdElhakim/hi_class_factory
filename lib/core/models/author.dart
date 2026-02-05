class Author {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final bool isVerified;
  final int booksPublished;
  final String totalReaders;
  final String bio;
  final String description;

  const Author({
    required this.name,
    required this.category,
    required this.bio,
    required this.description,
    required this.imageUrl,
    required this.id,
    this.isVerified = false,
    this.booksPublished = 0,
    this.totalReaders = '',
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      isVerified: json['isVerified'] ?? false,
      booksPublished: json['booksPublished'],
      totalReaders: json['totalReaders'],
      bio: json['bio'],
      category: json['category'],
      description: json['description'],
    );
  }
}
