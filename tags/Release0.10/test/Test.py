
import PhedOrg

print "Doing things the class way\n"

nbk = PhedOrg.Reform()

print nbk.HtmlEncode("<script> ")
print nbk.HtmlAttributeEncode("<script> ")
print nbk.XmlEncode("<script> ")
print nbk.XmlAttributeEncode("<script> ")
print nbk.JsString("<script> ")

print "VbsString: " + nbk.VbsString("Hello <script> World")
print "VbsString: " + nbk.VbsString("Hello \" : World")
print "VbsString: " + nbk.VbsString("\" Hello : World")

print "\nDoing things the static way\n"

from PhedOrg import *

print HtmlEncode("<script> ")
print HtmlAttributeEncode("<script> ")
print XmlEncode("<script> ")
print XmlAttributeEncode("<script> ")
print JsString("<script> ")
print VbsString("<script> ")

# end
