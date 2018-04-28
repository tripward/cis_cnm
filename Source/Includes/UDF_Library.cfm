<!---
################################################################################
#
# Filename:		UDF_Library.cfm
#
# Description:	Library of UDFs for use throughout the application
#
################################################################################
--->

<!--- UDF_isError(): Specifies whether or not specified field has an error --->
<CFSCRIPT>
	function UDF_isError(field) {
		if ( (IsDefined("arrErrors")) AND (ListFindNoCase(ArrayToList(arrErrors[1]), field) NEQ 0) ) {
			return "Error";
		} else {
			return "";
		}
	}
</CFSCRIPT>


<!--- UDF_padValue(): Returns specified value padded with specified character to --->
<!--- achieve specified lentgh --->
<CFSCRIPT>
	function UDF_padValue(value, padChar, justification, length) {
		if ( Len(Trim(value)) GTE length ) {
			return Left(Trim(value), length);
		} else if ( CompareNoCase(justification, "LEFT") EQ 0 ) {
			return Trim(value) & RepeatString(padChar, length - Len(Trim(value)));
		} else if ( CompareNoCase(justification, "RIGHT") EQ 0 ) {
			return RepeatString(padChar, length - Len(Trim(value))) & Trim(value);
		} else {
			return value;
		}
	}
</CFSCRIPT>


<!--- UDF_reverseDayOfYear(): Returns date based on year and day of the year --->
<CFSCRIPT>
	function UDF_reverseDayOfYear(aDayOfYear, aYear) {
		return DateAdd("d", aDayOfYear-1, CreateDate(aYear, "1", "1"));
	}
</CFSCRIPT>
