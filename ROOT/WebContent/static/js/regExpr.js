//var RegularExpression = /pattern/[switch]   ....     new RegExp("[abc]")  or simply: /[abc]/


// Check if string is non-blank
var isNonblank_re = /\S/;
function isNonblank(s) {
	return String(s).search(isNonblank_re) != -1;
}
// Check if string is a whole number(digits only).
var isWhole_re = /^\s*\d+\s*$/;
function isWhole(s) {
	return String(s).search(isWhole_re) != -1;
}

// check 0-9 digit
function regIsDigit(fData) {
	var reg = new RegExp("^[0-9]$");
	return (reg.test(fData));
}
// checks that an input string is an integer, with an optional +/- sign
// character.
var isInteger_re = /^\s*(\+|-)?\d+\s*$/;
function isInteger(s) {
	return String(s).search(isInteger_re) != -1;
}
// check is number
function regIsNumber(fData) {
	var reg = new RegExp("^[-]?[0-9]+[\.]?[0-9]+$");
	return reg.test(fData);
}
// Checks that an input string is a decimal number, with an optional +/- sign
// character.
var isDecimal_re = /^\s*(\+|-)?((\d+(\.\d+)?)|(\.\d+))\s*$/;
function isDecimal(s) {
	return String(s).search(isDecimal_re) != -1;
}
// Check if string is currency
var isCurrency_re = /^\s*(\+|-)?((\d+(\.\d\d)?)|(\.\d\d))\s*$/;
function isCurrency(s) {
	return String(s).search(isCurrency_re) != -1;
}
// checks that an input string looks like a valid email address.
var isEmail_re = /^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/;
function isEmail(s) {
	return String(s).search(isEmail_re) != -1;
}
// Check if string is a valid email address
function regIsEmail(fData) {
	var reg = new RegExp(
			"^[0-9a-zA-Z]+@[0-9a-zA-Z]+[\.]{1}[0-9a-zA-Z]+[\.]?[0-9a-zA-Z]+$");
	return reg.test(fData);
}
// Check for valid credit card type/number
var creditCardList = [
// type prefix length
[ "amex", "34", 15 ], [ "amex", "37", 15 ], [ "disc", "6011", 16 ],
		[ "mc", "51", 16 ], [ "mc", "52", 16 ], [ "mc", "53", 16 ],
		[ "mc", "54", 16 ], [ "mc", "55", 16 ], [ "visa", "4", 13 ],
		[ "visa", "4", 16 ] ];
function isValidCC(cctype, ccnumber) {
	var cc = getdigits(ccnumber);
	if (luhn(cc)) {
		for ( var i in creditCardList) {
			if (creditCardList[i][0] == (cctype.toLowerCase())) {
				if (cc.indexOf(creditCardList[i][1]) == 0) {
					if (creditCardList[i][2] == cc.length) {
						return true;
					}
				}
			}
		}
	}
	return false;
}
function luhn(cc) {
	var sum = 0;
	var i;

	for (i = cc.length - 2; i >= 0; i -= 2) {
		sum += Array(0, 2, 4, 6, 8, 1, 3, 5, 7, 9)[parseInt(cc.charAt(i), 10)];
	}
	for (i = cc.length - 1; i >= 0; i -= 2) {
		sum += parseInt(cc.charAt(i), 10);
	}
	return (sum % 10) == 0;
}
// This returns a string with everything but the digits removed.
function getdigits(s) {
	return s.replace(/[^\d]/g, "");
}
// Get String Length
function regGetStrLength(fData) {
	var valLength = fData.length;
	var reg = new RegExp("^[\u0391-\uFFE5]$");
	var result = 0;
	for ( var i = 0; i < valLength; i++) {
		if (reg.test(fData.charAt(i))) {
			result += 2;
		} else {
			result++;
		}
	}
	return result;
}
