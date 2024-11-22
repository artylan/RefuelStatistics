Class {
	#name : 'RefuelingDataTest',
	#superclass : 'TestCase',
	#category : 'RefuelingStatistics-Tests',
	#package : 'RefuelingStatistics-Tests'
}

{ #category : 'tests' }
RefuelingDataTest >> testFromCsvLine [
	| rd mt|
	mt := Character tab asString.
	rd := RefuelingData fromCsvLine: '28.02.2016',mt,'12942',mt,'33,15',mt,'38,75'.
	self assert: rd getDate equals: (Date year: 2016 month: 2 day: 28).
	self assert: rd getKm equals: 12942.
	self assert: rd getLiters equals: 33.15.
	self assert: rd getEuros equals: 38.75.

]

{ #category : 'tests' }
RefuelingDataTest >> testInitialization [
	"comment stating purpose of instance-side method"

	| rd |
	rd := RefuelingData new date: '07.02.1968' km: '1230' liters: '34,54' euros: '31,34'.
	self assert: rd getDate equals: (Date year: 1968 month: 2 day: 7).
	self assert: rd getKm equals: 1230.
	self assert: rd getLiters equals: 34.54.
	self assert: rd getEuros equals: 31.34.
	
]
