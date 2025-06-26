Class {
	#name : 'LightYearTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LightYearTest >> testWhenHyperJumpDistanceIsExpressedInLightYears [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 0. 300. 3. 90. 60. 30.}.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: aConfigureDiceSet.


	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
		         withDeck: {  }.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 17
]

{ #category : 'tests' }
LightYearTest >> testWhenHyperJumpIsExpressedInLightYearsAndParsecsThenIsExpressedInParsecs [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 100. 300. 3. 90. 60. 30 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: aConfigureDiceSet.


	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
		         withDeck: {  }.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 47
]

{ #category : 'tests' }
LightYearTest >> testWhenHyperJumpIsExpressedInParsecs [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 0. 300. 0. 3. 90. 60. 30 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: aConfigureDiceSet.


	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
		         withDeck: {  }.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 17
]
