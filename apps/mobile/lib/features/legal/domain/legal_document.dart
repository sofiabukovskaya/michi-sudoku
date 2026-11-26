enum LegalDocument { privacy, terms }

abstract final class LegalVersion {
  static const current = '2026-11-26';
  static const contact = '{{EMAIL}}';
  static const languages = ['en', 'cs', 'de', 'es', 'fr', 'uk'];

  static String resolveContact(String source) =>
      source.replaceAll('{{EMAIL}}', contact);

  static String asset(String locale, LegalDocument document) =>
      'assets/legal/$locale/${document.name}.md';
}
