<?php include('..\src\php\Reform.php'); ?>
<head></head>
<body>
<pre>
Tesintg Reform for PHP

<b>HtmlEncode:</b>

<?php echo Reform::HtmlEncode('<script>meow</script>'); ?>

<?php echo Reform::HtmlEncode(NULL, 'Default Value'); ?>

<?php echo Reform::HtmlEncode('asdalksjdlkasj'); ?>


<b>HtmlAttributeEncode:</b>

<?php echo Reform::HtmlAttributeEncode('<script>me  ow</script>'); ?>


<b>JsString:</b>

<?php echo Reform::JsString('<script>me  ow tic\'tic\'tic\'tic</script>'); ?>


<b>VbsString:</b>

<?php echo Reform::HtmlEncode(
	Reform::VbsString('<script>me  ow tic\'tic\'tic\'tic</script>')); ?>

</pre>
</body>
