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
#   Adam Cecchetti (adam@cecchetti.com)
#
# $Id$

require 'Reform' 
require 'test/unit'

# begin unit tests 


class TestCase_HtmlEncode < Test::Unit::TestCase 

	
	@@AlphaNumeric = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'
	
	# UsualSuspects = <>&\
	@@UsualSuspectsRaw = '<>&"'
	# UsualSuspects Encoded 
	@@UsualSuspectsEncoded = "&#60;&#62;&#38;&#34;" 

  @@AlphaNumericAttribute = @@AlphaNumeric[0..-4] 
  @@UsualSuspectsEncodedAttribute = @@UsualSuspectsEncoded + "&#32;&#44;&#46;"
  @@UsualSuspectsRawAttribute = @@UsualSuspectsRaw + " ,." 

	# PunctuationRaw 
	@@PunctuationRaw = '`~!@#$%^&*()_+=-{}|\][:;\'/?><'
	# Punctuation Others  
	@@PunctuationEncoded = "&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;"

	# UTF-8 Encoded 127-6000 
	@@UTF8Raw = (127..6000).to_a.pack("U*")  
	@@UTF8Encoded = "" 
	(127..6000).each { |i| @@UTF8Encoded += "&#%d;" % i }

	@@UTF8RawShortTest = (127..130).to_a.pack("U*") 
	############################################
	#
	############################################
	def testHtmlEncode()
		# Non encoded characters
		assert_equal(@@AlphaNumeric,
			Reform.HtmlEncode(@@AlphaNumeric), 
			"Non encoding chars")
		# Usual suspects
		assert_equal(@@UsualSuspectsEncoded,
			Reform.HtmlEncode(@@UsualSuspectsRaw), 
			"Usual suspects")

		# Other characters
		assert_equal(@@PunctuationEncoded ,
			Reform.HtmlEncode(@@PunctuationRaw), "Punctuation")

		assert_equal(@@UTF8Encoded,
			Reform.HtmlEncode(@@UTF8Raw), "Unicode characters to 6000")

	end #END testHTMLEncode 	

  #########################################
	#
	#########################################
	def testHtmlEncodeDefault()
		# Usual stuff
		assert_equal("default", 
			Reform.HtmlEncode(nil, "default"), "Checking default")
		
		# Non encoded characters
		assert_equal(@@AlphaNumeric,
			Reform.HtmlEncode(nil, @@AlphaNumeric), "Non encoding chars via default")

		# Usual suspects
		assert_equal(@@UsualSuspectsEncoded,
			Reform.HtmlEncode(nil, @@UsualSuspectsRaw), "Usual suspects via default")

		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.HtmlEncode(nil, @@PunctuationRaw), "Punctuation via default")

		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.HtmlEncode(nil, @@UTF8Raw), "Unicode characters to 6000 via default")
		
		# The following are sanity checks
		
		# Non encoded characters
		assert_equal(@@AlphaNumeric,
			Reform.HtmlEncode(@@AlphaNumeric, "default"), "Non encoding chars")

		# Usual suspects
		assert_equal(@@UsualSuspectsEncoded,
			Reform.HtmlEncode(@@UsualSuspectsRaw, "default"), "Usual suspects")
		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.HtmlEncode(@@PunctuationRaw, "default"), "Punctuation")
		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.HtmlEncode(@@UTF8Raw, "default"), "Unicode characters to 6000")
	end #END testHtmlEncodeDefault  


	#######################################
	#
	#######################################
	def testHtmlAttributeEncode()

		# Non encoded characters - "., "
		assert_equal(@@AlphaNumericAttribute,
			Reform.HtmlAttributeEncode(@@AlphaNumericAttribute), "Non encoding chars")

		# Usual suspects + "., "  
		assert_equal(@@UsualSuspectsEncodedAttribute,
			Reform.HtmlAttributeEncode(@@UsualSuspectsRawAttribute), "Usual suspects")

		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.HtmlAttributeEncode(@@PunctuationRaw), "Punctuation")

		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.HtmlAttributeEncode(@@UTF8Raw), "Unicode characters to 6000")
		end #END  

	#######################################
	#
	#######################################
	def testHtmlAttributeEncodeDefault()

		# Usual stuff
		assert_equal("default",
			Reform.HtmlAttributeEncode(nil, "default"), "Checking default")
		
		# Non encoded characters
		assert_equal(@@AlphaNumericAttribute,
			Reform.HtmlAttributeEncode(nil, @@AlphaNumericAttribute), "Non encoding chars via default")

		# Usual suspects
		assert_equal(@@UsualSuspectsEncodedAttribute,
			Reform.HtmlAttributeEncode(nil, @@UsualSuspectsRawAttribute), "Usual suspects via default")

		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.HtmlAttributeEncode(nil, @@PunctuationRaw), "Punctuation via default")

		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.HtmlAttributeEncode(nil, @@UTF8Raw), "Unicode characters to 6000 via default")
		
		# The following are sanity checks
		
		# Non encoded characters
		assert_equal(@@AlphaNumericAttribute,
			Reform.HtmlAttributeEncode(@@AlphaNumericAttribute,"default"), "Non encoding chars")
		# Usual suspects
		assert_equal(@@UsualSuspectsEncodedAttribute,
			Reform.HtmlAttributeEncode(@@UsualSuspectsRawAttribute, "default"), "Usual suspects")
		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.HtmlAttributeEncode(@@PunctuationRaw, "default"), "Punctuation")

		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.HtmlAttributeEncode(@@UTF8Raw, "default"), "Unicode characters to 6000")
	end #ENDtestHtmlAttributeEncodeDefault 

	##############################################
	#
	##############################################

	def testXmlEncode()
		# Non encoded characters
		assert_equal(@@AlphaNumeric,
			Reform.XmlEncode(@@AlphaNumeric), "Non encoding chars")

		# Usual suspects
		assert_equal(@@UsualSuspectsEncoded ,
			Reform.XmlEncode(@@UsualSuspectsRaw), "Usual suspects")

		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.XmlEncode(@@PunctuationRaw), "Punctuation")
		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.XmlEncode(@@UTF8Raw), "Unicode characters to 6000")
	end # END testXmlEncode


	#######################################
	#
	#######################################

	def testXmlEncodeDefault()
		assert_equal(nil,
			Reform.XmlEncode(nil, nil), "nil for both parameters")

		# Usual stuff
		assert_equal("default",
			Reform.XmlEncode(nil, "default"), "Checking default")

		# Non encoded characters
		assert_equal(@@AlphaNumeric,
			Reform.XmlEncode(nil, @@AlphaNumeric), "Non encoding chars via default")
	
		# Usual suspects
		assert_equal(@@UsualSuspectsEncoded,
			Reform.XmlEncode(nil, @@UsualSuspectsRaw), "Usual suspects via default")
		
		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.XmlEncode(nil, @@PunctuationRaw), "Punctuation via default")

		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.XmlEncode(nil, @@UTF8Raw), "Unicode characters to 6000 via default")
		
		# The following are sanity checks

		# Non encoded characters
		assert_equal(@@AlphaNumeric,
			Reform.XmlEncode(@@AlphaNumeric, "default"), "Non encoding chars")

		# Usual suspects
		assert_equal(@@UsualSuspectsEncoded,
			Reform.XmlEncode(@@UsualSuspectsRaw, "default"), "Usual suspects")
		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.XmlEncode(@@PunctuationRaw, "default"), "Punctuation")

		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.XmlEncode(@@UTF8Raw, "default"), "Unicode characters to 6000")
	end # END testXmlEncodeDefault  


	###############################
	#
	###############################
	def testXmlAttributeEncode()
		# Non encoded characters
		assert_equal(@@AlphaNumericAttribute,
			Reform.XmlAttributeEncode(@@AlphaNumericAttribute), "Non encoding chars")

		# Usual suspects
		assert_equal(@@UsualSuspectsEncodedAttribute,
			Reform.XmlAttributeEncode(@@UsualSuspectsRawAttribute), "Usual suspects")

		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.XmlAttributeEncode(@@PunctuationRaw), "Punctuation")
			
		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.XmlAttributeEncode(@@UTF8Raw), "Unicode characters to 6000")
	end #END testXmlAttributeEncode  

	###################################
	##
	###################################
	def testXmlAttributeEncodeDefault()
		assert_equal(nil,
			Reform.XmlAttributeEncode(nil, nil), "nil for both parameters")
		# Usual stuff
		assert_equal("default",
			Reform.XmlAttributeEncode(nil, "default"), "Checking default")

		# Non encoded characters
		assert_equal(@@AlphaNumericAttribute,
			Reform.XmlAttributeEncode(nil, @@AlphaNumericAttribute), "Non encoding chars via default")
		# Usual suspects
		assert_equal(@@UsualSuspectsEncodedAttribute,
			Reform.XmlAttributeEncode(nil, @@UsualSuspectsRawAttribute), "Usual suspects via default")
		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.XmlAttributeEncode(nil, @@PunctuationRaw), "Punctuation via default")

		assert_equal(@@UTF8Encoded,
			Reform.XmlAttributeEncode(nil, @@UTF8Raw), "Unicode characters to 6000 via default")

		# The following are sanity checks

		# Non encoded characters
		assert_equal(@@AlphaNumericAttribute,
			Reform.XmlAttributeEncode(@@AlphaNumericAttribute, "default"), "Non encoding chars")
		# Usual suspects
		assert_equal(@@UsualSuspectsEncodedAttribute,
			Reform.XmlAttributeEncode(@@UsualSuspectsRawAttribute, "default"), "Usual suspects")
		# Other characters
		assert_equal(@@PunctuationEncoded,
			Reform.XmlAttributeEncode(@@PunctuationRaw, "default"), "Punctuation")

		# Unicode characters
		assert_equal(@@UTF8Encoded,
			Reform.XmlAttributeEncode(@@UTF8Raw, "default"), "Unicode characters to 6000")
	end # END testXmlAttributeEncodeDefault   

	###################################
	#
	###################################

	def testJsString()
		# Non encoded characters
		assert_equal("'" + @@AlphaNumeric +  "'",
			Reform.JsString(@@AlphaNumeric), "Non encoding chars")

		# Usual suspects
		assert_equal("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
			Reform.JsString(@@UsualSuspectsRaw + "\\'"), "Usual suspects")

		# Other characters
		assert_equal("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
			Reform.JsString(@@PunctuationRaw), "Punctuation")

		# Unicode characters
		encodedStr = ''
		encodedStr += "'"
		(128..6000).each { |i|
			encodedStr += "\\u%04X" % i
		} 	
		encodedStr += "'"

		assert_equal(encodedStr,
			Reform.JsString(@@UTF8Raw[1..-1]), "Unicode characters to 6000")
	end # END testJsString  


	def testJsStringDefault()
		assert_equal("\'\'",
			Reform.JsString(nil, nil), "nil for both parameters")
		# Usual stuff
		assert_equal("'default'",
			Reform.JsString(nil, "default"), "Checking default")

		# Non encoded characters
		assert_equal( "'" + @@AlphaNumeric + "'",
			Reform.JsString(nil, @@AlphaNumeric), "Non encoding chars via default")
		# Usual suspects
		assert_equal("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
			Reform.JsString(nil, @@UsualSuspectsRaw + "\\'"), "Usual suspects via default")
		# Other characters
		assert_equal("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
			Reform.JsString(nil,  @@PunctuationRaw), "Punctuation via default")
		# Unicode characters
		encodedStr = ''
		encodedStr += "'"
		(128..6000).each{ |i|
			encodedStr += "\\u%04X" % i
		}	
		encodedStr += "'"
		assert_equal(encodedStr,
			Reform.JsString(nil, @@UTF8Raw[1..-1]), "Unicode characters to 6000 via default")

		# The following are sanity checks

		# Non encoded characters
		assert_equal("'" + @@AlphaNumeric +  "'",
			Reform.JsString(@@AlphaNumeric, "default"), "Non encoding chars")
		# Usual suspects
		assert_equal("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
			Reform.JsString(@@UsualSuspectsRaw + "\\'", "default"), "Usual suspects")
		# Other characters
		assert_equal("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
			Reform.JsString(@@PunctuationRaw, "default"), "Punctuation")
		# Unicode characters
		encodedStr = ''
		encodedStr += "'"
 		(128..6000).each { |i|
			encodedStr += "\\u%04X" % i
		} 	
		encodedStr += "'"
		assert_equal(encodedStr,
			Reform.JsString(@@UTF8Raw[1..-1], "default"), "Unicode characters to 6000")
	end #END testJsStringDefault

	###############################
	#
	###############################

	def testVbsString()
		assert_equal("\"abc\"&chrw(60)",
			Reform.VbsString("abc<"))
		assert_equal("chrw(60)&\"abc\"",
			Reform.VbsString("<abc"))

		# Non encoded characters
		assert_equal('"' + @@AlphaNumeric + '"',
			Reform.VbsString(@@AlphaNumeric ), "Non encoding chars")

		# Usual suspects
		assert_equal("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
			Reform.VbsString(@@UsualSuspectsRaw + "\\'"), "Usual suspects")

		# Other characters
		assert_equal("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
			Reform.VbsString(@@PunctuationRaw), "Punctuation")

		# Unicode characters
		encodedStr = ''
		(127..6000).each { |i|
			encodedStr += "&chrw(%d)" % i
		} 	
		encodedStr = encodedStr[1..-1] # remove &

		assert_equal(encodedStr,
			Reform.VbsString(@@UTF8Raw), "Unicode characters to 6000")

	end

	def testVbsStringDefault()
		assert_equal("\"\"", 
			Reform.VbsString(nil, nil), "nil for both parameters")
		assert_equal("\"abc\"&chrw(60)",
			Reform.VbsString(nil, "abc<"))
		assert_equal("chrw(60)&\"abc\"",
			Reform.VbsString(nil, "<abc"))

		# Usual stuff
		assert_equal("\"default\"",
			Reform.VbsString(nil, "default"), "Checking default")

		# Non encoded characters
		assert_equal( '"' + @@AlphaNumeric + '"',
			Reform.VbsString(nil, @@AlphaNumeric), "Non encoding chars via default")

		# Usual suspects
		assert_equal("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
			Reform.VbsString(nil, @@UsualSuspectsRaw + "\\'"), "Usual suspects via default")

		# Other characters
		assert_equal("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
			Reform.VbsString(nil, @@PunctuationRaw), "Punctuation via default")
		# Unicode characters
		toEncode = ''
		encodedStr = ''
		(127..6000).each { |i|
			encodedStr += "&chrw(%d)" % i
		} 	
		encodedStr = encodedStr[1..-1] # remove &
		assert_equal(encodedStr,
			Reform.VbsString(nil, @@UTF8Raw), "Unicode characters to 6000 via default")

		# The following are sanity checks

		# Non encoded characters
		assert_equal('"' + @@AlphaNumeric + '"',
			Reform.VbsString(@@AlphaNumeric, "default"), "Non encoding chars")
		# Usual suspects
		assert_equal("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
			Reform.VbsString(@@UsualSuspectsRaw + "\\'", "default"), "Usual suspects")
		# Other characters
		assert_equal("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
			Reform.VbsString(@@PunctuationRaw, "default"), "Punctuation")
		# Unicode characters
		encodedStr = ''
		(127..6000).each { |i|
			encodedStr += "&chrw(%d)" % i
		} 	
		encodedStr = encodedStr[1..-1] # remove &
		assert_equal(encodedStr,
			Reform.VbsString(@@UTF8Raw, "default"), "Unicode characters to 6000")
	end # END testVbsStringDefault 


end #end TestCase_HtmlEncode  

