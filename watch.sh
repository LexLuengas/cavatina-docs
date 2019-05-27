echo 'Compiling asciidoc on every change'
asciidoctor docs.adoc && fswatch --verbose -0 -d . -e "docs.html" | xargs -0 -n1 asciidoctor docs.adoc