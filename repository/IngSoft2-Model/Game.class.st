Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips',
		'laps',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> lapsMustBePositive: aNumberOfLaps [

	(aNumberOfLaps isInteger and: [ aNumberOfLaps > 0 ]) ifFalse: [
		self error: 'Laps must be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips [

	aNumberOfSpaceShips <= 0 ifTrue: [
		Error signal: 'The number of space ships must be at least 1.' ]
]

{ #category : 'as yet unclassified' }
Game class >> numberOfSpaceShipsMustBePositive: aNumberOfSpaceShips [

	(aNumberOfSpaceShips isInteger not or: [
		 aNumberOfSpaceShips negative ]) ifTrue: [
		Error signal:
			'The number of space ships should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Game class >> playedIn: aBoard by: aNumberOfSpaceShips throwing: aDiceSet wonAfter: aNumberOfLaps [

	self numberOfSpaceShipsMustBePositive: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.
	self lapsMustBePositive: aNumberOfLaps.

	^ self new
		  initializeWithBoardSize: aBoard
		  by: aNumberOfSpaceShips
		  thorwing: aDiceSet
		  wonAfter: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: spaceShip1 and: spaceShip2 [

	| throwSpaceShip1 throwSpaceShip2 |
	[
	throwSpaceShip2 := diceSet toss.
	throwSpaceShip1 := diceSet toss.
	throwSpaceShip1 = throwSpaceShip2 ] whileTrue: [  ].
	throwSpaceShip1 < throwSpaceShip2
		ifTrue: [ spaceShip1 lostBattle ]
		ifFalse: [ spaceShip2 lostBattle ]
]

{ #category : 'informationTest' }
Game >> getRanking [

	| ranking |
	self isOver ifFalse: [ ^ #(  ) ].

	ranking := spaceShips sorted: [ :ship1 :ship2 |
		           ((ship1 position) lap -> (ship1 position) position)
		           > ((ship2 position) lap -> (ship2 position) position) ].

	^ (ranking collect: [ :each |
		   each getID ]) asArray
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoard by: aNumberOfSpaceShips thorwing: aDiceSet wonAfter: aNumberOfLaps [

	board := aBoard.
	self startingPositions: aNumberOfSpaceShips.
	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aNumberOfLaps.
	^ self
]

{ #category : 'whats left of race positions' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  aShip position position = board boardSize and:
			  aShip position lap = laps ]
]

{ #category : 'informationTest' }
Game >> isOver [

	^ self isGameOver
]

{ #category : 'informationTest' }
Game >> lapOf: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) position lap
]

{ #category : 'as yet unclassified' }
Game >> lookForBattle: aSpaceShip [

	| opponentShip |
	(aSpaceShip position isPositionEqualTo: (Position at: 1 withLaps: 0))
		ifTrue: [ ^ self ].

	opponentShip := self obtainOponentShip: aSpaceShip.

	opponentShip == aSpaceShip ifFalse: [
		self battleBetween: aSpaceShip and: opponentShip ]
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [

	(self skippingTurn: aSpaceShip after: aDiceRoll) ifTrue: [ ^ self ].

	aSpaceShip storeageNewPosition: (Position at: aDiceRoll withLaps: 0).

	aSpaceShip storeageNewPosition:
		(board limitAdjustment: aSpaceShip position withTotalLaps: laps). "Done" "Done"

	"board checkForPowerUps: aSpaceShip andAllSpaceShips: spaceShips." "Polimorfism"
	aSpaceShip replacePositionWith:
		(board checkForWormHole: aSpaceShip position).

	board adjust: spaceShips positionAnd: laps.

	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Game >> obtainOponentShip: aSpaceShip [

	| otherShips |
	otherShips := spaceShips reject: [ :ship | ship = aSpaceShip ].

	otherShips ifEmpty: [ ^ aSpaceShip ].

	^ otherShips
		  detect: [ :ship |
		  (ship position isPositionEqualTo: (aSpaceShip position)) and: (ship canBattle)]
		  ifNone: [ aSpaceShip ]
]

{ #category : 'informationTest' }
Game >> positionOf: aSpaceShipID [

	^ ((spaceShips at: aSpaceShipID) position) position.
]

{ #category : 'informationTest' }
Game >> shieldOf: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getShield
]

{ #category : 'as yet unclassified' }
Game >> skippingTurn: aSpaceShip after: aDiceRoll [

	^ aSpaceShip skipTurns or: (aSpaceShip skipATurn: aDiceRoll)
]

{ #category : 'accessing' }
Game >> start [

	| aDiceRoll spaceShip |
	aDiceRoll := diceSet toss.
	"-1 allows to stop the rigged dice"
	[ self isGameOver or: aDiceRoll = -1 ] whileFalse: [
		spaceShip := spaceShips at: nextSpaceShipToMove.

		self move: spaceShip after: aDiceRoll.

		self updateNextShipToMove: nextSpaceShipToMove.
		aDiceRoll := diceSet toss ]
]

{ #category : 'whats left of race positions' }
Game >> startingPositions: aNumberOfSpaceShips [

	| aPosition aShield |
	aPosition := Position at: 1 withLaps: 0.
	aShield := 3.

	spaceShips := OrderedCollection new.
	1 to: aNumberOfSpaceShips do: [ :id |
		spaceShips add:
			(SpaceShip with: id initial: aPosition andStartingWith: aShield) ]
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
