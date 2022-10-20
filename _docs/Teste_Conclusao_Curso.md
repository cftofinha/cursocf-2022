**Teste para conclusão do curso**:
**Obs.: As aulas dos dias 20, 21 e 24 serão aulas de apoio para dúvidas sobre o TCC**
**Ao final do exercício, compacte os arquivos e envie para tofinha@gmail.com até o dia 25/10/2022 até às 10hs**:

1. Criar um projeto novo chamado **tcc** 

1. Desenvolver um componente CFC com base na tabela nova **materia** e implementar as funcionalidades: LISTAR, DETALHAR, NOVO, ALTERAR E EXCLUIR

1. Aplicar nos arquivos lista.cfm e formulario.cfm as funcionalidades acima

1. Desenvolver um componente CFC com propriedade ORM/HIBERNATE com base na tabela nova **materia**

1. Duplique o arquivos lista.cfm e faça uso do componente ORM para listagem

1. Faça uso das operações de **entityNew()** e da **entityLoadByPK()** para métodos de insert, update e delete

**Abaixo segue exemplos para utilização**

1. Arquivo Application.cfc:

    ```cfml
		component{
		this.name='TCC';
		this.datasource = 'DIGITE-AQUI-O-NOME-DO-SEU-BANCO';
		this.applicationTimeout = createTimeSpan(10, 0, 0, 0);
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
		
		setlocale("Portuguese (Brazilian)");
		setEncoding("URL", "UTF-8");
		setEncoding("FORM", "UTF-8");
		
		this.ormEnabled=true;
		this.ormSettings={
			logsql=true,
			dbcreate="update",
			cfclocation="com/entity"
		};

		this.invokeImplicitAccessor=true;
		this.sessionCookie.httpOnly=true;
		this.sessionCookie.timeout='10';
		this.sessionCookie.disableupdate=true;
		
		function onApplicationStart(){
			application.datasource = this.datasource;
			return true;
		}
		
		function onRequestStart(string targetPage){
			if(structKeyExists(url, 'reload') && url.reload eq 2022){
				onApplicationStart();
				ormReload();
			}
		}
		
		function onError( any Exception, string EventName){
			writeDump(arguments.exception);
		}
	}
    ```
	
1. Arquivo lista.cfm:
```cfml
		<html>
			<!--- Metatags --->
			<meta charset="utf-8">
			<!---css --->
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
			<style>
				.text-blue { color:##379BC1; }
			</style>

			<!--- Title --->
			<title>Teste de Conclusão do Curso ColdFusion - SENAC/2022</title>
			<body>

				<cfoutput>
					<div class="span10">
							<form class="navbar-form pull-right">
								<a class="btn btn-primary" href="">
									<i class="icon-plus icon-white"></i> 
									Nova Mensagem
								</a>
							</form>
						<table class="table table-hover">
							<thead>
								<tr>
									<th>Assunto</th>
									<th>Destinatário</th>
									<th>Data da Mensagem</th>
									<th>Ações</th>
								</tr>
							</thead>
							<tbody>
								
									<tr>
										<td>
											<!--- assunto --->
										</td>
										<td>
											<!--- destinatário --->
										</td>
										<td>
											<!--- data mensagem --->
										</td>
										<td>
											<a href="">
												<i class="icon-edit"></i>
												Alterar
											</a>
											<a href="">
												<i class="icon-edit"></i>
												Excluir
											</a>
										</td>
									</tr>
								</cfloop>
							</tbody>
						</table>
					</div>	
				</cfoutput>
			</body>
		</html>
    ```

1. Arquivo formulario.cfm:

    ```cfml
		<cfoutput>
			<html>
				<!--- Metatags --->
				<meta charset="utf-8">
				<!---css --->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
				<style>
					.text-blue { color:##379BC1; }
				</style>

				<!--- Title --->
				<title>Teste de Conclusão do Curso ColdFusion - SENAC/2022</title>
				<body>
					<cfoutput>
						<h2>Formulário</h2>
							<form class="form-horizontal" action="" method="post" enctype="multipart/form-data">
								<div class="control-group">
									<label class="control-label" for="assunto">Assunto</label>
									<div class="controls">
										<input type="text" id="assunto" name="assunto" value="">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="mensagem">Mensagem</label>
									<div class="controls">
										<textarea rows="3" id="mensagem" name="mensagem"></textarea>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="dataMensagem">Data da Mensagem</label>
									<div class="controls">
										<input type="text" id="dataMensagem" name="dataMensagem" value="">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="destinatario">Destinatário</label>
									<div class="controls">
										<select name="destinatario">
											<option value="">Selecione o Destinatário</option>
											<option value="Tofinha">Tofinha</option>
											<option value="Daniel">Daniel</option>
											<option value="Dagoberto">Dagoberto</option>
											<option value="Marcos">Marcos</option>
											<option value="Marcella">Marcella</option>
											<option value="Rodrigo">Rodrigo</option>
											<option value="Sandro">Sandro</option>
											<option value="Weller">Weller</option>
										</select>
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<button type="submit" class="btn btn-primary">Salvar</button>
									</div>
								</div>
							</form>
						</div>
					</cfoutput>
				</body>
			</html>
    ```