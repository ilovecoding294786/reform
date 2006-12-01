
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
 * $Id$
 */

using System;
using System.Text;
using NUnit.Framework;
using Owasp.Reform;

namespace Owasp.Reform.Test
{
	[TestFixture]
	public class ReformTest
	{
		[Test]
		public void HtmlEncode()
		{
			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
				Reform.HtmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.HtmlEncode("<>&\""), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.HtmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.HtmlEncode(toEncode.ToString()), "Unicode characters to 6000");
		}

		[Test]
		public void HtmlEncodeDefault()
		{
			// Usual stuff
			Assert.AreEqual("default", 
				Reform.HtmlEncode(null, "default"), "Checking default");

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
				Reform.HtmlEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.HtmlEncode(null, "<>&\""), "Usual suspects via default");
			// Other characters
			Assert.AreEqual("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.HtmlEncode(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation via default");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.HtmlEncode(null, toEncode.ToString()), "Unicode characters to 6000 via default");
			
			// The following are sanity checks

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
				Reform.HtmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.HtmlEncode("<>&\"", "default"), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.HtmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"), "Punctuation");
			// Unicode characters
			toEncode = new StringBuilder(6000);
			encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.HtmlEncode(toEncode.ToString(), "default"), "Unicode characters to 6000");
		}

		[Test]
		public void HtmlAttributeEncode()
		{
			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
				Reform.HtmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.HtmlAttributeEncode("<>&\""), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.HtmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.HtmlAttributeEncode(toEncode.ToString()), "Unicode characters to 6000");
		}

		[Test]
		public void HtmlAttributeEncodeDefault()
		{
			// Usual stuff
			Assert.AreEqual("default",
				Reform.HtmlAttributeEncode(null, "default"), "Checking default");

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
				Reform.HtmlAttributeEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars via default");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.HtmlAttributeEncode(null, "<>&\""), "Usual suspects via default");
			// Other characters
			Assert.AreEqual("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.HtmlAttributeEncode(null, " ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation via default");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.HtmlAttributeEncode(null, toEncode.ToString()), "Unicode characters to 6000 via default");

			// The following are sanity checks

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
				Reform.HtmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.HtmlAttributeEncode("<>&\"", "default"), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.HtmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"), "Punctuation");
			// Unicode characters
			toEncode = new StringBuilder(6000);
			encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.HtmlAttributeEncode(toEncode.ToString(), "default"), "Unicode characters to 6000");
		}
		[Test]
		public void XmlEncode()
		{
			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
				Reform.XmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.XmlEncode("<>&\""), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.XmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.XmlEncode(toEncode.ToString()), "Unicode characters to 6000");
		}

		[Test]
		public void XmlEncodeDefault()
		{
			Assert.AreEqual("",
				Reform.XmlEncode(null, null), "Null for both parameters");
			// Usual stuff
			Assert.AreEqual("default",
				Reform.XmlEncode(null, "default"), "Checking default");

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
				Reform.XmlEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.XmlEncode(null, "<>&\""), "Usual suspects via default");
			// Other characters
			Assert.AreEqual("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.XmlEncode(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation via default");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.XmlEncode(null, toEncode.ToString()), "Unicode characters to 6000 via default");

			// The following are sanity checks

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.",
				Reform.XmlEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.XmlEncode("<>&\"", "default"), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.XmlEncode("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"), "Punctuation");
			// Unicode characters
			toEncode = new StringBuilder(6000);
			encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.XmlEncode(toEncode.ToString(), "default"), "Unicode characters to 6000");
		}


		[Test]
		public void XmlAttributeEncode()
		{
			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
				Reform.XmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.XmlAttributeEncode("<>&\""), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.XmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.XmlAttributeEncode(toEncode.ToString()), "Unicode characters to 6000");
		}

		[Test]
		public void XmlAttributeEncodeDefault()
		{
			Assert.AreEqual("",
				Reform.XmlAttributeEncode(null, null), "Null for both parameters");
			// Usual stuff
			Assert.AreEqual("default",
				Reform.XmlAttributeEncode(null, "default"), "Checking default");

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
				Reform.XmlAttributeEncode(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321"), "Non encoding chars via default");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.XmlAttributeEncode(null, "<>&\""), "Usual suspects via default");
			// Other characters
			Assert.AreEqual("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.XmlAttributeEncode(null, " ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation via default");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.XmlAttributeEncode(null, toEncode.ToString()), "Unicode characters to 6000 via default");

			// The following are sanity checks

			// Non encoded characters
			Assert.AreEqual("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321",
				Reform.XmlAttributeEncode("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321", "default"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("&#60;&#62;&#38;&#34;",
				Reform.XmlAttributeEncode("<>&\"", "default"), "Usual suspects");
			// Other characters
			Assert.AreEqual("&#32;&#44;&#46;&#96;&#126;&#33;&#64;&#35;&#36;&#37;&#94;&#38;&#42;&#40;&#41;&#95;&#43;&#61;&#45;&#123;&#125;&#124;&#92;&#93;&#91;&#58;&#59;&#39;&#47;&#63;&#62;&#60;",
				Reform.XmlAttributeEncode(" ,.`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"), "Punctuation");
			// Unicode characters
			toEncode = new StringBuilder(6000);
			encodedStr = new StringBuilder(42000);
			for (uint i = 127; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append("&#").Append((int)i).Append(';');
			}
			Assert.AreEqual(encodedStr.ToString(),
				Reform.XmlAttributeEncode(toEncode.ToString(), "default"), "Unicode characters to 6000");
		}

		[Test]
		public void JsString()
		{
			// Non encoded characters
			Assert.AreEqual("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
				Reform.JsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
				Reform.JsString("<>&\"\\'"), "Usual suspects");
			// Other characters
			Assert.AreEqual("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
				Reform.JsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			encodedStr.Append('\'');
			for (uint i = 128; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append(String.Format("\\u{0:X4}", (int)i));
			}
			encodedStr.Append('\'');
			Assert.AreEqual(encodedStr.ToString(),
				Reform.JsString(toEncode.ToString()), "Unicode characters to 6000");
		}

		[Test]
		public void JsStringDefault()
		{
			Assert.AreEqual("\'\'",
				Reform.JsString(null, null), "Null for both parameters");
			// Usual stuff
			Assert.AreEqual("'default'",
				Reform.JsString(null, "default"), "Checking default");

			// Non encoded characters
			Assert.AreEqual("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
				Reform.JsString(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
			// Usual suspects
			Assert.AreEqual("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
				Reform.JsString(null, "<>&\"\\'"), "Usual suspects via default");
			// Other characters
			Assert.AreEqual("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
				Reform.JsString(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation via default");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			encodedStr.Append('\'');
			for (uint i = 128; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append(String.Format("\\u{0:X4}", (int)i));
			}
			encodedStr.Append('\'');
			Assert.AreEqual(encodedStr.ToString(),
				Reform.JsString(null, toEncode.ToString()), "Unicode characters to 6000 via default");

			// The following are sanity checks

			// Non encoded characters
			Assert.AreEqual("'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.'",
				Reform.JsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("'\\x3C\\x3E\\x26\\x22\\x5C\\x27'",
				Reform.JsString("<>&\"\\'", "default"), "Usual suspects");
			// Other characters
			Assert.AreEqual("'\\x60\\x7E\\x21\\x40\\x23\\x24\\x25\\x5E\\x26\\x2A\\x28\\x29\\x5F\\x2B\\x3D\\x2D\\x7B\\x7D\\x7C\\x5C\\x5D\\x5B\\x3A\\x3B\\x27\\x2F\\x3F\\x3E\\x3C'",
				Reform.JsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"), "Punctuation");
			// Unicode characters
			toEncode = new StringBuilder(6000);
			encodedStr = new StringBuilder(42000);
			encodedStr.Append('\'');
			for (uint i = 128; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append(String.Format("\\u{0:X4}", (int)i));
			}
			encodedStr.Append('\'');
			Assert.AreEqual(encodedStr.ToString(),
				Reform.JsString(toEncode.ToString(), "default"), "Unicode characters to 6000");
		}
		[Test]
		public void VbsString()
		{
			Assert.AreEqual("\"abc\"&chrw(60)",
				Reform.VbsString("abc<"));
			Assert.AreEqual("chrw(60)&\"abc\"",
				Reform.VbsString("<abc"));
			// Non encoded characters
			Assert.AreEqual("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
				Reform.VbsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
				Reform.VbsString("<>&\"\\'"), "Usual suspects");
			// Other characters
			Assert.AreEqual("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
				Reform.VbsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 128; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append(String.Format("&chrw({0})", (int)i));
			}
			encodedStr.Remove(0, 1); // remove &

			Assert.AreEqual(encodedStr.ToString(),
				Reform.VbsString(toEncode.ToString()), "Unicode characters to 6000");
		}

		[Test]
		public void VbsStringDefault()
		{
			Assert.AreEqual("\"\"", 
				Reform.VbsString(null, null), "Null for both parameters");
			Assert.AreEqual("\"abc\"&chrw(60)",
				Reform.VbsString(null, "abc<"));
			Assert.AreEqual("chrw(60)&\"abc\"",
				Reform.VbsString(null, "<abc"));
			// Usual stuff
			Assert.AreEqual("\"default\"",
				Reform.VbsString(null, "default"), "Checking default");

			// Non encoded characters
			Assert.AreEqual("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
				Reform.VbsString(null, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,."), "Non encoding chars via default");
			// Usual suspects
			Assert.AreEqual("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
				Reform.VbsString(null, "<>&\"\\'"), "Usual suspects via default");
			// Other characters
			Assert.AreEqual("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
				Reform.VbsString(null, "`~!@#$%^&*()_+=-{}|\\][:;'/?><"), "Punctuation via default");
			// Unicode characters
			StringBuilder toEncode = new StringBuilder(6000);
			StringBuilder encodedStr = new StringBuilder(42000);
			for (uint i = 128; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append(String.Format("&chrw({0})", (int)i));
			}
			encodedStr.Remove(0, 1); // remove &
			Assert.AreEqual(encodedStr.ToString(),
				Reform.VbsString(null, toEncode.ToString()), "Unicode characters to 6000 via default");

			// The following are sanity checks

			// Non encoded characters
			Assert.AreEqual("\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.\"",
				Reform.VbsString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0987654321 ,.", "default"), "Non encoding chars");
			// Usual suspects
			Assert.AreEqual("chrw(60)&chrw(62)&chrw(38)&chrw(34)&chrw(92)&chrw(39)",
				Reform.VbsString("<>&\"\\'", "default"), "Usual suspects");
			// Other characters
			Assert.AreEqual("chrw(96)&chrw(126)&chrw(33)&chrw(64)&chrw(35)&chrw(36)&chrw(37)&chrw(94)&chrw(38)&chrw(42)&chrw(40)&chrw(41)&chrw(95)&chrw(43)&chrw(61)&chrw(45)&chrw(123)&chrw(125)&chrw(124)&chrw(92)&chrw(93)&chrw(91)&chrw(58)&chrw(59)&chrw(39)&chrw(47)&chrw(63)&chrw(62)&chrw(60)",
				Reform.VbsString("`~!@#$%^&*()_+=-{}|\\][:;'/?><", "default"), "Punctuation");
			// Unicode characters
			toEncode = new StringBuilder(6000);
			encodedStr = new StringBuilder(42000);
			for (uint i = 128; i < 6000; i++)
			{
				toEncode.Append((char)i);
				encodedStr.Append(String.Format("&chrw({0})", (int)i));
			}
			encodedStr.Remove(0, 1); // remove &
			Assert.AreEqual(encodedStr.ToString(),
				Reform.VbsString(toEncode.ToString(), "default"), "Unicode characters to 6000");
		}
	}
}
