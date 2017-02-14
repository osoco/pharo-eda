as yet unclassified
extractLevel: aDictionary
    "Extracts the level from given dictionary"
    ^ GCLevel new
          levelName: (aDictionary at: #levelName);
          levelRangeSize:
              (aDictionary at: #levelRangeSize
                           ifAbsent: nil)