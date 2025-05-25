Class {
	#name : 'PowerCellsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PowerCellsTest >> testWhenABlackHoleEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithPosition: 1
		        type: #blackHole
		        effect: (HyperSpaceJump withDesplacementValue: 4 andShieldsSacrificed: 1).
		
	self assert: (cell position) equals: 1.
	self assert: cell type equals: #blackHole.

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
		        type: #blackHole
		        effect: (BlackHoleEffect withDesplacementValue: 4).
		
	self assert: (cell position) equals: 1.
	self assert: cell type equals: #blackHole.

]
