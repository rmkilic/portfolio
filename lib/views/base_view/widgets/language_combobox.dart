import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:portfolio/enums/language_enums.dart';
import 'package:portfolio/views/base_view/controllers/language_controllers.dart';

class LanguageCombobox extends StatefulWidget {
  const LanguageCombobox({super.key});

  @override
  State<LanguageCombobox> createState() => _LanguageComboboxState();
}

class _LanguageComboboxState extends State<LanguageCombobox> {
  
  late List<CountryFlag> countryFlags;

  @override
  void initState() {
  
    super.initState();
    countryFlags = [];
    for(LanguageEnums lang in LanguageEnums.values)
    {
      countryFlags.add(CountryFlag.fromCountryCode(lang.countryCode, shape: const RoundedRectangle(6),));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    return  _dropButton();
  }
    _dropButton()
  {

    final LanguageController languageController = Get.find();




     CountryFlag selectedValue = countryFlags.where((e)=> e.flagCode == languageController.currentLanguageEnums.value.countryCode).toList().first;

   return Theme(
       data: Theme.of(context).copyWith(
         buttonTheme: ButtonTheme.of(context).copyWith(
           alignedDropdown: true,  
         )
       ),
       child: DropdownButtonHideUnderline( 
         child: DropdownButton<CountryFlag>(
           borderRadius: BorderRadius.circular(6),
           padding: EdgeInsets.zero,
           items: countryFlags.map((CountryFlag value){
             return DropdownMenuItem<CountryFlag>(
               value: value,
               child: _label(countryCode: value.flagCode!),
             );
           }).toList(),
           onChanged: (CountryFlag? flag) async{
                       if(flag != null)
                       {
                         LanguageEnums lang = LanguageEnums.values.where((e)=> e.countryCode == flag.flagCode).toList().first;
                          languageController.changeLanguage(context, lang);
                           
                       }
                       
                     },
           value: selectedValue, 
         ),
       )
   );
  }


  Widget _label({required String countryCode})
  {
    return SizedBox(
            width: 28,
            height: 18,
            child: Center(
              child: AspectRatio(
              aspectRatio: 1.8,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: CountryFlag.fromCountryCode(countryCode, shape: const RoundedRectangle(6),),
              ),
                        ),
            ),
    );
  }
}

