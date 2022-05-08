# 🌵 Desert – dissertation and report class for 2022+

Modern general-purpose documentclass with LaTeX 3 and
currently 172 key–value document parameters.

Perfect for dissertations and similar documents. [Try it on Overleaf! 🍃](https://www.overleaf.com/read/bqpyjghrdxqs)


#### 🎁 Features

- **Key–value style options,** quietly redirected to various packages and commands.
- Built-in support for most academic needs, including theorems, nomenclature, abbreviations, and code.
- Uses modern packages and options, like Biber and LaTeX 3.
- New, consistently behaving, key–valued environments and commands.
  E.g. `entry=` for the TOC entry.
- Slowly opt-in to new features and fancy LaTeX 3 packages; your existing commands work fine.

```latex
\documentclass [
    pkg / minted,
    pkg / imakeidx,
    pkg / tcolorbox,
    pkg / chemfig,
    mode = thesis,
    langs = USenglish,  % comma-separated
    bib / hide-lang = true,
    color / url = 0000D2,
    cref / capitalize = true,
    font / size = 11.8pt,
    stretch / main = 1.6,
    num / eqn-within = chapter,
    num / eqn = arabic,
    num / eqn-brackets = square-bold,
    num / thm-like-in = chapter,
    sty / foreign-words = swash,
    sty / indx-starred = HTML:550000;sans;allcaps,
    sty / nom-group = LARGE;uppertosc,
    typo / subref-sep = {~},
    glue> / indent = 0em,  % >: right, <: left, ': above, .: below
    glue' / table-footer = 1ex plus 2pt, % rubber length
    glue. / section = 2ex plus 1 ex minus 1ex,
    toc / depth = section,
    ...  % 172 total keys
]{desert}
```

*There is a full list of the options at the bottom.*

#### Flexible section/chapter/etc. commands
```latex
\Section{I'm your regular section}
\Section*{I'm your regular numberless section}

\Section*[entry = Add this to TOC]{I'm a numberless section}
\Section[numberless, entry = Add this to TOC, title = I'm the same as above]
\Section[label=sec:xx, entry={}, title=I don't show up in TOC]

\Section[numberless, entry=Extra notes]  % I'm in the TOC but don't show text here
```


#### Information storage (from info.sty)

```latex
\SetInfo {
    subject = Physics,                     % mapped to XMP metadata
    title   = Xenodynamic cloud computing,
    author  = Karen Johnson,
    degree  = Doctor of Philosophy,        % arbitary extra data
}

\RenewDocumentCommand \ShowTitle {} {
    ``\info{title}"\\
    \Info{degree} \info{subject}[pre={in ``}, post={"}]\\
    \infolist{keywords}[sep=|, style-inline={red;bold}]\\
    \InfoList{author}[sep-{, }, sep-two={ and }, sep-last={, and }]
}
```

#### Example front matter

```latex
\ShowTitle

\begin{FrontChapter}{Acknowledgments}
...
\end{FrontChapter}

% This one will show in the TOC (via "entry") but won't show the title
\begin{SpecialChapter}[entry=Dedication, at=middle, align=right, width=0.6\textwidth]

\end{SpecialChapter}

\begin{FrontAbstract}[entry=Abstract]
Start of abstract.
(By default, the title and author are printed above.)
\end{FrontAbstract}

\ShowTableOfContents
\ShowListOfFigures
\ShowListOfTables
\ShowListOfAbbreviations
\ShowNomenclature
```

#### Example main matter

```latex
\StartMainMatter

\begin{MainChapter}{Introduction}
\Indx*{Xenodynamics} is an important new field.
My lightbulb uses \qty{5}{\mega\watt\per\meter\square} \foreign{in silico}.
\end{MainChapter}
```

#### Theorems and code

Theorems, lemmas, etc. via [amsthm](https://ctan.org/pkg/amsthm) and [thmtools](https://ctan.org/pkg/thmtools).

```latex

\NewTheoremEnvs [style=plain] {
    Theorem     = thm./thms. ,   % cleveref names: cref/Cref
    Proposition = prop./props. ,
}

\NewTheoremEnvs {  % auto-choose styles
    Definition = defn./defns. ,
    Remark     = rem./rems. ,
    Criterion  = criterion/criteria ,
    Property   = property/properties ,
}

\begin{Theorem} [
    label=thm1,
    name=Central Theorem of Xenodynamics
]
...
\end{Theorem}

\begin{Proof} \end{Proof}

\begin{MintedCode}{
    lang    = c++,
    label   = sourcecode1,
    entry   = My TOC entry,
    caption = ...,
    % ... minted options
}
\end{MintedCode}
```


#### Tables

Tables via [tabularray](https://ctan.org/pkg/tabularray) and [csvsimple](https://ctan.org/pkg/csvsimple)-l3.
(Regular `table` of course works fine too.)

```latex
\begin{LongTable} [  % multi-page if needed
    entry   = ...,
    caption = ...,
    label   = ...,
    note{a} = {A note for the footer.},
]{
    rowhead    = {1},
    row{even}  = {bg=gray},
    hline{1,Z} = {2pt,red},  % or toprule/midrule/bottomrule inside the table
    hline{2}   = {1pt,dotted},
}
Type & Trivial & Easy & Normal & Hard & Strenuous\\
Type 1 \TblrNote{a} (\%) & 300 & 200 & 150 & 100 & 75\\
Type 2 (\%) & 70 & 60 & 50 & 50 & 40\\
Type 3 (\%) & 80 & 75 & 70 & 65 & 60\\
\end{LongTable}
```


#### Figures

Figures via custom environments with key-value args.
Good old `figure` and `\includegraphics` work too, of course.

```latex

\begin{OnePanelFigure} [
    entry    = ...,
    caption  = ...,
    label    = ...,
]
\includegraphics{cows.pdf}
% or pass file=...
\end{OnePanelFigure}

% or shorthand:
\AddOnePanelFigure {
    entry    = ...,
    ...
    file     = cows.png,
    graphicx = {width=5cm}
}

\begin{MultiPanelFigure} [
    entry    = ...,
    caption  = ...,
    label    = ...
]
\AddPanel{entry=..., caption=..., label=..., file=...}
\end{MultiPanelFigure}

\begin{PhantomPanelFigure} [
    label    = ...,
    file     = ...,
]
\AddPhantomPanel{entry=..., label=a}
\caption {
    \describepanel{a}{Caption for panel.}
    \describepanels{b--c}{Photos of butterflies.}
}
\end{PhantomPanelFigure}
```

By the way, there's a smart `\captioning` macro:

```latex
\captioning{This is my caption.}
\captioning[entry=My Caption]{This is my caption.}
\captioning[entry=My Caption, caption=This is my caption., label=butterflies}
```

#### Boxes

Defaults are Note, Technical note, Example, Caution, and Tip.
Use `DeclareDezBox` to add your own,
or `DeclareTColorBox` to start one from scratch.

```latex

% like \DeclareTColorBox, but with defaults
\DeclareDesertBox [arc=1mm, fontlower=red] {Example}

% And a shorthand for setting colframe, colupper, and colback together
\DeclareDesertBox (xkcdalgae) [...] {Hint}

\begin{Example}[name=Optional title, label=Optional]
This is an example.
\end{Example}

```


#### Example back matter

```latex
\StartBackMatter

\ShowListOfTheoremLike![onlynamed]  % ! to number; e.g. Appendix A
\ShowListOfSourceCode!

\begin{Appendix}
...
\end{Appendix}
```

#### Strings

These commands will change the strings that Desert uses.
(Note: the choice of language affects the defaults.)

```latex
% shorthand for:
% \DeclareTranslation{<my-base-language>{table of contents}{Contents}, etc.
% uppercase etc. variants are defined automatically
% using language-specific Unicode rules
\SetTranslationStrings {
    table of contents = Contents ,
    list of figures   = Figures ,
    bibliography      = References ,
    endnotes          = Notes ,
}

% shorthand for \Crefname{figure}{fig.}{figs.}, etc.
\SetCrefStrings {
    figure  = fig./figs. ,
    page    = p./pp. ,
    diagram = diagran/diagrams ,
}

```

#### New packages

- `info.sty` (as seen above)
- `textiles.sty` (lets you use e.g. `red;semi-bold;allcaps;underline`)
- `noms.sty` (tools for nomencl: convenient creation and grouping under subheadings)
- `semantic.sty` (e.g. `\foreign`, `\code`, `\doi`, `ieeeauthor`)
- `pidgin.sty` (compatibility between language-aware packages)
- `tarmac.sty` (internal utils for spacing)
- `glue.sty` (internal macros to manipulate glues)


### 🍁 Contributing

Why is it called Desert?
Because deserts are sparsely populated yet beautiful biomes, rich in diversity of their flora and fauna.
And I thought it sounded a little like *dissertation*, though in fact it really doesn't.

[New issues](https://github.com/dmyersturnbull/desert-latex/issues) and pull requests are welcome.
Please refer to the [contributing guide](https://github.com/dmyersturnbull/desert-latex/blob/master/CONTRIBUTING.md)
and [security policy](https://github.com/dmyersturnbull/desert-latex/blob/main/SECURITY.md).

```text
=======                  D E S E R T                =======
=======                                             =======
                          *******
                , ,      *********
               *****     *********        , ,
              ******     *********       *****
              *****      *********      ******
               *****     ********      *******
               ******************      *******
                *****************      *******
                         ********************
                         ******************
                         ********
                         ********
                         ********
```

### Big list of options


*This may be out-of-date. Refer to the documentation PDF instead.*

```
draft 
langs 
mode ('thesis', 'article', or 'book')
preset 
pkg / svg 
pkg / kantlipsum 
pkg / chemformula 
pkg / chemmacros 
pkg / chemfig 
pkg / cryptocode 
pkg / imakeidx 
pkg / knowledge 
pkg / tikz 
pkg / graphs 
pkg / lettrine 
pkg / minted 
pkg / tcolorbox 
pkg / awesomebox 
pkg / ulem 
pkg / varioref 
bib / hide-lang 
bib / per-chap 
bib / style 
color / cite 
color / file 
color / ref 
color / url 
cref / abbrev 
cref / capitalize 
font / size (e.g. 11pt)
font / leading (between lines; e.g. 13pt)
layout / geometry 
layout / nom-symbol-width 
layout / index-cols 
layout / index-col-sep 
layout / header-left (e.g. \thepage)
layout / header-center 
layout / header-right 
layout / footer-left 
layout / footer-center 
layout / footer-right 
layout / fnotes-to-endnotes 
layout / endnote-backrefs 
layout / show-toc-like-links 
layout / show-nom-links 
layout / fnote-align (left, justify, or center)
layout / fnote-placement (option to footmisc)
stretch / main (line spacing; e.g. 1.5)
stretch / caption 
stretch / eqn 
stretch / toc 
stretch / list-of 
stretch / abbrevs 
stretch / nom 
stretch / source-code 
num / depth (one of part, chapter, section, subsection, subsubsection, paragraph, subparagraph)
num / back-pages (one of arabic, roman, Roman, alph, Alph, )
num / front-chaps 
num / main-chaps 
num / back-chaps 
num / fig-panels 
num / eqn-brackets (one of none, round, square, curly, none-bold, round-bold, etc.)
num / eqn-in (one of none, part, chapter, section, subsection, subsubsection)
num / float-in 
num / fnote-in 
num / fnotes (one of part,..., etc., or lamport, lamport*, etc.)
num / front-pages 
num / main-pages 
num / thm-like-in 
sty / abstract-by 
sty / abstract-authors 
sty / abstract-title 
sty / caption-body 
sty / caption-label 
sty / subcaption-body 
sty / subcaption-label 
sty / subref 
sty / table-head-body 
sty / table-head-label 
sty / table-footer 
sty / box-label 
sty / box-name 
sty / chap-label 
sty / chap-name 
sty / front-chap-title 
sty / part-label 
sty / part-name 
sty / chemical-diagram 
sty / fnote-body 
sty / foreign-words 
sty / indx-starred 
sty / nom-group 
sty / section-title 
sty / source-code 
sty / subsec-title 
sty / subsubsec-title 
sty / paragraph-title 
sty / toc-part-label 
sty / toc-chap-label 
sty / toc-section-label 
sty / toc-subsec-label 
sty / toc-subsubsec-label 
sty / toc-page-number 
toc / depth 
toc / refs 
toc / index 
toc / endnotes 
toc / fig-panels 
typo / ban-hyphens 
typo / caption-label-sep 
typo / subref-label-sep 
typo / subref-format 
typo / caption-table-note-sep 
typo / caption-table-rem-sep 
glue> / indent 
glue< / toc-part 
glue< / toc-chap 
glue< / toc-section 
glue< / toc-subsec 
glue< / toc-subsubsec 
glue< / thm-title 
glue< / def-title 
glue< / rem-title 
glue: / paragraphs 
glue: / items 
glue: / long-items 
glue: / fnotes 
glue: / refs 
glue' / fnote-list 
glue. / fnote-list 
glue' / caption 
glue' / subcaption 
glue' / table-title 
glue. / table-title 
glue' / table-footer 
glue. / table-footer 
glue' / front-chap 
glue. / front-chap 
glue' / chap 
glue. / chap 
glue. / chap-label 
glue. / part-label 
glue' / section 
glue. / section 
glue' / subsec 
glue. / subsec 
glue' / subsubsec 
glue. / subsubsec 
glue' / nom-group 
glue' / paragraph 
glue' / thm-like 
glue. / thm-like 
glue' / alg-like 
glue. / alg-like 
glue' / def-like 
glue. / def-like 
glue' / rem-like 
glue. / rem-like 
glue' / proof 
glue. / proof 
glue' / eqn 
glue. / eqn 
glue' / list 
glue' / long-list 
glue. / abstract-title 
glue' / abstract-authors 
glue' / abstract-body 
glue' / toc-part 
glue' / toc-chapter 
glue' / toc-section 
glue' / toc-subsec 
glue' / toc-subsubsec 

```