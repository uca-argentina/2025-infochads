Class {
	#name : 'DiceSet',
	#superclass : 'Object',
	#instVars : [
		'sackOfDices'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DiceSet class >> withDices: aSackOfDices [

	^ self new initializeWith: aSackOfDices
]

{ #category : 'initialization' }
DiceSet >> initializeWith: aSackOfDices [
	
	sackOfDices := aSackOfDices.
]

{ #category : 'testing' }
DiceSet >> isEmpty [

	^ false
]

{ #category : 'as yet unclassified' }
DiceSet >> toss [

	^ sackOfDices sum: [ :dice | dice roll ]
]
