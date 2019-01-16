Class {
	#name : #GtkTableAdapter,
	#superclass : #GtkAdapter,
	#category : #'Mars-Spec-Adapter-Table'
}

{ #category : #building }
GtkTableAdapter >> addModelTo: gtkWidget [
	| columnBuilder store |
	
	store := self newStoreFrom: self items.
	gtkWidget model: store.
	
	columnBuilder := GtkTableColumnBuilder on: self model.
	columnBuilder store: store.
	columnBuilder view: gtkWidget. 
	self model columns do: [ :each | 
		columnBuilder visit: each ].
]

{ #category : #private }
GtkTableAdapter >> addRow: anObject into: store [
	| gtkRow filler |
	
	gtkRow := store appendNew.
	filler := GtkTableRowFiller new
		gtkRow: gtkRow;
		row: anObject;
		yourself.
		
	self model columns do: [ :eachColumn | 
		filler visit: eachColumn ].
		
	^ gtkRow
]

{ #category : #building }
GtkTableAdapter >> buildWidget [
	| gtkTextView |

	gtkTextView := self newWidget.
	self addModelTo: gtkTextView.
	^ GtkScrolledWindow newWidget: gtkTextView
]

{ #category : #private }
GtkTableAdapter >> fillStore: store with: aCollection [
	
	aCollection do: [ :each | 
		self 
			addRow: each 
			into: store ]
]

{ #category : #private }
GtkTableAdapter >> items [

	^ self model items
]

{ #category : #'private factory' }
GtkTableAdapter >> newStore [
	| typeCollector |

	typeCollector := GtkTableColumnTypeCollector new.
	self model columns collect: [ :each | 
		typeCollector visit: each ].
	^ self storeClass newColumnTypes: typeCollector types
]

{ #category : #'private factory' }
GtkTableAdapter >> newStoreFrom: aCollection [
	| store |

	store := self newStore.
	self 
		fillStore: store
		with: aCollection.

	^ store
]

{ #category : #updating }
GtkTableAdapter >> refreshList [

	widget model: (self newStoreFrom: self model items)
]

{ #category : #private }
GtkTableAdapter >> storeClass [

	^ GtkListStore
]

{ #category : #updating }
GtkTableAdapter >> update: aSymbol [

	aSymbol == #items ifTrue: [ self refreshList ]
]

{ #category : #building }
GtkTableAdapter >> widgetClass [
	
	^ GtkTreeView
]