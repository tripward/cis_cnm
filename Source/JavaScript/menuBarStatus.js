/*
 * Filename:	menuBarStatus.js
 *
 * Description:	Provides functionality to control the contents of the status bar
**/

//
// Define Constants
//
var cFieldBackgroundColor = '#B2C3FF';
var cLabelFontWeight = 'normal';
var cLabelColor = '#660000';


//
// Define global place holder variables
//
var statusText = '';
var labelFontWeight = '';
var labelFontColor = '';
var fieldBackgroundColor = '';


//
// Define display functions
//
function setStatusText(text) {
	if (document.getElementById) {
		statusText = document.getElementById('MenuBarStatus').innerHTML;
		document.getElementById('MenuBarStatus').innerHTML = text;
	} else {
		statusText = document.all.MenuBarStatus.innerHTML;
		document.all.MenuBarStatus.innerHTML = text;
	}
}

function restoreStatusText() {
	if (document.getElementById) {
		document.getElementById('MenuBarStatus').innerHTML = statusText;
	} else {
		document.all.MenuBarStatus.innerHTML = statusText;
	}
}

function activateLabel(obj) {
	if (obj.type == 'radio') {
		var fieldValue = obj.value;
		var fieldName = obj.name + fieldValue;
		var labelName = fieldName + 'Label';
	
		if (document.getElementById) {
			fieldBackgroundColor = document.getElementById(fieldName).style.backgroundColor;
			labelFontWeight = document.getElementById(labelName).style.fontWeight;
			labelFontColor = document.getElementById(labelName).style.color;
//			document.getElementById(fieldName).style.backgroundColor = cFieldBackgroundColor;
			document.getElementById(labelName).style.fontWeight = cLabelFontWeight;
			document.getElementById(labelName).style.color = cLabelColor;
		}
	} else {
		var fieldName = obj.name;
		var labelName = fieldName + 'Label';

		if (document.getElementById) {
			fieldBackgroundColor = document.getElementById(fieldName).style.backgroundColor;
			labelFontWeight = document.getElementById(labelName).style.fontWeight;
			labelFontColor = document.getElementById(labelName).style.color;
			document.getElementById(fieldName).style.backgroundColor = cFieldBackgroundColor;
			document.getElementById(labelName).style.fontWeight = cLabelFontWeight;
			document.getElementById(labelName).style.color = cLabelColor;
		}
	}
}

function deactivateLabel(obj) {
	if (obj.type == 'radio') {
		var fieldValue = obj.value;
		var fieldName = obj.name + fieldValue;
		var labelName = fieldName + 'Label';
	
		if (document.getElementById) {
//			document.getElementById(fieldName).style.backgroundColor = fieldBackgroundColor;
			document.getElementById(labelName).style.fontWeight = labelFontWeight;
			document.getElementById(labelName).style.color = labelFontColor;
			fieldBackgroundColor = '';
			labelFontWeight = '';
			labelFontColor = '';
		}
	} else {
		var fieldName = obj.name;
		var labelName = fieldName + 'Label';

		if (document.getElementById) {
			document.getElementById(fieldName).style.backgroundColor = fieldBackgroundColor;
			document.getElementById(labelName).style.fontWeight = labelFontWeight;
			document.getElementById(labelName).style.color = labelFontColor;
			fieldBackgroundColor = '';
			labelFontWeight = '';
			labelFontColor = '';
		}
	}
}

function activateButton(obj) {
	var fieldName = obj.name;

	if (document.getElementById) {
		fieldBackgroundColor = document.getElementById(fieldName).style.backgroundColor;
		document.getElementById(fieldName).style.backgroundColor = cFieldBackgroundColor;
	}
}

function deactivateButton(obj) {
	var fieldName = obj.name;

	if (document.getElementById) {
		document.getElementById(fieldName).style.backgroundColor = fieldBackgroundColor;
		fieldBackgroundColor = '';
	}
}

