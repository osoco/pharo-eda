test
retrieveAggregateFromExistingAggregateMethodFor: fileName shouldBe: aggregate
	| generator stream contents json |
	generator := ATSGenerator new.
	stream := fileName readStream.
	contents := stream contents.
	stream close.
	json := NeoJSONReader fromString: contents.
	self assert: (generator retrieveAggregateFromExistingAggregateMethod: json) equals: aggregate