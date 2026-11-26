enum FeedbackCategory { idea, broken, scanner, learning, other }

final class FeedbackDraft {
  const FeedbackDraft({
    this.category,
    this.message = '',
    this.replyEmail = '',
    this.includeDetails = true,
  });

  factory FeedbackDraft.fromJson(Map<String, Object?> json) => FeedbackDraft(
    category: FeedbackCategory.values
        .where((item) => item.name == json['category'])
        .firstOrNull,
    message: json['message'] as String? ?? '',
    replyEmail: json['replyEmail'] as String? ?? '',
    includeDetails: json['includeDetails'] as bool? ?? true,
  );

  final FeedbackCategory? category;
  final String message;
  final String replyEmail;
  final bool includeDetails;

  int get length => message.trim().runes.length;
  bool get validMessage => length >= 10 && length <= 2000;
  bool get validEmail {
    final email = replyEmail.trim();
    return email.isEmpty ||
        (email.length <= 254 &&
            RegExp(
              r'^[^\s@<>(),;:"\\]+@[^\s@<>(),;:"\\]+\.[^\s@<>(),;:"\\]+$',
            ).hasMatch(email));
  }

  FeedbackDraft copyWith({
    FeedbackCategory? category,
    String? message,
    String? replyEmail,
    bool? includeDetails,
  }) => FeedbackDraft(
    category: category ?? this.category,
    message: message ?? this.message,
    replyEmail: replyEmail ?? this.replyEmail,
    includeDetails: includeDetails ?? this.includeDetails,
  );

  Map<String, Object?> toJson() => {
    'category': category?.name,
    'message': message,
    'replyEmail': replyEmail,
    'includeDetails': includeDetails,
  };
}
