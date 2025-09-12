$(document).ready(function() {
   get_areas();
   get_fases("");
   get_herramientas();

   $(".cancelar").click(function() {
        $("#m_editar").addClass("ocultar"); 
        $("#m_ver").addClass("ocultar");
        $("#m_herramientas").addClass("ocultar");
        $("#m_archivo").addClass("ocultar");
        $("#m_eliminar").addClass("ocultar");     
   });   
});
var get_areas = ()=>{
    $.ajax({
         type: "POST",
         url: "get_areas",
         success: function(response)
         {
            $('#area').html(response).fadeIn();
            $('#areae').html(response).fadeIn();
         }
   });
}
var get_fases = (area)=>{
    datos = 'area='+area;
    $.ajax({
         type: "POST",
         url: "get_fases",
         data: datos,
         success: function(response)
         {
            $('#fase').html(response).fadeIn();
            $('#fasee').html(response).fadeIn();
         }
   });
}
var get_fasese = ()=>{
    var areae = document.getElementById("areae").value;
    datos = 'area='+areae;
    $.ajax({
         type: "POST",
         url: "get_fases",
         data: datos,
         success: function(response)
         {
            $('#fasee').html(response).fadeIn();
         }
   });
}
var get_herramientas = ()=>{
    $.ajax({
         type: "POST",
         url: "get_herramientas",
         success: function(response)
         {
            $('#herramienta').html(response).fadeIn();
            $('#herramientae').html(response).fadeIn();
         }
   });
}
get_comandos=(select)=>{ 
    var area = document.getElementById("area").value;
    if(select=="area"){
        if(area!=""){
            document.getElementById("fase").disabled=false;
            get_fases(area);
        }
        else{
            document.getElementById("fase").disabled=true;
        }
        document.getElementById("fase").value="";
        document.getElementById("herramienta").value="";
        document.getElementById("buscar").value="";
    }
   var fase = document.getElementById("fase").value;
    if(select=="fase"){
        document.getElementById("herramienta").value="";
        document.getElementById("buscar").value="";
    }
   var herramienta = document.getElementById("herramienta").value;
    if(select=="herramienta"){
        document.getElementById("buscar").value="";
    }
   var buscar = document.getElementById("buscar").value;
   
   datos={'area':area,'fase':fase, 'herramienta':herramienta, 'buscar':buscar};
    $.ajax({
            type: "POST",
            url: "get_comandos",
            data: datos,
            success: function(response)
            {                     
                $("#comandos").html(response).fadeIn(); 
            }
    });
}
var insert_comando = ()=>{
    document.formComandos.action = "insert_comando";
    document.getElementById("etiquetas").value="";
    document.getElementById("comando").value="";
    document.getElementById("descripcion").value="";
    document.getElementById("detalles").value="";
    document.getElementById("areae").value="";
    document.getElementById("fasee").value="";
    document.getElementById("herramientae").value="";
    $("#m_editar").removeClass("ocultar");
 }
var update_comando = (datos)=>{
    document.formComandos.action = "update_comando";
    $("#m_editar").removeClass("ocultar");
    document.getElementById("idComando").value = datos[0];
    document.getElementById("etiquetas").value = decode(datos[1]);
    document.getElementById("comando").value=decode(datos[2]);
    document.getElementById("descripcion").value = decode(datos[3]);
    document.getElementById("detalles").value = decode(datos[4]);

    document.getElementById("areae").value = decode(datos[6]);
    document.getElementById("fasee").value = decode(datos[7]);
    console.log("idFase="+datos[7]);
    document.getElementById("herramientae").value = decode(datos[8]);
}
var ver_comando = (datos)=>{
    $("#m_ver").removeClass("ocultar");   
    document.getElementById("comandoV").value=decode(datos[2]);
    document.getElementById("descripcionV").innerHTML=decode(datos[3]);    
    document.getElementById("detallesV").value = decode(datos[4]);;
}
var save = (datos)=>{
    document.formComandos.submit();
}
//Ayuda de herramienta
var detalles_herramienta = (datosH)=>{
    $("#m_herramientas").removeClass("ocultar");
    document.getElementById("ayuda").value = datosH[2];          
}
var update_archivo = (datos)=>{
    $("#m_archivo").removeClass("ocultar");
    document.getElementById("idComandoA").value = datos[0];
    document.getElementById("nombreArchivoDB").value = decode(datos[5]);
    document.getElementById("archivo").value = "";
}
var save_archivo = (datos)=>{
    document.formArchivo.submit();
}
var delete_comando = (datos)=>{
        $("#m_eliminar").removeClass("ocultar");//Quitamos la clase para mostrar
        document.deleteForm.action = "delete_comando";//Asignamor url al formulario
        console.log("Eliminando");
        console.log(datos);
        document.getElementById("nombreComandoD").innerHTML = datos[1];
        document.getElementById("idComandoD").value = datos[0];
        document.getElementById("path").value = decode(datos[7]);
}
var deleteC = (datos)=>{
    document.deleteForm.submit();
}
var limpiar = ()=>{
    document.getElementById("area").value="";
    document.getElementById("fase").value="";
    document.getElementById("herramienta").value="";
    document.getElementById("buscar").value="";
    get_comandos();
}
var verD=()=>{document.getElementById("ver").innerHTML = "Ver hoja de trucos"; $("#ver").removeClass("ocultar");}
var verS=()=>{document.getElementById("ver").innerHTML = "Descargar Script"; $("#ver").removeClass("ocultar");}
var verE=()=>{document.getElementById("ver").innerHTML = "Editar comando"; $("#ver").removeClass("ocultar");}
var verA=()=>{document.getElementById("ver").innerHTML = "Adjuntar script"; $("#ver").removeClass("ocultar");}
var verEl=()=>{document.getElementById("ver").innerHTML = "Eliminar comando"; $("#ver").removeClass("ocultar");}
var ocultar=()=>{ $("#ver").addClass("ocultar");}