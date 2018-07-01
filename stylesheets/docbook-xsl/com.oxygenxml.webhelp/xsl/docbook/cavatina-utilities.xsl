<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://docbook.org/ns/docbook"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:cav="http://cavatina-font.com/docbook"
                exclude-result-prefixes="d saxon cav"
                version="1.0">

    <xsl:template match="cav:computer-key">
        <code class="computer-key">
            <xsl:apply-templates/>
        </code>
    </xsl:template>

    <xsl:template match="cav:musical-term">
        <span class="musical-term">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="xhtml:p/cav:music-notation">
        <span class="cavatina">
            <xsl:copy-of select="@*" />
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="cav:music-notation">
        <div style="text-align: center">
            <span class="cavatina">
                <xsl:copy-of select="@*" />
                <xsl:apply-templates/>
            </span>
        </div>
    </xsl:template>

    <xsl:template match="cav:figure[@id = 'keyboard-full']">
        <div id="k1" style="text-align: center; width: 100%">
            <ul class="keyboard" id="keyboard1">
                <li class="show-for-medium-up shift">
                    <a class="box" href="#">Shift</a>
                </li>
                <li class="show-for-medium-up hidden">
                    <a class="box" href="#" data-key="" data-extra-key="2"></a>
                </li>
                <li>
                    <a class="box" href="#" data-key="Z">Z</a>
                </li>
                <li>
                    <a class="box" href="#" data-key="X">X</a>
                </li>
                <li>
                    <a class="box" href="#" data-key="C">C</a>
                </li>
                <li>
                    <a class="box" href="#" data-key="V">V</a>
                </li>
                <li>
                    <a class="box" href="#" data-key="B">B</a>
                </li>
                <li>
                    <a class="box" href="#" data-key="N">N</a>
                </li>
                <li>
                    <a class="box" href="#" data-key="M">M</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key=",">,</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key=".">.</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="/">/</a>
                </li>
                <li class="show-for-medium-up hidden">
                    <a class="box" href="#" data-key="" data-extra-key="3"></a>
                </li>
                <li class="show-for-medium-up shift">
                    <a class="box" href="#">Shift</a>
                </li>
            </ul>
            <ul class="keyboard" id="koverlay1" style="opacity: 0.9;">
                <li class="show-for-medium-up ghost shift" style="position: relative">
                    <a class="box" href="#">Shift</a>
                </li>
                <li class="show-for-medium-up ghost hidden">
                    <a class="box" href="#" data-key="" data-extra-key="2"></a>
                </li>
                <li>
                    <a class="dark-blue box on" href="#">C</a>
                </li>
                <li>
                    <a class="dark-blue box on" href="#">D</a>
                </li>
                <li>
                    <a class="dark-blue box on" href="#">E</a>
                </li>
                <li>
                    <a class="dark-blue box on" href="#">F</a>
                </li>
                <li>
                    <a class="dark-blue box on" href="#">G</a>
                </li>
                <li>
                    <a class="dark-blue box on" href="#">A</a>
                </li>
                <li>
                    <a class="dark-blue box on" href="#" data-locl="B">B</a>
                </li>
                <li class="show-for-medium-up ghost">
                    <a class="box" href="#">,</a>
                </li>
                <li class="show-for-medium-up ghost">
                    <a class="box" href="#">.</a>
                </li>
                <li class="show-for-medium-up ghost">
                    <a class="box" href="#">/</a>
                </li>
                <li class="show-for-medium-up ghost hidden">
                    <a class="box" href="#" data-key="" data-extra-key="3"></a>
                </li>
                <li class="show-for-medium-up ghost shift">
                    <a class="box" href="#">Shift</a>
                </li>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="cav:figure[@id = 'keyboard-overview']">
        <div id="k2" style="text-align: center; width: 100%">
            <ul class="keyboard pop" id="oct6">
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="`">`</a>
                </li>
                <li>
                    <a class="box on cnote" href="#">1</a>
                </li>
                <li>
                    <a class="box on dnote" href="#">2</a>
                </li>
                <li>
                    <a class="box on enote" href="#">3</a>
                </li>
                <li>
                    <a class="box on fnote" href="#">4</a>
                </li>
                <li>
                    <a class="box on gnote" href="#">5</a>
                </li>
                <li>
                    <a class="box on anote" href="#">6</a>
                </li>
                <li>
                    <a class="box on bnote" href="#">7</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box on cnote" href="#">8</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box on dnote" href="#">9</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box on enote" href="#">0</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="-">-</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="=">=</a>
                </li>
                <li class="show-for-medium-up tab">
                    <a class="box" href="#"></a>
                </li>
            </ul>
            <ul class="keyboard pop" id="oct5">
                <li class="show-for-medium-up tab">
                    <a class="box" href="#"></a>
                </li>
                <li>
                    <a class="box on cnote" href="#" data-key="Q">Q</a>
                </li>
                <li>
                    <a class="box on dnote" href="#" data-key="W">W</a>
                </li>
                <li>
                    <a class="box on enote" href="#" data-key="E">E</a>
                </li>
                <li>
                    <a class="box on fnote" href="#" data-key="R">R</a>
                </li>
                <li>
                    <a class="box on gnote" href="#" data-key="T">T</a>
                </li>
                <li>
                    <a class="box on anote" href="#" data-key="Y">Y</a>
                </li>
                <li>
                    <a class="box on bnote" href="#" data-key="U">U</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="I">I</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="O">O</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="P">P</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="[">[</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="]">]</a>
                </li>
                <li class="show-for-medium-up return-upper">
                    <a class="box" href="#" data-key="\" data-extra-key="0">\</a>
                </li>
            </ul>
            <ul class="keyboard pop" id="oct4">
                <li class="show-for-medium-up" id="capslock">
                    <a class="box" href="#"></a>
                </li>
                <li>
                    <a class="box on cnote" href="#" data-key="A">A</a>
                </li>
                <li>
                    <a class="box on dnote" href="#" data-key="S">S</a>
                </li>
                <li>
                    <a class="box on enote" href="#" data-key="D">D</a>
                </li>
                <li>
                    <a class="box on fnote" href="#" data-key="F">F</a>
                </li>
                <li>
                    <a class="box on gnote" href="#" data-key="G">G</a>
                </li>
                <li>
                    <a class="box on anote" href="#" data-key="H">H</a>
                </li>
                <li>
                    <a class="box on bnote" href="#" data-key="J">J</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="K">K</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="L">L</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key=";">;</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="'">'</a>
                </li>
                <li class="show-for-medium-up hidden">
                    <a class="box" href="#" data-key="" data-extra-key="1"></a>
                </li>
                <li class="show-for-medium-up return">
                    <a class="box" href="#"></a>
                </li>
            </ul>
            <ul class="keyboard pop" id="oct3">
                <li class="show-for-medium-up shift">
                    <a class="box" href="#"></a>
                </li>
                <li class="show-for-medium-up hidden">
                    <a class="box" href="#" data-key="" data-extra-key="2"></a>
                </li>
                <li>
                    <a class="box on cnote" href="#" data-key="Z">Z</a>
                </li>
                <li>
                    <a class="box on dnote" href="#" data-key="X">X</a>
                </li>
                <li>
                    <a class="box on enote" href="#" data-key="C">C</a>
                </li>
                <li>
                    <a class="box on fnote" href="#" data-key="V">V</a>
                </li>
                <li>
                    <a class="box on gnote" href="#" data-key="B">B</a>
                </li>
                <li>
                    <a class="box on anote" href="#" data-key="N">N</a>
                </li>
                <li>
                    <a class="box on bnote" href="#" data-key="N">M</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key=",">,</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key=".">.</a>
                </li>
                <li class="show-for-medium-up">
                    <a class="box" href="#" data-key="/">/</a>
                </li>
                <li class="show-for-medium-up hidden">
                    <a class="box" href="#" data-key="" data-extra-key="3"></a>
                </li>
                <li class="show-for-medium-up shift">
                    <a class="box" href="#"></a>
                </li>
            </ul>
            <ul class="keyboard" id="koverlay2" style="margin-top: 6px; margin-left: 14px">
                <li class="show-for-medium-up shift" style="visibility: hidden; position: relative">
                    <a class="box" href="#">Shift</a>
                </li>
                <li>
                    <a class="dark-blue box on cnote" href="#">C</a>
                </li>
                <li>
                    <a class="dark-blue box on dnote" href="#">D</a>
                </li>
                <li>
                    <a class="dark-blue box on enote" href="#">E</a>
                </li>
                <li>
                    <a class="dark-blue box on fnote" href="#">F</a>
                </li>
                <li>
                    <a class="dark-blue box on gnote" href="#">G</a>
                </li>
                <li>
                    <a class="dark-blue box on anote" href="#">A</a>
                </li>
                <li>
                    <a class="dark-blue box on bnote" href="#" data-locl="B">B</a>
                </li>
                <li class="show-for-medium-up" style="visibility: hidden">
                    <a class="box" href="#">,</a>
                </li>
                <li class="show-for-medium-up" style="visibility: hidden">
                    <a class="box" href="#">.</a>
                </li>
                <li class="show-for-medium-up" style="visibility: hidden">
                    <a class="box" href="#">/</a>
                </li>
                <li class="show-for-medium-up shift" style="visibility: hidden">
                    <a class="box" href="#">Shift</a>
                </li>
            </ul>
        </div>
    </xsl:template>

</xsl:stylesheet>