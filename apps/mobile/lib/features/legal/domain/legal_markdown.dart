enum LegalBlockType { title, heading, paragraph, bullet }

typedef LegalBlock = ({LegalBlockType type, String text});
typedef LegalSpan = ({String text, bool bold, Uri? link});

/// The deliberately small Markdown subset shared by the app and static site.
abstract final class LegalMarkdown {
  static List<LegalBlock> blocks(String source) {
    final result = <LegalBlock>[];
    final paragraph = <String>[];
    void flush() {
      if (paragraph.isEmpty) return;
      result.add((type: LegalBlockType.paragraph, text: paragraph.join(' ')));
      paragraph.clear();
    }

    for (final line in source.split('\n').map((line) => line.trim())) {
      final (type, prefix) = switch (line) {
        String s when s.startsWith('# ') => (LegalBlockType.title, 2),
        String s when s.startsWith('## ') => (LegalBlockType.heading, 3),
        String s when s.startsWith('- ') => (LegalBlockType.bullet, 2),
        _ => (LegalBlockType.paragraph, 0),
      };
      if (line.isEmpty || prefix != 0) flush();
      if (prefix != 0) {
        result.add((type: type, text: line.substring(prefix)));
      } else if (line.isNotEmpty) {
        paragraph.add(line);
      }
    }
    flush();
    return result;
  }

  static final _inline = RegExp(r'\*\*([^*]+)\*\*|\[([^\]]+)\]\(([^)]+)\)');

  static List<LegalSpan> spans(String text) {
    final result = <LegalSpan>[];
    var offset = 0;
    for (final match in _inline.allMatches(text)) {
      if (match.start > offset) {
        result.add((
          text: text.substring(offset, match.start),
          bold: false,
          link: null,
        ));
      }
      final bold = match[1];
      final uri = Uri.tryParse(match[3] ?? '');
      final safe =
          uri != null &&
          ((uri.scheme == 'https' && uri.host.isNotEmpty) ||
              (uri.scheme == 'mailto' && uri.path.contains('@')));
      result.add((
        text: bold ?? match[2]!,
        bold: bold != null,
        link: safe ? uri : null,
      ));
      offset = match.end;
    }
    if (offset < text.length) {
      result.add((text: text.substring(offset), bold: false, link: null));
    }
    return result;
  }
}
