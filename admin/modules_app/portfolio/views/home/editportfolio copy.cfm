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
