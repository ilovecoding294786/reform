<% 

' 
' Copyright (c) 2005-2006 Michael Eddington
' Copyright (c) 2004 IOActive Inc. 
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
'   Michael Eddington (meddington@gmail.com)
'
' $Id$
'

class OWASPReform
	
	function HtmlEncode(str)
		HtmlEncode = HtmlEncodeEx(str, "")
	end function
	
	function HtmlEncodeEx(str, default)
	
		HtmlEncodeEx = ""
		dim cnt
		dim c
		
		if isNull(str) or isEmpty(str) or len(str) = 0 then
			if isNull(default) or isEmpty(default) or len(default) = 0 then
				HtmlEncodeEx = ""
				exit function
			else
				str = default
			end if
		end if
		
		' Allow: a-z A-Z 0-9 SPACE , .
		' Allow (dec): 97-122 65-90 48-57 32 44 46
		
		for cnt = 1 to len(str)
			
			c = ascw( mid(str, cnt, 1) )
			If c < 0 Then
				c = 65536 + c
			End If
			
			if  (c >= 97 and c <= 122) or _
				(c >= 65 and c <= 90 ) or _
				(c >= 48 and c <= 57 ) or _
				 c =  32 or  c =  44   or c = 46 then
				
				HtmlEncodeEx = HtmlEncodeEx & Chrw(c)
				
			else
				HtmlEncodeEx = HtmlEncodeEx & "&#" & c & ";"
				
			end if
		next
		
	end function
	
	function HtmlAttributeEncode(str)
		HtmlAttributeEncode = HtmlAttributeEncodeEx(str, "")
	end function
	
	function HtmlAttributeEncodeEx(str, default)
	
		HtmlAttributeEncodeEx = ""
		dim cnt
		dim c
		
		if isNull(str) or isEmpty(str) or len(str) = 0 then
			if isNull(default) or isEmpty(default) or len(default) = 0 then
				HtmlAttributeEncodeEx = ""
				exit function
			else
				str = default
			end if
		end if
		
		' Allow: a-z A-Z 0-9 SPACE , .
		' Allow (dec): 97-122 65-90 48-57 32 44 46
		
		for cnt = 1 to len(str)
			
			c = ascw( mid(str, cnt, 1) )
			If c < 0 Then
				c = 65536 + c
			End If
			
			if  (c >= 97 and c <= 122) or _
				(c >= 65 and c <= 90 ) or _
				(c >= 48 and c <= 57 ) then
				
				HtmlAttributeEncodeEx = HtmlAttributeEncodeEx & Chrw(c)
				
			else
				HtmlAttributeEncodeEx = HtmlAttributeEncodeEx & "&#" & c & ";"
				
			end if
		next
	end function
	
	function XmlEncode(str)
		XmlEncode = XmlEncodeEx(str, "")
	end function
	
	function XmlEncodeEx(str, default)
		XmlEncodeEx = HtmlEncodeEx(str, default)
	end function
	
	function XmlAttributeEncode(str)
		XmlAttributeEncode = HtmlAttributeEncodeEx(str, "")
	end function
	
	function XmlAttributeEncodeEx(str, default)
		XmlAttributeEncodeEx = HtmlAttributeEncodeEx(str, default)
	end function
	
	function JsString(str)
		JsString = JsStringEx(str, "")
	end function
	
	function JsStringEx(str, default)
	
		JsStringEx = "'"
		
		dim c
		dim cnt
		dim h
	
		if isNull(str) or isEmpty(str) or len(str) = 0 then
			if isNull(default) or isEmpty(default) or len(default) = 0 then
				JsStringEx = "''"
				exit function
			else
				str = default
			end if
		end if
		
		' Allow: a-z A-Z 0-9 SPACE , .
		' Allow (dec): 97-122 65-90 48-57 32 44 46
		
		for cnt = 1 to len(str)
		
			c = ascw(mid(str, cnt, 1))
			If c < 0 Then
				c = 65536 + c
			End If
			
			if  (c >= 97 and c <= 122) or _
				(c >= 65 and c <= 90 ) or _
				(c >= 48 and c <= 57 ) or _
				 c =  32 or  c =  44   or c = 46 then
				
				JsStringEx = JsStringEx & Chrw(c)
				
			elseif c <= 127 then
				h = hex(c)
				
				if len(h) < 2 then
					h = "0" & h
				end if
				
				JsStringEx = JsStringEx & "\x" & h
				
			else
				h = hex(c)
				
				while len(h) < 4
					h = "0" & h
				wend
				
				JsStringEx = JsStringEx & "\u" & h
			end if
		next
		
		JsStringEx = JsStringEx & "'"
	end function
	
	function VbsString(str)
		VbsString = VbsStringEx(str, "")
	end function
	
	function VbsStringEx(str, default)
	
		if isNull(str) or isEmpty(str) or len(str) = 0 then
			if isNull(default) or isEmpty(default) or len(default) = 0 then
				VbsStringEx = """"""
				exit function
			else
				str = default
			end if
		end if
		
		VbsStringEx = ""
		dim inStr
		dim c
		
		inStr = 0
		
		' Allow: a-z A-Z 0-9 SPACE , .
		' Allow (dec): 97-122 65-90 48-57 32 44 46
		
		for cnt = 1 to len(str)
		
			c = ascw(mid(str, cnt, 1))
			If c < 0 Then
				c = 65536 + c
			End If
			
			if  (c >= 97 and c <= 122) or _
				(c >= 65 and c <= 90 ) or _
				(c >= 48 and c <= 57 ) or _
				 c =  32 or  c =  44   or c = 46 then
				
				if inStr = 0 then
					inStr = 1
					VbsStringEx = VbsStringEx & "&"""
				end if
				
				VbsStringEx = VbsStringEx & Chrw(c)
			else
				
				if inStr = 0 then
					VbsStringEx = VbsStringEx & "&chrw(" & c & ")"
				else
					VbsStringEx = VbsStringEx & """&chrw(" & c & ")"
					inStr = 0
				end if
			end if
		next
		
		if asc(left(VbsStringEx, 1)) = 38 then ' & char
			VbsStringEx = Right(VbsStringEx, len(VbsStringEx) - 1)		
		end if
		
		if inStr = 1 then
				VbsStringEx = VbsStringEx & """"
		end if
		
	end function

end class

dim Reform
set Reform = new OWASPReform

%>