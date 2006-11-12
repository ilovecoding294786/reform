
/* 
 * Copyright (c) 2005-2006 Michael Eddington
 * Copyright (c) 2004-2005 IOActive Inc. 
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
 * $Id: Reform.cs,v 1.5 2006/11/06 06:03:19 meddingt Exp $
 */

using System;
using System.Text;

namespace Owasp.Reform
{
	public sealed class Reform
	{
		/// <summary>
		/// The HtmlEncode function takes in a string and 
		/// performs HTML encoding using the &amp;#NN; style 
		/// encoding where NN is the decimal number of the 
		/// character.  The encoding style is the same for 
		/// both Unicode and non Unicode characters.
		/// </summary>
		/// <param name="str">String to encode</param>
		/// <returns>Encoded string</returns>
		public static string HtmlEncode(string str)
		{
			return HtmlEncode(str, null);
		}
		/// <summary>
		/// The HtmlEncode function takes in a string and 
		/// performs HTML encoding using the &amp;#NN; style 
		/// encoding where NN is the decimal number of the 
		/// character.  The encoding style is the same for 
		/// both Unicode and non Unicode characters.
		/// </summary>
		/// <param name="str">[in] String to encode.  If string 
		/// is null then default is used.</param>
		/// <param name="def">[in] A default value to 
		/// use (will be encoded) if string is null.  If default 
		/// is not specified then an empty string will be used 
		/// instead.</param>
		/// <returns>Encoded string</returns>
		public static string HtmlEncode(string str, string def)
		{
			if(str == null || str.Length == 0)
			{
				str = (def == null ? "" : def);
			}
		
			int len = str.Length;
			StringBuilder outBuff = new StringBuilder((int)(len*1.5));
		
			// Allow: a-z A-Z 0-9 SPACE , .
			// Allow (dec): 97-122 65-90 48-57 32 44 46
		
			for(int cnt = 0; cnt < len; cnt++)
			{
				char c = str[cnt];
				if( (c >= 97 && c <= 122) ||
					(c >= 65 && c <= 90 ) ||
					(c >= 48 && c <= 57 ) ||
					c == 32 || c == 44 || c == 46 )
				{
					outBuff.Append(c);
				}
				else
				{
					outBuff.Append("&#").Append((int)c).Append(';');
				}
			}
		
			return outBuff.ToString();
		}
	
		/// <summary>
		/// The HtmlAttributeEncode function takes in a string and 
		/// performs HTML encoding using the &amp;#NN; style encoding 
		/// where NN is the decimal number of the character.  The 
		/// encoding style is the same for both Unicode and non 
		/// Unicode characters.
		/// 
		/// The HtmlAttributeEncode function differs from HtmlEncode 
		/// function due to a more restrictive encoding policy which 
		/// includes the SPACE character.  This is to prevent 
		/// vulnerabilities caused by failure to wrap the HTML 
		/// attribute in quotation marks.
		/// </summary>
		/// <param name="str">[in] String to encode.</param>
		/// <returns>Encoded string</returns>
		public static string HtmlAttributeEncode(string str)
		{
			return HtmlAttributeEncode(str, null);
		}
		/// <summary>
		/// The HtmlAttributeEncode function takes in a string and 
		/// performs HTML encoding using the &amp;#NN; style encoding 
		/// where NN is the decimal number of the character.  The 
		/// encoding style is the same for both Unicode and non 
		/// Unicode characters.
		/// 
		/// The HtmlAttributeEncode function differs from HtmlEncode 
		/// function due to a more restrictive encoding policy which 
		/// includes the SPACE character.  This is to prevent 
		/// vulnerabilities caused by failure to wrap the HTML 
		/// attribute in quotation marks.
		/// </summary>
		/// <param name="str">[in] String to encode.  If string is 
		/// null then default is used.</param>
		/// <param name="def">[in] A default value to use (will be 
		/// encoded) if string is null.  If default is not specified 
		/// then an empty string will be used instead.</param>
		/// <returns>Encoded string</returns>
		public static string HtmlAttributeEncode(string str, string def)
		{
			if(str == null || str.Length == 0)
			{
				str = (def == null ? "" : def);
			}
		
			int len = str.Length;
			StringBuilder outBuff = new StringBuilder((int)(len*1.5));
		
			// Allow: a-z A-Z 0-9
			// Allow (dec): 97-122 65-90 48-57
		
			for(int cnt = 0; cnt < len; cnt++)
			{
				char c = str[cnt];
				if( (c >= 97 && c <= 122) ||
					(c >= 65 && c <= 90 ) ||
					(c >= 48 && c <= 57 ) )
				{
					outBuff.Append(c);
				}
				else
				{
					outBuff.Append("&#").Append((int)c).Append(';');
				}
			}
		
			return outBuff.ToString();
		}
	
		/// <summary>
		/// The XmlEncode function takes in a string and performs XML 
		/// encoding using the &amp;#NN; style encoding where NN is the 
		/// decimal number of the character.  The encoding style is 
		/// the same for both Unicode and non Unicode characters.
		/// </summary>
		/// <param name="str">[in] String to encode.</param>
		/// <returns>Encoded string</returns>
		public static string XmlEncode(string str)
		{
			return HtmlEncode(str, null);
		}
		/// <summary>
		/// The XmlEncode function takes in a string and performs XML 
		/// encoding using the &amp;#NN; style encoding where NN is the 
		/// decimal number of the character.  The encoding style is 
		/// the same for both Unicode and non Unicode characters.
		/// </summary>
		/// <param name="str">[in] String to encode.  If string is 
		/// null then default is used.</param>
		/// <param name="def">[in] A default value to use (will be 
		/// encoded) if string is null.  If default is not specified 
		/// (null) then an empty string will be used instead.</param>
		/// <returns>Encoded string</returns>
		public static string XmlEncode(string str, string def)
		{
			return HtmlEncode(str, def);
		}
	
		/// <summary>
		/// The XmlAttributeEncode function takes in a string and 
		/// performs XML encoding using the &amp;#NN; style encoding 
		/// where NN is the decimal number of the character.  The 
		/// encoding style is the same for both Unicode and non 
		/// Unicode characters.
		/// 
		/// The XmlAttributeEncode function differs from XmlEncode
		/// function due to a more restrictive encoding policy 
		/// which includes the SPACE character.  This is to prevent
		/// vulnerabilities caused by failure to wrap the XML 
		/// attribute in quotation marks.
		/// </summary>
		/// <param name="str">[in] String to encode.</param>
		/// <returns>Encoded string</returns>
		public static string XmlAttributeEncode(string str)
		{
			return HtmlAttributeEncode(str, null);
		}
		/// <summary>
		/// The XmlAttributeEncode function takes in a string and 
		/// performs XML encoding using the &amp;#NN; style encoding 
		/// where NN is the decimal number of the character.  The 
		/// encoding style is the same for both Unicode and non 
		/// Unicode characters.
		/// 
		/// The XmlAttributeEncode function differs from XmlEncode
		/// function due to a more restrictive encoding policy 
		/// which includes the SPACE character.  This is to prevent
		/// vulnerabilities caused by failure to wrap the XML 
		/// attribute in quotation marks.
		/// </summary>
		/// <param name="str">[in] String to encode.  If string is 
		/// null then default is used.</param>
		/// <param name="def">[in] A default value to use (will be 
		/// encoded) if string is null.  If default is not specified
		/// then an empty string will be used instead.</param>
		/// <returns>Encoded string</returns>
		public static string XmlAttributeEncode(string str, string def)
		{
			return HtmlAttributeEncode(str, def);
		}
	
		/// <summary>
		/// The JsString function creates a literal JavaScript 
		/// string.  This means the output from this function is 
		/// actually wrapped in quotation marks.  Encoded characters
		/// are encoded using the \xNN and \uNNNN syntax where the 
		/// ‘u’ indicates a UCS-2 encoded Unicode character and 
		/// NN/NNNN is the hex number of the encoded character.
		/// </summary>
		/// <param name="str">[in] String to encode.</param>
		/// <returns>Encoded string</returns>
		public static string JsString(string str)
		{
			return JsString(str, null);
		}
		/// <summary>
		/// The JsString function creates a literal JavaScript 
		/// string.  This means the output from this function is 
		/// actually wrapped in quotation marks.  Encoded characters
		/// are encoded using the \xNN and \uNNNN syntax where the 
		/// ‘u’ indicates a UCS-2 encoded Unicode character and 
		/// NN/NNNN is the hex number of the encoded character.
		/// </summary>
		/// <param name="str">[in] String to encode.  If string is 
		/// null then default is used.</param>
		/// <param name="def">[in] A default value to use (will be 
		/// encoded) if string is null.  If default is not specified 
		/// then an empty string will be used instead.</param>
		/// <returns>Encoded string</returns>
		public static string JsString(string str, string def)
		{
			if(str == null || str.Length == 0)
			{
				str = (def == null ? "" : def);
			}
		
			int len = str.Length;
			StringBuilder outBuff = new StringBuilder((int)(len*1.5));
			outBuff.Append('\'');
		
			// Allow: a-z A-Z 0-9 SPACE , .
			// Allow (dec): 97-122 65-90 48-57 32 44 46
		
			for(int cnt = 0; cnt < len; cnt++)
			{
				char c = str[cnt];
				if( (c >= 97 && c <= 122) ||
					(c >= 65 && c <= 90 ) ||
					(c >= 48 && c <= 57 ) ||
					c == 32 || c == 44 || c == 46 )
				{
					outBuff.Append(c);
				}
				else if( c <= 127 )
				{
					outBuff.Append("\\x");
					
					string hex = Convert.ToInt32(c).ToString("X");
					if( hex.Length < 2 )
					{
						outBuff.Append('0');
					}
					
					outBuff.Append(hex);
				}
				else
				{
					outBuff.Append(String.Format("\\u{0:X4}", (int)c));
				}
			}
		
			return outBuff.Append('\'').ToString();
		}
	
		/// <summary>
		/// The VbsString function returns a value that can be 
		/// treated as a string literal in VBScript.  In addition, 
		/// characters are encoded using the wchr function which 
		/// is able to handle both Unicode and non Unicode 
		/// characters.  Encoding VBScript strings is not as straight
		/// forward as with others since VBScript provides no way to 
		/// actually escape characters from inside of the string (see
		/// 3.6.3 for more information).
		/// </summary>
		/// <param name="str">[in] String to encode.</param>
		/// <returns>Encoded string</returns>
		public static string VbsString(string str)
		{
			return VbsString(str, null);
		}
		/// <summary>
		/// The VbsString function returns a value that can be 
		/// treated as a string literal in VBScript.  In addition, 
		/// characters are encoded using the wchr function which 
		/// is able to handle both Unicode and non Unicode 
		/// characters.  Encoding VBScript strings is not as straight
		/// forward as with others since VBScript provides no way to 
		/// actually escape characters from inside of the string (see
		/// 3.6.3 for more information).
		/// </summary>
		/// <param name="str">[in] String to encode.  If string is 
		/// null then default is used.</param>
		/// <param name="def">[in] A default value to use (will be 
		/// encoded) if string is null.  If default is not specified 
		/// then an empty string will be used instead.</param>
		/// <returns>Encoded string</returns>
		public static string VbsString(string str, string def)
		{
			if(str == null || str.Length == 0)
			{
				str = (def == null ? "" : def);

				if (str.Length == 0)
					return "\"\"";
			}
		
			bool inStr = false;
			int len = str.Length;
			StringBuilder outBuff = new StringBuilder((int)(len*1.5));
		
			// Allow: a-z A-Z 0-9 SPACE , .
			// Allow (dec): 97-122 65-90 48-57 32 44 46
		
			for(int cnt = 0; cnt < len; cnt++)
			{
				char c = str[cnt];
				if( (c >= 97 && c <= 122) ||
					(c >= 65 && c <= 90 ) ||
					(c >= 48 && c <= 57 ) ||
					c == 32 || c == 44 || c == 46 )
				{
					if(!inStr)
					{
						inStr = true;
						outBuff.Append("&\"");
					}
				
					outBuff.Append(c);
				}
				else
				{
					if(!inStr)
					{
						outBuff.Append("&chrw(").Append((int)c).Append(')');
					}
					else
					{
						outBuff.Append("\"&chrw(").Append((int)c).Append(')');
						inStr = false;
					}
				}
			}
		
			if( outBuff[0] == '&' )
			{
				outBuff.Remove(0,1);
			}
		
			return outBuff.Append(inStr ? "\"" : "").ToString();
		}	
	}
}

// end
