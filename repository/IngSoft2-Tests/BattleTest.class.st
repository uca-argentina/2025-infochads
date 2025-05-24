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

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith:
		            { 5. 5. 1. 2. 6. 1. 1. 2. 7. 1. 1. 2. 1. 1. 1. 1 }.
	aGame := Game
		         withBoardSize: 100
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 10
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2Enconter3TimesAndShip2WinsThenShip1NowLooses2TurnsAndThenItMoves1 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith:
		            { 5. 5. 1. 2. 6. 1. 1. 2. 7. 1. 1. 2. 1. 1. 1. 1. 1. 1 }.
	aGame := Game
		         withBoardSize: 100
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1.
	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 2) equals: 11
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAfterOneRoundAndShip1WinsThenShip2ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2. 5. 5. 2. 2. 1 }.
	aGame := Game
		         withBoardSize: 20
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 8.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsAndShip2Loses1ShieldThenShip2Toss0ToRecoverTo3Shields [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 3. 2. 1. 0 }.
	aGame := Game
		         withBoardSize: 20
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame shieldStatus: 2) equals: 3.
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2NowHas2Shields [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame shieldStatus: 2) equals: 2.
	self assert: (aGame shieldStatus: 1) equals: 3.
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 6.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip1ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 6
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip2NowHas2Shields [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame shieldStatus: 1) equals: 2.
	self assert: (aGame shieldStatus: 2) equals: 3.
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndTheyTossTheSameNumberThenTheyTossTillTheyAreDifferent [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 2. 3. 3. 3. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 6.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip3EnconterAndShip1WinsThenShip3ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 1. 5. 2. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 6.
	self assert: (aGame positionOfSpaceShip: 2) equals: 2.
	self assert: (aGame positionOfSpaceShip: 3) equals: 1
]

{ #category : 'tests' }
BattleTest >> testWhenShip1Has3ShieldsThenShip1CantSkipTurns [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 0. }.
	aGame := Game
		         withBoardSize: 20
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	self
		should: [ aGame start ]
		raise: Error
		withMessageText: 'The Shield is already full, it cant be recharged.'
]
