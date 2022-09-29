component {
	public query function getLogin(required string email){
		qService = new Query();
		//qService.setDatasource(application.datasource);
		//qService.setName("qConsLogin");
		qService.setSql("
			select 
				id,
				firstname,
				lastname,
				emailaddress,
				password,
				salt
			from administrator
			where emailaddress = :paramEmail
		");
		qService.addParam(name="paramEmail", value=arguments.email);
		
		return qService.execute().getResult();
	}
	
}