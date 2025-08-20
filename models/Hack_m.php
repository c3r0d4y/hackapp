<?php
class Hack_m extends Conexion{
    function __construct(){
        parent::__construct();
    }
    public function insertActivo_m ($nombreActivo, $urlActivo, $administradorActivo, $rtmActivo, $descripcionActivo){
        $tabla='activo';
        $campos='nombre_activo, url_activo, descripcion_activo, administrador_activo, rtm_activo';
        $values = "'$nombreActivo', '$urlActivo', '$descripcionActivo','$administradorActivo', '$rtmActivo'";
        $response = $this->db->insert($tabla, $campos, $values, 0);
        return($response);//recibimos el id del usuario insertado
    }
    function get_areas_m(){
        $column="*";
        $tabla="areas";
        $where=" WHERE 1";
        $tipoSentencia="muchosRegistros";
        $response = $this->db->select($column, $tabla, $where, $tipoSentencia);
        return($response);
    }
    function get_fases_m($area){
        $column="*";
        $tabla="fases, areas";
        $where=" WHERE fases.id_area=areas.id_area AND fases.id_area=$area ORDER BY fases.orden";
        $tipoSentencia="muchosRegistros";
        $response = $this->db->select($column, $tabla, $where, $tipoSentencia);
        return($response);
    }
    function get_herramientas_m($idFase){
        $column="*";
        $tabla="herramientas";
        $where=" WHERE 1 ORDER BY nombre";
        $tipoSentencia="muchosRegistros";
        $response = $this->db->select($column, $tabla, $where, $tipoSentencia);
        return($response);
    }
    function get_comandos_m($area, $fase, $herramienta, $buscar){
        $column="";
        $tabla="";
        $where="";
        //areas
        if($area!="" && $fase=="" && $herramienta=="" && $buscar==""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area";
        //area y fase
        }else if($area!='' && $fase!="" && $herramienta=="" && $buscar==""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area AND id_fase=$fase";
        }
        //area + fase + herramienta
        else if($area!='' && $fase!="" && $herramienta!="" && $buscar==""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area AND id_fase=$fase AND id_herramienta=$herramienta";
        }
        //area + fase + herramienta+buscar
        else if($area!='' && $fase!="" && $herramienta!="" && $buscar!=""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area AND id_fase=$fase AND id_herramienta=$herramienta AND etiquetas LIKE '%$buscar%'";
        }
        //area + herramienta
        else if($area!='' && $fase=="" && $herramienta!="" && $buscar==""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area AND id_herramienta=$herramienta";
        }
        //area +herramienta+buscar
        else if($area!='' && $fase=="" && $herramienta!="" && $buscar!=""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area AND id_herramienta=$herramienta AND etiquetas LIKE '%$buscar%'";
        }
        //area + buscar
        else if($area!='' && $fase=="" && $herramienta=="" && $buscar!=""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area AND etiquetas LIKE '%$buscar%'";
        }
        //area + fase + buscar
        else if($area!='' && $fase!="" && $herramienta=="" && $buscar!=""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_area=$area AND id_fase=$fase AND etiquetas LIKE '%$buscar%'";
        }    
        //herramienta+buscar
        else if($area=='' && $fase=="" && $herramienta!="" && $buscar!=""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_herramienta=$herramienta AND etiquetas LIKE '%$buscar%'";
        }
        //buscar
        else if($area=='' && $fase=="" && $herramienta=="" && $buscar!=""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE etiquetas LIKE '%$buscar%'";
        }
        //herramienta
        else if($area=='' && $fase=="" && $herramienta!="" && $buscar==""){
            $column="*";
            $tabla="comandos";
            $where=" WHERE id_herramienta=$herramienta";
        }            


        if($column!="" &&$tabla!=""&&$where!=""){
            $tipoSentencia="muchosRegistros";
            $response = $this->db->select($column, $tabla, $where, $tipoSentencia);
            return($response);
        }
    }
    function get_detalle_herramienta_m($id_herramienta){
        $column="*";
        $tabla="herramientas";
        $where=" WHERE id_herramienta=$id_herramienta";
        $tipoSentencia="muchosRegistros";
        $response = $this->db->select($column, $tabla, $where, $tipoSentencia);
        return($response);
    }

    public function  update_comando_m($idComando, $area, $fase, $herramienta, $comando, $etiquetas, $descripcion, $detalles){
        $tabla='comandos';
        $where="WHERE id_comando =". $idComando;
        if($fase){
            $values = "etiquetas='$etiquetas', comando = '$comando', descripcion='$descripcion', detalles='$detalles', id_area=$area, id_fase=$fase, id_herramienta=$herramienta";
        }else{
            $values = "etiquetas='$etiquetas', comando = '$comando', descripcion='$descripcion', detalles='$detalles', id_area=$area, id_herramienta=$herramienta";
        }
            $response = $this->db->update($tabla, $where, $values);
    }
    public function  insert_comando_m($area, $fase, $herramienta, $comando, $etiquetas, $descripcion, $detalles){
        $tabla='comandos';
        $campos='etiquetas, comando, descripcion, detalles, id_area, id_fase, id_herramienta';
        $values = "'$etiquetas', '$comando', '$descripcion', '$detalles', $area, $fase, $herramienta";
        $response = $this->db->insert($tabla, $campos, $values, 0);
        return($response);//recibimos el id del usuario insertado
   }
   public function  update_archivo_m($idComando, $nombreArchivoDB, $archivo, $eliminarArchivo){
        $ruta= RC.'/archivos/';
        $nombreArchivoNuevo=rand(1,100).date("Ydms");////Nombre con que se guardara en base de datos       
        
        if($eliminarArchivo==1){
            if($nombreArchivoDB==""){$cargarArchivo="";}else{$cargarArchivo = $this->db->deleteArchivo($ruta, $nombreArchivoDB);}
        }
        elseif(isset($archivo["name"]) && $archivo["name"]!=""){
            //Cargamos el archivo y obtenemos el nombre para la base de datos
            $cargarArchivo = $this->db->updateArchivo($archivo, $ruta, $nombreArchivoNuevo, $nombreArchivoDB);
        }
        else{
            $cargarArchivo=$nombreArchivoDB;
        }

        $tabla='comandos';
        $where="WHERE id_comando=".$idComando;
        $values = "archivos = '$cargarArchivo'";
        $response = $this->db->update($tabla, $where, $values);
    }  
    public function delete_comando_m ($idComandoD, $path){
        if($path!=""){unlink("resource/archivos/".$path);}
        $tabla="comandos";
        $where= " WHERE id_comando=".$idComandoD;
        $response = $this->db->delete($tabla, $where);
        return($response);
    }
    //===================================================================================Herramientas=========================
    function get_herramientase_m($buscar){
        if($buscar==""){
            $column="*";
            $tabla="herramientas";
            $where=" WHERE 1 ORDER BY nombre LIMIT 15";
            
        //herramienta
        }else{
            $column="*";
            $tabla="herramientas";
            $where=" WHERE nombre LIKE '%$buscar%' ORDER BY nombre LIMIT 15";
            
        }
        $tipoSentencia="muchosRegistros";
        $response = $this->db->select($column, $tabla, $where, $tipoSentencia);
        return($response);
        
    }
    public function  update_herramienta_m($idHerramienta, $nombreHerramienta, $ayudaHerramienta){
        $tabla='herramientas';
        $where="WHERE id_herramienta =". $idHerramienta;
        $values = "nombre = '$nombreHerramienta', notas='$ayudaHerramienta'";
        $response = $this->db->update($tabla, $where, $values);
    }
    public function  insert_herramienta_m($nombreHerramienta, $ayudaHerramienta){
        $tabla='herramientas';
        $campos='nombre, notas';
        $values = "'$nombreHerramienta', '$ayudaHerramienta'";
        $response = $this->db->insert($tabla, $campos, $values, 0);
        return($response);//recibimos el id del usuario insertado
   }
   public function delete_herramienta_m ($idHerramientaD){
        $tabla="herramientas";
        $where= " WHERE id_herramienta =". $idHerramientaD;
        $response = $this->db->delete($tabla, $where);
        return($response);
    }
    public function  update_cheat_m($idHerramienta, $nombreArchivoDB, $archivo,$eliminarArchivo){
        $ruta= RC.'/cheats/';
        $nombreArchivoNuevo=rand(1,100).date("Ydms");////Nombre con que se guardara en base de datos       
        if($eliminarArchivo==1){
            if($nombreArchivoDB==""){$cargarArchivo="";}else{$cargarArchivo = $this->db->deleteArchivo($ruta, $nombreArchivoDB);}
        }
        elseif(isset($archivo["name"]) && $archivo["name"]!=""){
            //Cargamos el archivo y obtenemos el nombre para la base de datos
            $cargarArchivo = $this->db->updateArchivo($archivo, $ruta, $nombreArchivoNuevo, $nombreArchivoDB);
        }
        else{
            $cargarArchivo=$nombreArchivoDB;
        }
        $tabla='herramientas';
        $where="WHERE id_herramienta=".$idHerramienta;
        $values = "archivo = '$cargarArchivo'";
        $response = $this->db->update($tabla, $where, $values);
    }  
}
?>
