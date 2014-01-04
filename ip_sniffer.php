<?php

$to = 'YOU@HOTMAIL.COM';  // The email address you want notifications sent to
$subject = 'Visitors IP'; // What do you want the subject line of notifications to be?

$visitorSpecs = 
"<hr size=2 width=300 align=left>".
"<b>Visitor IP address:</b> ".$_SERVER['REMOTE_ADDR'];

$headers = "Content-type: text/html \nFrom: IP sniffer script";

$body = "<body>
<br>
<table cellspacing=1 cellpadding=2 align=center>
<tr>
<td>
<b><font face=arial size=2>Website visitors IP address and system specs:</font></b>
</td></tr>
<tr>
<td>
<font face=arial size=2> ".$visitorSpecs." </font>
</td></tr></table>
</body>";

mail($to,$subject,$body,$headers);
?>
