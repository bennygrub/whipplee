<?php
//var_dump($_POST);

// Contact subject
$subject =$_POST['subject']; 

// Details
$message=$_POST['detail'] . $_POST['name'];;

// Mail of sender
$mail_from=$_POST['customer_mail']; 

// From
//$name=$_POST['name'];

//$header="from: $name <$mail_from>";

//$headers = 'From: $name <$mail_from>' . "\r\n" .
//    'Reply-To: $mail_from' . "\r\n" .
//    'X-Mailer: PHP/' . phpversion();

$headers = "From:" . $mail_from;

// Enter your email address
$to ='blgruber@gmail.com';
$send_contact=mail($to,$subject,$message,$headers);

// Check, if message sent to your email 
// display message "We've recived your information"
if($send_contact){
header("Location: http://www.30straightmeals.com"); /* Redirect browser */
exit();
}
else {
echo "ERROR";
}
?>