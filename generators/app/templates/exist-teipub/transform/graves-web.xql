(:~

    Transformation module generated from TEI ODD extensions for processing models.
    ODD: /db/<%- defcoll %>/<%- short %>/<%- odd %>/graves.odd
 :)
xquery version "3.1";

module namespace model="http://www.tei-c.org/pm/models/graves/web";

declare default element namespace "http://www.tei-c.org/ns/1.0";

declare namespace xhtml='http://www.w3.org/1999/xhtml';

declare namespace xi='http://www.w3.org/2001/XInclude';

declare namespace pb='http://teipublisher.com/1.0';

import module namespace css="http://www.tei-c.org/tei-simple/xquery/css";

import module namespace html="http://www.tei-c.org/tei-simple/xquery/functions";

(:~

    Main entry point for the transformation.
    
 :)
declare function model:transform($options as map(*), $input as node()*) {
        
    let $config :=
        map:new(($options,
            map {
                "output": ["web"],
                "odd": "/db/<%- defcoll %>/<%- short %>/<%- odd %>/graves.odd",
                "apply": model:apply#2,
                "apply-children": model:apply-children#3
            }
        ))
    
    return (
        html:prepare($config, $input),
    
        let $output := model:apply($config, $input)
        return
            html:finish($config, $output)
    )
};

declare function model:apply($config as map(*), $input as node()*) {
        let $parameters := 
        if (exists($config?parameters)) then $config?parameters else map {}
    return
    $input !         (
            let $node := 
                .
            return
                            typeswitch(.)
                    case element(castItem) return
                        (: Insert item, rendered as described in parent list rendition. :)
                        html:listItem($config, ., ("tei-castItem"), ., ())
                    case element(item) return
                        html:listItem($config, ., ("tei-item"), ., ())
                    case element(figure) return
                        if (head or @rendition='simple:display') then
                            html:block($config, ., ("tei-figure1"), .)
                        else
                            html:inline($config, ., ("tei-figure2"), .)
                    case element(teiHeader) return
                        if ($parameters?header='short') then
                            html:block($config, ., ("tei-teiHeader3"), .)
                        else
                            html:metadata($config, ., ("tei-teiHeader4"), .)
                    case element(supplied) return
                        if (parent::choice) then
                            html:inline($config, ., ("tei-supplied1"), .)
                        else
                            if (@reason='damage') then
                                html:inline($config, ., ("tei-supplied2"), .)
                            else
                                if (@reason='illegible' or not(@reason)) then
                                    html:inline($config, ., ("tei-supplied3"), .)
                                else
                                    if (@reason='omitted') then
                                        html:inline($config, ., ("tei-supplied4"), .)
                                    else
                                        html:inline($config, ., ("tei-supplied5"), .)
                    case element(milestone) return
                        html:inline($config, ., ("tei-milestone"), .)
                    case element(label) return
                        html:inline($config, ., ("tei-label"), .)
                    case element(signed) return
                        if (parent::closer) then
                            html:block($config, ., ("tei-signed1"), .)
                        else
                            html:inline($config, ., ("tei-signed2"), .)
                    case element(pb) return
                        html:omit($config, ., ("tei-pb"), .)
                    case element(pc) return
                        html:inline($config, ., ("tei-pc"), .)
                    case element(anchor) return
                        html:anchor($config, ., ("tei-anchor"), ., @xml:id)
                    case element(TEI) return
                        html:document($config, ., ("tei-TEI2"), .)
                    case element(formula) return
                        if (@rendition='simple:display') then
                            html:block($config, ., ("tei-formula1"), .)
                        else
                            html:inline($config, ., ("tei-formula2"), .)
                    case element(choice) return
                        if (sic and corr) then
                            html:alternate($config, ., ("tei-choice4"), ., corr[1], sic[1])
                        else
                            if (abbr and expan) then
                                html:alternate($config, ., ("tei-choice5"), ., expan[1], abbr[1])
                            else
                                if (orig and reg) then
                                    html:alternate($config, ., ("tei-choice6"), ., reg[1], orig[1])
                                else
                                    $config?apply($config, ./node())
                    case element(hi) return
                        if (@rendition) then
                            html:inline($config, ., css:get-rendition(., ("tei-hi1")), .)
                        else
                            if (not(@rendition)) then
                                html:inline($config, ., ("tei-hi2"), .)
                            else
                                $config?apply($config, ./node())
                    case element(code) return
                        html:inline($config, ., ("tei-code"), .)
                    case element(note) return
                        if (@place) then
                            html:note($config, ., ("tei-note1"), ., @place, @n)
                        else
                            if (parent::div and not(@place)) then
                                html:block($config, ., ("tei-note2"), .)
                            else
                                if (not(@place)) then
                                    html:inline($config, ., ("tei-note3"), .)
                                else
                                    $config?apply($config, ./node())
                    case element(dateline) return
                        html:block($config, ., css:get-rendition(., ("tei-dateline2")), .)
                    case element(back) return
                        html:block($config, ., ("tei-back"), .)
                    case element(del) return
                        html:inline($config, ., ("tei-del"), .)
                    case element(trailer) return
                        html:block($config, ., ("tei-trailer"), .)
                    case element(titlePart) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePart")), .)
                    case element(ab) return
                        html:paragraph($config, ., ("tei-ab"), .)
                    case element(revisionDesc) return
                        html:omit($config, ., ("tei-revisionDesc"), .)
                    case element(am) return
                        html:inline($config, ., ("tei-am"), .)
                    case element(subst) return
                        html:inline($config, ., ("tei-subst"), .)
                    case element(roleDesc) return
                        html:block($config, ., ("tei-roleDesc"), .)
                    case element(orig) return
                        html:inline($config, ., ("tei-orig"), .)
                    case element(opener) return
                        html:block($config, ., ("tei-opener2"), .)
                    case element(speaker) return
                        html:block($config, ., ("tei-speaker"), .)
                    case element(imprimatur) return
                        html:block($config, ., ("tei-imprimatur"), .)
                    case element(publisher) return
                        if (ancestor::teiHeader) then
                            (: Omit if located in teiHeader. :)
                            html:omit($config, ., ("tei-publisher"), .)
                        else
                            $config?apply($config, ./node())
                    case element(figDesc) return
                        html:inline($config, ., ("tei-figDesc"), .)
                    case element(rs) return
                        html:inline($config, ., ("tei-rs"), .)
                    case element(foreign) return
                        html:inline($config, ., ("tei-foreign"), .)
                    case element(fileDesc) return
                        if ($parameters?header='short') then
                            (
                                html:block($config, ., ("tei-fileDesc1", "header-short"), titleStmt),
                                html:block($config, ., ("tei-fileDesc2", "header-short"), editionStmt),
                                html:block($config, ., ("tei-fileDesc3", "header-short"), publicationStmt)
                            )

                        else
                            html:title($config, ., ("tei-fileDesc4"), titleStmt)
                    case element(seg) return
                        html:inline($config, ., css:get-rendition(., ("tei-seg")), .)
                    case element(profileDesc) return
                        html:omit($config, ., ("tei-profileDesc"), .)
                    case element(email) return
                        html:inline($config, ., ("tei-email"), .)
                    case element(text) return
                        html:body($config, ., ("tei-text"), .)
                    case element(floatingText) return
                        html:block($config, ., ("tei-floatingText"), .)
                    case element(sp) return
                        html:block($config, ., ("tei-sp"), .)
                    case element(abbr) return
                        html:inline($config, ., ("tei-abbr"), .)
                    case element(table) return
                        html:table($config, ., ("tei-table"), .)
                    case element(cb) return
                        html:break($config, ., ("tei-cb"), ., 'column', @n)
                    case element(group) return
                        html:block($config, ., ("tei-group"), .)
                    case element(licence) return
                        if (@target) then
                            html:link($config, ., ("tei-licence1", "licence"), 'Licence', @target)
                        else
                            html:omit($config, ., ("tei-licence2"), .)
                    case element(editor) return
                        if (ancestor::teiHeader) then
                            html:omit($config, ., ("tei-editor1"), .)
                        else
                            html:inline($config, ., ("tei-editor2"), .)
                    case element(c) return
                        html:inline($config, ., ("tei-c"), .)
                    case element(listBibl) return
                        if (bibl) then
                            html:list($config, ., ("tei-listBibl1"), bibl, ())
                        else
                            html:block($config, ., ("tei-listBibl2"), .)
                    case element(address) return
                        html:block($config, ., ("tei-address"), .)
                    case element(g) return
                        if (not(text())) then
                            html:glyph($config, ., ("tei-g1"), .)
                        else
                            html:inline($config, ., ("tei-g2"), .)
                    case element(author) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-author1"), .)
                        else
                            html:inline($config, ., ("tei-author2"), .)
                    case element(castList) return
                        if (child::*) then
                            html:list($config, ., css:get-rendition(., ("tei-castList")), castItem, ())
                        else
                            $config?apply($config, ./node())
                    case element(l) return
                        html:block($config, ., css:get-rendition(., ("tei-l")), .)
                    case element(closer) return
                        html:block($config, ., ("tei-closer2"), .)
                    case element(rhyme) return
                        html:inline($config, ., ("tei-rhyme"), .)
                    case element(list) return
                        if (@rendition) then
                            html:list($config, ., css:get-rendition(., ("tei-list1")), item, ())
                        else
                            if (not(@rendition)) then
                                html:list($config, ., ("tei-list2"), item, ())
                            else
                                $config?apply($config, ./node())
                    case element(p) return
                        html:paragraph($config, ., css:get-rendition(., ("tei-p")), .)
                    case element(measure) return
                        html:inline($config, ., ("tei-measure"), .)
                    case element(q) return
                        if (l) then
                            html:block($config, ., css:get-rendition(., ("tei-q1")), .)
                        else
                            if (ancestor::p or ancestor::cell) then
                                html:inline($config, ., css:get-rendition(., ("tei-q2")), .)
                            else
                                html:block($config, ., css:get-rendition(., ("tei-q3")), .)
                    case element(actor) return
                        html:inline($config, ., ("tei-actor"), .)
                    case element(epigraph) return
                        html:block($config, ., ("tei-epigraph"), .)
                    case element(s) return
                        html:inline($config, ., ("tei-s"), .)
                    case element(docTitle) return
                        html:block($config, ., css:get-rendition(., ("tei-docTitle")), .)
                    case element(lb) return
                        html:break($config, ., css:get-rendition(., ("tei-lb")), ., 'line', @n)
                    case element(w) return
                        html:inline($config, ., ("tei-w"), .)
                    case element(stage) return
                        html:block($config, ., ("tei-stage"), .)
                    case element(titlePage) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePage")), .)
                    case element(name) return
                        if ($parameters?mode='facets' and @type='person') then
                            html:webcomponent($config, ., ("tei-name2"), id(substring-after(@ref, '#'), root($parameters?root)), 'pb-highlight', map {"key": substring-after(@ref, '#'), "subscribe": 'letter', "emit": 'facets'})
                        else
                            if ($parameters?mode='facets' and @type='place') then
                                html:webcomponent($config, ., ("tei-name3"), id(substring-after(@ref, '#'), root($parameters?root)), 'pb-highlight', map {"key": substring-after(@ref, '#'), "scroll": true(), "subscribe": 'letter', "emit": 'facets'})
                            else
                                if (@type='place' and id(substring-after(@ref, '#'), root($parameters?root))/location/geo) then
                                    html:webcomponent($config, ., ("tei-name4"), ., 'pb-geolocation', map {"longitude": tokenize(id(substring-after(@ref, '#'), root($parameters?root))/location/geo, ' ')[2], "latitude": tokenize(id(substring-after(@ref, '#'), root($parameters?root))/location/geo, ' ')[1], "label": id(substring-after(@ref, '#'), root($parameters?root))/placeName, "key": substring-after(@ref, '#'), "scroll": true(), "emit": 'letter', "duration": 1000})
                                else
                                    if (@type='person' and id(substring-after(@ref, '#'), root($parameters?root))) then
                                        html:webcomponent($config, ., ("tei-name5"), ., 'pb-highlight', map {"key": substring-after(@ref, '#'), "scroll": true(), "emit": 'letter'})
                                    else
                                        if (@type='place') then
                                            html:inline($config, ., ("tei-name6"), .)
                                        else
                                            $config?apply($config, ./node())
                    case element(front) return
                        html:block($config, ., ("tei-front"), .)
                    case element(lg) return
                        html:block($config, ., ("tei-lg"), .)
                    case element(publicationStmt) return
                        html:block($config, ., ("tei-publicationStmt1"), availability/licence)
                    case element(biblScope) return
                        html:inline($config, ., ("tei-biblScope"), .)
                    case element(desc) return
                        html:inline($config, ., ("tei-desc"), .)
                    case element(role) return
                        html:block($config, ., ("tei-role"), .)
                    case element(docEdition) return
                        html:inline($config, ., ("tei-docEdition"), .)
                    case element(num) return
                        html:inline($config, ., ("tei-num"), .)
                    case element(docImprint) return
                        html:inline($config, ., ("tei-docImprint"), .)
                    case element(postscript) return
                        (
                            html:heading($config, ., ("tei-postscript2"), ('Postscript by ', id(substring-after(@resp, '#'), root(.))/persName), 5),
                            html:block($config, ., ("tei-postscript3"), .)
                        )

                    case element(edition) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-edition"), .)
                        else
                            $config?apply($config, ./node())
                    case element(cell) return
                        (: Insert table cell. :)
                        html:cell($config, ., ("tei-cell"), ., ())
                    case element(relatedItem) return
                        html:inline($config, ., ("tei-relatedItem"), .)
                    case element(div) return
                        if (@type='title_page') then
                            html:block($config, ., ("tei-div1"), .)
                        else
                            if (parent::body or parent::front or parent::back) then
                                html:section($config, ., ("tei-div2"), .)
                            else
                                html:block($config, ., ("tei-div3"), .)
                    case element(graphic) return
                        html:graphic($config, ., ("tei-graphic"), ., @url, @width, @height, @scale, desc)
                    case element(reg) return
                        html:inline($config, ., ("tei-reg"), .)
                    case element(ref) return
                        if (not(@target)) then
                            html:inline($config, ., ("tei-ref1"), .)
                        else
                            if (not(text())) then
                                html:link($config, ., ("tei-ref2"), @target, ())
                            else
                                html:link($config, ., ("tei-ref3"), ., ())
                    case element(pubPlace) return
                        if (ancestor::teiHeader) then
                            (: Omit if located in teiHeader. :)
                            html:omit($config, ., ("tei-pubPlace"), .)
                        else
                            $config?apply($config, ./node())
                    case element(add) return
                        html:inline($config, ., ("tei-add"), .)
                    case element(docDate) return
                        html:inline($config, ., ("tei-docDate"), .)
                    case element(head) return
                        if ($parameters?header='short') then
                            html:inline($config, ., ("tei-head1"), replace(string-join(.//text()[not(parent::ref)]), '^(.*?)[^\w]*$', '$1'))
                        else
                            if (parent::figure) then
                                html:block($config, ., ("tei-head2"), .)
                            else
                                if (parent::table) then
                                    html:block($config, ., ("tei-head3"), .)
                                else
                                    if (parent::lg) then
                                        html:block($config, ., ("tei-head4"), .)
                                    else
                                        if (parent::list) then
                                            html:block($config, ., ("tei-head5"), .)
                                        else
                                            if (parent::div) then
                                                html:heading($config, ., ("tei-head6"), ., count(ancestor::div))
                                            else
                                                html:block($config, ., ("tei-head7"), .)
                    case element(ex) return
                        html:inline($config, ., ("tei-ex"), .)
                    case element(castGroup) return
                        if (child::*) then
                            (: Insert list. :)
                            html:list($config, ., ("tei-castGroup"), castItem|castGroup, ())
                        else
                            $config?apply($config, ./node())
                    case element(time) return
                        html:inline($config, ., ("tei-time"), .)
                    case element(bibl) return
                        if (parent::listBibl) then
                            html:listItem($config, ., ("tei-bibl1"), ., ())
                        else
                            html:inline($config, ., ("tei-bibl2"), .)
                    case element(salute) return
                        if (parent::closer) then
                            html:inline($config, ., ("tei-salute1"), .)
                        else
                            html:block($config, ., ("tei-salute2"), .)
                    case element(unclear) return
                        html:inline($config, ., ("tei-unclear"), .)
                    case element(argument) return
                        html:block($config, ., ("tei-argument"), .)
                    case element(date) return
                        if (@when) then
                            html:alternate($config, ., ("tei-date3"), ., ., @when)
                        else
                            if (text()) then
                                html:inline($config, ., ("tei-date4"), .)
                            else
                                $config?apply($config, ./node())
                    case element(title) return
                        if ($parameters?header='short') then
                            html:heading($config, ., ("tei-title1"), ., 5)
                        else
                            if (parent::titleStmt/parent::fileDesc) then
                                (
                                    if (preceding-sibling::title) then
                                        html:text($config, ., ("tei-title2"), ' — ')
                                    else
                                        (),
                                    html:inline($config, ., ("tei-title3"), .)
                                )

                            else
                                if (not(@level) and parent::bibl) then
                                    html:inline($config, ., ("tei-title4"), .)
                                else
                                    if (@level='m' or not(@level)) then
                                        (
                                            html:inline($config, ., ("tei-title5"), .),
                                            if (ancestor::biblFull) then
                                                html:text($config, ., ("tei-title6"), ', ')
                                            else
                                                ()
                                        )

                                    else
                                        if (@level='s' or @level='j') then
                                            (
                                                html:inline($config, ., ("tei-title7"), .),
                                                if (following-sibling::* and     (  ancestor::biblFull)) then
                                                    html:text($config, ., ("tei-title8"), ', ')
                                                else
                                                    ()
                                            )

                                        else
                                            if (@level='u' or @level='a') then
                                                (
                                                    html:inline($config, ., ("tei-title9"), .),
                                                    if (following-sibling::* and     (    ancestor::biblFull)) then
                                                        html:text($config, ., ("tei-title10"), '. ')
                                                    else
                                                        ()
                                                )

                                            else
                                                html:inline($config, ., ("tei-title11"), .)
                    case element(corr) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            (: simple inline, if in parent choice. :)
                            html:inline($config, ., ("tei-corr1"), .)
                        else
                            html:inline($config, ., ("tei-corr2"), .)
                    case element(cit) return
                        if (child::quote and child::bibl) then
                            (: Insert citation :)
                            html:cit($config, ., ("tei-cit"), ., ())
                        else
                            $config?apply($config, ./node())
                    case element(titleStmt) return
                        if ($parameters?mode='title') then
                            html:heading($config, ., ("tei-titleStmt3"), title[not(@type)], 5)
                        else
                            if ($parameters?header='short') then
                                (
                                    html:link($config, ., ("tei-titleStmt4"), title[1], $parameters?doc),
                                    html:block($config, ., ("tei-titleStmt5"), subsequence(title, 2)),
                                    html:block($config, ., ("tei-titleStmt6"), author)
                                )

                            else
                                html:block($config, ., ("tei-titleStmt7"), .)
                    case element(sic) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            html:inline($config, ., ("tei-sic1"), .)
                        else
                            html:inline($config, ., ("tei-sic2"), .)
                    case element(expan) return
                        html:inline($config, ., ("tei-expan"), .)
                    case element(body) return
                        if ($parameters?mode='facets') then
                            (
                                html:heading($config, ., ("tei-body1"), 'Places', 2),
                                html:block($config, ., ("tei-body2"), for $n in .//name[@type='place'] group by $ref := $n/@ref order by $ref return $n[1]),
                                html:heading($config, ., ("tei-body3"), 'People', 2),
                                html:section($config, ., ("tei-body4"), for $n in .//name[@type='person'] group by $ref := $n/@ref order by $ref return $n[1])
                            )

                        else
                            (
                                html:index($config, ., ("tei-body5"), 'toc', .),
                                html:block($config, ., ("tei-body6"), .)
                            )

                    case element(spGrp) return
                        html:block($config, ., ("tei-spGrp"), .)
                    case element(fw) return
                        if (ancestor::p or ancestor::ab) then
                            html:inline($config, ., ("tei-fw1"), .)
                        else
                            html:block($config, ., ("tei-fw2"), .)
                    case element(encodingDesc) return
                        html:omit($config, ., ("tei-encodingDesc"), .)
                    case element(addrLine) return
                        html:block($config, ., ("tei-addrLine"), .)
                    case element(gap) return
                        if (desc) then
                            html:inline($config, ., ("tei-gap1"), .)
                        else
                            if (@extent) then
                                html:inline($config, ., ("tei-gap2"), @extent)
                            else
                                html:inline($config, ., ("tei-gap3"), .)
                    case element(quote) return
                        if (ancestor::p) then
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            html:inline($config, ., css:get-rendition(., ("tei-quote1")), .)
                        else
                            (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                            html:block($config, ., css:get-rendition(., ("tei-quote2")), .)
                    case element(row) return
                        if (@role='label') then
                            html:row($config, ., ("tei-row1"), .)
                        else
                            (: Insert table row. :)
                            html:row($config, ., ("tei-row2"), .)
                    case element(docAuthor) return
                        html:inline($config, ., ("tei-docAuthor"), .)
                    case element(byline) return
                        html:block($config, ., ("tei-byline"), .)
                    case element(place) return
                        (
                            html:heading($config, ., ("tei-place2"), string-join(placeName, ', '), 3),
                            if (location/geo) then
                                html:block($config, ., ("tei-place3"), location/geo)
                            else
                                (),
                            html:block($config, ., ("tei-place4"), string-join(location/* except location/geo, ', ')),
                            html:block($config, ., ("tei-place5"), note/node())
                        )

                    case element(geo) return
                        (
                            html:inline($config, ., ("tei-geo1"), 'Location: '),
                            html:webcomponent($config, ., ("tei-geo2"), ., 'pb-geolocation', map {"latitude": tokenize(., ' ')[1], "longitude": tokenize(., ' ')[2], "emit": 'letter'}),
                            html:inline($config, ., ("tei-geo3"), .)
                        )

                    case element(person) return
                        (
                            html:heading($config, ., ("tei-person2"), persName, 3),
                            if (birth or death or occupation) then
                                html:block($config, ., ("tei-person3"), (occupation, birth, death))
                            else
                                (),
                            if (idno) then
                                html:block($config, ., ("tei-person4"), idno)
                            else
                                (),
                            html:block($config, ., ("tei-person5"), note/node())
                        )

                    case element(persName) return
                        if (forename or surname) then
                            html:inline($config, ., ("tei-persName1"), (forename, ' ', surname[not(@type='married')], if (surname[@type='married']) then (' (', string-join(surname[@type='married'], ', '), ')') else ()))
                        else
                            html:inline($config, ., ("tei-persName2"), .)
                    case element(birth) return
                        if (following-sibling::death) then
                            html:inline($config, ., ("tei-birth1"), ('* ', ., '; '))
                        else
                            html:inline($config, ., ("tei-birth2"), ('* ', .))
                    case element(death) return
                        html:inline($config, ., ("tei-death"), ('✝', .))
                    case element(occupation) return
                        html:inline($config, ., ("tei-occupation"), (., ' '))
                    case element(idno) return
                        if (@type='VIAF' and following-sibling::idno) then
                            html:link($config, ., ("tei-idno1"), 'VIAF', 'https://viaf.org/viaf/' || string() || '/')
                        else
                            if (@type='VIAF') then
                                html:link($config, ., ("tei-idno2"), 'VIAF', 'https://viaf.org/viaf/' || string() || '/')
                            else
                                if (@type='LC-Name-Authority-File' and following-sibling::idno) then
                                    html:link($config, ., ("tei-idno3"), 'LoC Authority', 'https://lccn.loc.gov/' || string())
                                else
                                    if (@type='LC-Name-Authority-File') then
                                        html:link($config, ., ("tei-idno4"), 'LoC Authority', 'https://lccn.loc.gov/' || string())
                                    else
                                        $config?apply($config, ./node())
                    case element(exist:match) return
                        html:match($config, ., .)
                    case element() return
                        if (namespace-uri(.) = 'http://www.tei-c.org/ns/1.0') then
                            $config?apply($config, ./node())
                        else
                            .
                    case text() | xs:anyAtomicType return
                        html:escapeChars(.)
                    default return 
                        $config?apply($config, ./node())

        )

};

declare function model:apply-children($config as map(*), $node as element(), $content as item()*) {
        
    $content ! (
        typeswitch(.)
            case element() return
                if (. is $node) then
                    $config?apply($config, ./node())
                else
                    $config?apply($config, .)
            default return
                html:escapeChars(.)
    )
};

