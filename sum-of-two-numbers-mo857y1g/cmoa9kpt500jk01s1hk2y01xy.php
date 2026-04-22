<?php
$parts = preg_split('/\s+/', trim(stream_get_contents(STDIN)));
$a = (int)$parts[0];
$b = (int)$parts[1];
echo ($a + $b) . PHP_EOL;