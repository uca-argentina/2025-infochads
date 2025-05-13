Class {
	#name : 'DiceSet',
	#superclass : 'Object',
	#instVars : [
		'sackOfDices'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
DiceSet >> add: aDice [

	sackOfDices add: aDice
]

{ #category : 'initialization' }
DiceSet >> initializeWith [

	sackOfDices := OrderedCollection new
]

{ #category : 'as yet unclassified' }
DiceSet >> toss [

	^ sackOfDices inject: 0 into: [ :result :dice | result + dice roll ]
]
