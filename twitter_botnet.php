<?php 

$consumerKey = ysMSjQeXWXlR3l8vxNAToA;
$consumerSecret  = PzaNhyb5TXRKfBJRSrIQO0wA03HBNhrSobVUsPe2g;
$oAuthtoken = 1411954831-55W7xiIWtgwuWYMxDSlbTzLA6gMmHmJHvLyh0s4;
$oAuthSecret = CCRdzhLzoVG85NRFvipIer2EwaAJw73UTt5bMEU;


function tweet($consumerKey, $consumerSecret, $oAuthToken, $oAuthSecret, $message)
        {
                $tweet = new TwitterOAuth
                        ($consumerKey, $consumerSecret, $oAuthToken, $oAuthSecret);
                return var_dump($tweet->post('statuses/update', array('status' => "$message")));
        }
                        
function follow($consumerKey, $consumerSecret, $oAuthToken, $oAuthSecret, $user_id)
        {
                $tweet = new TwitterOAuth
                        ($consumerKey, $consumerSecret, $oAuthToken, $oAuthSecret);
                return var_dump($tweet->post('friendships/create', array('user_id' => "$user_id")));
        }

function database_count_bots()
        {
                $return count(file('./botnet.db'));
        }

function database_read_base($userid)
        {
                $database_array = file('./botnet.db');
                if(!database)array[$userid])
                        {return "BAD/404";}
                else
                        {return explode(" ", $database_array[$userid]);}
        }
        
?>
