# pandoc --verbose -f docbook -t asciidoc -s bundle.xml -o out/doc.adoc

xmllint --xinclude documentation.xml --output bundle.xml
saxon -xsl:stylesheets/cavatina2docbook.xsl -s:bundle.xml -o:bundle2.xml
# saxon -xsl:stylesheets/html.xsl -s:bundle2.xml -o:out/test.html