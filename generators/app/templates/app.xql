xquery version "3.1";

(:~ This is the default application library module of the <%- title %> app.
 :
 : @author <%- author %>
 : @version <%- version %>
 : @see <%- website %>
 :)

(: Module for app-specific template functions :)
<%_ if (apptype == 'teipub') { %>
module namespace app="teipublisher.com/app";
<% } else { %>
module namespace app="<%- defuri %>/<%- defcoll %>/<%- short %>/templates";
<% } _%>
import module namespace templates="http://exist-db.org/xquery/templates";
<%_ if (apptype == 'teipub') { %>
import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";
<% } else { %>
import module namespace config="<%- defuri %>/<%- defcoll %>/<%- short %>/config" at "config.xqm";
<% } _%>

(:~
 : This is a sample templating function. It will be called by the templating module if
 : it encounters an HTML element with an attribute: data-template="app:test" or class="app:test" (deprecated).
 : The function has to take 2 default parameters. Additional parameters are automatically mapped to
 : any matching request or function parameter.
 :
 : @param $node the HTML node with the attribute which triggered this call
 : @param $model a map containing arbitrary data - used to pass information between template calls
 :)

declare
    %templates:wrap
function app:foo($node as node(), $model as map(*)) {
    <p>Dummy templating function.</p>
};
<%_ if (apptype !== 'teipub') { %>
declare function app:test($node as node(), $model as map(*)) {
      <p>Dummy template output generated by function app:test at {current-dateTime()}. The templating
          function was triggered by the data-template attribute <code>data-template="app:test"</code>.</p>
};
<% } _%>
