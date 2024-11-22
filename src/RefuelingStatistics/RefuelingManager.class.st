"
Ein Objekt dieser Klasse liest und wertet aus alle Tankvorgänge einer CSV-Datei.
"
Class {
	#name : 'RefuelingManager',
	#superclass : 'Object',
	#instVars : [
		'refuelings'
	],
	#category : 'RefuelingStatistics',
	#package : 'RefuelingStatistics'
}

{ #category : 'initialization' }
RefuelingManager class >> readCsv [

	| manager |
	manager := self new readCsv.
	^ manager

]

{ #category : 'initialization' }
RefuelingManager >> dump [

	refuelings do: [:each | Transcript show: each printString; cr ].
]

{ #category : 'as yet unclassified' }
RefuelingManager >> dumpYearsEuros [

	self getYears do: [:each | Transcript show: each printString,
		 ': ',
		 (self format: ((self getSumEurosPerYear: each) roundTo: 0.01) printString fill: '          '),
		Character cr asString].
]

{ #category : 'initialization' }
RefuelingManager >> format: str fill: fill [

	| len |
	len := fill size - str size.
	^ (fill copyFrom: 1 to: len) , str
]

{ #category : 'as yet unclassified' }
RefuelingManager >> getSumEurosPerYear: yearIn [

	| sum |
	sum := 0.
	refuelings do: [:each |  (each getDate year) == yearIn  ifTrue: [ sum := sum + each getEuros ]].
	^ sum
]

{ #category : 'initialization' }
RefuelingManager >> getYears [

	| years year_ |
	years := OrderedCollection new.
	refuelings do: [:each |
		year_ := each getDate year. 
		(years includes: year_) ifFalse: [ years add: year_ ]].
	^ years
]

{ #category : 'initialization' }
RefuelingManager >> readCsv [

	| lines |
	lines := (FileSystem workingDirectory / 'Opel Adam - OF-AW 150.txt') readStream contents lines.
	refuelings := lines collect: [ :line | RefuelingData fromCsvLine: line ].

]
