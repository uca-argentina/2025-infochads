Class {
	#name : 'PowerCellsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PowerCellsTest >> testWhenAAtomicBombEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithPosition: 1
		        type: #atomicBomb
		        effect: (AtomicBombEffect
				         ShieldsSacrificed: 1).

	self assert: cell position equals: 1.
	self assert: cell type equals: #atomicBomb
]

{ #category : 'tests' }
PowerCellsTest >> testWhenABlackHoleEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithPosition: 1
		        type: #blackHole
		        effect: (HyperSpaceJumpEffect withDesplacementValue: 4 andShieldsSacrificed: 1).
		
	self assert: (cell position) equals: 1.
	self assert: cell type equals: #blackHole.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenAHyperJumpEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithPosition: 1
		        type: #hyperJump
		        effect: (HyperJumpEffect
				         withParsecValue: 100
				         totalBoardSize: 10
				         andParsecJumps: #( 10 7 2 )).

	self assert: cell position equals: 1.
	self assert: cell type equals: #hyperJump
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAMoonWalkEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithPosition: 1
		        type: #moonWalk
		        effect: (MoonWalkEffect withDesplacementValue: 4).
		
	self assert: (cell position) equals: 1.
	self assert: cell type equals: #moonWalk.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenANormalEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithPosition: 1
		        type: #normal
		        effect: nil.
		
	self assert: (cell position) equals: 1.
	self assert: cell type equals: #normal.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenHyperSpaceJumpEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithPosition: 1
		        type: #hyperSpaceJump
		        effect: (BlackHoleEffect withDesplacementValue: 4).
		
	self assert: (cell position) equals: 1.
	self assert: cell type equals: #hyperSpaceJump.

]
