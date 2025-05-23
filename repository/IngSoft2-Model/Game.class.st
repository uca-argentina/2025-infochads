Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'aBoard',
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips [

	aNumberOfSpaceShips <= 0 ifTrue: [
		Error signal: 'The number of space ships must be at least 1.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBePositiveInteger: boardSize [

	(boardSize isInteger not or: [ boardSize negative ]) ifTrue: [
		Error signal:
			'The number of space ships should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> withBoardSize: aBoardSize withSpaceShips: aNumberOfSpaceShips withDiceSet: aDiceSet withWormHole: aWormHolePosition [
	
	self numberOfSpaceShipsMustBePositiveInteger: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.

	^ self new
		  initializeWithBoardSize: aBoardSize
		  AndNumberOfSpaceShips: aNumberOfSpaceShips
		  AndDiceSet: aDiceSet
		  AndWormHole: aWormHolePosition
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: attacker and: defendant [

	| attackDiceRoll1 attackDiceRoll2 |
	[
	attackDiceRoll1 := diceSet toss.
	attackDiceRoll2 := diceSet toss.
	attackDiceRoll1 = attackDiceRoll2 ] whileTrue.

	attackDiceRoll1 > attackDiceRoll2
		ifTrue: [ attacker lostBattle ]
		ifFalse: [ defendant lostBattle ]
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoardSize AndNumberOfSpaceShips: aNumberOfSpaceShips AndDiceSet: aDiceSet AndWormHole: aWormHolePosition [

	aBoard := Board withSize: aBoardSize andWormHolePosition: aWormHolePosition .
	spaceShips := self startingPositions: aNumberOfSpaceShips.
	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	^ self
]

{ #category : 'testing' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip | (aShip getPosition) = aBoard boardSize ]
]

{ #category : 'testing' }
Game >> isOver [

	^ self isGameOver
]

{ #category : 'as yet unclassified' }
Game >> lookForBattle: aSpaceShip [

	| opponentShip otherShips |
	otherShips := spaceShips select: [ :ship | ship ~= aSpaceShip ].

	opponentShip := otherShips
		                detect: [ :ship |
		                ship getPosition = aSpaceShip getPosition ]
		                ifNone: [ nil ].

	opponentShip isNil ifFalse: [
		self battleBetween: aSpaceShip and: opponentShip ]
]

{ #category : 'as yet unclassified' }
Game >> positionOfSpaceShip: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getPosition.
]

{ #category : 'as yet unclassified' }
Game >> shieldStatus: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getShield
]

{ #category : 'accessing' }
Game >> start [

	| diceRoll spaceShip |
	diceRoll := diceSet toss.
	[ self isGameOver or: diceRoll = 0 ] whileFalse: [
		spaceShip := spaceShips at: nextSpaceShipToMove.
		self the: spaceShip hasRolled: diceRoll.
		self lookForBattle: spaceShip.
		self updateNextShipToMove: nextSpaceShipToMove.
		diceRoll := diceSet toss ]
]

{ #category : 'whats left of race positions' }
Game >> startingPositions: aNumberOfSpaceShips [

	| initialPositions |
	initialPositions := OrderedCollection new.
	1 to: aNumberOfSpaceShips do: [ :position |
		initialPositions add: (SpaceShip new
				 initializeWithShield: 3
				 andInitialPosition: 0
				 andID: position) ].

	^ initialPositions
]

{ #category : 'as yet unclassified' }
Game >> the: spaceShip hasRolled: diceRoll [

	spaceShip goToTemporaryPosition: diceRoll.
	spaceShip updatePosition:
		(aBoard adjustPositionOf: spaceShip getTemporaryPosition)
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
