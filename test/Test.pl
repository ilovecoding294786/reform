
use strict;
use warnings;
use NBK::Reform;

print Reform->HtmlEncode('hello world') . "\n";
print Reform->HtmlEncode('<script>hello world</script>') . "\n";
print Reform->HtmlEncode('<script>hello []{}<> world</script>') . "\n";
print Reform->JsString('<script>hello []{}<> world</script>') . "\n";
print Reform->VbsString('<script>hello []{}<> world</script>') . "\n";
print Reform->VbsString('hello []{}<> world') . "\n";

# end
