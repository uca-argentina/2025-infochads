Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'spaceShipID',
		'loseTurn',
		'effects',
		'hand'
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
SpaceShip class >> with: anId andStartingWith: aShield [

	self itMustHaveThree: aShield.
	self itMustHaveAnID: anId.

	^ self new initializeWithShield: aShield and: anId
]

{ #category : 'target resize' }
SpaceShip >> apply: aCardEffect [

	(self redoCardEffect: aCardEffect) ifTrue: [ ^ self ].
	(self cancellationCardEffect: aCardEffect) ifTrue: [ ^ self ].

	(aCardEffect isPermanent )ifTrue: [effects add: aCardEffect]
]

{ #category : 'testing' }
SpaceShip >> canBattle [

	^ shield > 0 and: loseTurn = 0
]

{ #category : 'target resize' }
SpaceShip >> cancellationCardEffect: aCardEffect [

	| effectToRemove |
	aCardEffect isCancellation ifFalse: [ ^ false ].
	effectToRemove := effects
		                  detect: [ :each | each = aCardEffect getEffect ]
		                  ifNone: [
			                  Error signal:
				                  'There is no Permanent effect active, Cancelleation Card not Used.' ].

	effects remove: effectToRemove.
	^ true
]

{ #category : 'as yet unclassified' }
SpaceShip >> drawCard: aCard [

	hand add: aCard
]

{ #category : 'as yet unclassified' }
SpaceShip >> getMercenary [

	
	^ (effects select: [ :effect | effect isMercenary ])  
]

{ #category : 'getters' }
SpaceShip >> getShield [

	^ shield
]

{ #category : 'as yet unclassified' }
SpaceShip >> getShipDeck [

	^ hand
]

{ #category : 'testing' }
SpaceShip >> hasMercenary [

	^ (self getMercenary) notEmpty
]

{ #category : 'getters' }
SpaceShip >> id [

	^ spaceShipID
]

{ #category : 'initialization' }
SpaceShip >> initializeWithShield: aNumberOfShields and: aSpaceShipID [

	spaceShipID := aSpaceShipID.
	shield := aNumberOfShields.
	loseTurn := 0.
	effects := OrderedCollection new.
	hand := OrderedCollection new.
	^ self
]

{ #category : 'shield' }
SpaceShip >> loseShield [

	shield := shield - 1.
	shield = 0 ifTrue: [ loseTurn := 2 ]
]

{ #category : 'shield' }
SpaceShip >> rechargableShield: aDiceRoll [

	(shield = 3 and: aDiceRoll = 0) ifTrue: [
		Error signal: 
			'The Shield is already full, it cant be recharged.' ]
]

{ #category : 'target resize' }
SpaceShip >> redoCardEffect: aCardEffect [

	aCardEffect isRedo ifTrue: [
		effects add: (aCardEffect getLastCardEffect).
		^ true ].
	^ false
]

{ #category : 'as yet unclassified' }
SpaceShip >> searchForIncrementalEffect [

	| incrementalEffects |
	incrementalEffects := effects count: [ :anEffect | anEffect affectsMovement  ].

	^ incrementalEffects
]

{ #category : 'initialization' }
SpaceShip >> setMercenary: aMercenarySpaceShip [

	effects do: [ :effect |
		(effect isMercenary and: [ effect hasNoMercenary ]) ifTrue: [
			effect signContract: aMercenarySpaceShip.

			^ self ] ]
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
