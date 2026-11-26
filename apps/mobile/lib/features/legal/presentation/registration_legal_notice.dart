import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/legal/domain/legal_document.dart';
import 'package:michi_mobile/features/legal/presentation/legal_link.dart';

final class RegistrationLegalNotice extends StatefulWidget {
  const RegistrationLegalNotice({super.key});

  @override
  State<RegistrationLegalNotice> createState() =>
      _RegistrationLegalNoticeState();
}

final class _RegistrationLegalNoticeState
    extends State<RegistrationLegalNotice> {
  late final _terms = TapGestureRecognizer()
    ..onTap = () => _open(LegalDocument.terms);
  late final _privacy = TapGestureRecognizer()
    ..onTap = () => _open(LegalDocument.privacy);

  void _open(LegalDocument document) =>
      context.router.push(LegalRoute(document: document)).ignore();

  @override
  void dispose() {
    _terms.dispose();
    _privacy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final copy = context.t.legal;
    const terms = '{terms}';
    const privacy = '{privacy}';
    final sentence = copy.registration(terms: terms, privacy: privacy);
    return Text.rich(
      TextSpan(
        children: [
          for (final part
              in sentence
                  .split(
                    RegExp(
                      r'(?=\{(?:terms|privacy)\})|(?<=\{(?:terms|privacy)\})',
                    ),
                  )
                  .where((part) => part.isNotEmpty))
            if (part == terms || part == privacy)
              TextSpan(
                text: part == terms ? copy.termsInline : copy.privacyInline,
                recognizer: part == terms ? _terms : _privacy,
                mouseCursor: SystemMouseCursors.click,
                style: legalLinkStyle.copyWith(
                  fontSize: MichiTypography.meta.fontSize,
                ),
              )
            else
              TextSpan(text: part),
        ],
      ),
      style: MichiTypography.meta,
    );
  }
}
