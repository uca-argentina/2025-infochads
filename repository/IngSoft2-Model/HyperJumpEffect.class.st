Class {
	#name : 'HyperJumpEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'listOfJumps',
		'turn',
		'parsecsPerCell'
	],
	#classInstVars : [
		'parsecs',
		'parsecScale',
		'listOfJumps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJumpEffect class >> with: aParsecValue andParsec: jumps [
	
	^self new initializeWith: aParsecValue andParsec: jumps
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> applyToSpaceShip: aPosition [

	| aDisplacement |
	aDisplacement := listOfJumps removeFirst.
	listOfJumps add: aDisplacement.
	
	^ Position at: aPosition + (aDisplacement/parsecsPerCell) withLaps: 0
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> initializeWith: aParsecValue andParsec: jumps [

	parsecsPerCell := aParsecValue.
	listOfJumps := jumps.
	turn := 1.
]
