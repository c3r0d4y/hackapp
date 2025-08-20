<?php
     function v($datos, $tipo){
            if($tipo=='encode'){
                $datos=str_replace('\\', 'xyz', $datos);
                $datos=htmlentities($datos);
                $datos=htmlspecialchars($datos, ENT_QUOTES);
                return($datos);
            }elseif($tipo=='decode'){
                $datos=str_replace('xyz', '\\', $datos);
                $datos=htmlspecialchars_decode($datos);
                $datos=html_entity_decode($datos); 
                return($datos);
            }
            elseif($tipo == "archivo"){
                //echo "Entra a f<br/>";
                if(isset($datos)){
                    //echo "Entra a archivo<br/>";
                    //nombre Temporal         
                    $fileName = $datos['name'];
                    $fileSize = $datos['size'];
                    if($fileSize>50000000){
                        return('size');
                    }
                    //extraemos extencion
                    $nameArray = explode(".", $fileName);
                    //Convertimos a minusculas
                    $extencion = strtolower(end($nameArray));
                    if($extencion!="zip" && $extencion!="rar"){
                        return('formato');
                    }
                    return($datos);
                }
            }
            elseif($tipo == "pdf"){
                //echo "Entra a f<br/>";
                if(isset($datos)){
                    //echo "Entra a archivo<br/>";
                    //nombre Temporal         
                    $fileName = $datos['name'];
                    $fileSize = $datos['size'];
                    if($fileSize>50000000){
                        return('size');
                    }
                    //extraemos extencion
                    $nameArray = explode(".", $fileName);
                    //Convertimos a minusculas
                    $extencion = strtolower(end($nameArray));
                    if($extencion!="pdf"){
                        return('formato');
                    }
                    return($datos);
                }
            }
            return('');   
    }
 
?>