class Book {
  String id;
  String title;
  String author;
  String description;
  String coverUrl;
  String category;
  num rating;

  Book(this.id, this.title, this.author, this.description, this.coverUrl, this.category, this.rating);

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
      data['id'],
      data['title'],
      data['author'],
      data['description'],
      data['coverUrl'],
      data['category'],
      data['rating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverUrl': coverUrl,
      'category': category,
      'rating': rating,
    };
  }

  Book copyWith({String? id, String? title, String? author, String? description, String? coverUrl, String? category, num? rating}) {
    return Book(
      id ?? this.id,
      title ?? this.title,
      author ?? this.author,
      description ?? this.description,
      coverUrl ?? this.coverUrl,
      category ?? this.category,
      rating ?? this.rating,
    );
  }
}