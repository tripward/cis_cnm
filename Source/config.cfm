<!---
################################################################################
#
# Filename:		config.cfm
#
# Description:	Configuration file
#
################################################################################
--->

<!--- Create Site Details structure and initialize with defaults --->
<CFSET stSiteDetails = StructNew()>
<CFSET stSiteDetails.BaseURL = "/CIS_Intranet">
<CFSET stSiteDetails.BasePath = "C:\Projects\Contemporary Insurance Services\Intranet">
<CFSET stSiteDetails.DataSource = "CIS_Intranet">
<CFSET stSiteDetails.DateMask = "MMMM d, yyyy">
<CFSET stSiteDetails.DateSpanMask.StartDate = "MMMM d-">
<CFSET stSiteDetails.DateSpanMask.EndDate = "d, yyyy">
<CFSET stSiteDetails.TimeMask = "h:MM tt">


<!--- Create Page Details structure and initialize with defaults --->
<CFSET stPageDetails = StructNew()>
<CFSET stPageDetails.Title = "CIS Intranet: ">
<CFSET stPageDetails.Keywords = "">
<CFSET stPageDetails.Description = "">
<CFSET stPageDetails.DTPublicIdentifier = "-//W3C//DTD HTML 4.01 Transitional//EN">
<CFSET stPageDetails.DTSystemIdentifier = "http://www.w3.org/TR/html4/loose.dtd">
<CFSET stPageDetails.ContentType = "text/html; charset=iso-8859-1">
<CFSET stPageDetails.BreadCrumb = "">


<!--- Define System Constants --->
<CFSET stSystemConstants = StructNew()>
<CFSET stSystemConstants.acFeedSequenceNumber = "218">
<CFSET stSystemConstants.acPolicySymbol = "CNM">
<CFSET stSystemConstants.adjustmentIndicator = "">
<CFSET stSystemConstants.agencyBillIndicator = "A">
<CFSET stSystemConstants.aicoIndicator = "">
<CFSET stSystemConstants.aigrmContractNumber = "">
<CFSET stSystemConstants.aiStartSubmissionNumber = 0>
<CFSET stSystemConstants.ascoCompanyNumber = 29>
<CFSET stSystemConstants.biDeductibleCode = "">
<CFSET stSystemConstants.biLimitCode = "">
<CFSET stSystemConstants.branchNumber = 57>
<CFSET stSystemConstants.commissionRate = 20>
<CFSET stSystemConstants.coverageMajorClass = "659">
<CFSET stSystemConstants.coverageNumber = "001">
<CFSET stSystemConstants.coverageSymbol = "CNM">
<CFSET stSystemConstants.defaultInsuranceCompanyID = 029>
<CFSET stSystemConstants.divisionCode = 066>
<CFSET stSystemConstants.eStartSubmissionNumber = 0>
<CFSET stSystemConstants.exportAttachmentFileName = "#stSiteDetails.BasePath#\Temp\">
<CFSET stSystemConstants.exportCcAddress = "mosh.teitelbaum@evoch.com">
<CFSET stSystemConstants.exportFromAddress = "mosh.teitelbaum@evoch.com">
<CFSET stSystemConstants.exportToAddress = "mosh.teitelbaum@evoch.com">
<CFSET stSystemConstants.exposureAmount = "0">
<CFSET stSystemConstants.exposureBase = "">
<CFSET stSystemConstants.limitedCoding = 1>
<CFSET stSystemConstants.lineOfBusiness = "">
<CFSET stSystemConstants.locationNumber = "001">
<CFSET stSystemConstants.masterCertAndDecNumber = "00000000000">
<CFSET stSystemConstants.mgaTransaction = "Y">
<CFSET stSystemConstants.njSurplusLinesLicenseNumber = "G069A">
<CFSET stSystemConstants.payPlanCode = "02">
<CFSET stSystemConstants.pcFeedSequenceNumber = "022">
<CFSET stSystemConstants.pcPolicySymbol = "CIS">
<CFSET stSystemConstants.policyFormCode = "C">
<CFSET stSystemConstants.policyType = "90">
<CFSET stSystemConstants.premiumRecordType = "P">
<CFSET stSystemConstants.previousCertNumber = "00000000000">
<CFSET stSystemConstants.producerNumber = 54485>
<CFSET stSystemConstants.rateCommission = "">
<CFSET stSystemConstants.rateDeductible = "">
<CFSET stSystemConstants.rateExpense = "">
<CFSET stSystemConstants.rateExperience = "">
<CFSET stSystemConstants.ratePackage = "">
<CFSET stSystemConstants.rateSchedule = "">
<CFSET stSystemConstants.statPlanNumber = "29">
<CFSET stSystemConstants.surplusLinesAgentsAddress = "11301 Amherst Avenue, Suite 201">
<CFSET stSystemConstants.surplusLinesAgentsCity = "Silver Spring">
<CFSET stSystemConstants.surplusLinesAgentsName = "Israel Teitelbaum">
<CFSET stSystemConstants.surplusLinesAgentsState = "MD">
<CFSET stSystemConstants.tailDate = "00000000">
<CFSET stSystemConstants.terrorismTypeCode = 2>

<!--- Date on which system switched to new Premium Coding feed format --->
<CFSET stSystemConstants.premiumCodingFormatSwitchDate = "7/11/2007">

<!--- Define CrLf --->
<CFSET CrLf = Chr(13) & Chr(10)>