<?php
class Hack extends Controllers
{
    function __construct(){
        parent::__construct();
        require_once "library/validar_cadenas.php";
        
    }
    //Para la vista de interfaz de usuarios OK
    public function hack(){
       $param='';
       $menu='';
       $this->view->render($this, "hack_v", $menu, $param);
    }
    public function herramientas(){
        $this->view->render($this, "herramientas_v", '', '');
    }
    function get_areas(){
        $count=0;
        $count_tr=0;
        $respond = $this->model->get_areas_m();
        echo "<option value=''>Area</option>";
        foreach ($respond as $row){
            $datos=json_encode($respond[$count]);
            $id_seccion=$row[0];
            $nombre=$row[1];
            $nombre=$nombre;
            echo "<option value='$id_seccion'>$nombre</option>";
        }
    }
    function get_fases(){
        $area=$_POST['area'];
        $count=0;
        $count_tr=0;
        echo "<option value=''>Fase</option>";
        if($area!=""){
            $respond = $this->model->get_fases_m($area);       
            foreach ($respond as $row){
                $datos=json_encode($respond[$count]);
                $id_seccion=$row[0];
                $nombre=$row[1];
                echo "<option value='$id_seccion'>$nombre</option>";
            }
        }
    }
    function get_herramientas(){
        echo "<option value=''>Herramienta</option>";
        $count=0;
        //$buscar=$_POST['buscar'];
        $count_tr=0;
        //Obtenemos las herramientas solo de la fase de
        $respond = $this->model->get_herramientas_m($idFase);
        foreach ($respond as $row){
            $datos=json_encode($respond[$count]);
            $id_herramienta=$row[0];
            $nombreHerramienta=$row[1];
            echo "<option value='$id_herramienta'>$nombreHerramienta</option>";
        }
    }
    function get_comandos(){
        $count=0;
        $area=$_POST['area'];
        if(isset($_POST['fase'])){$fase=$_POST['fase'];}else{$fase="";}
        if(isset($_POST['herramienta'])){$herramienta=$_POST['herramienta'];}else{$herramienta="";}
        if(isset($_POST['buscar'])){$buscar=$_POST['buscar'];}else{$buscar="";}
        $bg_tr="claro";
        $count_tr=0;
        $respond = $this->model->get_comandos_m($area, $fase, $herramienta,$buscar);
        if(!empty($respond)){
            echo "<table><tr>
                <th>Comando</th>
                <th class='des'>Descripción</th>
                <th>Herramienta</th>
                <th colspan='4' class='td_btn'><div id='ver' class='ocultar'></div></th>
            </tr>";
            foreach ($respond as $row){
                $datos=json_encode($respond[$count]);   
                //$po= $datos[0];
               //echo $po."</br>";
                if($count_tr==0){$bg_tr="claro";$count_tr++;}else{$bg_tr="oscuro";$count_tr=0;}  
                $comando=v($row[2],'decode');
                $descripcion=v($row[3],'decode');
                $imagen=$row[5];
                $descargar=$row[5];
                //Imagenes de carga de archivo
                if($imagen!=""){
                    $imagen="datosa.png";
                    $img_deacarga="dowa.png";
                    $link="href='../resource/archivos/$descargar'";                
                }else{
                    $imagen="datosan.png";
                    $img_deacarga="dow.png";
                    $link="";
                }    
                $id_herramienta=$row[8];
                $countH=0;
                $respondH = $this->model->get_detalle_herramienta_m($id_herramienta);
                foreach ($respondH as $rowH){
                    $datosH=json_encode($respondH[$countH]);
                    $nombreHerramienta=$rowH[1];
                    $imagenC=$rowH[3];
                    $descargarC=$rowH[3];
                }
                //Color carga hoja de trucos
                if($imagenC!=""){
                    $linkC="<a class='red' href='../resource/cheats/$descargarC' target='blank'>";
                }else{
                    $linkC="<a class='text'>";
                }   
                $cadena = "
                    <tr class='$bg_tr'>".
                        "<td class='comando'><pre><code>$comando</pre></code></td>".
                        "<td class='btn_img' onclick='ver_comando(".$datos.")'>$descripcion</td>".
                        "<td class='btn_img' onmouseover='verD()' onmouseout='ocultar()'>$linkC $nombreHerramienta</a></td>".
                        "<td class='btn_img' onmouseover='verS()' onmouseout='ocultar()'><a $link ><img src='../resource/images/iconos/$img_deacarga'></a></td>".
                        "<td class='btn_img' onmouseover='verE()' onmouseout='ocultar()' ><img src='../resource/images/iconos/editar.png'></td>".
                        "<td class='btn_img' onmouseover='verA()' onmouseout='ocultar()' ><img src='../resource/images/iconos/$imagen'></td>".
                        "<td class='btn_img' onmouseover='verEl()' onmouseout='ocultar()' ><img src='../resource/images/iconos/eliminar.png'></td>".
                    "</tr>";
                echo $cadena;
                $count++;
            }
            echo "</table>";
        }
    }
    
    //===============================================================================================Herramientas
    function get_herramientase(){
        $count=0;
        $no=1;
        $buscar=$_POST['buscar'];
        $bg_tr="claro";
        $count_tr=0;
        $respond = $this->model->get_herramientase_m($buscar);
        echo "<table><tr>
                <th class='no'>No</th>
                <th>Nombre</th>
                <th colspan='4'><div id='ver' class='ocultar'></div></th>
                </tr>";
        foreach ($respond as $row){
            $datos=json_encode($respond[$count]);
            if($count_tr==0){$bg_tr="claro";$count_tr++;}else{$bg_tr="oscuro";$count_tr=0;}
            
            $idHerramienta=$row[0];
            $nombre=$row[1];
            $imagen=$row[3];
            $descargar=$row[3];

            //Imagenes de caqrga de archivo
            if($imagen!=""){
                $imagen="datosa.png";
                $img_deacarga="dowPA.png";
                $link="<a href='../resource/cheats/$descargar' target='blank'>";
            }else{
                $imagen="datosan.png";
                $img_deacarga="dowP.png";
                $link="<a>";
            }
            $cadena = "
                <tr class='$bg_tr'>".
                    "<td class='no'>$no</td>".
                    "<td>$nombre</td>".
                    "<td class='btn_img' onmouseover='verE()' onmouseout='ocultar()'><img src='../resource/images/iconos/editar.png'></td>".
                    "<td class='btn_img' onmouseover='verD()' onmouseout='ocultar()'>$link<img src='../resource/images/iconos/$img_deacarga'></a></td>".
                    "<td class='btn_img' onmouseover='verA()' onmouseout='ocultar()'><img src='../resource/images/iconos/$imagen'></td>".
                    "<td class='btn_img' onmouseover='verEl()' onmouseout='ocultar()'><img src='../resource/images/iconos/eliminar.png'></td>".
                "</tr>";
                echo $cadena;
                $count++;
                $no++;
        }
        echo "</table>";
    }
}
