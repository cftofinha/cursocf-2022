component table="portfoliocategory" persistent="true" {
	property name="id" column="portfoliocategoryid" fieldtype="id" generator="increment";
	property name="name" column="name" ormtype="string" ;
	
	property name="portfolios" fieldtype="one-to-many" cfc="Portfolio" fkcolumn="categoryid" lazy="true";
	
}