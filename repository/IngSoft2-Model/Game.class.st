Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips',
		'laps',
		'board',
		'spaceShipPositions',
		'lastCardEffect'
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
Game >> affectedRoll: aDiceRoll of:aSpaceShip [

	| extraPositionsByEffect |
	extraPositionsByEffect := aSpaceShip searchForIncrementalEffect.
	^aDiceRoll + extraPositionsByEffect
]

{ #category : 'as yet unclassified' }
Game >> applyEffect: aCardEffect to: anAffectedShip [

	| effectiveCard targetShips |
	effectiveCard := aCardEffect resolveCardWith: lastCardEffect.

	aCardEffect isRepeat ifTrue: [
		board
			applyLastEffectPowerUpUponA: (spaceShips at: anAffectedShip)
			andAll: spaceShips
			andIts: spaceShipPositions ].

	targetShips := anAffectedShip = 0
		               ifTrue: [ spaceShips ]
		               ifFalse: [
		               Array with: (spaceShips at: anAffectedShip) ]. "atributo tipo celda"

	targetShips do: [ :ship | ship apply: effectiveCard ].

	lastCardEffect := aCardEffect isRedo
		                  ifFalse: [ aCardEffect ]
		                  ifTrue: [ lastCardEffect ]
]

{ #category : 'as yet unclassified' }
Game >> battleBetween: aSpaceShip1 and: aSpaceShip2 [

	| throwSpaceShip1 throwSpaceShip2 winner loser throwMercenary2 throwMercenary1 |
	[
	throwSpaceShip2 := diceSet toss.
	throwSpaceShip1 := diceSet toss.
	throwSpaceShip1 = throwSpaceShip2 ] whileTrue: [  ]. 
	(aSpaceShip1 hasMercenary or: aSpaceShip2 hasMercenary) ifTrue: [
		throwMercenary2 := 0.
		(aSpaceShip2 getMercenary) do: [ :mercenary | throwMercenary2 := (throwMercenary2 + diceSet toss)   ].
		throwMercenary1 := 0.
		(aSpaceShip1 getMercenary) do: [ :mercenary | throwMercenary1 := (throwMercenary1 + diceSet toss)   ].
		
		throwSpaceShip2 :=  throwMercenary2 + throwSpaceShip2.
		throwSpaceShip1 := throwMercenary1 + throwSpaceShip1 ].

	throwSpaceShip1 < throwSpaceShip2
		ifTrue: [
			winner := aSpaceShip2.
			loser := aSpaceShip1 ]
		ifFalse: [
			winner := aSpaceShip1.
			loser := aSpaceShip2 ].

	self lostBattle: loser.
	loser hasMercenary ifTrue: [ (loser getMercenary) do: [ :mercenaryShip | self lostBattle: mercenaryShip getAlly ] ] 
]

{ #category : 'as yet unclassified' }
Game >> chooseMercenary: aMercenarySpaceShip for: aSpaceShip [

	(spaceShips at: aSpaceShip) setMercenary: (spaceShips at: aMercenarySpaceShip).
]

{ #category : 'whats left of race positions' }
Game >> create: aNumberOfSpaceShips [

	| aPosition aShield |
	aPosition := Position at: 1 withLaps: 0.
	aShield := 3.

	spaceShips := OrderedCollection new.
	spaceShipPositions := OrderedDictionary new.

	1 to: aNumberOfSpaceShips do: [ :id |
		spaceShips add:
			(SpaceShip with: id andStartingWith: aShield).
		spaceShipPositions at: id put: aPosition ]
]

{ #category : 'informationTest' }
Game >> getRanking [

	| ranking |
	self isOver ifFalse: [ ^ #(  ) ].

	ranking := spaceShips sorted: [ :ship1 :ship2 |
		           (spaceShipPositions at: ship1 id) lap
		           -> (spaceShipPositions at: ship1 id) position
		           > ((spaceShipPositions at: ship2 id) lap
			            -> (spaceShipPositions at: ship2 id) position) ].

	^ (ranking collect: [ :each | each id ]) asArray
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoard by: aNumberOfSpaceShips thorwing: aDiceSet wonAfter: aNumberOfLaps [

	board := aBoard.
	
	spaceShipPositions := OrderedDictionary new.
	self create: aNumberOfSpaceShips.
	
	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	laps := aNumberOfLaps.
	^ self
]

{ #category : 'whats left of race positions' }
Game >> isGameOver [

	^ spaceShips anySatisfy: [ :aShip |
		  (spaceShipPositions at: aShip id) isEqualTo:
			  (Position at: board boardSize withLaps: laps) ]
]

{ #category : 'informationTest' }
Game >> isOver [

	^ self isGameOver
]

{ #category : 'informationTest' }
Game >> lapOf: aSpaceShipID [

	^ (spaceShipPositions at: aSpaceShipID) lap
]

{ #category : 'as yet unclassified' }
Game >> lookForBattle: aSpaceShip [

	| opponentShip |
	((spaceShipPositions at: aSpaceShip id) isPositionEqualTo:
		 (Position at: 1 withLaps: 0)) ifTrue: [ ^ self ].

	opponentShip := self obtainOponentShip: aSpaceShip.

	opponentShip == aSpaceShip ifFalse: [
		self battleBetween: aSpaceShip and: opponentShip ]
]

{ #category : 'as yet unclassified' }
Game >> lostBattle: aSpaceShip [

	spaceShipPositions
		at: aSpaceShip id
		put: ((spaceShipPositions at: aSpaceShip id) sumTo: (Position
					  at: (spaceShipPositions at: aSpaceShip id) position negated + 1
					  withLaps: 0)).
	aSpaceShip loseShield
]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceShip after: aDiceRoll [

	| aDiceRollWithEffect |
	(self skippingTurn: aSpaceShip after: aDiceRoll) ifTrue: [ ^ self ].
	
	aDiceRollWithEffect:=self affectedRoll:aDiceRoll of:aSpaceShip.
	self sumTo: aSpaceShip the: (Position at: aDiceRollWithEffect withLaps: 0).

	self sumTo: aSpaceShip the: (board
			 limitAdjustment: (spaceShipPositions at: aSpaceShip id)
			 withTotalLaps: laps).

	board
		applyEffecOfPowerUpUponA: aSpaceShip
		andAll: spaceShips
		andIts: spaceShipPositions.

	self
		replacePositionOf: aSpaceShip
		with:
		(board checkForWormHole: (spaceShipPositions at: aSpaceShip id)).

	spaceShips do: [ :ship |
		self sumTo: ship the: (board
				 limitAdjustment: (spaceShipPositions at: ship id)
				 withTotalLaps: laps) ].

	self lookForBattle: aSpaceShip
]

{ #category : 'as yet unclassified' }
Game >> obtainOponentShip: aSpaceShip [

	| otherShips |
	otherShips := spaceShips reject: [ :ship | ship = aSpaceShip ].

	otherShips ifEmpty: [ ^ aSpaceShip ].

	^ otherShips
		  detect: [ :ship |
			  ((spaceShipPositions at: ship id) isPositionEqualTo:
				   (spaceShipPositions at: aSpaceShip id)) and: ship canBattle ]
		  ifNone: [ aSpaceShip ]
]

{ #category : 'informationTest' }
Game >> positionOf: aSpaceShipID [

	^ (spaceShipPositions at: aSpaceShipID) position
]

{ #category : 'as yet unclassified' }
Game >> replacePositionOf: aSpaceShip with: aPosition [

	spaceShipPositions
		at: aSpaceShip id
		put:
		((spaceShipPositions at: aSpaceShip id) replacePositionWith:
			 aPosition)
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

{ #category : 'as yet unclassified' }
Game >> sumTo: aSpaceShip the: aPosition [

	spaceShipPositions
		at: aSpaceShip id
		put: ((spaceShipPositions at: aSpaceShip id) sumTo: aPosition)
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
