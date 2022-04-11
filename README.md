# 🌵 Desert – dissertation and report class for 2022+

Modern general-purpose documentclass with LaTeX 3 and
50+ key–value arguments.

Perfect for dissertations and similar documents. [Try it on Overleaf! 🍃]() *(oops, the link is coming)*


#### 🎁 Features

- **Key–value style options,** quietly redirected to various packages and commands.
- Built-in support for most academic needs, including theorems, nomenclature, abbreviations, and code.
- Uses modern packages and options, like Biber and LaTeX 3.
- New key–valued environments and commands.

```latex
\documentclass[
    feature / minted,
    feature / imakeidx,
    feature / tcolorbox,
    feature / chemmacros,
    feature / chemfig,
    language = USenglish,
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


#### Information storage (from info.sty)

```latex
\SetInfo {
    subject = Physics,                     % mapped to XMP metadata
    title = Xenodynamic cloud computing,
    author = Karen Johnson,                %
    degree = Doctor of Philosophy,         % arbitary extra data
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

\begin{FrontAbstract}
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

Theorems, lemmas, etc. via thmtools.

```latex
\begin{theorem}[
    label=thm1,
    name=Central Theorem of Xenodynamics
]
...
\end{theorem}

\begin{proof} \end{proof}

\begin{sourcecode}{
    lang    = c++,
    label   = sourcecode1,
    entry   = My TOC entry,
    caption = ...,
    % ... minted options
}
```


#### Tables

Tables via tabularray and csvsimple-l3.
(Regular `table` of course works fine too.)

```latex
\begin{longtblr}[
entry   = ...,
    caption = ...,
    label   = ...,
    note{a}   = {A note for the footer.},
]{
    rowhead   = {1},
    row{even} = {bg=gray},
}
\hline
Type & Trivial & Easy & Normal & Hard & Strenuous\\
\hline
Type 1 \TblrNote{a} (\%) & 300 & 200 & 150 & 100 & 75\\
Type 2 (\%) & 70 & 60 & 50 & 50 & 40\\
Type 3 (\%) & 80 & 75 & 70 & 65 & 60\\
\hline
\end{longtblr}
```


#### Figures

Figures via custom environments with key-value args.
Good old `figure` and `\includegraphics` work too, of course.

```latex

\begin{OnePanelFigure}{
    entry    = ...,
    caption  = ...,
    label    = ...,
}
\includegraphics{cows.pdf}
% or pass file=...
\end{OnePanelFigure}

% or shorthand:
\AddOnePanelFigure {
    entry    = ...,
    ...
    file     = cows.png
graphicx = {width=5cm}
}

\begin{MultiPanelFigure}{
    entry    = ...,
    caption  = ...,
    label    = ...
}
\AddPanel{entry=..., caption=..., label=..., file=...}
\end{MultiPanelFigure}

\begin{PhantomPanelFigure}{
    label    = ...,
    file     = ...,
}
\AddPhantomPanel{entry=..., label=a}
\caption{
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
\begin{BoxExample}[title=Optional title]
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
