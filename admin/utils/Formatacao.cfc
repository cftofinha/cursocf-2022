<cfcomponent displayname="Função para limpar textos com acentuação.">

	<cffunction name="LimpaTexto" displayname="Função para limpar textos com acentuação" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[áàâãª]','a','All');
			texto = rereplaceNoCase(texto,'[éèê]','e','All');
			texto = rereplaceNoCase(texto,'[íìî]','i','All');
			texto = rereplaceNoCase(texto,'[óòôõº]','o','All');
			texto = rereplaceNoCase(texto,'[úùûü]','u','All');
			texto = rereplaceNoCase(texto,'[ç]','c','All');
			texto = rereplaceNoCase(texto,'[-]','_','All');
			texto = rereplaceNoCase(texto,'[,]','','All');
			texto = rereplaceNoCase(texto,"[']","","All");
		</cfscript>

		<cfreturn texto />

	</cffunction>

	<cffunction name="TextoAcentuado" displayname="Função para limpar textos com acentuação" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[á]','&aacute;','All');
			texto = rereplaceNoCase(texto,'[à]','&agrave','All');
			texto = rereplaceNoCase(texto,'[â]','&acirc;','All');
			texto = rereplaceNoCase(texto,'[ã]','&atilde;','All');
			texto = rereplaceNoCase(texto,'[ª]','&ordf;','All');

			texto = rereplaceNoCase(texto,'[é]','&eacute;','All');
			texto = rereplaceNoCase(texto,'[è]','&egrave;','All');
			texto = rereplaceNoCase(texto,'[ê]','&ecirc;','All');

			texto = rereplaceNoCase(texto,'[í]','&iacute;','All');
			texto = rereplaceNoCase(texto,'[ì]','&igrave;','All');
			texto = rereplaceNoCase(texto,'[î]','&icirc;','All');

			texto = rereplaceNoCase(texto,'[ó]','&oacute;','All');
			texto = rereplaceNoCase(texto,'[ò]','&ograve;','All');
			texto = rereplaceNoCase(texto,'[ô]','&ocirc;','All');
			texto = rereplaceNoCase(texto,'[õ]','&otilde;','All');
			texto = rereplaceNoCase(texto,'[º]','&ordm;','All');

			texto = rereplaceNoCase(texto,'[ú]','&uacute;','All');
			texto = rereplaceNoCase(texto,'[ù]','&ugrave;','All');
			texto = rereplaceNoCase(texto,'[û]','&ucirc;','All');
			texto = rereplaceNoCase(texto,'[ü]','&uuml;','All');

			texto = rereplaceNoCase(texto,'[ç]','&ccedil;','All');

		</cfscript>

		<cfreturn texto />

	</cffunction>

	<cffunction name="TiraEspaco" displayname="Função para tirar os espaços em branco" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[[:space:]]','','All');
		</cfscript>

		<cfreturn texto />

	</cffunction>

	<cffunction name="URLAmigavel" displayname="Função para tirar os espaços em branco" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[áàâãª]','a','All');
			texto = rereplaceNoCase(texto,'[éèê]','e','All');
			texto = rereplaceNoCase(texto,'[íìî]','i','All');
			texto = rereplaceNoCase(texto,'[óòôõº]','o','All');
			texto = rereplaceNoCase(texto,'[úùûü]','u','All');
			texto = rereplaceNoCase(texto,'[ç]','c','All');
			texto = rereplaceNoCase(texto,'[[:punct:]]','','All');
			texto = rereplaceNoCase(texto,'[[:space:]]','-','All');
		</cfscript>

		<cfreturn texto />

	</cffunction>
	<cffunction name="setNomeAmigavel" displayname="Função para tirar os espaços em branco e trocar por traços" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[áàâãª]','a','all');
			texto = rereplaceNoCase(texto,'[éèê]','e','all');
			texto = rereplaceNoCase(texto,'[íìî]','i','all');
			texto = rereplaceNoCase(texto,'[óòôõº]','o','all');
			texto = rereplaceNoCase(texto,'[úùûü]','u','all');
			texto = rereplaceNoCase(texto,'[ç]','c','all');
			texto = rereplaceNoCase(texto,'[[:punct:]]','','all');
			texto = rereplaceNoCase(texto,'[[:space:]]','-','all');
			texto = rereplaceNoCase(texto,'[(]','-','all');
			texto = rereplaceNoCase(texto,'[)]','','all');
			texto = rereplaceNoCase(texto,'[:]','','all');
			texto = rereplaceNoCase(texto,'["]','','all');
			texto = rereplaceNoCase(texto,"[']","","all");
			texto = rereplaceNoCase(texto,'[.]','','all');
		</cfscript>

		<cfreturn texto />

	</cffunction>
	
	<cffunction name="setNomeLimpoUnderlines" displayname="Função para tirar os acentos e espaços em branco e trocar por underlines" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[áàâãª]','a','all');
			texto = rereplaceNoCase(texto,'[éèê]','e','all');
			texto = rereplaceNoCase(texto,'[íìî]','i','all');
			texto = rereplaceNoCase(texto,'[óòôõº]','o','all');
			texto = rereplaceNoCase(texto,'[úùûü]','u','all');
			texto = rereplaceNoCase(texto,'[ç]','c','all');
			texto = rereplaceNoCase(texto,'[[:punct:]]','','all');
			texto = rereplaceNoCase(texto,'[[:space:]]','_','all');
			texto = rereplaceNoCase(texto,'[(]','-','all');
			texto = rereplaceNoCase(texto,'[)]','','all');
			texto = rereplaceNoCase(texto,'[:]','','all');
			texto = rereplaceNoCase(texto,'["]','','all');
			texto = rereplaceNoCase(texto,"[']","","all");
			texto = rereplaceNoCase(texto,'[.]','','all');
		</cfscript>

		<cfreturn lCase(texto) />

	</cffunction>
	
	<cffunction name="setUrlAmigavel" displayname="Função para gerar a URL amigavel" access="remote" returntype="string">
		<cfargument name="categoria" required="true" type="string" />
		<!---<cfargument name="codCategoria" required="true" type="string" />--->
		<cfargument name="codConteudo" required="false" type="numeric" />
		<cfargument name="tituloMateria" required="false" type="string" />

		<cfscript>
			var linkUrlAmigavel = "http://" & CGI.HTTP_HOST &"/pub/"& this.setNomeAmigavel(lCase(arguments.categoria))/* &"/"& arguments.codCategoria*/;

			if(isDefined("arguments.codConteudo")){
				linkUrlAmigavel = linkUrlAmigavel &"/"& arguments.codConteudo;
			}
			if(isDefined("arguments.tituloMateria")){
				linkUrlAmigavel = linkUrlAmigavel &"/"& this.setNomeAmigavel(lCase(arguments.tituloMateria));
			}

			urlAmigavel = linkUrlAmigavel;
		</cfscript>

		<cfreturn urlAmigavel />

	</cffunction>
	
	<!---
	* Funcao: Função para definir a extensao de arquivopara usar os  icons do Font Awesome
	* @name getIconeExtensao
	* @return string
	--->
	<cffunction name="getIconeExtensao" displayname="Função para definir a extensao de arquivopara usar os  icons do Font Awesome" access="remote" returntype="string">
		<cfargument name="extensao_arquivo" required="true" type="string" />
		
		<cfscript>
			//<i class="fa fa-files-o"></i>
			var extensaoArquivo = "";
			
			if(not compareNoCase(arguments.extensao_arquivo, ".doc") or not compareNoCase(arguments.extensao_arquivo, ".dot") or not compareNoCase(arguments.extensao_arquivo, ".rtf")){
				extensaoArquivo = '<i class="fa fa-file-word-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".xls")){
				extensaoArquivo = '<i class="fa fa-file-excel-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".txt")){
				extensaoArquivo = '<i class="fa fa-file-text-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".htm") or not compareNoCase(arguments.extensao_arquivo, ".html")){
				extensaoArquivo = '<i class="fa fa-file-code-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".pdf")){
				extensaoArquivo = '<i class="fa fa-file-pdf-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".zip") or not compareNoCase(arguments.extensao_arquivo, ".rar")){
				extensaoArquivo = '<i class="fa fa-file-zip-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".ppt") or not compareNoCase(arguments.extensao_arquivo, ".pps")){
				extensaoArquivo = '<i class="fa fa-file-powerpoint-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".mdb")){
				extensaoArquivo = '<i class="fa fa-file"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".gif") or not compareNoCase(arguments.extensao_arquivo, ".png") or not compareNoCase(arguments.extensao_arquivo, ".jpg") or not compareNoCase(arguments.extensao_arquivo, ".tif") or not compareNoCase(arguments.extensao_arquivo, ".bmp")){
				extensaoArquivo = '<i class="fa fa-file-image-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".mp3") or not compareNoCase(arguments.extensao_arquivo, ".wma") or not compareNoCase(arguments.extensao_arquivo, ".wav")){
				extensaoArquivo = '<i class="fa fa-file-sound-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".sql")){
				extensaoArquivo = '<i class="fa fa-file-code-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".swf")){
				extensaoArquivo = '<i class="fa fa-files-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".fla")){
				extensaoArquivo = '<i class="fa fa-files-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".css")){
				extensaoArquivo = '<i class="fa fa-file-code-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".js")){
				extensaoArquivo = '<i class="fa fa-file-code-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".dll")){
				extensaoArquivo = '<i class="fa fa-file-code-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".xml")){
				extensaoArquivo = '<i class="fa fa-file-code-o"></i>';
			}
			else if(not compareNoCase(arguments.extensao_arquivo, ".vsd")){
				extensaoArquivo = '<i class="fa fa-file-code-o"></i>';
			}
			else{
				extensaoArquivo = '<i class="fa fa-files-o"></i>';
			}
		</cfscript>

		<cfreturn extensaoArquivo />

	</cffunction>

</cfcomponent>