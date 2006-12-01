
#
# Copyright (c) 2006 Michael Eddington
#
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights 
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in 
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Authors:
#   Michael Eddington (meddington@gmail.com)

# $Id$

class Reform

def HtmlEncode(str, default='')
	
	if str == None or len(str) == 0
		str = default
		end
	
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	out = ''
	for char in str
		c = ord(char)
		if ((c >= 97 and c <= 122) or
			(c >= 65 and c <= 90 ) or
			(c >= 48 and c <= 57 ) or
			c == 32 or c == 44 or c == 46)
			out += char
		else
			out += "&#%d;" % c
		end
	end
		
	return out
end
		
def HtmlAttributeEncode(str, default=''):
	
	if str == None or len(str) == 0:
		str = default
	
	# Allow: a-z A-Z 0-9
	# Allow (dec): 97-122 65-90 48-57
	
	out = '';
	for char in str:
		c = ord(char);
		if ((c >= 97 and c <= 122) or
			(c >= 65 and c <= 90 ) or
			(c >= 48 and c <= 57 )):
			out += char
		else:
			out += "&#%d;" % c
	
	return out

def XmlEncode(str, default=''):
	return HtmlEncode(str, default)

def XmlAttributeEncode(str, default=''):
	return HtmlAttributeEncode(str, default)

def JsString(str, default=''):
	
	if str == None or len(str) == 0:
		str = default
		
		if str == None or len(str) == 0:
			return "''"
	
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	out = '';
	for char in str:
		c = ord(char);
		if ((c >= 97 and c <= 122) or
			(c >= 65 and c <= 90 ) or
			(c >= 48 and c <= 57 ) or
			c == 32 or c == 44 or c == 46):
			out += char
		elif c <= 127:
			out += "\\x%2x;" % c
		else:
			out += "\\u%4x;" % c
	
	return "'%s'" % out

def VbsString(str, default=''):
	
	if str == None or len(str) == 0:
		str = default
		
		if str == None or len(str) == 0:
			return '""'
	
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
		
	out = '';
	inStr = 0;	# Boolean (0 false, 1 true)
				# Using numerical for backwards
				# compatability
		
	for char in str:
		c = ord(char);
		if ((c >= 97 and c <= 122) or
			(c >= 65 and c <= 90 ) or
			(c >= 48 and c <= 57 ) or
			c == 32 or c == 44 or c == 46):
			
			if inStr == 0:
				inStr = 1
				out += '&"'
			
			out += char
		else:
			if inStr == 0:
				out += "&chrw(%d)" % c
			else:
				inStr = 0
				out += "\"&chrw(%d)" % c
		
	if inStr == 1:
		out += '"'
		
	return out.lstrip('&')
end
	
# end
