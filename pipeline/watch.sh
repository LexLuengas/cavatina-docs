echo 'Compiling asciidoc on every change'
asciidoctor docs.adoc && fswatch --verbose -0 -d . -e ".*" -i "[^E]\\.adoc$" | xargs -0 -n1 -I{} asciidoctor {}