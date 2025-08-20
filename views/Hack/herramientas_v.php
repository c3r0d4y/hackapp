<div class="c_main">
   <h1>Herramientas</h1>
      
    <table>
            <tbody>
                <tr>
                    <td class='btn_img'><a href="hack"><img src='../resource/images/iconos/volver.png'></a></td>
                    <td><input class="buscar input" type="text" id="buscar" onkeyup="get_herramientase();"></td>
                    <td class="btn_img" onclick="insert_herramientas();"><img src='../resource/images/iconos/add.png'></td>
                </tr>
            </tbody>
        </table>
    <div id="herramientase"></div>
</div>

 <!--Modal ayuda -->
 <div id="m_view" class="bgModal ocultar"> 
        <div class="modalAyuda">
            <div class="btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
            <div onclick='save();' class="btn_img le"><img src="<?php echo URL; ?>resource/images/iconos/guardar.png"></div>
                <h2>Notas sobre la herramienta</h2>
                <form name="formHerramientas" method="post">
                    <table class="tableComandos">
                        <tr><th>Herramienta</th></tr>
                        <tr><td><input id="nombreHerramienta" name="nombreHerramienta" class="input"></textarea></td></tr>
                        <tr><th>Ayuda de herramienta</th></tr>
                        <tr><td><textarea id="ayudaHerramienta" class="ayuda" name="ayudaHerramienta"></textarea></td></tr>
                        <input type="hidden" name="idHerramienta" id="idHerramienta">
                    </table>
                </form>
        </div>  
    </div>
    <!--Modal archivos -->
    <div id="m_archivo" class="bgModal ocultar">
        <div class="modal m_archivos">
        <div class="btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
        <div onclick='save_archivo();' class="btn_img le"><img src="<?php echo URL; ?>resource/images/iconos/guardar.png"></div>
            <h2>Guardar cheat sheet (PDF)</h2>
            <form action="update_cheat" method="POST" name="formArchivo" enctype="multipart/form-data">
                <table class="tableComandos">
                    <tr>
                        <td><input type="file" name="archivo" id="archivo"></td>
                        <td>Eliminar:<input type="checkbox" name="delete" value="1"> </td>
                    </tr>
                    <input type="hidden" name="nombreArchivoDB" id="nombreArchivoDB">
                    <input type="hidden" name="idHerramientaA" id="idHerramientaA">
                </table>
            </form>
        </div> 
    </div>
    <!-- Modal delete -->
    <div id="m_eliminar" class="bgModal ocultar"> 
        <div class="modal m_eliminar">
        <div class="btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
        <div onclick='deleteH();' class="btn_img guardar le"><img src="<?php echo URL; ?>resource/images/iconos/eliminar.png"></div>
            <h2>¿Esta seguro de eliminar?</h2>
            <form action="#" method="POST" id="deleteForm" name="deleteForm">
                <table>
                    <tr><td><h3 id="nombreHerramientaD"></h3></td></tr>
                        <td><input type="hidden" name="idHerramientaD" id="idHerramientaD" value=""></td>
                    </tr>
                </table>
            </form>
        </div>
</div>