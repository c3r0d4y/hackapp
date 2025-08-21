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
}
?>