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
HyperJumpEffect class >> mustBeInOrder: jumps [

	| previousJump |
	previousJump := jumps first + 1.

	(jumps allSatisfy: [ :jump |
		 previousJump > jump
			 ifTrue: [
				 previousJump := jump.
				 true ]
			 ifFalse: [ false ] ]) ifFalse: [
		Error signal: 'The Jump list must be in order.' ]
]

{ #category : 'as yet unclassified' }
HyperJumpEffect class >> mustHaveAtleastOne: jumps [

	jumps ifEmpty: [
		Error signal: 'The Jump list must have at least one value.' ]
]

{ #category : 'as yet unclassified' }
HyperJumpEffect class >> with: aParsecValue andParsec: jumps [

	self mustHaveAtleastOne: jumps.
	self mustBeInOrder: jumps.
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
