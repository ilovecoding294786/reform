
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
 * $Id: WebControls.cs,v 1.2 2006/11/06 06:03:19 meddingt Exp $
 */

using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Owasp.Reform;

namespace Owasp.Reform.WebControls
{
	public class ReformLabel : Label
	{
		public ReformLabel() : base()
		{
		}

		protected override void Render(HtmlTextWriter output)
		{
			string _reformText = Text;
			Text = Reform.HtmlEncode(_reformText);
			base.Render(output);
			Text = _reformText;
		}
	}

	public class ReformLiteral : Literal
	{
		public ReformLiteral() : base()
		{
		}

		protected override void Render(HtmlTextWriter output)
		{
			string _reformText = Text;
			Text = Reform.HtmlEncode(_reformText);
			base.Render(output);
			Text = _reformText;
		}
	}

	// CheckBox
	public class ReformCheckBox : CheckBox
	{
		public ReformCheckBox() : base()
		{
		}

		protected override void Render(HtmlTextWriter output)
		{
			string _reformText = Text;
			Text = Reform.HtmlEncode(_reformText);
			base.Render(output);
			Text = _reformText;
		}
	}

	// DataGrid
	// DataGridItem
	// DataList
	// DataListItem

	/// <summary>
	/// Safe HyperLink control.  Only allows schemes of HTTP,
	/// HTTPS, and MAILTO.  If a bad URL is found an exception
	/// is thrown at render time of type ReformUrlException.
	/// </summary>
	public class ReformHyperLink : HyperLink
	{
		public ReformHyperLink() : base()
		{
		}

		// Hack to work around improper OO design
		protected override void Render(HtmlTextWriter output)
		{
			Uri url = null;
			
			try
			{
				url = new Uri(this.NavigateUrl);

				if( url.Scheme == Uri.UriSchemeHttp ||
					url.Scheme == Uri.UriSchemeHttps ||
					url.Scheme == Uri.UriSchemeMailto )
				{
					string _reformText = Text;

					NavigateUrl = url.ToString();
					Text = Reform.HtmlEncode(_reformText);
					
					base.Render(output);
					
					Text = _reformText;
				}
				else
				{
					throw new ReformUrlException(url, "IOActive.Reform.ReformHyperLink::Render()");
				}
			}
			catch(UriFormatException)
			{
				throw new ReformUrlException(null, this.NavigateUrl);
			}
		}
	}

	/// <summary>
	/// Exception thrown when a URL does not have
	/// correct format or scheme.
	/// </summary>
	public class ReformUrlException : Exception
	{
		/// <summary>
		/// Bad url
		/// </summary>
		public Uri url;

		public ReformUrlException(Uri url, string msg) : base(msg)
		{
			this.url = url;
		}
	}

	// LinkButton
	public class ReformLinkButton : LinkButton
	{
		public ReformLinkButton() : base()
		{
		}

		protected override void Render(HtmlTextWriter output)
		{
			string _reformText = Text;
			Text = Reform.HtmlEncode(_reformText);
			base.Render(output);
			Text = _reformText;
		}
	}

	// RadioButton
	public class ReformRadioButton : RadioButton
	{
		public ReformRadioButton() : base()
		{
		}

		protected override void Render(HtmlTextWriter output)
		{
			string _reformText = Text;
			Text = Reform.HtmlEncode(_reformText);
			base.Render(output);
			Text = _reformText;
		}
	}

	// TableCell
	public class ReformTableCell : TableCell
	{
		public ReformTableCell() : base()
		{
		}

		protected override void Render(HtmlTextWriter output)
		{
			string _reformText = Text;
			Text = Reform.HtmlEncode(_reformText);
			base.Render(output);
			Text = _reformText;
		}
	}
}

// end
