Class {
	#name : 'BattleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BattleTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2Enconter3TimesAndShip2WinsThenShip1NowLooses2Turns [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith:
		            { 5. 5. 1. 2. 6. 1. 1. 2. 7. 1. 1. 2. 1. 1. 1. 1 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 10
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2Enconter3TimesAndShip2WinsThenShip1NowLooses2TurnsAndThenItMoves1 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith:
		            { 5. 5. 1. 2. 6. 1. 1. 2. 7. 1. 1. 2. 1. 1. 1. 1. 1. 1 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 11
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAfterOneRoundAndShip1WinsThenShip2ReturnsToStart [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 2. 5. 5. 2. 2. 1 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 8.
	self assert: (aGame positionOf: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsAndShip2Loses1ShieldThenShip2Toss0ToRecoverTo3Shields [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 3. 2. 1. 0 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame shieldOf: 2) equals: 3
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2NowHas2Shields [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 1 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame shieldOf: 2) equals: 2.
	self assert: (aGame shieldOf: 1) equals: 3.
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2ReturnsToStart [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 1 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip1ReturnsToStart [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 6
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip2NowHas2Shields [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame shieldOf: 2) equals: 3.
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndTheyTossTheSameNumberThenTheyTossTillTheyAreDifferent [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 2. 3. 3. 3. 1 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip3EnconterAndShip1WinsThenShip3ReturnsToStart [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 1. 5. 2. 1 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 3) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1Has3ShieldsThenShip1CantSkipTurns [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 0. }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	self
		should: [ aGame start ]
		raise: Error
		withMessageText: 'The Shield is already full, it cant be recharged.'
]
