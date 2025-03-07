import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/extension/context_extension.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: LanguageEnums.values.map((lang) {
            return FlagWidget(lang: lang,);
          }).toList(),
        );
  }
}

class FlagWidget extends StatefulWidget {
  final LanguageEnums lang;
  const FlagWidget({super.key, required this.lang});

  @override
  State<FlagWidget> createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {
  bool isHovered = false;
    final LanguageController languageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return _item();
  
}
_item()
{
  bool isSelected =  widget.lang.languageCode == languageController.currentLanguage.value;
  return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.2,
              color: 
              isHovered? context.dividerColor:
              isSelected
                  ? context.dividerColor
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          padding:  EdgeInsets.all(isSelected ? 5 : isHovered ? 2 : 5),
          width: 40,
          height: 30,
          child: AspectRatio(
            aspectRatio: 1.8,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            
            onTap: ()
          {
            languageController.changeLanguage(context, widget.lang);
          }, child: CountryFlag.fromCountryCode(widget.lang.countryCode,shape: const RoundedRectangle(6))),
            ),
          ),
        ),
      ),
    );
}

}
