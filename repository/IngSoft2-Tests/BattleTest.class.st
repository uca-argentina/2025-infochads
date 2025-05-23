Class {
	#name : 'BattleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAfterOneRoundAndShip1WinsThenShip2ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2. 5. 5. 2. 2. 1 }.
	aGame := Game
		         withBoardSize: 20
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7.
	self assert: (aGame positionOfSpaceShip: 2) equals: 0
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2NowHas2Shields [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame shieldStatus: 2) equals: 2.
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip1WinsThenShip2ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 5.
	self assert: (aGame positionOfSpaceShip: 2) equals: 0
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip1ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 0.
	self assert: (aGame positionOfSpaceShip: 2) equals: 5
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndShip2WinsThenShip2NowHas2Shields [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 1. 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame shieldStatus: 1) equals: 2.
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip2EnconterAndTheyTossTheSameNumberThenTheyTossTillTheyAreDifferent [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 5. 2. 2. 3. 3. 3. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 5.
	self assert: (aGame positionOfSpaceShip: 2) equals: 0
]

{ #category : 'tests' }
BattleTest >> testWhenShip1AndShip3EnconterAndShip1WinsThenShip3ReturnsToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 1. 5. 2. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 5.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 3) equals: 0
]
