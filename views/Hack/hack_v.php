
<div class="container">
        <h1>Notas de hacking ético</h1>
    <div class="c_main">
        <table class="t_search">
        </table>
        <table>
                <tbody>
                    <tr>
                        <td class="tselect">
                            <select name="area" id="area" onchange="get_comandos('area')"></select>
                        </td>    
                        <td class="tselect">
                            <select name="fase" id="fase" onchange="get_comandos('fase')" disabled></select>
                        </td>
                        <td class="tselect">
                            <select name="herramienta" id="herramienta" onchange="get_comandos('herramienta')"></select>
                        </td>
                        <td><input class="buscar input" type="text" id="buscar" onkeyup="get_comandos('buscar')"></td>
                        <td class='btn_img' onclick='limpiar();'><img src="<?php echo URL.'/resource/images/iconos/limpiar.png';?>"></td>
                        <td class='btn_img' onclick="insert_comando();"><img src="<?php echo URL.'/resource/images/iconos/add.png';?>"></td>
                        <td class='btn_img'><a class='link' href="herramientas"><img src="<?php echo URL.'/resource/images/iconos/herramientas.png';?>"></a></td>
                    </tr>
                </tbody>
            </table>
        <div id="comandos"></div>
</div>
</div>
 <!--Modal editar -->
 <div id="m_editar" class="bgModal ocultar"> 
        <div class="modal m_editar">
            <div class="btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
            <div onclick='save();' class="btn_img le"><img src="<?php echo URL; ?>resource/images/iconos/guardar.png"></div>
                <h2>Editar comando</h2>
                <form name="formComandos" method="post">
                    <table class="tableComandos">
                        <tr><td>Area</td><td>Fase</td><td>Herramientas</td></tr>
                        <tr>
                            <td class="tselect"><select name="areae" id="areae" onclick="get_fasese();"></select></td>    
                            <td class="tselect"><select name="fasee" id="fasee"></select></td>
                            <td class="tselect"><select name="herramientae" id="herramientae"></select></td>
                        </tr>
                        <tr><th colspan="3">Comando</th></tr>
                        <tr><td colspan="3"><textarea id="comando" name="comando" class='taComando'></textarea></td></tr>
                        <tr><th colspan="3">Etiquetas</th></tr>
                        <tr><td colspan="3"><input type="text" class="input" id="etiquetas" name="etiquetas"></td></tr>
                        <tr><th colspan="3">Descripcion</th></tr>
                        <tr><td colspan="3"><input type="text" class="input"  id="descripcion" name="descripcion"></td></tr>
                        <tr><th colspan="3">Detalles</th></tr>
                        <tr><td colspan="3"><textarea id="detalles" name="detalles" class='taDetalles'></textarea></td></tr>
                        <input type="hidden" name="idComando" id="idComando">
                    </table>
                </form>
        </div>  
    </div>
    <!--Modal ver -->
 <div id="m_ver" class="bgModal ocultar"> 
        <div class="modal m_ver">
            <div class="btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
            <h2 id="descripcionV"></h2>
                <form >
                    <table class="tableComandos">
                        <tr><td colspan="2"><textarea id="comandoV" name="comandoV" class='taComando'></textarea></td></tr>
                        <tr><th colspan="2">Detalles</th></tr>
                        <tr><td colspan="2"><textarea id="detallesV" name="detallesV" class='taDetalles'></textarea></td></tr>
                    </table>
                </form>
        </div>  
    </div>
    <!--Modal herramientas -->
    <div id="m_herramientas" class="bgModal ocultar"> 
        <div class="modal">
        <div class=" btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
            <h2>Notas de la herramienta</h2>
            <table>
                <tr><td><textarea id="ayuda" class="ayuda" name="ayuda"></textarea></td></tr>
            </table>
        </div> 
    </div>
    <!--Modal archivos -->
    <div id="m_archivo" class="bgModal ocultar">
        <div class="modal m_archivos">
        <div class="btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
        <div onclick='save_archivo();' class="btn_img le"><img src="<?php echo URL; ?>resource/images/iconos/guardar.png"></div>
            <h2>Guardar archivo (ZIP o RAR)</h2>
            <form action="update_archivo" method="POST" name="formArchivo" enctype="multipart/form-data">
                <table class="tableComandos">
                    <tr>
                        <td><input type="file" name="archivo" id="archivo"></td>
                        <td>Eliminar:<input type="checkbox" name="delete" value="1"> </td>
                    </tr>
                    <input type="hidden" name="nombreArchivoDB" id="nombreArchivoDB">
                    <input type="hidden" name="idComandoA" id="idComandoA">
                </table>
            </form>
        </div> 
    </div>
    <!-- Modal delete -->
    <div id="m_eliminar" class="bgModal ocultar"> 
        <div class="modal m_eliminar">
        <div class="btn_img cancelar ri"><img src="<?php echo URL; ?>resource/images/iconos/cancelar.png"></div>
        <div onclick='deleteC();' class="btn_img le"><img src="<?php echo URL; ?>resource/images/iconos/eliminar.png"></div>
            <h2>¿Esta seguro de eliminar?</h2>
            <form action="#" method="POST" id="deleteForm" name="deleteForm">
                <table>
                    <tr><td><h3 id="nombreComandoD"></h3></td></tr>
                        <td><input type="hidden" name="idComandoD" id="idComandoD" value=""></td>
                        <td><input type="hidden" name="path" id="path" value=""></td>
                    </tr>
                </table>
            </form>
        </div>
</div>
 