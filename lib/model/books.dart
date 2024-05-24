
class Books {
  final int? bookId;
  final String bookName;
  final String bookAuthor;
  final String bookAmt;
  final String pubDate;
  final String bookGenre;
  final String bookDescript;
  final String language;
  Books({
    this.bookId,
    required this.bookName,
    required this.bookAuthor,
    required this.bookAmt,
    required this.pubDate,
    required this.bookGenre,
    required this.bookDescript,
    required this.language
  });

  factory Books.fromMap(Map<String, dynamic> json) => Books(
        bookId: json["bookId"],
        bookName: json["bookName"],
        bookAuthor: json["bookAuthor"],
        bookAmt: json["bookAmt"],
        pubDate: json["pubDate"],
        bookGenre: json["bookGenre"],
        bookDescript: json["bookDescript"],
        language: json['Language']
      );

  Map<String, dynamic> toMap() => {
        "bookId": bookId,
        "bookName": bookName,
        "bookAuthor": bookAuthor,
        "bookAmt":bookAmt,
        "pubDate":pubDate,
        "bookGenre":bookGenre,
        "bookDescript":bookDescript,
        "Language":language
      };
}