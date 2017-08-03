import module namespace m='http://www.tei-c.org/pm/models/beamer/epub' at '/db/apps/teipub/transform/beamer-epub.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["../transform/beamer.css"],
    "collection": "/db/apps/teipub/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)