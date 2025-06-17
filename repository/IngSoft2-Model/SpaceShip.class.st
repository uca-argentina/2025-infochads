Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'position',
		'spaceShipID',
		'loseTurn',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceShip class >> itMustHaveAnID: anId [

	(anId = '') ifTrue: [
		Error signal: 'The ship must be identifiable.' ]
]

{ #category : 'as yet unclassified' }
SpaceShip class >> itMustHaveThree: aShield [

	(aShield isInteger and: [ aShield = 3 ]) ifFalse: [
		Error signal: 'The ship must initialize with 3 shield.' ]
]

{ #category : 'as yet unclassified' }
SpaceShip class >> with: anId initial: aPosition andStartingWith: aShield [

	self itMustHaveThree: aShield.
	self itMustHaveAnID: anId.

	^ self new
		  initializeWithShield: aShield
		  andInitial: aPosition
		  and: anId
]

{ #category : 'testing' }
SpaceShip >> canBattle [

	^ shield > 0 and: loseTurn = 0
]

{ #category : 'getters' }
SpaceShip >> getID [

	^ spaceShipID
]

{ #category : 'getters' }
SpaceShip >> getShield [

	^ shield
]

{ #category : 'initialization' }
SpaceShip >> initializeWithShield: aNumberOfShields andInitial: aPosition and: aSpaceShipID [

	spaceShipID := aSpaceShipID.
	shield := aNumberOfShields.
	position := aPosition.
	loseTurn := 0.
	laps := 0.
	^ self
]

{ #category : 'shield' }
SpaceShip >> loseShield [

	shield := shield - 1.
	shield = 0 ifTrue: [ loseTurn := 2 ]
]

{ #category : 'accessing' }
SpaceShip >> lostBattle [

	self storeageNewPosition:
		(Position at: (position position negated + 1) withLaps: 0).
	self loseShield
]

{ #category : 'accessing' }
SpaceShip >> position [

	^ position
]

{ #category : 'shield' }
SpaceShip >> rechargableShield: aDiceRoll [

	(shield = 3 and: aDiceRoll = 0) ifTrue: [
		Error signal: 
			'The Shield is already full, it cant be recharged.' ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> replacePositionWith: aPosition [

	position:= position sumPositionTo: aPosition
]

{ #category : 'accessing' }
SpaceShip >> skipATurn: aDiceRoll [

	| doSkip |
	self rechargableShield: aDiceRoll.

	doSkip := false.
	aDiceRoll = 0 ifTrue: [
		shield := 3.
		doSkip := true ].

	^ doSkip
]

{ #category : 'accessing' }
SpaceShip >> skipTurns [

	loseTurn ~= 0
		ifTrue: [
			loseTurn := loseTurn - 1.
			^ true ]
		ifFalse: [ ^ false ]
]

{ #category : 'as yet unclassified' }
SpaceShip >> storeageNewPosition: aPosition [

	position := position sumTo: aPosition
]
