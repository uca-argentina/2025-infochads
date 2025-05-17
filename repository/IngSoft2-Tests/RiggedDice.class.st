Class {
	#name : 'RiggedDice',
	#superclass : 'Object',
	#instVars : [
		'setOfMovements',
		'turn'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialization' }
RiggedDice >> initializeWith: aSetOfMovements [

	setOfMovements := aSetOfMovements.
	turn := 1
]

{ #category : 'as yet unclassified' }
RiggedDice >> toss [

	| movement |
	movement := setOfMovements at: turn.
	turn := turn + 1.
	^ movement
]
