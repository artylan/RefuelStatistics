"
Ein Objekt dieser Klasse steht für einen Tankvorgang.
"
Class {
	#name : 'RefuelingData',
	#superclass : 'Object',
	#instVars : [
		'date',
		'km',
		'liters',
		'euros'
	],
	#category : 'RefuelingStatistics',
	#package : 'RefuelingStatistics'
}

{ #category : 'instance creation' }
RefuelingData class >> date: dateIn km: kmIn liters: litersIn euros: eurosIn [

	| data |
	data := self basicNew date: dateIn km: kmIn liters: litersIn euros: eurosIn.
	^ data
]

{ #category : 'instance creation' }
RefuelingData class >> fromCsvLine: lineCsv [

	| data |
	data := self basicNew fromCsvLine: lineCsv.
	^ data
]

{ #category : 'initialization' }
RefuelingData >> date: dateString km: kmIn liters: litersIn euros: eurosIn [

	| dateParts day month year|
	dateParts := dateString findTokens: '.'.
	day := (dateParts at: 1) asInteger.
	month := (dateParts at: 2) asInteger.
	year := (dateParts at: 3) asInteger. 
	date := Date newDay: day month: month year: year.
	km := (kmIn copyReplaceAll: ',' with: '.') asNumber.
	liters := (litersIn copyReplaceAll: ',' with: '.') asNumber.
	euros := (eurosIn copyReplaceAll: ',' with: '.') asNumber

]

{ #category : 'initialization' }
RefuelingData >> fromCsvLine: csvLine [

	| parts dateIn kmIn litersIn eurosIn|
	parts := csvLine findTokens: Character tab asString.
	dateIn := parts at: 1.
	kmIn := parts at: 2.
	litersIn := parts at: 3.
	eurosIn := parts at: 4.
	self date: dateIn km: kmIn liters: litersIn euros: eurosIn
]

{ #category : 'accessing' }
RefuelingData >> getDate [
	^ date
]

{ #category : 'accessing' }
RefuelingData >> getEuros [
	^ euros
]

{ #category : 'accessing' }
RefuelingData >> getKm [
	^ km
]

{ #category : 'accessing' }
RefuelingData >> getLiters [
	^ liters
]

{ #category : 'printing' }
RefuelingData >> printOn: aStream [

	aStream 
		nextPutAll: 'RefuelingData(';
		nextPutAll: 'date: '; print: date;  nextPutAll: ', ';
		nextPutAll: 'km: '; print: km; nextPutAll: ', ';
		nextPutAll: 'liters: '; print: liters; nextPutAll: ', ';
		nextPutAll: 'euros: '; print: euros;
		nextPutAll: ')'.
]
