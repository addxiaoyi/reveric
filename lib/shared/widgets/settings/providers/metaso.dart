// 职责: 展示秘塔科技 MiniMax H3 的介绍卡片和渠道入口。
// 关联文件:
//   lib/shared/widgets/settings/providers/registry.dart
//   lib/shared/widgets/settings/provider_overview.dart
//   lib/shared/models/provider_brand.dart
//   lib/shared/localization/locale_keys.dart
//   assets/translations/en/settings.json
//   assets/translations/zh-CN/settings.json
// 遵循的 Rules:
//   .agents/rules/design-system.md
//   .agents/rules/i18n.md

import 'package:flutter/material.dart';

import '../../../components/reveric_button.dart';
import '../../../components/reveric_surfaces.dart';
import '../../../localization/app_localization.dart';
import '../../../localization/locale_keys.dart';
import '../../../models/provider_brand.dart';
import '../../../theme/theme.dart';
import '../provider_overview.dart';
import 'registry.dart';

const metasoShowcase = ProviderShowcase(card: _buildCard);

Widget _buildCard(BuildContext context) => const _MetasoCard();

class _MetasoCard extends StatelessWidget {
  const _MetasoCard();

  @override
  Widget build(BuildContext context) {
    final colors = RevericTheme.colorsOf(context);
    final typo = RevericTheme.typographyOf(context);
    final divider = Padding(
      padding: const EdgeInsets.symmetric(vertical: RevericSpacing.x3l),
      child: Divider(
        height: RevericSizes.dividerThickness,
        color: colors.borderSubtle,
      ),
    );
    return RevericElevatedCard(
      fallback: colors.surface,
      padding: const EdgeInsets.all(RevericSpacing.x4l),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 380;
          // 按钮与说明并排需要更宽的空间，单独判断。
          final footerWide = constraints.maxWidth >= 520;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.t(LocaleKeys.settingsProviderMetasoCategory),
                style: typo.uiTiny.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: RevericSpacing.lg),
              _pair(
                wide: wide,
                flexible: false,
                first: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t(LocaleKeys.settingsProviderMetasoTagline),
                      style: typo.uiSmall.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: RevericSpacing.xs),
                    Text.rich(
                      TextSpan(
                        text: 'MiniMax',
                        children: [
                          TextSpan(
                            text: ' H3',
                            style: typo.display.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      style: typo.display.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: RevericSpacing.sm),
                    Text(
                      context.t(LocaleKeys.settingsProviderMetasoSummary),
                      style: typo.uiSmall.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
                second: Column(
                  crossAxisAlignment: wide
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.t(LocaleKeys.settingsProviderMetasoMaxDuration),
                      style: typo.uiTiny.copyWith(color: colors.textMuted),
                    ),
                    const SizedBox(height: RevericSpacing.xxs),
                    Text(
                      '30${context.t(LocaleKeys.settingsProviderMetasoSeconds)}',
                      style: typo.display.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: RevericSpacing.xxs),
                    Text(
                      '480P / 768P',
                      style: typo.uiTiny.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
              ),
              divider,
              _pair(
                wide: wide,
                divided: false,
                first: _Feature(
                  icon: RevericIcons.film_slate,
                  title: context.t(
                    LocaleKeys.settingsProviderMetasoResolutionTitle,
                  ),
                  description: context.t(
                    LocaleKeys.settingsProviderMetasoResolutionDescription,
                  ),
                ),
                second: _Feature(
                  icon: RevericIcons.waveform,
                  title: context.t(LocaleKeys.settingsProviderMetasoAudioTitle),
                  description: context.t(
                    LocaleKeys.settingsProviderMetasoAudioDescription,
                  ),
                ),
              ),
              divider,
              Flex(
                direction: footerWide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: footerWide
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: RevericSpacing.lg,
                          runSpacing: RevericSpacing.xxs,
                          children: [
                            for (final label in [
                              context.t(
                                LocaleKeys
                                    .settingsProviderMetasoOpenaiCompatible,
                              ),
                              'ComfyUI',
                              context.t(
                                LocaleKeys.settingsProviderMetasoCanvas,
                              ),
                            ])
                              Text(
                                label,
                                style: typo.uiSmallSemibold.copyWith(
                                  color: colors.textPrimary,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: RevericSpacing.xxs),
                        Text(
                          context.t(LocaleKeys.settingsProviderMetasoNoGpu),
                          style: typo.uiTiny.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: footerWide ? RevericSpacing.x4l : 0,
                    height: footerWide ? 0 : RevericSpacing.lg,
                  ),
                  RevericButton.primary(
                    label: context.t(LocaleKeys.settingsProviderMetasoLink),
                    icon: RevericIcons.arrow_square_out,
                    onPressed: () => openProviderChannelUrl(
                      context,
                      providerChannelUrls['metaso']!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: RevericSpacing.x3l),
              Text(
                context.t(LocaleKeys.settingsProviderMetasoPricingNote),
                style: typo.uiTiny.copyWith(color: colors.textMuted),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 宽屏左右并排（可选竖分隔线），窄屏上下堆叠。
  Widget _pair({
    required bool wide,
    required Widget first,
    required Widget second,
    bool divided = true,
    bool flexible = true,
  }) {
    if (!wide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          first,
          const SizedBox(height: RevericSpacing.x3l),
          second,
        ],
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: first),
          if (divided)
            Builder(
              builder: (context) => VerticalDivider(
                width: RevericSpacing.x6l,
                thickness: RevericSizes.dividerThickness,
                color: RevericTheme.colorsOf(context).borderSubtle,
              ),
            )
          else
            const SizedBox(width: RevericSpacing.x4l),
          if (flexible) Expanded(child: second) else second,
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = RevericTheme.colorsOf(context);
    final typo = RevericTheme.typographyOf(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevericIcon(icon, size: 18, color: colors.textSecondary),
        const SizedBox(width: RevericSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: typo.uiSmallSemibold.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: RevericSpacing.xxs),
              Text(
                description,
                style: typo.uiTiny.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
