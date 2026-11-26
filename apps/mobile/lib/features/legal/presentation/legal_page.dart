import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/legal/domain/legal_document.dart';
import 'package:michi_mobile/features/legal/domain/legal_markdown.dart';
import 'package:michi_mobile/features/legal/presentation/legal_link.dart';

@RoutePage()
final class LegalPage extends StatefulWidget {
  const LegalPage({required this.document, super.key});

  final LegalDocument document;

  @override
  State<LegalPage> createState() => _LegalPageState();
}

final class _LegalPageState extends State<LegalPage> {
  Future<String>? _text;
  String? _locale;
  AssetBundle? _bundle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  @override
  void didUpdateWidget(LegalPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.document != widget.document) {
      _locale = null;
      _load();
    }
  }

  void _load() {
    final locale = TranslationProvider.of(
      context,
    ).locale.flutterLocale.languageCode;
    final bundle = DefaultAssetBundle.of(context);
    if (_locale == locale && identical(_bundle, bundle)) return;
    _locale = locale;
    _bundle = bundle;
    _text = _read(bundle, locale, widget.document);
  }

  static Future<String> _read(
    AssetBundle bundle,
    String locale,
    LegalDocument document,
  ) async {
    if (locale != 'en') {
      try {
        return await bundle.loadString(LegalVersion.asset(locale, document));
      } on Object {
        // Older bundles may only contain the English document.
      }
    }
    return bundle.loadString(LegalVersion.asset('en', document));
  }

  @override
  Widget build(BuildContext context) {
    final copy = context.t.legal;
    return Scaffold(
      backgroundColor: MichiColors.paper,
      appBar: AppBar(
        title: Text(
          widget.document == LegalDocument.privacy ? copy.privacy : copy.terms,
        ),
      ),
      body: SafeArea(
        child: MichiContentFrame(
          child: FutureBuilder<String>(
            future: _text,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              final source = snapshot.data;
              if (source == null) return Center(child: Text(copy.unavailable));
              return SelectionArea(
                child: ListView(
                  padding: const EdgeInsets.all(MichiSpacing.xl),
                  children: [
                    Text(
                      copy.updated(date: LegalVersion.current),
                      style: MichiTypography.meta,
                    ),
                    const SizedBox(height: MichiSpacing.md),
                    LegalMarkdownView(
                      source: LegalVersion.resolveContact(source),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

final class LegalMarkdownView extends StatelessWidget {
  const LegalMarkdownView({required this.source, super.key});
  final String source;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (final block in LegalMarkdown.blocks(source))
        Padding(
          padding: EdgeInsets.only(
            bottom: block.type == LegalBlockType.bullet
                ? MichiSpacing.xs
                : MichiSpacing.md,
          ),
          child: Semantics(
            header:
                block.type == LegalBlockType.title ||
                block.type == LegalBlockType.heading,
            child: Text.rich(
              TextSpan(
                children: [
                  if (block.type == LegalBlockType.bullet)
                    const TextSpan(text: '•  '),
                  for (final span in LegalMarkdown.spans(block.text))
                    if (span.link case final uri?)
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: LegalLink(
                          label: span.text,
                          onTap: () => openLegalLink(context, uri),
                        ),
                      )
                    else
                      TextSpan(
                        text: span.text,
                        style: span.bold
                            ? const TextStyle(fontWeight: FontWeight.w700)
                            : null,
                      ),
                ],
              ),
              style: switch (block.type) {
                LegalBlockType.title => MichiTypography.functionalTitle,
                LegalBlockType.heading => MichiTypography.heading,
                _ => MichiTypography.body,
              },
            ),
          ),
        ),
    ],
  );
}
