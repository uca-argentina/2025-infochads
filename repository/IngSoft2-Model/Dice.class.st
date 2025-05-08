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
Dice class >> sidesMustBePositiveInteger: aNumberOfSides [

	((aNumberOfSides isInteger not) or: [aNumberOfSides negative]) ifTrue: [
		Error signal: 'The number of sides should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Dice class >> withSides: aNumberOfSides [

	self sidesMustBePositiveInteger: aNumberOfSides.
	^ self new initializeWithSides: aNumberOfSides
]

{ #category : 'initialization' }
Dice >> initializeWithSides: aNumberOfSides [

	numberOfSides := aNumberOfSides.
	^ self
]

{ #category : 'as yet unclassified' }
Dice >> roll [

	^ (1 to: numberOfSides) atRandom
]
