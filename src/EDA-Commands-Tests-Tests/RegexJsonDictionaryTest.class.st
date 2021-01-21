Class {
	#name : #RegexJsonDictionaryTest,
	#superclass : #TestCase,
	#category : 'EDA-Commands-Tests-Tests'
}

{ #category : #tests }
RegexJsonDictionaryTest >> test_assertAssociationMatches_for_tricky_arrays [
	| input instance jsonText json regex regexJson |
	jsonText := '{"body":{"questions":[],"blocks":[{"i18n":[{"text":"Block 1","lang":"EN"},{"text":"Bloque 1","lang":"ES"}],"blockKey":"123456","questions":[{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"Less than 1,5M euros revenues in last year","lang":"EN"},{"text":"Menos de 1,5M euros de ingresos en el último año","lang":"ES"}],"type":"INTEGERS"},{"i18n":[{"text":"Rate your status","lang":"EN"},{"text":"Valora su estado","lang":"ES"}],"params":{"placeholder":{"i18n":[{"text":"Own a beta or a prototype that can be tested and already running","lang":"ES"},{"text":"Tener una versión Beta o Prototipo.","lang":"EN"}]},"multiple":false,"responses":[{"i18n":[{"text":"Well","lang":"EN"},{"text":"Bien","lang":"ES"}],"value":5,"default":true},{"i18n":[{"text":"Bad","lang":"EN"},{"text":"Mal","lang":"ES"}],"value":1}]},"type":"SELECT"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"Own a beta or a prototype that can be tested and already running","lang":"ES"},{"text":"Tener una versión Beta o Prototipo.","lang":"EN"}],"type":"INTEGERS"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"A startup created  from January 1st,  2013","lang":"EN"},{"text":"Startup creada después del 1 de enero de 2013","lang":"ES"}],"type":"INTEGERS"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"It has to match the thematic of each vertical to be eligible for the corresponding competition.","lang":"EN"},{"text":"Para participar en las competiciones Temáticas/Regional, deberá ser una startup relacionada con dicho tema o tener el negocio en la región correspondiente.","lang":"ES"}],"type":"INTEGERS"}]},{"i18n":[{"text":"Block 2","lang":"EN"},{"text":"Bloque 2","lang":"ES"}],"blockKey":"789456","questions":[{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"Less than 1,5M euros revenues in last year","lang":"EN"},{"text":"Menos de 1,5M euros de ingresos en el último año","lang":"ES"}],"type":"INTEGERS"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"Less than 2,5M euros fundraising","lang":"EN"},{"text":"Menos de 2,5M euros de financiación","lang":"ES"}],"type":"INTEGERS"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"Own a beta or a prototype that can be tested and already running","lang":"ES"},{"text":"Tener una versión Beta o Prototipo.","lang":"EN"}],"type":"INTEGERS"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"A startup created  from January 1st,  2013","lang":"EN"},{"text":"Startup creada después del 1 de enero de 2013","lang":"ES"}],"type":"INTEGERS"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"It has to match the thematic of each vertical to be eligible for the corresponding competition.","lang":"EN"},{"text":"Para participar en las competiciones Temáticas/Regional, deberá ser una startup relacionada con dicho tema o tener el negocio en la región correspondiente.","lang":"ES"}],"type":"INTEGERS"},{"params":{"values":[1,2,3,4,5]},"i18n":[{"text":"It has to match the thematic of each vertical to be eligible for the corresponding competition.","lang":"EN"},{"text":"Para participar en las competiciones Temáticas/Regional, deberá ser una startup relacionada con dicho tema o tener el negocio en la región correspondiente.","lang":"ES"}],"type":"INTEGERS"}]}],"aggregateRootVersion":1,"evaluatorsPerApplication":{"minToComplete":4,"groups":[{"backup":0,"recommended":0,"main":0,"evaluatorGroup":"group-1","rules":["rule-1","rule-2"]}]},"languages":["ES","EN"],"startDate":"2017-03-24T00:00:00","dateCreated":"2018-12-07T08:24:34+00:00","contestId":"contest-id-1","roundEntryDueDate":"2017-04-28T00:00:00","delete":false,"filters":[{"from_rounds":{"excluding":["f992d279-e914-428e-bb95-af6ec89a6e58"],"including":["f992d279-e914-428e-bb95-af6ec89a6e57"]}},{"above_score":{"inAllRounds":[{"blockKey":"block-1","roundId":"f992d279-e914-428e-bb95-af6ec89a6e57"},{"blockKey":"block-2","roundId":"f992d279-e914-428e-bb95-af6ec89a6e58"},{"roundId":"f992d279-e914-428e-bb95-af6ec89a6e59"}],"minEvaluations":[1,3,2],"score":3.1}},{"question":{"questionId":"15","allowedValues":["SPAIN","UK"]}},{"tag":{"values":["tag-1","tag-2"]}},{"top":{"inAnyRounds":[{"blockKey":"block-1","roundId":"f992d279-e914-428e-bb95-af6ec89a6e57"},{"blockKey":"block-2","roundId":"f992d279-e914-428e-bb95-af6ec89a6e58"},{"roundId":"f992d279-e914-428e-bb95-af6ec89a6e59"}],"topN":10}}],"version":1,"name":"OpenTalent2017-Identity-Round1","evaluationLimitInDays":5,"inputFilter":null,"evaluatorAcceptanceDueDate":"2017-04-17T00:00:00","id":"760ffb14-cc38-0d00-9ef7-1bc4098664c5","evaluatorsPerApplicant":null},"meta":{"delete":false,"version":6,"timestamp":"2018-12-07T08:24:34+00:00","id":"01b7fb14-cc38-0d00-9ef8-0a5d098664c5","correlationId":"<ANYTHING>","type":"ROUND_CREATED"}}'.
	
	regex := '{
  "meta": {
    "id": "<ANYTHING>",
    "version": 6,
    "timestamp": "1970-01-01T00:00:00",
    "correlationId": "41c8e0aa-56a2-4ab0-a54b-86e93dee73fb",
    "type": "ROUND_CREATED"
  },
  "body": {
    "id": "round-1",
    "version": 1,
    "contestId": "contest-id-1",
    "name": "OpenTalent2017-Identity-Round1",
    "startDate": "2017-03-24T00:00:00",
    "dateCreated": "1970-01-01T00:00:00",
    "roundEntryDueDate": "2017-04-28T00:00:00",
    "evaluatorAcceptanceDueDate": "2017-04-17T00:00:00",
    "evaluationLimitInDays": 5,
    "languages": [
      "ES",
      "EN"
    ],
    "evaluatorsPerApplication": {
      "minToComplete": 4,
      "groups": [
        {
          "evaluatorGroup": "group-1",
          "rules": [
            "rule-1",
            "rule-2"
          ],
          "main": 0,
          "backup": 0,
          "recommended": 0
        }
      ]
    },
    "filters": [
      {
        "from_rounds": {
          "including": [
            "f992d279-e914-428e-bb95-af6ec89a6e57"
          ],
          "excluding": [
            "f992d279-e914-428e-bb95-af6ec89a6e58"
          ]
        }
      },
      {
        "above_score": {
          "inAllRounds": [
            {
              "roundId": "f992d279-e914-428e-bb95-af6ec89a6e57",
              "blockKey": "block-1"
            },
            {
              "roundId": "f992d279-e914-428e-bb95-af6ec89a6e58",
              "blockKey": "block-2"
            },
            {
              "roundId": "f992d279-e914-428e-bb95-af6ec89a6e59"
            }
          ],
          "score": 3.1,
          "minEvaluations": [
            1,
            3,
            2
          ]
        }
      },
      {
        "question": {
          "questionId": "15",
          "allowedValues": [
            "SPAIN",
            "UK"
          ]
        }
      },
      {
        "tag": {
          "values": [
            "tag-1",
            "tag-2"
          ]
        }
      },
      {
        "top": {
          "inAnyRounds": [
            {
              "roundId": "f992d279-e914-428e-bb95-af6ec89a6e57",
              "blockKey": "block-1"
            },
            {
              "roundId": "f992d279-e914-428e-bb95-af6ec89a6e58",
              "blockKey": "block-2"
            },
            {
              "roundId": "f992d279-e914-428e-bb95-af6ec89a6e59"
            }
          ],
          "topN": 10
        }
      }
    ],
    "blocks": [
      {
        "blockKey": "123456",
        "i18n": [
          {
            "lang": "EN",
            "text": "Block 1"
          },
          {
            "lang": "ES",
            "text": "Bloque 1"
          }
        ],
        "questions": [
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "Less than 1,5M euros revenues in last year"
              },
              {
                "lang": "ES",
                "text": "Menos de 1,5M euros de ingresos en el último año"
              }
            ]
          },
          {
            "type": "SELECT",
            "i18n": [
              {
                "lang": "EN",
                "text": "Rate your status"
              },
              {
                "lang": "ES",
                "text": "Valora su estado"
              }
            ],
            "params": {
              "placeholder": {
                "i18n": [
                  {
                    "lang": "ES",
                    "text": "Own a beta or a prototype that can be tested and already running"
                  },
                  {
                    "lang": "EN",
                    "text": "Tener una versión Beta o Prototipo."
                  }
                ]
              },
              "responses": [
                {
                  "i18n": [
                    {
                      "lang": "EN",
                      "text": "Well"
                    },
                    {
                      "lang": "ES",
                      "text": "Bien"
                    }
                  ],
                  "value": 5,
                  "default": true
                },
                {
                  "i18n": [
                    {
                      "lang": "EN",
                      "text": "Bad"
                    },
                    {
                      "lang": "ES",
                      "text": "Mal"
                    }
                  ],
                  "value": 1
                }
              ],
              "multiple": false
            }
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "ES",
                "text": "Own a beta or a prototype that can be tested and already running"
              },
              {
                "lang": "EN",
                "text": "Tener una versión Beta o Prototipo."
              }
            ]
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "A startup created  from January 1st,  2013"
              },
              {
                "lang": "ES",
                "text": "Startup creada después del 1 de enero de 2013"
              }
            ]
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "It has to match the thematic of each vertical to be eligible for the corresponding competition."
              },
              {
                "lang": "ES",
                "text": "Para participar en las competiciones Temáticas/Regional, deberá ser una startup relacionada con dicho tema o tener el negocio en la región correspondiente."
              }
            ]
          }
        ]
      },
      {
        "blockKey": "789456",
        "i18n": [
          {
            "lang": "EN",
            "text": "Block 2"
          },
          {
            "lang": "ES",
            "text": "Bloque 2"
          }
        ],
        "questions": [
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "Less than 1,5M euros revenues in last year"
              },
              {
                "lang": "ES",
                "text": "Menos de 1,5M euros de ingresos en el último año"
              }
            ]
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "Less than 2,5M euros fundraising"
              },
              {
                "lang": "ES",
                "text": "Menos de 2,5M euros de financiación"
              }
            ]
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "ES",
                "text": "Own a beta or a prototype that can be tested and already running"
              },
              {
                "lang": "EN",
                "text": "Tener una versión Beta o Prototipo."
              }
            ]
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "A startup created  from January 1st,  2013"
              },
              {
                "lang": "ES",
                "text": "Startup creada después del 1 de enero de 2013"
              }
            ]
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "It has to match the thematic of each vertical to be eligible for the corresponding competition."
              },
              {
                "lang": "ES",
                "text": "Para participar en las competiciones Temáticas/Regional, deberá ser una startup relacionada con dicho tema o tener el negocio en la región correspondiente."
              }
            ]
          },
          {
            "type": "INTEGERS",
            "params": {
              "values": [1,2,3,4,5]
            },
            "i18n": [
              {
                "lang": "EN",
                "text": "It has to match the thematic of each vertical to be eligible for the corresponding competition."
              },
              {
                "lang": "ES",
                "text": "Para participar en las competiciones Temáticas/Regional, deberá ser una startup relacionada con dicho tema o tener el negocio en la región correspondiente."
              }
            ]
          }
        ]
      }
    ]
  }
}
'.
	json := NeoJSONReader fromString: jsonText.
	regexJson := RegexJson fromString: regex andTestCase: self.
	regexJson assertMatches: json
]
