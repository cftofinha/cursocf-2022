In this hands on, we are going to create a more complex query and output that to the page.

**Tags Used**: [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfcomponent>](https://helpx.adobe.com/coldfusion/developing-applications/building-blocks-of-coldfusion-applications/building-and-using-coldfusion-components.html)


1. Create a component called Portifolio.cfc in folder models

1. Inside the <cfcomponent> tag, create a function to query records based on the portfolio table

1. Create insert function for portfolio table

1. Change the portifolio.cfm page by instantiating your new CFC model and replace the static data with dynamic

1. Create a cfm page to test your insert functionality and on this same page make a function to send an image using the <cffile> tag

