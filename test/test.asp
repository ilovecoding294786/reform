<%@ Language=VBScript%>

<body>

<!-- #include file="..\src\asp\Reform.inc.asp" -->

Here are some exmaples!

<pre>

Html: <%= Reform.HtmlEncode("<script>alert('meow')</script>") %>
Html2: <%= Reform.HtmlEncodeEx("<script>alert('meow')</script>", "default") %>
Html3: <%= Reform.HtmlEncodeEx(Null, "default value <script>") %>

Js: <%= Reform.JsString("<script>alert('meow')</script>") %>
Js2: <%= Reform.JsStringEx("<script>alert('meow')</script>", "default") %>
Js3: <%= Reform.JsStringEx(Null, "default <script>") %>

Vb: <%= Reform.VbsString("<script>alert('meow')</script>") %>
Vb2: <%= Reform.VbsStringEx("<script>alert('meow')</script>", "default") %>
Vb3: <%= Reform.VbsStringEx(Null, "default <script>") %>

</pre>

</body>
