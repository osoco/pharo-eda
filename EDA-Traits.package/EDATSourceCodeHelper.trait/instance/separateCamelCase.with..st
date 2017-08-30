helper
separateCamelCase: aString with: aSeparator
   ^ (aString copyWithRegex: '[A-Z]' matchesTranslatedUsing: [ :each | aSeparator , each asLowercase  ]) allButFirst 