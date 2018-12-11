|font1 font2 text1 text2 textMorph|

"PolymorphSystemSettings desktopLogoFileName: (FileSystem workingDirectory fullName , '/logo.png'); desktopColor: Color white.

font1 := (TextFontReference toFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 25)).
text1 := ('BBVA Applicant Tracking System', String cr) asText addAttribute: font1.
font2 := (TextFontReference toFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 14)).
text2 := (SystemVersion current datedVersion, ' [' , SystemVersion current highestUpdate printString , ']') asText addAttribute: font2.

textMorph := TextMorph new.
textMorph contents: (text1, text2).
textMorph position: (50@600).
textMorph openInWorld."
