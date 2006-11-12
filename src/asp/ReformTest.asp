<% 

' 
' Copyright (c) 2006 Michael Eddington
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy  
' of this software and associated documentation files (the "Software"), to deal 
' in the Software without restriction, including without limitation the rights  
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
' copies of the Software, and to permit persons to whom the Software is  
' furnished to do so, subject to the following conditions: 
' 
' The above copyright notice and this permission notice shall be included in  
' all copies or substantial portions of the Software. 
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
' SOFTWARE. 
' 
' Authors:
'   Michael Eddington (meddington@phed.org)
'
' $Id$
'

%>
<!-- #include file="Reform.inc.asp" -->
<html>
<head>
<title>Reform Test Cases</title>
</head>
<body>
<h3>Reform Test Cases</h3><br>
<%

currentTestCase = "None"

function assertAreEqual(str1, str2, msg)

	if str1 <> str2 then
		Response.Write("<br>[" & currentTestCase & "] <b>!!FAILURE!!</b> ("&msg&"): <br><pre>" & str1 & "</pre>------<br><pre>" & str2 &"</pre>")
		Response.End
	end if
	
end function

function startTest(testName)
	currentTestCase = testName
	Response.Write("<hr>Starting test case: " & currentTestCase & "...")
end function

function endTest()
	Response.Write("OK<br>")
end function

function testHtmlEncode()
	
	startTest("testHtmlEncode")
	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", _
		Reform.HtmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.HtmlEncode("<>&"""), "Usual suspects"
	' Other characters
	assertAreEqual "&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.HtmlEncode("`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.HtmlEncode(toEncode), "Unicode characters to 6000"
	
	endTest()
end function
testHtmlEncode()

function testHtmlEncodeDefault()

	startTest("testHtmlEncodeDefault")
	' Usual stuff
	assertAreEqual "default", _
		Reform.HtmlEncodeEx(null, "default"), "Checking default"

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", _
		Reform.HtmlEncodeEx(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.HtmlEncodeEx(null, "<>&"""), "Usual suspects via default"
	' Other characters
	assertAreEqual "&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.HtmlEncodeEx(null, "`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation via default"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.HtmlEncodeEx(null, toEncode), "Unicode characters to 6000 via default"
	
	' The following are sanity checks

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", _
		Reform.HtmlEncodeEx("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.HtmlEncodeEx("<>&""", "default"), "Usual suspects"
	' Other characters
	assertAreEqual "&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.HtmlEncodeEx("`~!@#$%^&*()_+=-{}|\][:;'/?><", "default"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.HtmlEncodeEx(toEncode, "default"), "Unicode characters to 6000"
	
	endTest()
end function
testHtmlEncodeDefault()

function testHtmlAttributeEncode()

	startTest("testHtmlAttributeEncode")
	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", _
		Reform.HtmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.HtmlAttributeEncode("<>&"""), "Usual suspects"
	' Other characters
	assertAreEqual "&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.HtmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.HtmlAttributeEncode(toEncode), "Unicode characters to 6000"
	endTest()
end function
testHtmlAttributeEncode()

function testHtmlAttributeEncodeDefault()

	startTest("testHtmlAttributeEncodeDefault")
	' Usual stuff
	assertAreEqual "default", _
		Reform.HtmlAttributeEncodeEx(null, "default"), "Checking default"

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", _
		Reform.HtmlAttributeEncodeEx(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars via default"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.HtmlAttributeEncodeEx(null, "<>&"""), "Usual suspects via default"
	' Other characters
	assertAreEqual "&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.HtmlAttributeEncodeEx(null, " ,.`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation via default"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.HtmlAttributeEncodeEx(null, toEncode), "Unicode characters to 6000 via default"

	' The following are sanity checks

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", _
		Reform.HtmlAttributeEncodeEx("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.HtmlAttributeEncodeEx("<>&""", "default"), "Usual suspects"
	' Other characters
	assertAreEqual "&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.HtmlAttributeEncodeEx(" ,.`~!@#$%^&*()_+=-{}|\][:;'/?><", "default"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.HtmlAttributeEncodeEx(toEncode, "default"), "Unicode characters to 6000"
	endTest()
end function
testHtmlAttributeEncodeDefault()

function testXmlEncode()

	startTest("testXmlEncode")
	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", _
		Reform.XmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.XmlEncode("<>&"""), "Usual suspects"
	' Other characters
	assertAreEqual "&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.XmlEncode("`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.XmlEncode(toEncode), "Unicode characters to 6000"
	endTest()
end function
testXmlEncode()

function testXmlEncodeDefault()

	startTest("testXmlEncodeDefault")
	assertAreEqual "", _
		Reform.XmlEncodeEx(null, null), "Null for both parameters"
	' Usual stuff
	assertAreEqual "default", _
		Reform.XmlEncodeEx(null, "default"), "Checking default"

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", _
		Reform.XmlEncodeEx(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.XmlEncodeEx(null, "<>&"""), "Usual suspects via default"
	' Other characters
	assertAreEqual "&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.XmlEncodeEx(null, "`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation via default"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.XmlEncodeEx(null, toEncode), "Unicode characters to 6000 via default"

	' The following are sanity checks

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", _
		Reform.XmlEncodeEx("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.XmlEncodeEx("<>&""", "default"), "Usual suspects"
	' Other characters
	assertAreEqual "&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.XmlEncodeEx("`~!@#$%^&*()_+=-{}|\][:;'/?><", "default"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.XmlEncodeEx(toEncode, "default"), "Unicode characters to 6000"
	endTest()
end function
testXmlEncodeDefault()

function testXmlAttributeEncode()

	startTest("testXmlAttributeEncode")
	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", _
		Reform.XmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.XmlAttributeEncode("<>&"""), "Usual suspects"
	' Other characters
	assertAreEqual "&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.XmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.XmlAttributeEncode(toEncode), "Unicode characters to 6000"
	endTest()
	
end function
testXmlAttributeEncode()

function testXmlAttributeEncodeDefault()

	startTest("testXmlAttributeEncodeDefault")
	assertAreEqual "", _
		Reform.XmlAttributeEncodeEx(null, null), "Null for both parameters"
	' Usual stuff
	assertAreEqual "default", _
		Reform.XmlAttributeEncodeEx(null, "default"), "Checking default"

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", _
		Reform.XmlAttributeEncodeEx(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars via default"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.XmlAttributeEncodeEx(null, "<>&"""), "Usual suspects via default"
	' Other characters
	assertAreEqual "&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.XmlAttributeEncodeEx(null, " ,.`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation via default"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.XmlAttributeEncodeEx(null, toEncode), "Unicode characters to 6000 via default"

	' The following are sanity checks

	' Non encoded characters
	assertAreEqual "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", _
		Reform.XmlAttributeEncodeEx("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "&#60;&#62;&#38;&#34;", _
		Reform.XmlAttributeEncodeEx("<>&""", "default"), "Usual suspects"
	' Other characters
	assertAreEqual "&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;", _
		Reform.XmlAttributeEncodeEx(" ,.`~!@#$%^&*()_+=-{}|\][:;'/?><", "default"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 127 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&#" & i & ";"
	next
	assertAreEqual encodedStr, _
		Reform.XmlAttributeEncodeEx(toEncode, "default"), "Unicode characters to 6000"
	endTest()
	
end function
testXmlAttributeEncodeDefault()

function bin2hex(c)
	h = hex(c)
	
	for cnt = len(h) to 3
		h = "0" & h
	next
	
	bin2hex = h
	
end function

function testJsString()

	startTest("testJsString")
	' Non encoded characters
	assertAreEqual "'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'", _
		Reform.JsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars"
	' Usual suspects
	assertAreEqual "'\x3C\x3E\x26\x22\x5C\x27'", _
		Reform.JsString("<>&""\'"), "Usual suspects"
	' Other characters
	assertAreEqual "'\x60\x7E\x21\x40\x23\x24\x25\x5E\x26\x2A\x28\x29\x5F\x2B\x3D\x2D\x7B\x7D\x7C\x5C\x5D\x5B\x3A\x3B\x27\x2F\x3F\x3E\x3C'", _
		Reform.JsString("`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	encodedStr = encodedStr & "'"
	for  i = 128 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "\u" & bin2hex(i)
	next
	encodedStr = encodedStr & "'"
	assertAreEqual encodedStr, _
		Reform.JsString(toEncode), "Unicode characters to 6000"
	endTest()
	
end function
testJsString()

function testJsStringDefault()

	startTest("testJsStringDefault")
	assertAreEqual "''", _
		Reform.JsStringEx(null, null), "Null for both parameters"
	' Usual stuff
	assertAreEqual "'default'", _
		Reform.JsStringEx(null, "default"), "Checking default"

	' Non encoded characters
	assertAreEqual "'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'", _
		Reform.JsStringEx(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default"
	' Usual suspects
	assertAreEqual "'\x3C\x3E\x26\x22\x5C\x27'", _
		Reform.JsStringEx(null, "<>&""\'"), "Usual suspects via default"
	' Other characters
	assertAreEqual "'\x60\x7E\x21\x40\x23\x24\x25\x5E\x26\x2A\x28\x29\x5F\x2B\x3D\x2D\x7B\x7D\x7C\x5C\x5D\x5B\x3A\x3B\x27\x2F\x3F\x3E\x3C'", _
		Reform.JsStringEx(null, "`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation via default"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	encodedStr = encodedStr & "'"
	for  i = 128 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "\u" & bin2hex(i)
	next
	encodedStr = encodedStr & "'"
	assertAreEqual encodedStr, _
		Reform.JsStringEx(null, toEncode), "Unicode characters to 6000 via default"

	' The following are sanity checks

	' Non encoded characters
	assertAreEqual "'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'", _
		Reform.JsStringEx("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "'\x3C\x3E\x26\x22\x5C\x27'", _
		Reform.JsStringEx("<>&""\'", "default"), "Usual suspects"
	' Other characters
	assertAreEqual "'\x60\x7E\x21\x40\x23\x24\x25\x5E\x26\x2A\x28\x29\x5F\x2B\x3D\x2D\x7B\x7D\x7C\x5C\x5D\x5B\x3A\x3B\x27\x2F\x3F\x3E\x3C'", _
		Reform.JsStringEx("`~!@#$%^&*()_+=-{}|\][:;'/?><", "default"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	encodedStr = encodedStr & "'"
	for  i = 128 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "\u" & bin2hex(i)
	next
	encodedStr = encodedStr & "'"
	assertAreEqual encodedStr, _
		Reform.JsStringEx(toEncode, "default"), "Unicode characters to 6000"
	endTest()
	
end function
testJsStringDefault()

function testVbsString()

	startTest("testVbsString")
	assertAreEqual """abc""&chrw(60)", _
		Reform.VbsString("abc<"), "VBS String prefix"
	assertAreEqual "chrw(60)&""abc""", _
		Reform.VbsString("<abc"), "VBS chrw prefix"
	' Non encoded characters
	assertAreEqual """ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.""", _
		Reform.VbsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars"
	' Usual suspects
	assertAreEqual "chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)", _
		Reform.VbsString("<>&""\'"), "Usual suspects"
	' Other characters
	assertAreEqual "chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)", _
		Reform.VbsString("`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 128 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&chrw("&i&")"
	next
	encodedStr = Right(encodedStr, len(encodedStr) - 1)	 ' remove &

	assertAreEqual encodedStr, _
		Reform.VbsString(toEncode), "Unicode characters to 6000"
	endTest()
	
end function
testVbsString()

function testVbsStringDefault()

	startTest("testVbsStringDefault")
	assertAreEqual """""", _
		Reform.VbsStringEx(null, null), "Null for both parameters"
	assertAreEqual """abc""&chrw(60)", _
		Reform.VbsStringEx(null, "abc<"), "String prefix"
	assertAreEqual "chrw(60)&""abc""", _
		Reform.VbsStringEx(null, "<abc"), "chrw prefix"
	' Usual stuff
	assertAreEqual """default""", _
		Reform.VbsStringEx(null, "default"), "Checking default"

	' Non encoded characters
	assertAreEqual """ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.""", _
		Reform.VbsStringEx(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default"
	' Usual suspects
	assertAreEqual "chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)", _
		Reform.VbsStringEx(null, "<>&""\'"), "Usual suspects via default"
	' Other characters
	assertAreEqual "chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)", _
		Reform.VbsStringEx(null, "`~!@#$%^&*()_+=-{}|\][:;'/?><"), "Punctuation via default"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 128 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&chrw("&i&")"
	next
	encodedStr = Right(encodedStr, len(encodedStr) - 1)	 ' remove &
	assertAreEqual encodedStr, _
		Reform.VbsStringEx(null, toEncode), "Unicode characters to 6000 via default"

	' The following are sanity checks

	' Non encoded characters
	assertAreEqual """ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.""", _
		Reform.VbsStringEx("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars"
	' Usual suspects
	assertAreEqual "chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)", _
		Reform.VbsStringEx("<>&""\'", "default"), "Usual suspects"
	' Other characters
	assertAreEqual "chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)", _
		Reform.VbsStringEx("`~!@#$%^&*()_+=-{}|\][:;'/?><", "default"), "Punctuation"
	' Unicode characters
	toEncode = ""
	encodedStr = ""
	for  i = 128 to 6000
		toEncode = toEncode & chrw(i)
		encodedStr = encodedStr & "&chrw("&i&")"
	next
	encodedStr = Right(encodedStr, len(encodedStr) - 1)	 ' remove &
	assertAreEqual encodedStr, _
		Reform.VbsStringEx(toEncode, "default"), "Unicode characters to 6000"
	endTest()
	
end function
testVbsStringDefault()

%>
