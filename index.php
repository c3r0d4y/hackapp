<?php
    require "config.php";//Aqui estan las constantes
    //Recibimos los datos redireccionados por  htacces y si no hay datos pasamos el controlador index, 
   $url = $_GET['url'] ?? header("Location:".URL."Hack/hack");;
   
   //Con este metodo separamos los datos recibidos separados por /
   $url = explode("/", $url);
   $controller = "";
   $method = "";
    //echo $url[0].">>>".$url[1];
    //Checamos que haya un controlador y un mnodelo (posicion 0 y 1)
   if(isset($url[0]) && isset($url[1])){
        //echo "1";
        $controller = $url[0];
        $method = $url[1];
    }else{
        //echo "2";
        header("Location:".URL."Hack/hack");
    }
   //Verificamos que nunca haya un tercer parametro, de lo contrario cerramos la session o enviamos a main
   if(isset($url[2])){
    //echo "3";
       header("Location:".URL."Hack/hack");
    }
   
   //La clase debe tener el nombre del archivo
   spl_autoload_register(function($class){
        if(file_exists(LBS.$class.".php")){
            //echo "4";
            require LBS.$class.".php";
        }
   });
   //Incluimos el archivo controller para despues instanciar la clase
   $controllerPath = "controllers/".$controller.".php";
   //echo "Controlador index = ".$controllerPath."<br/>";
   if(file_exists($controllerPath)){
       require $controllerPath;
       //echo "5";
       //Instanciamos la clase
       $controller = new $controller();
        if(isset($method)){
            //echo "6";
            //Dependiendo el controlador  que invoquemos es el metodo que invocaremos
            if(method_exists($controller, $method)){
                //echo "7";
                $controller->{$method}();
            }else{
                //Cuando no se encuentra el metodo nos vamos a main
                header("Location:".URL."Hack/hack");
            }
        }
   }else{
        header("Location:".URL."Hack/hack");
   }
   
?>
