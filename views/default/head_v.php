<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html"; charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>HackApp</title>

    <script src="<?php echo URL.'resource/js/jquery-3.7.1.js';?>" type="text/javascript"></script>   
    <script src="<?php echo URL.'resource/js/commons.js';?>" type="text/javascript"></script>
    
    <link rel="stylesheet" href="<?php echo URL.'resource/css/common.css';?>">
    <link rel="stylesheet" href="<?php echo URL.'resource/css/buttons.css';?>">
    <link rel="stylesheet" href="<?php echo URL.'resource/css/modals.css';?>">
    <link rel="stylesheet" href="<?php echo URL.'resource/css/specific.css';?>">

<?php
        $select = $_SERVER['REQUEST_URI'];
        $select = explode("/", $select);
        $select = end($select);

        if($select=='hack'){
            echo "<script src='../resource/js/hack.js' type='text/javascript'></script>";
        }
        elseif($select=='herramientas'){
            echo "<script src='../resource/js/herramientas.js' type='text/javascript'></script>";
        }
?>
</head>
<body>
  <!-- Fondo con caracteres hexadecimales -->
    <div class="hex-bg">
        <?php 
        // Generar líneas de caracteres hexadecimales
        $hexChars = '0123456789ABCDEF0123456789ABCDEF';
        for ($i = 0; $i < 30; $i++) {
            echo '<div class="hex-line">';
            for ($j = 0; $j < 150; $j++) {
                $char = $hexChars[rand(0, 15)];
                echo '<span class="hex-char">'.$char.'</span>';
            }
            echo '</div>';
        }
        ?>
    </div>
