#
# Copyright (c) 2008 Adam Cecchetti 
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
#
# Authors:
#		Adam Cecchetti (adam@cecchetti.com)
#
# $Id$


class Reform

def self.HtmlEncode( str, default='' )
	
	if( str == nil or str.length == 0 )  
		str = default 
	end

	if (str == nil || str.length == 0 )
		return nil 
	end 
	
	
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	out = ''
	
	str.unpack("U*").each { |c|
		if( (c >= 97 and c <= 122) or
				(c >= 65 and c <= 90 ) or
				(c >= 48 and c <= 57 ) or
				 c == 32 or  c == 44   or  
				 c == 46  )
			out += c.chr
		else
			out += "&#%d;" % c
		end
	}

	return out
end # END HtmlEncode 
	

def Reform.HtmlAttributeEncode(str, default='')
	
	if (str == nil || str.length == 0)
		str = default
	end 	

	if (str == nil || str.length == 0)
		return nil 	
	end 
	# Allow: a-z A-Z 0-9
	# Allow (dec): 97-122 65-90 48-57

	out = ''
	str.unpack("U*").each { |c| 	

		if((c >= 97 and c <= 122) or
			 (c >= 65 and c <= 90 ) or
			 (c >= 48 and c <= 57 ) )
			out += c.chr
		else
			out += "&#%d;" % c
		end
	}

	return out
end # END HtmlAttributeEncode  

def Reform.XmlEncode(str, default='')
	return HtmlEncode(str, default)
end # END XmlEncode 

def Reform.XmlAttributeEncode(str, default='')
	return HtmlAttributeEncode(str, default)
end # END XmlAttributeEncode

def Reform.JsString( str, default='' )
	
	if( str == nil or str.length == 0 ) 
		str = default
	end
		
	if( str == nil or str.length == 0 )
			return "''"
	end 
	
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	out = '';
	str.unpack("U*").each { |c| 

		if( (c >= 97 and c <= 122) or
				(c >= 65 and c <= 90 ) or
				(c >= 48 and c <= 57 ) or
				 c == 32 or  c == 44   or
				 c == 46 )

			out += c.chr
		elsif( c <= 127 )
			out += "\\x%02X" % c
		else
			out += "\\u%04X" % c
		end 
	} 

	return "'%s'" % out

end # END JsString 

def Reform.VbsString( str, default='' )
	
	if( str == nil or str.length == 0 ) 
		str = default
	end
		
	if( str == nil or str.length == 0 ) 
		return '""'
	end	

	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
		
	out = ''
	inStr = 0	
				# Boolean (0 false, 1 true)
				# Using numerical for backwards
				# compatability
		
	str.unpack("U*").each { |c| 	

		if( (c >= 97 and c <= 122) or
				(c >= 65 and c <= 90 ) or
				(c >= 48 and c <= 57 ) or
				 c == 32 or c == 44 or 
				 c == 46 )
			
			if( inStr == 0 )
				inStr = 1
				out += '&"'
			end

			out += c.chr

		else
			if( inStr == 0 ) 
				out += "&chrw(%d)" % c
			else
				inStr = 0
				out += "\"&chrw(%d)" % c
			end
		end
	}

	if ( inStr == 1 ) 
		out += '"'
	end

	return out.sub('&','')
end # END VbsString
	
end # END Reform 


