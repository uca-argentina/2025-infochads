Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfSides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Dice class >> withSides: aNumberOfSides [ 
	^self new initializeWithSides: aNumberOfSides.
]

{ #category : 'initialization' }
Dice >> initializeWithSides: aNumberOfSides [ 
	numberOfSides := aNumberOfSides .
	^self
]

{ #category : 'as yet unclassified' }
Dice >> roll [

	^ (1 to: numberOfSides) atRandom
]
