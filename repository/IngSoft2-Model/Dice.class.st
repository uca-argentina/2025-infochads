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
Dice class >> AssertIsPositive: aNumberOfSides [

	(aNumberOfSides isInteger not or: [ aNumberOfSides negative ])
		ifTrue: [
		Error signal: 'The number of sides should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Dice class >> withSides: aNumberOfSides [

	self AssertIsPositive: aNumberOfSides.
	^ self new initializeWithSides: aNumberOfSides
]

{ #category : 'initialization' }
Dice >> initializeWithSides: aNumberOfSides [

	numberOfSides := aNumberOfSides.

]

{ #category : 'as yet unclassified' }
Dice >> roll [

	^ numberOfSides atRandom
]
