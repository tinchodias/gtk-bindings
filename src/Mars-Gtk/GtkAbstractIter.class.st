Class {
	#name : #GtkAbstractIter,
	#superclass : #FFIExternalStructure,
	#traits : 'TGtkLibrary',
	#classTraits : 'TGtkLibrary classTrait',
	#instVars : [
		'store'
	],
	#classVars : [
		'OFFSET_STAMP',
		'OFFSET_USER_DATA',
		'OFFSET_USER_DATA2',
		'OFFSET_USER_DATA3'
	],
	#pools : [
		'GtkTypes'
	],
	#category : #'Mars-Gtk-Widget-Tree'
}

{ #category : #'field definition' }
GtkAbstractIter class >> fieldsDesc [
	"self compileFields"
	^ #(
		gint stamp;
		gpointer user_data;
		gpointer user_data2;
		gpointer user_data3;)
]

{ #category : #accessing }
GtkAbstractIter >> atColumnIndex: index setValue: aValue [

	 self subclassResponsibility
]

{ #category : #accessing }
GtkAbstractIter >> setValues: aValueArray [

	self subclassResponsibility
]

{ #category : #accessing }
GtkAbstractIter >> store [
	^ store
]

{ #category : #accessing }
GtkAbstractIter >> store: anObject [
	store := anObject
]