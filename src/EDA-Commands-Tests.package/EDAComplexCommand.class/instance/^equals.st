as yet unclassified
= aCommand
  ^ ((self class = aCommand class)
     and: (self commandId = aCommand commandId))
    and: (self levels = aCommand levels)
