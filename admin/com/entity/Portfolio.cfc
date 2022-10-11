component table="portfolio" persistent="true" {
	
	property name="id" column="id" fieldtype="id" generator="increment";
	property name="title" ormtype="string" ;
	property name="summary" ormtype="text" ;
	property name="website" ormtype="string" ;
	property name="image" ormtype="string" ;
	property name="categorias" column="categoryid" type="array" fieldtype="many-to-one" cfc="PortfolioCategory" fkcolumn="categoryid";	
}