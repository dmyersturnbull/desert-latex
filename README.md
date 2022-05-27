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
- Clearer separation between contents and style
- Slowly opt-in to new features and fancy LaTeX 3 packages; your existing commands work fine.

```latex
\documentclass [
    pkg / minted,
    pkg / imakeidx,
    pkg / tcolorbox,
    pkg / noms,
    pkg / chemfig,
    mode = thesis,
    lang / extras = {spanish},  % comma-separated
    bib / hide-lang = true,
    color / url = xkcd cloudy blue,
    cref / capitalize = true,
    font / size = 11.8pt,
    stretch / main = 1.6,
    num / eqn-within = chapter,
    num / eqn = arabic,
    num / eqn-brackets = square-bold,
    num / thm-like-in = chapter,
	footer / R = \thepage of \pageref{LastPage},
	header / back / C = \gettitle,
    sty / foreign-words = swash,
    sty / indx-starred = HTML:550000;sans;allcaps,
    sty / nom-group = LARGE;uppertosc,
    typo / subref-sep = {:\ },
	typo / ban-hyphens = true ,
    glue< / indent = 0em,  % >: right, <: left, ': above, .: below
    glue' / table-footer = 1ex plus 2pt, % rubber length
    glue. / section = 2ex plus 1 ex minus 1ex,
    toc / depth = section,
	toc / fig-panels = true ,
    ...  % 172 total keys
]{desert}
```

#### Requirements

- LuaTeX
- Updated packages (e.g. Tex Live 2022)

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

Create new special sections with `\NewFrontChapter`, `\NewSpecialChapter`, and `\NewAppendix`.

```latex

% in preamble...
\NewFrontChapter {Foreword} [ no-title ]
\RenewSpecialChapter {Contributions} []
\DeclareSpecialChapter {Dedication} [entry=Dedication, at=middle, align=right, width=0.6\textwidth]

\begin{Foreword}
...
\end{Foreword}

% This one will show in the TOC (via "entry") but won't show the title
\begin{Dedication}

\end{Dedication}

% You can slso use them directly
\begin{SpecialChapter}[numberless, title=A Special Chapter]

\end{SpecialChapter}

\begin{Abstract}
Start of abstract.
(By default, the title and author are printed above.)
\end{Abstract}

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
\SetBabelStrings {
    listfigures       = Figures ,
	% ...
}

\SetTranslationStrings {
	Something From Translations = A string ,
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

