
#
# Copyright (c) 2005-2006 Michael Eddington
# Copyright (c) 2004 IOActive Inc.
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

package Owasp::Reform;

use utf8;
use strict;
use warnings;
#use bytes;

sub HtmlEncode
{
	my ($str,
		$default
		) = @_;
	
	if(! $str )
	{
		$str = ($default ? $default : '');
	}
		
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	my $out = '';
	foreach my $char (split(//, $str))
	{
		my $c = ord($char);
		if( ($c >= 97 && $c <= 122) ||
			($c >= 65 && $c <= 90 ) ||
			($c >= 48 && $c <= 57 ) ||
			$c == 32 || $c == 44 || $c == 46 )
		{
			$out .= $char;
		}
		else
		{
			$out .= "&#$c;";
		}
	}
	
	return $out;
}

sub HtmlAttributeEncode
{
	my ($str,
		$default
		) = @_;
	
	if(! $str )
	{
		$str = ($default ? $default : '');
	}
		
	# Allow: a-z A-Z 0-9
	# Allow (dec): 97-122 65-90 48-57
	
	my $out = '';
	foreach my $char (split(//, $str))
	{
		my $c = ord($char);
		if( ($c >= 97 && $c <= 122) ||
			($c >= 65 && $c <= 90 ) ||
			($c >= 48 && $c <= 57 ) )
		{
			$out .= $char;
		}
		else
		{
			$out .= "&#$c;";
		}
	}
	
	return $out;
}

sub XmlEncode
{
	my ($str,
		$default
		) = @_;
	
	if(! $str )
	{
		$str = ($default ? $default : '');
	}
		
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	my $out = '';
	foreach my $char (split(//, $str))
	{
		my $c = ord($char);
		if( ($c >= 97 && $c <= 122) ||
			($c >= 65 && $c <= 90 ) ||
			($c >= 48 && $c <= 57 ) ||
			$c == 32 || $c == 44 || $c == 46 )
		{
			$out .= $char;
		}
		else
		{
			$out .= "&#$c;";
		}
	}
	
	return $out;
}

sub XmlAttributeEncode
{
	my ($str,
		$default
		) = @_;
	
	if(! $str )
	{
		$str = ($default ? $default : '');
	}
		
	# Allow: a-z A-Z 0-9
	# Allow (dec): 97-122 65-90 48-57
	
	my $out = '';
	foreach my $char (split(//, $str))
	{
		my $c = ord($char);
		if( ($c >= 97 && $c <= 122) ||
			($c >= 65 && $c <= 90 ) ||
			($c >= 48 && $c <= 57 ) )
		{
			$out .= $char;
		}
		else
		{
			$out .= "&#$c;";
		}
	}
	
	return $out;
}

sub JsString
{
	my ($str,
		$default
		) = @_;
	
	if(! $str )
	{
		$str = ($default ? $default : '');
		
		if(length($str) == 0)
		{
			return "''";
		}
	}
		
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	my $out = '';
	foreach my $char (split(//, $str))
	{
		my $c = ord($char);
		if( ($c >= 97 && $c <= 122) ||
			($c >= 65 && $c <= 90 ) ||
			($c >= 48 && $c <= 57 ) ||
			$c == 32 || $c == 44 || $c == 46 )
		{
			$out .= $char;
		}
		elsif( $c <= 127 )
		{
			$out .= sprintf('\x%02X', $c);
		}
		else
		{
			$out .= sprintf('\u%04X', $c);
		}
	}
	
	return "'$out'";
}

sub VbsString
{
	my ($str,
		$default
		) = @_;
	
	if(! $str )
	{
		$str = ($default ? $default : '');
		
		if(length($str) == 0)
		{
			return '""';
		}
	}
		
	# Allow: a-z A-Z 0-9 SPACE , .
	# Allow (dec): 97-122 65-90 48-57 32 44 46
	
	my $out = '';
	my $inStr = 0;
	foreach my $char (split(//, $str))
	{
		my $c = ord($char);
		if( ($c >= 97 && $c <= 122) ||
			($c >= 65 && $c <= 90 ) ||
			($c >= 48 && $c <= 57 ) ||
			$c == 32 || $c == 44 || $c == 46 )
		{
			if( ! $inStr )
			{
				$out .= '&"';
				$inStr = 1;
			}
			
			$out .= $char;
		}
		else
		{
			if( $inStr )
			{
				$out .= "\"&chrw($c)";
				$inStr = 0;
			}
			else
			{
				$out .= "&chrw($c)";
			}
		}
	}
	
	return substr($out,1) . '"' if $inStr;
	return substr($out,1);
}

1;

# end
