<?php
    class Conexion{
        function __construct(){
            //creamos instanciamos querymanagger y pasamos los parametros usuario-contraseña y base de datos
            $this->db = new QueryManager("root","","hackapp");  
        }
    }
?>