# 🌵 Desert – dissertation and report class for 2022+

Modern general-purpose documentclass with LaTeX 3 and
50+ key–value arguments.

Perfect for dissertations and similar documents. [Try it on Overleaf! 🍃](https://www.overleaf.com/read/bqpyjghrdxqs)


#### 🎁 Features

- **Key–value style options,** quietly redirected to various packages and commands.
- Built-in support for most academic needs, including theorems, nomenclature, abbreviations, and code.
- Uses modern packages and options, like Biber and LaTeX 3.
- New, consistently behaving, key–valued environments and commands.
  E.g. `entry=` for the TOC entry.
- Slowly opt-in to new features and fancy LaTeX 3 packages; your existing commands work fine.

```latex
\documentclass[
    feature / minted,
    feature / imakeidx,
    feature / tcolorbox,
    feature / chemmacros,
    feature / chemfig,
    language = en-us,
    bib / hide-language = true,
    color / url = 0000D2,
    cref / capitalize = true,
    font-size / main = 11.8pt,
    linespace / main = 1.6,
    numbering / equation-within = chapter,
    numbering / equation = arabic,
    numbering / equation-brackets = square-bold,
    numbering / theorem-like-within = chapter,
    style / foreign-words = {italic},
    style / indx-starred = {HTML:550000;sans,allcaps},
    style / nomenclature-group = {LARGE;uppertosc},
    typo / subcaption-sep = {~},
    glue / indent = 0em,
    glue-above / table-footer = 1ex plus 2pt, % rubber length
    glue-below / section = 2ex plus 1 ex minus 1ex,
    toc / depth = section,
    ...
]{desert}
```

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

\begin{SpecialChapter}[entry=Dedication, at=middle, width=0.6\textwidth]

\end{SpecialChapter}

\begin{FrontAbstract}[entry=Abstract]
Start of abstract.
(By default, the title and author are printed above.)
\end{FrontAbstract}

\ShowTableOfContents
\ShowListOfFigures
\ShowListOfTables
\ShowListOfAbbrevs
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
    Theorem     = thm./thms. ,
    Proposition = prop./props. ,
}

\NewTheoremEnvs {  % auto-choose styles
    Definition = defn./defns. ,
    Remark     = rem./rems. ,
    Criterion  = criterion/criteria ,
    Property   = property/properties ,
}

\begin{Theorem}[
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
    hline{1,Z} = {2pt,red},
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

#### Boxes

Defaults are Note, Technical note, Example, Caution, and Tip.
Use `DeclareDesertBox` to add your own,
or `DeclareTColorBox` to start one from scratch.

```latex

% like \DeclareTColorBox, but with defaults
% set nice colors with () and/or pass any tcolorbox options with []
\DeclareDesertBox [...] {Example}
\DeclareDesertBox (green!50!black) {Hint}

\begin{BoxExample}[name=Optional title, label=Optional]
This is an example.
\end{BoxExample}
```


#### Example back matter

```latex
\StartBackMatter

\ShowListOfTheorems![onlynamed]  % ! to number; e.g. Appendix A
\ShowListOfSourceCode!

\begin{BackChapter}
...
\end{BackChapter}
```

#### Strings

These commands will change the strings that Desert uses.
(Note: the choice of language affects the defaults.)

```latex
% shorthand for:
% \DeclareTranslation{<my-base-language>{table of contents}{Contents}, etc.
% uppercase etc. variants are defined automatically
% using language-specific Unicode rules
\SetTranslations {
    table of contents = Contents ,
    list of figures   = Figures ,
    bibliography      = References ,
    endnotes          = Notes ,
}

% shorthand for \Crefname{figure}{fig.}{figs.}, etc.
\SetCrefNames {
    figure  = fig./figs. ,
    page    = p./pp. ,
    diagram = diagran/diagrams ,
}

% theorem-like envs with complete cleveref support
% pre-defined thmtools styles are as they recommend:
% plain, definition, and remark
\NewTheoremEnvs [style=plain] {
    theorem     = thm./thms. ,
    proposition = prop./props. ,
}

```

#### New packages

- `info.sty` (as seen above)
- `txtstyles.sty` (lets you use e.g. `red;semi-bold;allcaps;underline`)
- `nomgroups.sty` (group nomenclature under subheadings)
- `semantics.sty` (e.g. `\foreign`, `\code`, `\doi`, `ieeeauthor`)


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
