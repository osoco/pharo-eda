test
testRetrieveCommandAttributesBut
	| generator |
	generator := EDAGenerator new.
	generator commandJson: { (#body -> { (#a -> 1) . (#b -> 2) . (#c -> 3) } asDictionary ) } asDictionary.
	self assert: (generator retrieveCommandAttributesBut: #('a')) equals: #(#b #c) asSortedCollection.
	generator commandJson: { (#body -> { (#answers -> 'a') . (#applicantKey -> 'b') . (#applicationKey -> 'c' ) . (#contestId -> 'd') . (#firstSubmissionDate -> 'e') . (#formId -> 'f') . (#language -> 'g') . (#origin -> 'h') . (#recoveryKey -> 'i') . (#sections -> 'j') . (#status -> 'k') . (#submissionDate -> 'l') } asDictionary ) } asDictionary.
	self assert: (generator retrieveCommandAttributesBut: #('applicationKey')) equals: #(#answers #applicantKey #contestId #firstSubmissionDate #formId #language #origin #recoveryKey #sections #status #submissionDate) asSortedCollection.
