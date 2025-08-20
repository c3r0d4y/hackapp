$(document).ready(function() {
    get_herramientase(); 
   $(".cancelar").click(function() {
        console.log("cancelando");
        $("#m_view").addClass("ocultar");
        $("#m_herramientas").addClass("ocultar");
        $("#m_archivo").addClass("ocultar");
        $("#m_eliminar").addClass("ocultar");  
   });
   $("#buscar").focus(function(){
        $(this).css({"background":"rgb(0, 0, 0, .5)"})
    })
    $("#buscar").blur(function(){
        $(this).css({"background":"transparent"})
    })
  
});
get_herramientase=()=>{
    var buscar = document.getElementById("buscar").value;
    datos = 'buscar='+buscar;
    $.ajax({
        type: "POST",
        url: "get_herramientase",
        data: datos,
        success: function(response)
        {                     
            $("#herramientase").html(response).fadeIn();      
        }
    });
}
var update_herramientas = (datos)=>{
	console.log("updating");
    document.formHerramientas.action = "update_herramienta";
    $("#m_view").removeClass("ocultar");

    document.getElementById("idHerramienta").value = datos[0];
    document.getElementById("nombreHerramienta").value = decode(datos[1]);
    document.getElementById("ayudaHerramienta").value = decode(datos[2]);   
}
var save = (datos)=>{
	document.formHerramientas.submit();
}
//Ayuda de herramienta
var detallesHerramienta = (datosH)=>{
    $("#m_herramientas").removeClass("ocultar");
    ayuda=atob(datosH[1]);
    document.getElementById("ayuda").innerHTML = "<pre><code>"+ayuda+"<pre><code>";         
}
var insert_herramientas = ()=>{
	document.formHerramientas.action = "insert_herramienta";
	document.getElementById("idHerramienta").value = "";
    document.getElementById("nombreHerramienta").value = "";
    document.getElementById("ayudaHerramienta").value = "";
    $("#m_view").removeClass("ocultar");
 }
var delete_herramientas = (datos)=>{
        $("#m_eliminar").removeClass("ocultar");//Quitamos la clase para mostrar
        document.deleteForm.action = "delete_herramienta";//Asignamor url al formulario
        console.log("Eliminando");
        document.getElementById("nombreHerramientaD").innerHTML = decode(datos[1]);
        document.getElementById("idHerramientaD").value = datos[0];
}
var deleteH = (datos)=>{
	document.deleteForm.submit();
}
var update_cheat = (datos)=>{
    $("#m_archivo").removeClass("ocultar");
    document.getElementById("idHerramientaA").value = datos[0];
    document.getElementById("nombreArchivoDB").value = datos[3];
    document.getElementById("archivo").value = "";
}
var save_archivo = (datos)=>{
    document.formArchivo.submit();
}
var verE=()=>{document.getElementById("ver").innerHTML = "Editar"; $("#ver").removeClass("ocultar");}
var verD=()=>{document.getElementById("ver").innerHTML = "Cheat Sheet"; $("#ver").removeClass("ocultar");}
var verEl=()=>{document.getElementById("ver").innerHTML = "Eliminar"; $("#ver").removeClass("ocultar");}
var verA=()=>{document.getElementById("ver").innerHTML = "Cheat Sheet"; $("#ver").removeClass("ocultar");}
var ocultar=()=>{ $("#ver").addClass("ocultar");}