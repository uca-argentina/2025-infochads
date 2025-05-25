Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'aBoard',
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips',
		'laps',
		'ranking'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> lapsMustBePositiveInteger: aLapsCount [

	(aLapsCount isInteger and: [ aLapsCount > 0 ]) ifFalse: [
		self error: 'Laps must be a positive integer.' ]
]

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
Game class >> withBoardSize: aBoardSize withSpaceShips: aNumberOfSpaceShips withDiceSet: aDiceSet withWormHole: aWormHolePosition withAmountOfLaps: aLapsCount [

	self numberOfSpaceShipsMustBePositiveInteger: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.
	self lapsMustBePositiveInteger: aLapsCount.

	^ self new
		  initializeWithBoardSize: aBoardSize
		  AndNumberOfSpaceShips: aNumberOfSpaceShips
		  AndDiceSet: aDiceSet
		  AndWormHole: aWormHolePosition
		  Andlaps: aLapsCount
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: attacker and: defendant [

	| attackDiceRollAttacker attackDiceRollDefendant |
	[
	attackDiceRollDefendant := diceSet toss.
	attackDiceRollAttacker := diceSet toss.
	attackDiceRollAttacker = attackDiceRollDefendant ] whileTrue.

	attackDiceRollAttacker < attackDiceRollDefendant
		ifTrue: [ attacker lostBattle ]
		ifFalse: [ defendant lostBattle ]
]

{ #category : 'initialization' }
Game >> determineWinner [

	^ (spaceShips select: [ :aShip |
		   aShip getPosition = aBoard boardSize and: aShip getLaps = laps ]) first.
]

{ #category : 'as yet unclassified' }
Game >> getRanking [
	^ ranking asArray
]

{ #category : 'as yet unclassified' }
Game >> inWhichLapIsSpaceShip: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getLaps
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoardSize AndNumberOfSpaceShips: aNumberOfSpaceShips AndDiceSet: aDiceSet AndWormHole: aWormHolePosition Andlaps: aLapsCount [

	aBoard := Board
		          withSize: aBoardSize
		          andWormHolePosition: aWormHolePosition.
	spaceShips := self startingPositions: aNumberOfSpaceShips.
	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aLapsCount ifNil: [ laps := 1 ].
	ranking:= OrderedCollection new.
	^ self
]

{ #category : 'testing' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  aShip getPosition = aBoard boardSize and: aShip getLaps = laps ]
]

{ #category : 'testing' }
Game >> isOver [

	self isGameOver
		ifTrue: [
			self setRanking.
			^ true ]
		ifFalse: [ ^ false ]
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

{ #category : 'initialization' }
Game >> setRanking [

	| winner otherShips sortedOthers |
	winner := self determineWinner.

	otherShips := spaceShips select: [ :ship | ship ~= winner ].

	sortedOthers := self sortShipsByProgress: otherShips.

	ranking add: winner getID.

	sortedOthers isNotEmpty ifTrue: [
		ranking add: (sortedOthers at: 1) getID ].

	sortedOthers size >= 2 ifTrue: [
		ranking add: (sortedOthers at: 2) getID ]
]

{ #category : 'as yet unclassified' }
Game >> shieldStatus: aSpaceShipID [

	^ (spaceShips at: aSpaceShipID) getShield
]

{ #category : 'sorting' }
Game >> sortShipsByProgress: ships [

	^ ships sort: [ :a :b |
		  a getPosition = b getPosition
			  ifTrue: [ a getLaps > b getLaps ]
			  ifFalse: [ a getPosition > b getPosition ] ]
]

{ #category : 'accessing' }
Game >> start [

	| diceRoll spaceShip |
	diceRoll := diceSet toss.
	[ self isGameOver or: diceRoll = -1 ] whileFalse: [
		spaceShip := spaceShips at: nextSpaceShipToMove.
		self the: spaceShip hasRolled: diceRoll.
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
				 andInitialPosition: 1
				 andID: position) ].

	^ initialPositions
]

{ #category : 'as yet unclassified' }
Game >> the: spaceShip hasRolled: diceRoll [

	spaceShip skipTurns ifTrue: [ ^ self ].
	(spaceShip skipATurn: diceRoll) ifTrue: [ ^ self ].
	spaceShip goToTemporaryPosition: diceRoll.

	aBoard adjustPositionOf: spaceShip considering: laps.

	self lookForBattle: spaceShip
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
