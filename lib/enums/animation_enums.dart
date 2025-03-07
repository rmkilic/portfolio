enum AnimationEnums
{
  notfound,
  theme
}

extension AnimationExtension on AnimationEnums{

  String get animationName
  {
    switch(this)
    {      
      case AnimationEnums.notfound:
        return 'an_astronaut';
      
      case AnimationEnums.theme:
        return 'an_theme';

    
    }
  }

  String get toPath => 'assets/animation/$animationName.json';


}