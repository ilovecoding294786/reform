
/* 
 * Copyright (c) 2006 Michael Eddington
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy  
 * of this software and associated documentation files (the "Software"), to deal 
 * in the Software without restriction, including without limitation the rights  
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
 * copies of the Software, and to permit persons to whom the Software is  
 * furnished to do so, subject to the following conditions: 
 * 
 * The above copyright notice and this permission notice shall be included in  
 * all copies or substantial portions of the Software. 
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
 * SOFTWARE. 
 * 
 * Authors:
 *   Michael Eddington (meddington@phed.org)
 *
 * $Id: ReformTest.java,v 1.1 2006/11/05 10:13:39 meddingt Exp $
 */

package org.owasp.reform.test;

import junit.framework.JUnit4TestAdapter;
import org.junit.Assert.*;
import org.junit.*;
import org.owasp.reform.Reform;

public class ReformTest
{
	public static void main (String... args)
	{
		junit.textui.TestRunner.run (suite());
	}
	public static junit.framework.Test suite()
	{
		return new JUnit4TestAdapter(ReformTest.class);
	}
	
	@Test public void HtmlEncode()
	{
		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
			Reform.HtmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.HtmlEncode("<>&\""));
		// Other characters
		Assert.assertEquals("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.HtmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		
		Assert.assertEquals(encodedStr.toString(),
			Reform.HtmlEncode(toEncode.toString()));
	}

	@Test public void HtmlEncodeDefault()
	{
		// Usual stuff
		Assert.assertEquals("default", 
			Reform.HtmlEncode(null, "default"));

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
			Reform.HtmlEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.HtmlEncode(null, "<>&\""));
		// Other characters
		Assert.assertEquals("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.HtmlEncode(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.HtmlEncode(null, toEncode.toString()));
		
		// The following are sanity checks

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
			Reform.HtmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.HtmlEncode("<>&\"", "default"));
		// Other characters
		Assert.assertEquals("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.HtmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"));
		// Unicode characters
		toEncode = new StringBuffer(6000);
		encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.HtmlEncode(toEncode.toString(), "default"));
	}

	@Test public void HtmlAttributeEncode()
	{
		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
			Reform.HtmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.HtmlAttributeEncode("<>&\""));
		// Other characters
		Assert.assertEquals("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.HtmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.HtmlAttributeEncode(toEncode.toString()));
	}

	@Test public void HtmlAttributeEncodeDefault()
	{
		// Usual stuff
		Assert.assertEquals("default",
			Reform.HtmlAttributeEncode(null, "default"));

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
			Reform.HtmlAttributeEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.HtmlAttributeEncode(null, "<>&\""));
		// Other characters
		Assert.assertEquals("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.HtmlAttributeEncode(null, " ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.HtmlAttributeEncode(null, toEncode.toString()));

		// The following are sanity checks

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
			Reform.HtmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.HtmlAttributeEncode("<>&\"", "default"));
		// Other characters
		Assert.assertEquals("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.HtmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"));
		// Unicode characters
		toEncode = new StringBuffer(6000);
		encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.HtmlAttributeEncode(toEncode.toString(), "default"));
	}
	
	@Test public void XmlEncode()
	{
		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
			Reform.XmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.XmlEncode("<>&\""));
		// Other characters
		Assert.assertEquals("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.XmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.XmlEncode(toEncode.toString()));
	}
	
	@Test public void XmlEncodeDefault()
	{
		Assert.assertEquals("",
			Reform.XmlEncode(null, null));
		// Usual stuff
		Assert.assertEquals("default",
			Reform.XmlEncode(null, "default"));

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
			Reform.XmlEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.XmlEncode(null, "<>&\""));
		// Other characters
		Assert.assertEquals("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.XmlEncode(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.XmlEncode(null, toEncode.toString()));

		// The following are sanity checks

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
			Reform.XmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.XmlEncode("<>&\"", "default"));
		// Other characters
		Assert.assertEquals("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.XmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"));
		// Unicode characters
		toEncode = new StringBuffer(6000);
		encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.XmlEncode(toEncode.toString(), "default"));
	}
	
	@Test public void XmlAttributeEncode()
	{
		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
			Reform.XmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.XmlAttributeEncode("<>&\""));
		// Other characters
		Assert.assertEquals("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.XmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.XmlAttributeEncode(toEncode.toString()));
	}

	@Test public void XmlAttributeEncodeDefault()
	{
		Assert.assertEquals("",
			Reform.XmlAttributeEncode(null, null));
		// Usual stuff
		Assert.assertEquals("default",
			Reform.XmlAttributeEncode(null, "default"));

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
			Reform.XmlAttributeEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.XmlAttributeEncode(null, "<>&\""));
		// Other characters
		Assert.assertEquals("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.XmlAttributeEncode(null, " ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.XmlAttributeEncode(null, toEncode.toString()));

		// The following are sanity checks

		// Non encoded characters
		Assert.assertEquals("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
			Reform.XmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"));
		// Usual suspects
		Assert.assertEquals("&#60;&#62;&#38;&#34;",
			Reform.XmlAttributeEncode("<>&\"", "default"));
		// Other characters
		Assert.assertEquals("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
			Reform.XmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"));
		// Unicode characters
		toEncode = new StringBuffer(6000);
		encodedStr = new StringBuffer(42000);
		for (int i = 127; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&#").append((int)i).append(';');
		}
		Assert.assertEquals(encodedStr.toString(),
			Reform.XmlAttributeEncode(toEncode.toString(), "default"));
	}

	@Test public void JsString()
	{
		// Non encoded characters
		Assert.assertEquals("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
			Reform.JsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("'\\x3c\\x3e\\x26\\x22\\x5c\\x27'",
			Reform.JsString("<>&\"\\'"));
		// Other characters
		Assert.assertEquals("'\\x60\\x7e\\x21\\x40\\x23\\x24\\x25\\x5e\\x26\\x2a\\x28\\x29\\x5f\\x2b\\x3d\\x2d\\x7b\\x7d\\x7c\\x5c\\x5d\\x5b\\x3a\\x3b\\x27\\x2f\\x3f\\x3e\\x3c'",
			Reform.JsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		encodedStr.append('\'');
		for (int i = 128; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("\\u");
			String hex = Integer.toString(i, 16);
			for(int x = hex.length(); x<4; x++)
			{
				encodedStr.append('0');
			}
			encodedStr.append(hex);
		}
		encodedStr.append('\'');
		Assert.assertEquals(encodedStr.toString(),
			Reform.JsString(toEncode.toString()));
	}

	@Test public void JsStringDefault()
	{
		Assert.assertEquals("\'\'",
			Reform.JsString(null, null));
		// Usual stuff
		Assert.assertEquals("'default'",
			Reform.JsString(null, "default"));

		// Non encoded characters
		Assert.assertEquals("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
			Reform.JsString(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("'\\x3c\\x3e\\x26\\x22\\x5c\\x27'",
			Reform.JsString(null, "<>&\"\\'"));
		// Other characters
		Assert.assertEquals("'\\x60\\x7e\\x21\\x40\\x23\\x24\\x25\\x5e\\x26\\x2a\\x28\\x29\\x5f\\x2b\\x3d\\x2d\\x7b\\x7d\\x7c\\x5c\\x5d\\x5b\\x3a\\x3b\\x27\\x2f\\x3f\\x3e\\x3c'",
			Reform.JsString(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		encodedStr.append('\'');
		for (int i = 128; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("\\u");
			String hex = Integer.toString(i, 16);
			for(int x = hex.length(); x<4; x++)
			{
				encodedStr.append('0');
			}
			encodedStr.append(hex);
		}
		encodedStr.append('\'');
		Assert.assertEquals(encodedStr.toString(),
			Reform.JsString(null, toEncode.toString()));

		// The following are sanity checks

		// Non encoded characters
		Assert.assertEquals("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
			Reform.JsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"));
		// Usual suspects
		Assert.assertEquals("'\\x3c\\x3e\\x26\\x22\\x5c\\x27'",
			Reform.JsString("<>&\"\\'", "default"));
		// Other characters
		Assert.assertEquals("'\\x60\\x7e\\x21\\x40\\x23\\x24\\x25\\x5e\\x26\\x2a\\x28\\x29\\x5f\\x2b\\x3d\\x2d\\x7b\\x7d\\x7c\\x5c\\x5d\\x5b\\x3a\\x3b\\x27\\x2f\\x3f\\x3e\\x3c'",
			Reform.JsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"));
		// Unicode characters
		toEncode = new StringBuffer(6000);
		encodedStr = new StringBuffer(42000);
		encodedStr.append('\'');
		for (int i = 128; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("\\u");
			String hex = Integer.toString(i, 16);
			for(int x = hex.length(); x<4; x++)
			{
				encodedStr.append('0');
			}
			encodedStr.append(hex);
		}
		encodedStr.append('\'');
		Assert.assertEquals(encodedStr.toString(),
			Reform.JsString(toEncode.toString(), "default"));
	}
	
	@Test public void VbsString()
	{
		Assert.assertEquals("\"abc\"&chrw(60)",
			Reform.VbsString("abc<"));
		Assert.assertEquals("chrw(60)&\"abc\"",
			Reform.VbsString("<abc"));
		// Non encoded characters
		Assert.assertEquals("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
			Reform.VbsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
			Reform.VbsString("<>&\"\\'"));
		// Other characters
		Assert.assertEquals("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
			Reform.VbsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 128; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&chrw(").append(i).append(')');
		}
		encodedStr.delete(0, 1); // delete &

		Assert.assertEquals(encodedStr.toString(),
			Reform.VbsString(toEncode.toString()));
	}

	@Test public void VbsStringDefault()
	{
		Assert.assertEquals("\"\"", 
			Reform.VbsString(null, null));
		Assert.assertEquals("\"abc\"&chrw(60)",
			Reform.VbsString(null, "abc<"));
		Assert.assertEquals("chrw(60)&\"abc\"",
			Reform.VbsString(null, "<abc"));
		// Usual stuff
		Assert.assertEquals("\"default\"",
			Reform.VbsString(null, "default"));

		// Non encoded characters
		Assert.assertEquals("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
			Reform.VbsString(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."));
		// Usual suspects
		Assert.assertEquals("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
			Reform.VbsString(null, "<>&\"\\'"));
		// Other characters
		Assert.assertEquals("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
			Reform.VbsString(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"));
		// Unicode characters
		StringBuffer toEncode = new StringBuffer(6000);
		StringBuffer encodedStr = new StringBuffer(42000);
		for (int i = 128; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&chrw(").append(i).append(')');
		}
		encodedStr.delete(0, 1); // delete &
		Assert.assertEquals(encodedStr.toString(),
			Reform.VbsString(null, toEncode.toString()));

		// The following are sanity checks

		// Non encoded characters
		Assert.assertEquals("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
			Reform.VbsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"));
		// Usual suspects
		Assert.assertEquals("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
			Reform.VbsString("<>&\"\\'", "default"));
		// Other characters
		Assert.assertEquals("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
			Reform.VbsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"));
		// Unicode characters
		toEncode = new StringBuffer(6000);
		encodedStr = new StringBuffer(42000);
		for (int i = 128; i < 6000; i++)
		{
			toEncode.append((char)i);
			encodedStr.append("&chrw(").append(i).append(')');
		}
		encodedStr.delete(0, 1); // delete &
		Assert.assertEquals(encodedStr.toString(),
			Reform.VbsString(toEncode.toString(), "default"));
	}
}

// end
