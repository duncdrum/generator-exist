module namespace pml='http://www.tei-c.org/pm/models/docbook/fo/module';

import module namespace m='http://www.tei-c.org/pm/models/docbook/fo' at '/db/<%- defcoll %>/<%- short %>/transform/docbook-print.xql';

(: Generated library module to be directly imported into code which
 : needs to transform TEI nodes using the ODD this module is based on.
 :)
declare function pml:transform($xml as node()*, $parameters as map(*)?) {

   let $options := map {
       "styles": ["../transform/docbook.css"],
       "collection": "/db/<%- defcoll %>/<%- short %>/transform",
       "parameters": if (exists($parameters)) then $parameters else map {}
   }
   return m:transform($options, $xml)
};