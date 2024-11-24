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

{ #category : 'visualization' }
RefuelingManager >> createYearsChart [
    | c p x y size |
    x := (self getYearsEurosSeries collect: [ :elem | elem first ]) reverse.
    y := (self getYearsEurosSeries collect: [ :elem | elem at: 2 ]) reverse.
    c := RSCompositeChart new.
    p := RSHorizontalBarPlot new x: y y: x.
    size := 15.
    p barSize: size.
    p barOffset: 0 - 1.
    c add: p.
    c build.
    p bars @ RSPopup.
    ^ c canvas

]

{ #category : 'initialization' }
RefuelingManager >> dump [

	refuelings do: [:each | Transcript show: each printString; cr ].
]

{ #category : 'utils' }
RefuelingManager >> format: str fill: fill [

	| len |
	len := fill size - str size.
	^ (fill copyFrom: 1 to: len) , str
]

{ #category : 'accessing' }
RefuelingManager >> getSumEurosPerYear: yearIn [

	| sum |
	sum := 0.
	refuelings do: [:each |  (each getDate year) == yearIn  ifTrue: [ sum := sum + each getEuros ]].
	^ sum
]

{ #category : 'accessing' }
RefuelingManager >> getYears [

	| years year_ |
	years := OrderedCollection new.
	refuelings do: [:each |
		year_ := each getDate year. 
		(years includes: year_) ifFalse: [ years add: year_ ]].
	^ years
]

{ #category : 'accessing' }
RefuelingManager >> getYearsEurosSeries [

    ^ self getYears collect: [:year | Array with: year with: ((self getSumEurosPerYear: year) roundTo: 0.01)].

]

{ #category : 'initialization' }
RefuelingManager >> readCsv [

	| lines |
	lines := (FileSystem workingDirectory / 'Opel Adam - OF-AW 150.txt') readStream contents lines.
	refuelings := lines collect: [ :line | RefuelingData fromCsvLine: line ].

]
