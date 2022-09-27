In this hands on, we are going to create a more complex query and output that to the page.

**Tags Used**: [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfcomponent>](https://helpx.adobe.com/coldfusion/developing-applications/building-blocks-of-coldfusion-applications/building-and-using-coldfusion-components.html)

1. Duplique o arquivo Main.cfm que está dentro da pasta admin\layouts e renomei ele para LoginLayout.cfm

1. Abra o arquivo ModuleConfig.cfc que está dentro da pasta admin\modules_app\login\ e na linha 81 altere conforme abaixo
	```cfml
		defaultLayout = "LoginLayout"
	```

1. No arquivo Main.cfm coloque a validação abaixo no topo da página
	```cfml
		<cfif !structKeyExists(session,"adminID") || !val(session.adminID)>
			<cflocation 
				url="#event.getHTMLBaseURL()#index.cfm/login" 
				addtoken="false">
		</cfif>
	```

1. Reinicie a aplicação chamando a seguinte URL: http://localhost:8500/cursocf/admin/index.cfm?fwreinit=1 (conforme o nome da sua pasta)

1. Crie um componente chamado Login.cfc na pasta admin\modules_app\login\models

1. Dentro da tag  <cfcomponent>, crie uma função chamada getLogin com dois aurgumentos: email e senha

1. Essa função deve validar o login passado pelo usuário

