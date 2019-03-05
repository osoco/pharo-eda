removing
removeDuplicatesBlock
	^ [ :first :second | first class = second class and: [ first id = second id ] ]