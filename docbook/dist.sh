
xmllint --xinclude documentation.xml --output bundle.xml
saxon -xsl:cavatina2docbook.xsl -s:bundle.xml -o:bundle2.xml
pandoc --verbose -f docbook -t asciidoc -s bundle2.xml -o out/doc.adoc