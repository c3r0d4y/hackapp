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
        $img_deacarga="";
        $respond = $this->model->get_comandos_m($area, $fase, $herramienta,$buscar);
        if(!empty($respond)){
            echo "<table><tr>
                <th>Comando</th>
                <th>Descipcion</th>
                <th>Herramienta</th>
                <th colspan='5' class='td_btn'><div id='ver' class='ocultar'></div></th>
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
                //Imagenes de caqrga de archivo
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

                if($imagenC!=""){
                    $img_deacargaC="dowPA.png";
                    $linkC="<a href='../resource/cheats/$descargarC' target='blank'>";
                }else{
                    $img_deacargaC="dowP.png";
                    $linkC="<a>";
                }   

                $cadena = "
                    <tr class='$bg_tr'>".
                        "<td class='comando'><pre><code>$comando</pre></code></td>".
                        "<td class='btn_img' onclick='ver_comando(".$datos.")'>$descripcion</td>".
                        "<td class='btn_img' onclick='detalles_herramienta(".$datosH.")'> $nombreHerramienta</td>".
                        "<td class='btn_img' onmouseover='verD()' onmouseout='ocultar()'>$linkC<img src='../resource/images/iconos/$img_deacargaC'></a></td>".
                        "<td class='btn_img' onmouseover='verD()' onmouseout='ocultar()'><a $link ><img src='../resource/images/iconos/$img_deacarga'></a></td>".
                        "<td class='btn_img' onmouseover='verE()' onmouseout='ocultar()' onclick='update_comando(".$datos.")'><img src='../resource/images/iconos/editar.png'></td>".
                        "<td class='btn_img' onmouseover='verA()' onmouseout='ocultar()' onclick='update_archivo(".$datos.")'><img src='../resource/images/iconos/$imagen'></td>".
                        "<td class='btn_img' onmouseover='verEl()' onmouseout='ocultar()' onclick='delete_comando(".$datos.")'><img src='../resource/images/iconos/eliminar.png'></td>".
                    "</tr>";
                echo $cadena;
                $count++;
            }
            echo "</table>";
        }
    }
    public function update_comando(){
        $idComando=v($_POST['idComando'],'encode');
        $area=v($_POST['areae'],'encode');
        $fase=v($_POST['fasee'],'encode');
        $herramienta=v($_POST['herramientae'],'encode');
        $comando=v($_POST['comando'],'encode');
        $etiquetas=v($_POST['etiquetas'],'encode');
        $descripcion=v($_POST['descripcion'],'encode');
        $detalles=v($_POST['detalles'],'encode');
        $data =  $this->model->update_comando_m($idComando, $area, $fase, $herramienta, $comando, $etiquetas, $descripcion, $detalles);
        
        $param[0]="¡Comando actualizado con exito!";
        $param[1]="Hack/hack";
        $menu=''; //1 oculta header 0 lo muestra
        $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
    }
    function insert_comando(){
        $area=v($_POST['areae'],'encode');
        $fase=v($_POST['fasee'],'encode');
        $herramienta=v($_POST['herramientae'],'encode');
        $comando=v($_POST['comando'],'encode');
        $etiquetas=v($_POST['etiquetas'],'encode');
        $descripcion=v($_POST['descripcion'],'encode');
        $detalles=v($_POST['detalles'],'encode');
        // echo $area."|".$fase."|".$herramienta;      
        if($area!="" && $fase!="" && $herramienta !=""){
            $data =  $this->model->insert_comando_m($area, $fase, $herramienta, $comando, $etiquetas, $descripcion, $detalles);
            $param[0]="¡Comando agregado con exito!";
            $param[1]="Hack/hack";
            $menu=''; //1 oculta header 0 lo muestra
        }else{
            $menu='';
            $param[0]="¡Debe seleccionar un area, fase y herramienta!";
            $param[1]="Hack/hack";
        }
        $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
    }

    public function update_archivo(){
        $idComando = $_POST["idComandoA"];
        $nombreArchivoDB = $_POST["nombreArchivoDB"];
        $archivo = $_FILES["archivo"];
        if(isset($_POST['delete'])){$eliminarArchivo=1;}else{$eliminarArchivo=0;}

        if($archivo["name"]!=""){$archivo = v($_FILES["archivo"],'archivo');}else{$archivo="";}
        
        if($archivo=='formato'){
            $param[0]="¡EL formato de la imagen no es valido!";
            $param[1]="Hack/hack";
            $menu='';
            $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
        }
        elseif($archivo=='size'){
            $param[0]="¡El tamaño de la imagen excede el permitido (1 MB)";
            $param[1]="Hack/hacks";
            $menu='';
            $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
            //devuelve null cuando no se carga un archivo
        }
        else{
                //Guardamos el nombre del archivo en la tabla
                $data =  $this->model->update_archivo_m($idComando, $nombreArchivoDB,$archivo, $eliminarArchivo);
                $param[0]="¡Archivo actualizado con exito!";
                $param[1]="Hack/hack";
                $menu=''; //1 oculta header 0 lo muestra
                $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
            }
    }
    public function delete_comando(){
        $idComandoD = v($_POST["idComandoD"],'decode');
        $path = $_POST["path"];
        $response = $this->model->delete_comando_m($idComandoD, $path);
        $param[0]="¡Comando eliminado con exito!";
        $param[1]="Hack/hack";
        $menu='';
        $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
    }
//===============================================================================================Herramientas
    function get_herramientase(){
        $count=0;
        $buscar=$_POST['buscar'];
        $bg_tr="claro";
        $count_tr=0;
        $respond = $this->model->get_herramientase_m($buscar);
        echo "<table><tr>
                <th>ID</th>
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
                    "<td class=''>$idHerramienta</td>".
                    "<td>$nombre</td>".
                    "<td class='btn_img' onmouseover='verE()' onmouseout='ocultar()' onclick='update_herramientas(".$datos.")'><img src='../resource/images/iconos/editar.png'></td>".
                    "<td class='btn_img' onmouseover='verD()' onmouseout='ocultar()'>$link<img src='../resource/images/iconos/$img_deacarga'></a></td>".
                    "<td class='btn_img' onmouseover='verA()' onmouseout='ocultar()' onclick='update_cheat(".$datos.")'><img src='../resource/images/iconos/$imagen'></td>".
                    "<td class='btn_img' onmouseover='verEl()' onmouseout='ocultar()' onclick='delete_herramientas(".$datos.")'><img src='../resource/images/iconos/eliminar.png'></td>".
                "</tr>";
                echo $cadena;
                $count++;
        }
        echo "</table>";
    }
    public function update_herramienta(){
        $idHerramienta=$_POST['idHerramienta'];
        $nombreHerramienta=v($_POST['nombreHerramienta'], 'encode');
        $ayudaHerramienta=v($_POST['ayudaHerramienta'], 'encode');      
        $data =  $this->model->update_herramienta_m($idHerramienta, $nombreHerramienta, $ayudaHerramienta);
        $param[0]="¡Herramnienta actualizada con exito!";
        $param[1]="Hack/herramientas";
        $menu=''; //1 oculta header 0 lo muestra
        $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
    }
    function insert_herramienta(){
        $nombreHerramienta=v($_POST['nombreHerramienta'],'encode');
        $ayudaHerramienta=v($_POST['ayudaHerramienta'], 'encode');
        $data =  $this->model->insert_herramienta_m($nombreHerramienta,  $ayudaHerramienta);
        $param[0]="¡Herramienta agregada con exito!";
        $param[1]="hack/herramientas";
        $menu=''; //1 oculta header 0 lo muestra
        $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
    }
    public function delete_herramienta(){
        $idHerramientaD=$_POST['idHerramientaD'];
        $response = $this->model->delete_herramienta_m($idHerramientaD);
        $param[0]="¡Herramienta eliminada con exito!";
        $param[1]="Hack/herramientas";
        $menu='';
        $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
    }
    public function update_cheat(){
        $idHerramienta = $_POST["idHerramientaA"];
        $nombreArchivoDB = $_POST["nombreArchivoDB"];
        $archivo = $_FILES["archivo"];
        if(isset($_POST['delete'])){$eliminarArchivo=1;}else{$eliminarArchivo=0;}
                
        if($archivo["name"]!=""){$archivo = v($_FILES["archivo"],'pdf');}else{$archivo="";}
        if($archivo=='formato'){
            $param[0]="¡EL formato de la imagen no es valido!";
            $param[1]="Hack/herramientas";
            $menu='';
            $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
        }
        elseif($archivo=='size'){
            $param[0]="¡El tamaño de la imagen excede el permitido (5 MB)";
            $param[1]="Hack/herramientas";
            $menu='';
            $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
        }
        else{
                //Guardamos el nombre del archivo en la tabla
                $data =  $this->model->update_cheat_m($idHerramienta,$nombreArchivoDB,$archivo,$eliminarArchivo);
                $param[0]="¡Archivo actualizado con exito!";
                $param[1]="Hack/herramientas";
                $menu=''; //1 oculta header 0 lo muestra
                $this->view->render($this, "../Mesage/mesage_v", $menu, $param);
            }
    }
}
