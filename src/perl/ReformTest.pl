
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
#   Michael Eddington (meddington@phed.org)

# $Id$

package Owasp::Owasp::Reform::Test;

require "Reform.pm";
use base qw(Test::Class);
use Test::More;
use warnings;
use utf8;

sub HtmlEncode : Test(4)
{
	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
		Owasp::Reform::HtmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::HtmlEncode("<>&\""), "Usual suspects");
	# Other characters
	is("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::HtmlEncode('`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::HtmlEncode($toEncode), "Unicode characters to 6000");
}

sub testHtmlEncodeDefault : Test(9)
{
	# Usual stuff
	is("default", 
		Owasp::Reform::HtmlEncode(undef, "default"), "Checking default");

	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
		Owasp::Reform::HtmlEncode(undef, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::HtmlEncode(undef, "<>&\""), "Usual suspects via default");
	# Other characters
	is("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::HtmlEncode(undef, '`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation via default");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode = chr($i);
		$encodedStr = "&#$i;";
	}
	
	is($encodedStr,
		Owasp::Reform::HtmlEncode(undef, $toEncode), "Unicode characters to 6000 via default");
	
	# The following are sanity checks

	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
		Owasp::Reform::HtmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::HtmlEncode("<>&\"", "default"), "Usual suspects");
	# Other characters
	is("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::HtmlEncode('`~!@#$%^&*()_+=-{}|\\][:;\'/?><', "default"), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::HtmlEncode($toEncode, "default"), "Unicode characters to 6000");
}

sub testHtmlAttributeEncode : Test(4)
{
	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
		Owasp::Reform::HtmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::HtmlAttributeEncode("<>&\""), "Usual suspects");
	# Other characters
	is("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::HtmlAttributeEncode(' ,.`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::HtmlAttributeEncode($toEncode), "Unicode characters to 6000");
}

sub testHtmlAttributeEncodeDefault : Test(9)
{
	# Usual stuff
	is("default",
		Owasp::Reform::HtmlAttributeEncode(undef, "default"), "Checking default");

	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
		Owasp::Reform::HtmlAttributeEncode(undef, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars via default");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::HtmlAttributeEncode(undef, "<>&\""), "Usual suspects via default");
	# Other characters
	is("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::HtmlAttributeEncode(undef, ' ,.`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation via default");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::HtmlAttributeEncode(undef, $toEncode), "Unicode characters to 6000 via default");

	# The following are sanity checks

	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
		Owasp::Reform::HtmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::HtmlAttributeEncode("<>&\"", "default"), "Usual suspects");
	# Other characters
	is("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::HtmlAttributeEncode(' ,.`~!@#$%^&*()_+=-{}|\\][:;\'/?><', "default"), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::HtmlAttributeEncode($toEncode, "default"), "Unicode characters to 6000");
}

sub testXmlEncode : Test(4)
{
	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
		Owasp::Reform::XmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::XmlEncode("<>&\""), "Usual suspects");
	# Other characters
	is("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::XmlEncode('`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::XmlEncode($toEncode), "Unicode characters to 6000");
}

sub testXmlEncodeDefault : Test(10)
{
	is("",
		Owasp::Reform::XmlEncode(undef, undef), "undef for both parameters");
	# Usual stuff
	is("default",
		Owasp::Reform::XmlEncode(undef, "default"), "Checking default");

	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
		Owasp::Reform::XmlEncode(undef, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::XmlEncode(undef, "<>&\""), "Usual suspects via default");
	# Other characters
	is("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::XmlEncode(undef, '`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation via default");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::XmlEncode(undef, $toEncode), "Unicode characters to 6000 via default");
	
	# The following are sanity checks
	
	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
		Owasp::Reform::XmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::XmlEncode("<>&\"", "default"), "Usual suspects");
	# Other characters
	is("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::XmlEncode('`~!@#$%^&*()_+=-{}|\\][:;\'/?><', "default"), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::XmlEncode($toEncode, "default"), "Unicode characters to 6000");
}

sub testXmlAttributeEncode : Test(4)
{
	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
		Owasp::Reform::XmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::XmlAttributeEncode("<>&\""), "Usual suspects");
	# Other characters
	is("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::XmlAttributeEncode(' ,.`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::XmlAttributeEncode($toEncode), "Unicode characters to 6000");
}

sub testXmlAttributeEncodeDefault : Test(10)
{
	is("",
		Owasp::Reform::XmlAttributeEncode(undef, undef), "undef for both parameters");
	# Usual stuff
	is("default",
		Owasp::Reform::XmlAttributeEncode(undef, "default"), "Checking default");

	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
		Owasp::Reform::XmlAttributeEncode(undef, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars via default");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::XmlAttributeEncode(undef, "<>&\""), "Usual suspects via default");
	# Other characters
	is("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::XmlAttributeEncode(undef, ' ,.`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation via default");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::XmlAttributeEncode(undef, $toEncode), "Unicode characters to 6000 via default");

	# The following are sanity checks

	# Non encoded characters
	is("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
		Owasp::Reform::XmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"), "Non encoding chars");
	# Usual suspects
	is("&#60;&#62;&#38;&#34;",
		Owasp::Reform::XmlAttributeEncode("<>&\"", "default"), "Usual suspects");
	# Other characters
	is("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
		Owasp::Reform::XmlAttributeEncode(' ,.`~!@#$%^&*()_+=-{}|\\][:;\'/?><', "default"), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 127; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= "&#$i;";
	}
	is($encodedStr,
		Owasp::Reform::XmlAttributeEncode($toEncode, "default"), "Unicode characters to 6000");
}

sub testJsString : Test(4)
{
	# Non encoded characters
	is("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
		Owasp::Reform::JsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
	# Usual suspects
	is("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
		Owasp::Reform::JsString("<>&\"\\'"), "Usual suspects");
	# Other characters
	is("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
		Owasp::Reform::JsString('`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	$encodedStr .= "'";
	for ($i = 128; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= sprintf("\\u%04X", $i);
		
	}
	$encodedStr .= "'";
	is($encodedStr,
		Owasp::Reform::JsString($toEncode), "Unicode characters to 6000");
}

sub testJsStringDefault : Test(10)
{
	is("''",
		Owasp::Reform::JsString(undef, undef), "undef for both parameters");
	# Usual stuff
	is("'default'",
		Owasp::Reform::JsString(undef, "default"), "Checking default");

	# Non encoded characters
	is("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
		Owasp::Reform::JsString(undef, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
	# Usual suspects
	is("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
		Owasp::Reform::JsString(undef, "<>&\"\\'"), "Usual suspects via default");
	# Other characters
	is("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
		Owasp::Reform::JsString(undef, '`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation via default");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	$encodedStr .= '\'';
	for ($i = 128; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= sprintf("\\u%04X", $i);
	}
	$encodedStr .= '\'';
	is($encodedStr,
		Owasp::Reform::JsString(undef, $toEncode), "Unicode characters to 6000 via default");

	# The following are sanity checks

	# Non encoded characters
	is("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
		Owasp::Reform::JsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
	# Usual suspects
	is("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
		Owasp::Reform::JsString("<>&\"\\'", "default"), "Usual suspects");
	# Other characters
	is("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
		Owasp::Reform::JsString('`~!@#$%^&*()_+=-{}|\\][:;\'/?><', "default"), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	$encodedStr .= '\'';
	for ($i = 128; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= sprintf("\\u%04X", $i);
	}
	$encodedStr .= '\'';
	is($encodedStr,
		Owasp::Reform::JsString($toEncode, "default"), "Unicode characters to 6000");
}

sub testVbsString : Test(6)
{
	is("\"abc\"&chrw(60)",
		Owasp::Reform::VbsString("abc<"));
	is("chrw(60)&\"abc\"",
		Owasp::Reform::VbsString("<abc"));
	# Non encoded characters
	is("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
		Owasp::Reform::VbsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
	# Usual suspects
	is("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
		Owasp::Reform::VbsString("<>&\"\\'"), "Usual suspects");
	# Other characters
	is("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
		Owasp::Reform::VbsString('`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 128; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= sprintf("&chrw(%d)", $i);
	}
	
	$encodedStr = substr($encodedStr, 1); # remove &

	is($encodedStr,
		Owasp::Reform::VbsString($toEncode), "Unicode characters to 6000");
}

sub testVbsStringDefault : Test(12)
{
	is("\"\"", 
		Owasp::Reform::VbsString(undef, undef), "undef for both parameters");
	is("\"abc\"&chrw(60)",
		Owasp::Reform::VbsString(undef, "abc<"));
	is("chrw(60)&\"abc\"",
		Owasp::Reform::VbsString(undef, "<abc"));
	# Usual stuff
	is("\"default\"",
		Owasp::Reform::VbsString(undef, "default"), "Checking default");

	# Non encoded characters
	is("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
		Owasp::Reform::VbsString(undef, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
	# Usual suspects
	is("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
		Owasp::Reform::VbsString(undef, "<>&\"\\'"), "Usual suspects via default");
	# Other characters
	is("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
		Owasp::Reform::VbsString(undef, '`~!@#$%^&*()_+=-{}|\\][:;\'/?><'), "Punctuation via default");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 128; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= sprintf("&chrw(%d)", $i);
	}
	$encodedStr = substr($encodedStr, 1); # remove &
	
	is($encodedStr,
		Owasp::Reform::VbsString(undef, $toEncode), "Unicode characters to 6000 via default");

	# The following are sanity checks

	# Non encoded characters
	is("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
		Owasp::Reform::VbsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
	# Usual suspects
	is("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
		Owasp::Reform::VbsString("<>&\"\\'", "default"), "Usual suspects");
	# Other characters
	is("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
		Owasp::Reform::VbsString('`~!@#$%^&*()_+=-{}|\\][:;\'/?><', "default"), "Punctuation");
	# Unicode characters
	$toEncode = "";
	$encodedStr = "";
	for ($i = 128; $i < 6000; $i++)
	{
		$toEncode .= chr($i);
		$encodedStr .= sprintf("&chrw(%d)", $i);
	}
	$encodedStr = substr($encodedStr, 1); # remove &
	is($encodedStr,
		Owasp::Reform::VbsString($toEncode, "default"), "Unicode characters to 6000");
}

package main;

Test::Class->runtests;
# end
