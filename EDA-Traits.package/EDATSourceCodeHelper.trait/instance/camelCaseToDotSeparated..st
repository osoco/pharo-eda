helper
camelCaseToDotSeparated: aString
   ^ (aString copyWithRegex: '[A-Z]' matchesTranslatedUsing: [ :each | '.' , each asLowercase  ]) allButFirst 