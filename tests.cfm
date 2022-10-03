<cfoutput>
	Salt = #GenerateSecretKey("AES")# <br>
	AES = #Hash(GenerateSecretKey("AES"), "SHA-256", "UTF-8")# <br>
</cfoutput>