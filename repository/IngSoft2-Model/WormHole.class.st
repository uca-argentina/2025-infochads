Class {
	#name : 'WormHole',
	#superclass : 'Object',
	#instVars : [
		'entry',
		'exit'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
WormHole class >> startingAt: aPosition endingAt: anotherPosition [

	self wormHoleExitMustBePositive: aPosition.
	self wormHoleExitMustBePositive: anotherPosition.

	^ self new intializeStartingAt: aPosition endingAt: anotherPosition.
]

{ #category : 'as yet unclassified' }
WormHole class >> wormHoleExitMustBePositive: aWormHoleExit [

	(aWormHoleExit isInteger and: [
		 aWormHoleExit = 0 or: [ aWormHoleExit > 1 ] ]) ifFalse: [
		Error signal:
			'WormHole must be a pair of integers.' ]
]

{ #category : 'as yet unclassified' }
WormHole class >> wormHoleExitMustNotBeEntry: aWormHole [

	aWormHole first = aWormHole second ifTrue: [
		Error signal: 'The WormHole Entry cannot be the exit.' ]
]

{ #category : 'accessing' }
WormHole >> if: aPosition isPlacedAt: oneEntry mustComeOutAt: anotherEntry [

	aPosition = oneEntry ifTrue: [ ^ anotherEntry ].
	^ aPosition
]

{ #category : 'as yet unclassified' }
WormHole >> intializeStartingAt: aPosition endingAt: anotherPosition [

	entry := aPosition.
	exit := anotherPosition.
	self verifyExistanceOfWormHole ifTrue: [
		self the: entry cannotBeEqualTo: exit ].
	 "iF entry = exit = 0 Then is valid BUT the WH doesnt exist"
	
]

{ #category : 'as yet unclassified' }
WormHole >> mustBeWithInLimits: aBoardSize [

	self verifyExistanceOfWormHole ifFalse: [ ^ self ].

	self the: entry mustBeInside: aBoardSize.
	self the: exit mustBeInside: aBoardSize
]

{ #category : 'as yet unclassified' }
WormHole >> the: aPosition cannotBeEqualTo: anotherPosition [

	aPosition = anotherPosition ifTrue: [
		Error signal: 'The WormHole Entry cannot be the exit.' ]
]

{ #category : 'as yet unclassified' }
WormHole >> the: position mustBeInside: aBoardsize [

	(position < aBoardsize and: position >= 1) ifFalse: [
		Error signal: 'WormHole exit must be within board limits.' ]
]

{ #category : 'as yet unclassified' }
WormHole >> verifyExistanceOfWormHole [

	^ (exit = entry and: entry = 0)
		  ifTrue: [ ^ false ]
		  ifFalse: [ ^ true ]
]

{ #category : 'as yet unclassified' }
WormHole >> verifyPosition: aPosition [

	| auxiliaryPosition |
	auxiliaryPosition := self
		                     if: aPosition
		                     isPlacedAt: entry
		                     mustComeOutAt: exit.
	aPosition = entry ifFalse: [
		auxiliaryPosition := self
			                     if: auxiliaryPosition
			                     isPlacedAt: exit
			                     mustComeOutAt: entry ].


	^ auxiliaryPosition
]
