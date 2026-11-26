import 'dart:convert';
import 'dart:io';

import 'package:michi_mobile/features/legal/domain/legal_document.dart';
import 'package:michi_mobile/features/legal/domain/legal_markdown.dart';

const _escape = HtmlEscape();

void main(List<String> args) {
  if (args.any((arg) => arg != '--check-ready')) {
    stderr.writeln(
      'Usage: dart run tool/build_legal_site.dart [--check-ready]',
    );
    exitCode = 64;
    return;
  }

  final mobile = File.fromUri(Platform.script).parent.parent.path;
  final pages = <String, String>{};
  final unresolved = <String>{};
  for (final language in LegalVersion.languages) {
    final localeFile = File(
      '$mobile/lib/core/localization/i18n/$language.i18n.json',
    );
    final translations =
        jsonDecode(localeFile.readAsStringSync()) as Map<String, dynamic>;
    final legal = translations['legal'] as Map<String, dynamic>;
    final updated = (legal['updated'] as String).replaceAll(
      r'$date',
      LegalVersion.current,
    );
    for (final document in LegalDocument.values) {
      final draft = File(
        '$mobile/${LegalVersion.asset(language, document)}',
      ).readAsStringSync();
      final source = LegalVersion.resolveContact(draft);
      unresolved.addAll(
        RegExp(r'\{\{[A-Z_]+\}\}').allMatches(source).map((match) => match[0]!),
      );
      pages['$language/${document.name}.html'] = _page(
        language,
        document,
        source,
        updated,
        legal,
      );
    }
  }

  if (unresolved.isNotEmpty) {
    stderr.writeln('Draft placeholders: ${unresolved.join(', ')}');
    if (args.contains('--check-ready')) {
      exitCode = 1;
      return;
    }
  }

  final output = '$mobile/build/legal_site';
  for (final page in pages.entries) {
    File('$output/${page.key}')
      ..createSync(recursive: true)
      ..writeAsStringSync(page.value);
  }
  File('$output/index.html').writeAsStringSync(
    '<!doctype html><html lang="en"><meta charset="utf-8"> '
    '<meta name="viewport" content="width=device-width,initial-scale=1"> '
    '<title>MICHI</title><style>$_css</style><main><h1>MICHI</h1> '
    '<nav aria-label="Language">${_languages(LegalDocument.privacy, fromIndex: true)}</nav></main></html>',
  );
  stdout.writeln('Generated ${pages.length} documents in $output');
}

String _page(
  String language,
  LegalDocument document,
  String source,
  String updated,
  Map<String, dynamic> legal,
) {
  final blocks = LegalMarkdown.blocks(source);
  final body = StringBuffer();
  final finalHeading = blocks.lastIndexWhere(
    (block) => block.type == LegalBlockType.heading,
  );
  var list = false;
  for (final (index, block) in blocks.indexed) {
    final bullet = block.type == LegalBlockType.bullet;
    if (bullet != list) {
      body.write(bullet ? '<ul>' : '</ul>');
      list = bullet;
    }
    final tag = switch (block.type) {
      LegalBlockType.title => 'h1',
      LegalBlockType.heading => 'h2',
      LegalBlockType.paragraph => 'p',
      LegalBlockType.bullet => 'li',
    };
    // The account-deletion section is the final heading in each policy.
    final anchor = document == LegalDocument.privacy && index == finalHeading
        ? ' id="delete-account"'
        : '';
    body.write('<$tag$anchor>${_inline(block.text)}</$tag>');
    if (tag == 'h1') {
      body.write('<p class="updated">${_escape.convert(updated)}</p>');
    }
  }
  if (list) body.write('</ul>');
  final other = document == LegalDocument.privacy
      ? LegalDocument.terms
      : LegalDocument.privacy;
  final otherLabel = _escape.convert(legal[other.name] as String);
  return '<!doctype html><html lang="$language"><meta charset="utf-8"> '
      '<meta name="viewport" content="width=device-width,initial-scale=1"> '
      '<title>MICHI · ${_escape.convert(blocks.first.text)}</title> '
      '<style>$_css</style><main><nav aria-label="Language"> '
      '${_languages(document)}</nav>$body '
      '<footer><a href="${other.name}.html">$otherLabel</a></footer> '
      '</main></html>';
}

String _inline(String value) => LegalMarkdown.spans(value).map((span) {
  final text = _escape.convert(span.text);
  if (span.link case final uri?) {
    return '<a href="${_escape.convert(uri.toString())}">$text</a>';
  }
  return span.bold ? '<strong>$text</strong>' : text;
}).join();

String _languages(LegalDocument document, {bool fromIndex = false}) => [
  for (final language in LegalVersion.languages)
    _languageLink(language, document, fromIndex: fromIndex),
].join(' ');

String _languageLink(
  String language,
  LegalDocument document, {
  required bool fromIndex,
}) {
  final path = '${fromIndex ? '' : '../'}$language/${document.name}.html';
  return '<a hreflang="$language" href="$path">${language.toUpperCase()}</a>';
}

const _css = '''
html{background:#f7f2e8;color:#252724;font:1.05rem/1.65 system-ui,sans-serif}
main{max-width:43rem;margin:auto;padding:clamp(1rem,4vw,3rem)}
h1,h2{font-family:Georgia,serif;line-height:1.25} h2{margin-top:2rem}
a{color:#4d6275} nav a{display:inline-block;padding:.4rem;margin-right:.35rem}
.updated{color:#66655e}
''';
