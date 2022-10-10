component persistent="true" {
	
	property name="id" column="id" fieldtype="id" generator="increment";
	property name="firstname" ormtype="string" ;
	property name="lastname" ormtype="text" ;
	property name="emailaddress" ormtype="string" ;
	property name="password" ormtype="string" ;
	property name="salt" ormtype="string" ;
	
}