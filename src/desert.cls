% Copyright 2022 Douglas Myers-Turnbull
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or
% (at your option) any later version. The latest version of this license is
% in http://www.latex-project.org/lppl.txt and version 1.3 or later is part of
% all distributions of LaTeX version 2005/12/01 or later.


%=======                                                   =======
%=======                      DESERT                       =======
%=======                                                   =======

% DECLARATION
\NeedsTeXFormat{LaTeX2e}[2020-10-01]
\ExplSyntaxOn
\RequirePackage{etoolbox}
\RequirePackage{l3keys2e}
\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass {desert} {2022-04-09} {0.1} {Desert~dissertation~template}

\cs_generate_variant:Nn \tl_if_blank:nTF { VTF }
\cs_generate_variant:Nn \tl_if_blank:nT { VT }
\cs_generate_variant:Nn \tl_if_blank:nF { VF }


%========================================================================================
%                    containers to store package options
%========================================================================================

% Saving optional features

\seq_new:N \g_desert_feature_seq

\prg_new_conditional:Npnn  \desert_has_feat:n #1 { T, F, TF }
{
    \seq_if_in:NnTF \g_desert_feature_seq {#1}
    { \prg_return_true: }
    { \prg_return_false: }
}

\cs_new:Npn \desert_load_feat:nn #1#2
{
    \seq_if_in:NnT \g_desert_feature_seq {#2}
        { \RequirePackage[#1]{#2} }
}

\cs_new:Npn \desert_load_feat:n #1
{
    \seq_if_in:NnT \g_desert_feature_seq {#1}
        { \RequirePackage{#1} }
}


% STORE TXTSTYLES AND COLORS
\prop_new:N \g_desert_style_prop
\prop_new:N \g_desert_color_prop



%========================================================================================
%                    package options and setup
%========================================================================================

% LOAD BASE CLASS
% --------------------------------------
% Load report BEFORE DECLARING OPTIONS!!
% Otherwise em and ex units are zero.
\LoadClass{report}
% --------------------------------------


\keys_define:nn {desert}
{
draft .bool_gset:N = \g_desert_draft_bool,
draft .initial:n = false,

language .tl_gset:N = \g_desert_language_str,
language .initial:n = USenglish,

geometry .tl_gset:N = \g_desert_geometry_tl,
geometry .default:n = {},

preset .choices:nn =
    { GenericLetter, GenericAFour, UCSF, UCSB, Stanford, CMU, Cambridge }
    { \tl_gset_eq:NN \g_desert_preset_str \l_keys_choice_tl },
preset .initial:n = GenericAFour,

feature / chemformula .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {chemformula} },
feature / chemformula .value_forbidden:n = true,

feature / chemfig .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {chemfig} },
feature / chemfig .value_forbidden:n = true,

feature / chemmacros .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {chemmacros} },
feature / chemmacros .value_forbidden:n = true,

feature / cryptocode .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {cryptocode} },
feature / cryptocode .value_forbidden:n = true,

feature / imakeidx .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {imakeidx} },
feature / imakeidx .value_forbidden:n = true,
feature / index .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {imakeidx} },
feature / index .value_forbidden:n = true,

feature / knowledge .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {knowledge} },
feature / knowledge .value_forbidden:n = true,

feature / lettrine .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {lettrine} },
feature / lettrine .value_forbidden:n = true,

feature / minted .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {minted} },
feature / minted .value_forbidden:n = true,

feature / tcolorbox .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {tcolorbox} },
feature / tcolorbox .value_forbidden:n = true,

feature / ulem .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {ulem} },
feature / ulem .value_forbidden:n = true,

feature / varioref .code:n = { \seq_gput_right:Nn \g_desert_feature_seq {varioref} },
feature / varioref .value_forbidden:n = true,

bib / hide-language .bool_gset:N = \g_desert_bib_hide_language_bool,
bib / hide-language .initial:n = false,

bib / per-chapter .bool_gset:N = \g_desert_bib_per_chapter_bool,
bib / per-chapter .initial:n = false,

bib / style .tl_gset:N = \g_desert_bib_style_str,
bib / style .initial:n = ieee,

color / cite  .prop_gput:N = \g_desert_color_prop,
color / cite  .initial:n  = 000060,

color / file  .prop_gput:N = \g_desert_color_prop,
color / file  .initial:n  = red,

color / ref   .prop_gput:N = \g_desert_color_prop,
color / ref   .initial:n  = 000060,

color / url   .prop_gput:N = \g_desert_color_prop,
color / url   .initial:n  = 0000A0,

cref / abbreviate .bool_gset:N = \g_desert_cref_abbreviate_bool,
cref / abbreviate .initial:n = false,

cref / capitalize .bool_gset:N = \g_desert_cref_capitalize_bool,
cref / capitalize .initial:n = false,

font-size / main .tl_gset:N = \g_desert_font_size_tl,
font-size / main .initial:n = 11pt,

layout / index-cols .int_gset:N = \g_desert_layout_index_cols_int,
layout / index-cols .initial:n = 2,

layout / index-col-sep .dim_gset:N = \g_desert_layout_index_col_sep_dim,
layout / index-col-sep .initial:n = 3em,

layout / header-left .tl_gset:N = \g_desert_layout_header_left_tl,

layout / header-center .tl_gset:N = \g_desert_layout_header_center_tl,

layout / header-right .tl_gset:N = \g_desert_layout_header_right_tl,

layout / footer-left .tl_gset:N = \g_desert_layout_footer_left_tl,

layout / footer-center .tl_gset:N = \g_desert_layout_footer_center_tl,

layout / footer-right .tl_gset:N = \g_desert_layout_footer_right_tl,
layout / footer-right .initial:n = \thepage,

layout / hide-copyright-page-footer .bool_gset:N = \g_desert_hide_copyright_page_footer_bool,
layout / hide-copyright-page-footer .initial:n = false,

layout / hide-title-page-footer .bool_gset:N = \g_desert_hide_title_page_footer_bool,
layout / hide-title-page-footer .initial:n = false,

layout / footnote-placement .choices:nn =
    {default, endnotes, abovefloats, belowfloats, bottom, bottomfloats, bottomfootnotes}
    { \tl_gset_eq:NN \g_desert_layout_footnote_placement_str \l_keys_choice_tl },
layout / footnote-placement .initial:n = default,

layout / hide-links-in-title .bool_gset:N = \g_desert_hide_links_in_title_bool,
layout / hide-links-in-title .initial:n = false,

linespace / main .tl_gset:N = \g_desert_linespace_main_fp,
linespace / main .initial:n = 1.5,

linespace / caption .tl_gset:N = \g_desert_linespace_caption_fp,
linespace / caption .initial:n = 1.2,

linespace / equation .tl_gset:N = \g_desert_linespace_equation_fp,
linespace / equation .initial:n = 1.2,

linespace / list-of .tl_gset:N = \g_desert_linespace_list_of_fp,
linespace / list-of .initial:n = 1.2,

linespace / abbrevs .tl_gset:N = \g_desert_linespace_abbrevs_fp,
linespace / abbrevs .initial:n = 1.2,

linespace / nomenclature .tl_gset:N = \g_desert_linespace_nomenclature_fp,
linespace / nomenclature .initial:n = 1.2,

linespace / source-code .tl_gset:N = \g_desert_linespace_source_code_fp,
linespace / source-code .initial:n = 1.1,

linespace / toc .tl_gset:N = \g_desert_linespace_toc_fp,
linespace / toc .initial:n = 1.2,

numbering / depth .choices:nn =
    { none,chapter,section,subsection,subsubsection,paragraph,subparagraph }
    { \tl_gset_eq:NN \g_desert_numbering_depth_str \l_keys_choice_tl },
numbering / depth .initial:n = subparagraph,

numbering / back-matter .choices:nn =
    {arabic,roman,Roman,alph,Alph}
    { \tl_gset_eq:NN \g_desert_numbering_back_str \l_keys_choice_tl },
numbering / back-matter .initial:n = arabic,

numbering / capitalize-panels .bool_gset:N = \g_desert_numbering_capitalize_panels_bool,
numbering / capitalize-panels .initial:n = false,

numbering / equation-brackets .choices:nn =
    { none,round,square,curly,none-bold,round-bold,square-bold,curly-bold }
    { \tl_gset_eq:NN \g_desert_numbering_equation_brackets_str \l_keys_choice_tl },
numbering / equation-brackets .initial:n = round,

numbering / equation-within .choices:nn =
    { none,chapter,section,subsection,subsubsection }
    { \tl_gset_eq:NN \g_desert_numbering_equation_within_str \l_keys_choice_tl },
numbering / equation-within .initial:n = chapter,

numbering / float-within .choices:nn =
    {none,chapter,section,subsection}
    { \tl_gset_eq:NN \g_desert_numbering_float_within_str \l_keys_choice_tl },
numbering / float-within .initial:n = chapter,

numbering / footnote-within .choices:nn =
    { none,page,chapter }
    { \tl_gset_eq:NN \g_desert_numbering_footnote_within_str \l_keys_choice_tl },
numbering / footnote-within .tl_gset:N = \g_desert_numbering_footnote_within_str,

numbering / footnotes .choices:nn =
    { arabic,roman,Roman,alph,Alph,lamport,lamport*,bringhurst,chicago,wiley }
    { \tl_gset_eq:NN \g_desert_numbering_footnotes_str \l_keys_choice_tl },
numbering / footnotes .initial:n = lamport*,

numbering / front-matter .choices:nn =
    {arabic,roman,Roman,alph,Alph}
    { \tl_gset_eq:NN \g_desert_numbering_front_str \l_keys_choice_tl },
numbering / front-matter .initial:n = roman,

numbering / main-matter .choices:nn =
    { arabic,roman,Roman,alph,Alph }
    { \tl_gset_eq:NN \g_desert_numbering_main_str \l_keys_choice_tl },
numbering / main-matter .initial:n = arabic,

numbering / theorem-like-within .choices:nn =
    { none,chapter,section,subsection,subsubsection }
    { \tl_gset_eq:NN \g_desert_numbering_theorem_within_str \l_keys_choice_tl },
numbering / theorem-like-within .initial:n = chapter,

style / abstract-by .prop_gput:N = \g_desert_style_prop,
style / abstract-by .initial:n = {largerr},

style / abstract-authors .prop_gput:N = \g_desert_style_prop,
style / abstract-authors .initial:n = {largerr},

style / abstract-title .prop_gput:N = \g_desert_style_prop,
style / abstract-title .initial:n = {Large,bold},

style / caption-body .prop_gput:N = \g_desert_style_prop,
style / caption-body .initial:n = {small,sans},

style / caption-label .prop_gput:N = \g_desert_style_prop,
style / caption-label .initial:n = {small,sans,bold},

style / subcaption-body .prop_gput:N = \g_desert_style_prop,
style / subcaption-body .initial:n = {small,sans},

style / subcaption-label .prop_gput:N = \g_desert_style_prop,
style / subcaption-label .initial:n = {small,sans,bold},

style / subref .prop_gput:N = \g_desert_style_prop,
style / subref .initial:n = {bold},

style / table-head-body .prop_gput:N = \g_desert_style_prop,
style / table-head-body .initial:n = {small,sffamily,bfseries},

style / table-head-label .prop_gput:N = \g_desert_style_prop,
style / table-head-label .initial:n = {small,sffamily,bfseries},

style / table-footer .prop_gput:N = \g_desert_style_prop,
style / table-footer .initial:n = {small,sffamily,bfseries},

style / chapter-label .prop_gput:N = \g_desert_style_prop,
style / chapter-label .initial:n = {Huge,404040,smallcaps},

style / chapter-name .prop_gput:N = \g_desert_style_prop,
style / chapter-name .initial:n = {huge},

style / front-chapter-title .prop_gput:N = \g_desert_style_prop,
style / front-chapter-title .initial:n = {hugerr,404040,smallcaps},

style / chemistry .prop_gput:N = \g_desert_style_prop,
style / chemistry .initial:n = {sans,small},

style / footnote-label .prop_gput:N = \g_desert_style_prop,
style / footnote-label .initial:n = {mini,sans},

style / footnote-body .prop_gput:N = \g_desert_style_prop,
style / footnote-body .initial:n = {mini,sans},

style / foreign-words .prop_gput:N = \g_desert_style_prop,
style / foreign-words .initial:n = {italic},

style / indx-starred .prop_gput:N = \g_desert_style_prop,
style / indx-starred .initial:n = {italic},

style / nomenclature-group .prop_gput:N = \g_desert_style_prop,
style / nomenclature-group .initial:n = {bold,large},

style / section-title .prop_gput:N = \g_desert_style_prop,
style / section-title .initial:n = {LARGE,bold},

style / source-code .prop_gput:N = \g_desert_style_prop,
style / source-code .initial:n = {small},

style / subsection-title .prop_gput:N = \g_desert_style_prop,
style / subsection-title .initial:n = {Large,bold},

style / subsubsection-title .prop_gput:N = \g_desert_style_prop,
style / subsubsection-title .initial:n = {large,bold},

style / paragraph-title .prop_gput:N = \g_desert_style_prop,
style / paragraph-title .initial:n = {bold},

style / chapter-toc-label .prop_gput:N = \g_desert_style_prop,
style / chapter-toc-label .initial:n = {large,bold},

toc / depth .choices:nn =
    { none,chapter,section,subsection,subsubsection }
    { \tl_gset_eq:NN \g_desert_toc_depth_str \l_keys_choice_tl },
toc / depth .initial:n = section,

toc / front-chapters .bool_gset:N = \g_desert_toc_front_chapters_bool,
toc / front-chapters .initial:n = false,

toc / bib .bool_gset:N = \g_desert_toc_bib_bool,
toc / bib .initial:n = false,

toc / index .bool_gset:N = \g_desert_toc_index_bool,
toc / index .initial:n = false,

toc / figure-panels .bool_gset:N = \g_desert_toc_panels_bool,
toc / figure-panels .initial:n = false,

typo / allow-hyphens .bool_gset:N = \g_desert_typo_allow_hyphens_bool,
typo / allow-hyphens .initial:n = false,

typo / caption-label-sep .tl_gset:N = \g_desert_typo_caption_label_sep_tl,
typo / caption-label-sep .initial:n = {:~},

typo / subcaption-label-sep .tl_gset:N = \g_desert_typo_subcaption_label_sep_tl,
typo / subcaption-label-sep .initial:n = {:~},

typo / subref-prefix .tl_gset:N = \g_desert_typo_subref_prefix_tl,
typo / subref-prefix .initial:n = {},

typo / subref-suffix .tl_gset:N = \g_desert_typo_subref_suffix_tl,
typo / subref-suffix .initial:n = {},

typo / caption-table-note-sep .tl_gset:N = \g_desert_typo_table_note_sep_tl,
typo / caption-table-note-sep .initial:n = {\space},

typo / caption-table-remark-sep .tl_gset:N = \g_desert_typo_table_remark_sep_tl,
typo / caption-table-remark-sep .initial:n = {},

glue / indent .skip_gset:N = \g_desert_indent_dim,
glue / indent .initial:n = 0pt,

glue-left / toc-chapter .dim_gset:N = \g_desert_toc_chapter_dim,
glue-left / toc-chapter .initial:n = 3pc,

glue-left / toc-section .dim_gset:N = \g_desert_toc_section_dim,
glue-left / toc-section .initial:n = 3pc,

glue-left / toc-subsection .dim_gset:N = \g_desert_toc_subsection_dim,
glue-left / toc-subsection .initial:n = 3pc,

glue-left / toc-subsubsection .dim_gset:N = \g_desert_toc_subsubsection_dim,
glue-left / toc-subsubsection .initial:n = 3pc,

glue-left / theorem-title .skip_gset:N = \g_desert_glue_after_theorem_title_skip,
glue-left / theorem-title .initial:n = 0.8em plus 0.02em minus 0.01em,

glue-left / definition-title .skip_gset:N = \g_desert_glue_after_definition_title_skip,
glue-left / definition-title .initial:n = 0.8em plus 0.02em minus 0.01em,

glue-left / remark-title .skip_gset:N = \g_desert_glue_after_remark_title_skip,
glue-left / remark-title .initial:n = 0.8em plus 0.02em minus 0.01em,

glue-between / paragraphs .skip_gset:N = \g_desert_between_paragraphs_skip,
glue-between / paragraphs .initial:n = 2ex plus 0.2ex minus 0.2ex,

glue-between / items .skip_gset:N = \g_desert_between_items_skip,
glue-between / items .initial:n = -0.8ex plus 0.1ex minus 0.1ex,  % best depends on line spacing

glue-between / multipar-items .skip_gset:N = \g_desert_between_multipar_items_skip,
glue-between / multipar-items .initial:n = 1ex plus 0.1ex minus 0.025ex,

glue-between / footnotes .skip_gset:N = \g_desert_between_footnotes_skip,
glue-between / footnotes .initial:n = 0.4ex plus 0.05ex minus 0.0125ex,

glue-between / refs .skip_gset:N = \g_desert_between_refs_skip,
glue-between / refs .initial:n = 0.5ex plus 0.05ex minus 0.0125ex,

glue-above / footnote-list .skip_gset:N = \g_desert_above_footnotes_skip,
glue-above / footnote-list .initial:n = 6ex plus 6ex,
glue-below / footnote-list .skip_gset:N = \g_desert_above_footnotes_skip,
glue-below / footnote-list .initial:n = 6ex plus 18ex,  % only when floats are below

glue-above / caption .skip_gset:N = \g_desert_above_caption_skip,
glue-above / caption .initial:n = 1ex plus 0.5ex minus 0.125ex,

glue-above / table-title .skip_gset:N = \g_desert_above_table_title_skip,
glue-above / table-title .initial:n = 2ex plus 4ex minus 0.25ex,
glue-below / table-title .skip_gset:N = \g_desert_below_table_title_skip,
glue-below / table-title .initial:n = 2ex plus 1ex minus 0.25ex,

glue-above / table-footer .skip_gset:N = \g_desert_above_table_footer_skip,
glue-above / table-footer .initial:n = 1ex plus 0.5ex minus 0.125ex,
glue-below / table-footer .skip_gset:N = \g_desert_below_table_footer_skip,
glue-below / table-footer .initial:n = 2ex plus 4ex minus 0.25ex,

glue-above / front-chapter .skip_gset:N = \g_desert_above_front_chapter_skip,
glue-above / front-chapter .initial:n = 0pc,
glue-below / front-chapter .skip_gset:N = \g_desert_below_front_chapter_skip,
glue-below / front-chapter .initial:n = 4ex plus 2ex minus 0.5ex,

glue-above / chapter .skip_gset:N = \g_desert_above_chapter_skip,
glue-above / chapter .initial:n = 0pc,
glue-below / chapter .skip_gset:N = \g_desert_below_chapter_skip,
glue-below / chapter .initial:n = 6ex plus 1.5ex minus 0.375ex,

glue-below / chapter-label .skip_gset:N = \g_desert_below_chapter_label_skip,
glue-below / chapter-label .initial:n = 3ex plus 1.5ex minus 0.375ex,

glue-above / section .skip_gset:N = \g_desert_above_section_skip,
glue-above / section .initial:n = 8ex plus 2ex minus 0.5ex,
glue-below / section .skip_gset:N = \g_desert_below_section_skip,
glue-below / section .initial:n = 4ex plus 1ex minus 0.25ex,

glue-above / subsection .skip_gset:N = \g_desert_above_subsection_skip,
glue-above / subsection .initial:n = 6ex plus 3ex minus 0.75ex,
glue-below / subsection .skip_gset:N = \g_desert_below_subsection_skip,
glue-below / subsection .initial:n = 3ex plus 0.75ex minus 0.375ex,

glue-above / subsubsection .skip_gset:N = \g_desert_above_subsubsection_skip,
glue-below / subsubsection .initial:n = 2ex plus 0.2ex minus 0.2ex,
glue-below / subsubsection .skip_gset:N = \g_desert_below_subsubsection_skip,
glue-below / subsubsection .initial:n = 2ex plus 0.2ex minus 0.2ex,

glue-above / paragraph .skip_gset:N = \g_desert_above_paragraph_skip,
glue-above / paragraph .initial:n = 2ex plus 0.2ex minus 0.2ex,

glue-above / theorem-like .skip_gset:N = \g_desert_above_theorem_skip,
glue-above / theorem-like .initial:n = 3ex plus 0.375ex minus 0.1875ex,
glue-below / theorem-like .skip_gset:N = \g_desert_below_theorem_skip,
glue-below / theorem-like .initial:n = 3ex plus 0.375ex minus 0.1875ex,

glue-above / algorithm-like .skip_gset:N = \g_desert_above_algorithm_skip,
glue-above / algorithm-like .initial:n = 3ex plus 0.375ex minus 0.1875ex,
glue-below / algorithm-like .skip_gset:N = \g_desert_below_algorithm_skip,
glue-below / algorithm-like .initial:n = 3ex plus 0.375ex minus 0.1875ex,

glue-above / definition-like .skip_gset:N = \g_desert_above_definition_skip,
glue-above / definition-like .initial:n = 3ex plus 0.375ex minus 0.1875ex,
glue-below / definition-like .skip_gset:N = \g_desert_below_definition_skip,
glue-below / definition-like .initial:n = 3ex plus 0.375ex minus 0.1875ex,

glue-above / remark-like .skip_gset:N = \g_desert_above_remark_skip,
glue-above / remark-like .initial:n = 2ex plus 0.5ex minus 0.125ex,
glue-below / remark-like .skip_gset:N = \g_desert_below_remark_skip,
glue-below / remark-like .initial:n = 2ex plus 0.5ex minus 0.125ex,

glue-above / equation .skip_gset:N = \g_desert_above_equation_skip,
glue-above / equation .initial:n = 2ex plus 0.5ex minus 0.125ex,
glue-below / equation .skip_gset:N = \g_desert_below_equation_skip,
glue-below / equation .initial:n = 2ex plus 0.5ex minus 0.125ex,

glue-above / list .skip_gset:N = \g_desert_above_list_skip,
glue-above / list .initial:n = 1ex plus 0.2ex minus 0.05ex,

glue-above / multipar-list .skip_gset:N = \g_desert_above_multipar_list_skip,
glue-above / multipar-list .initial:n = 1ex plus 0.2ex minus 0.05ex,

glue-below / abstract-title .skip_gset:N = \g_desert_below_abstract_title_skip,
glue-below / abstract-title .initial:n = 2.5ex,

glue-above / abstract-authors .skip_gset:N = \g_desert_above_abstract_author_skip,
glue-above / abstract-authors .initial:n = 2.5ex,

glue-above / abstract-body .skip_gset:N = \g_desert_above_abstract_body_skip,
glue-above / abstract-body .initial:n = 7.5ex,

glue-above / toc-chapter .skip_gset:N = \g_desert_above_toc_chapter_skip,
glue-above / toc-chapter .initial:n = 1.8pc plus 0.16pc minus 0.04pc,

glue-above / toc-section .skip_gset:N = \g_desert_above_toc_section_skip,
glue-above / toc-section .initial:n = 0pc,

glue-above / toc-subsection .skip_gset:N = \g_desert_above_toc_subsection_skip,
glue-above / toc-subsection .initial:n = 0pc,

glue-above / toc-subsubsection .skip_gset:N = \g_desert_above_toc_subsubsection_skip,
glue-above / toc-subsubsection .initial:n = 0pc,
}

\ProcessKeysOptions{desert}  % Process!


%========================================================================================
%                    hooks for fancy users
%========================================================================================


\ProvideDocumentCommand \PreFrontTitleHook {}
    { \hypersetup{hidelinks} }

\ProvideDocumentCommand \PreFrontCopyrightHook {}
    { \hypersetup{hidelinks} }

\ProvideDocumentCommand \PreTocLikeListHook {}
    { \hypersetup{hidelinks} }

\ProvideDocumentCommand \PreFrontAbstractHook {}
    { }

\ProvideDocumentCommand \PreFrontChapterHook {}
    { }

\ProvideDocumentCommand \PreSpecialChapterHook {}
    { }

\ProvideDocumentCommand \PreMainChapterHook {}
    { }

\ProvideDocumentCommand \PreAppendixHook {}
    { }

\ProvideDocumentCommand \DesertTocChapterHook {}
    { \Large \bfseries }

\ProvideDocumentCommand \DesertTocSectionHook {}
    { \normalsizerr }

\ProvideDocumentCommand \DesertTocSubsectionHook {}
    { }

\ProvideDocumentCommand \DesertTocSubsubsectionHook {}
    { }

\ProvideDocumentCommand \DesertTocPageNumberHook {}
    { \normalsizerr }


%========================================================================================
%                    presets
%========================================================================================


\NewDocumentCommand \GenericAFourPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
    {
        a4paper,
        top=2cm,
        bottom=2cm,
        left=3cm,
        right=3cm,
        footskip=1cm
    }
}

\NewDocumentCommand \GenericLetterPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper, top=1in, bottom=1in, left=1.5in, right=1.5in, footskip=0.5in }
}

\NewDocumentCommand \UcsfPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper,  margin=1in, footskip=0.5in }
    \str_gset:Nn \g_desert_numbering_front_str {roman}
    \str_gset:Nn \g_desert_numbering_float_within_str {chapter}
    \bool_gset_true:N \g_desert_hide_title_page_footer_bool
    \bool_gset_false:N \g_desert_hide_copyright_page_footer_bool
    \bool_gset:Nn \g_desert_linespace_main_fp {2}
    \tl_gset:Nn \g_desert_linespace_caption_fp {1}
    \tl_gset:Nn \g_desert_between_footnotes_skip {\baselineskip}
    \tl_gset:Nn \g_desert_linespace_main_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_toc_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_list_of_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_abbrevs_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_nomenclature_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_caption_fp {1.05}
}

\NewDocumentCommand \UcsbPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper, top=1in, bottom=1in, left=1.5in, right=1in, footskip=0.25in }
    \str_gset:Nn \g_desert_numbering_front_str {roman}
    \bool_gset_true:N \g_desert_hide_title_page_footer_bool
    \bool_gset_false:N \g_desert_hide_copyright_page_footer_bool
    \tl_gset:Nn \g_desert_font_size_tl {12}
    \tl_gset:Nn \g_desert_linespace_main_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_toc_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_list_of_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_abbrevs_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_nomenclature_fp {2.0}
    \tl_gset:Nn \g_desert_linespace_caption_fp {1.05}
}

\NewDocumentCommand \CmuPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper, margin=1in, footskip=0.25in }
    \str_gset:Nn \g_desert_numbering_front_str {roman}
    \str_gset:Nn \g_desert_layout_footnote_placement_str {bottomfloats}
    \str_gset:Nn \g_desert_numbering_footnotes_str {arabic}
    \str_gset:Nn \g_desert_numbering_float_within_str {none}
    \str_gset:Nn \g_desert_numbering_equation_within_str {none}
    \str_gset:Nn \g_desert_numbering_theorem_within_str {none}
    \str_gset:Nn \g_desert_numbering_footnotes_reset_bool {true}
    \bool_gset_true:N \g_desert_hide_title_page_footer_bool
    \bool_gset_true:N \g_desert_hide_copyright_page_footer_bool
    \bool_gset:Nn \g_desert_linespace_main_fp {2}
    \tl_gset:Nn \g_desert_linespace_caption_fp {1.05}
    \tl_gset:Nn \g_desert_between_footnotes_skip {\baselineskip}
}

\NewDocumentCommand \StanfordPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper, top=1in, bottom=1in, outer=1.5in, inner=1in, footskip=0.5in }
    \str_gset:Nn \g_desert_numbering_front_str {roman}
    \bool_gset_true:N \g_desert_hide_title_page_footer_bool
    \bool_gset_false:N \g_desert_hide_copyright_page_footer_bool
    \bool_gset:Nn \g_desert_linespace_main_fp {1.5}
}

\NewDocumentCommand \CambridgePreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
    { a4paper, top=2cm, bottom=2cm, inner=3cm, outer=2cm, footskip=1cm }
    \str_gset:Nn \g_desert_numbering_front_str {arabic}
    \bool_gset_false:N \g_desert_hide_title_page_footer_bool
    \bool_gset_false:N \g_desert_hide_copyright_page_footer_bool
    % unknown linespace
}

\cs_if_exist_use:c { \g_desert_preset_str Preset}



%========================================================================================
%                    load packages
%========================================================================================


% Pass along options:
\PassOptionsToPackage {\g_desert_language_str} {babel}
\desert_has_feat:nT {varioref}
    { \PassOptionsToPackage {\g_desert_language_str} {varioref} }
\PassOptionsToPackage {useregional} {datetime2}
\PassOptionsToPackage {list} {subcaption}
\bool_if:NT \g_desert_draft_bool
    { \PassOptionsToPackage {draft=true} {microtype} }
\bool_if:NT \g_desert_toc_panels_bool
    { \PassOptionsToPackage{list}{subcaption} }
\bool_if:NF \g_desert_cref_abbreviate_bool
    { \PassOptionsToPackage{noabbrev}{cleveref} }
\bool_if:NT \g_desert_cref_capitalize_bool
    { \PassOptionsToPackage{capitalize}{cleveref} }
\PassOptionsToPackage{babel=true}{microtype}
\desert_has_feat:nT {ulem}
    { \PassOptionsToPackage{markup}{txtstyles} }
% biblatex doesn't like hyperref's backref= option
    

\str_if_eq:VnF \g_desert_layout_footnote_placement_str {default}  % for compatibility
{
    \str_if_eq:VnF \g_desert_layout_footnote_placement_str {endnotes}
    { \PassOptionsToPackage{\g_desert_layout_footnote_placement_str}{footmisc} }
}


% early and order-dependent:
%\RequirePackage{xpatch}                     % needed to patch commands
%\RequirePackage{pdfmanagement-testphase}
\RequirePackage{hyperxmp}
\RequirePackage{mathcommand}                 % prime, subscript, preserving commands

% language:
\RequirePackage{tracklang}                   % before packages that use it
\RequirePackage{babel}                       % Main multilingual support
\RequirePackage{translations}                % \gettranslation; after: Babel

% layout control:
\RequirePackage{fancyvrb}                    % _verbatim_ , etc.
\RequirePackage[newcommands]{ragged2e}       % full ragged environments; before: footmisc
\RequirePackage{newfloat}                    % declare new float environments
%\RequirePackage{afterpage}                  % force something to happen on next page
\RequirePackage{geometry}                    % \geometry
\RequirePackage{adjustbox}                   % resize boxes
\RequirePackage{perpage}                     % reset a counter every page
\RequirePackage{datetime2}                   % format dates and times (after: babel)

% xindy and hyperref
\desert_load_feat:nn{xindy}{imakeidx}        % index; before: knowledge
\RequirePackage{hyperref}                    % AFTER xindy

% font control and math
% loads amsmath, unicode-math, fontspec, microtype, and fontsize:
\RequirePackage[faces,markup]{txtstyles}
\RequirePackage[fix]{info}                   % requires txtstyles
\RequirePackage{amsthm}                      % theorem-like environments
\RequirePackage{thmtools}                    % \declaretheorem
\RequirePackage{bm}                          % bold math
\RequirePackage{mathtools}                   % better environments; loads amsmath

% acro, index, nomenclature, etc.
\RequirePackage[backend=biber]{biblatex}     % BibLaTeX! after: hyperref
\RequirePackage{accsupp}                     % before: acro
\RequirePackage{acro}                        % for all abbreviations
\RequirePackage{nomencl}                     % nomenclature / list of symbols
\RequirePackage{nomgroups}                   % nomenclature groups


% layout & spacing
\RequirePackage[explicit]{titlesec}          % to format headers; explicit: use #1
\RequirePackage{titletoc}                    % to format TOC
\RequirePackage[titles]{tocloft}             % prevent loading without titles
\RequirePackage{appendix}                    % \begin{appendices}
\RequirePackage{fancyhdr}                    % footer and header
\RequirePackage{enumitem}                    % control spacing for lists
\RequirePackage{footmisc}                    % footnote styling and counters
\RequirePackage{enotez}                      % fixed endnotes
%\RequirePackage[backref]{enotez}            % NEEDS: 2022

% graphics
\RequirePackage[hypcap]{caption}             % needed for formatting; use hypcap option
\RequirePackage[hypcap]{subcaption}          % successor to subfig; use hypcap option
\RequirePackage{graphicx}                    % for, well, everything
%\RequirePackage{svg}                        % \includesvg; after graphicx

% tables
\RequirePackage{tabularray}                  % LaTeX3 tabular and table replacement
\UseTblrLibrary{amsmath}                     % (amsmath loaded earlier)
\UseTblrLibrary{counter}                     % get row and col counters
\UseTblrLibrary{booktabs}                    % \toprule, etc. and envs
\UseTblrLibrary{siunitx}                     % (siunitx loaded earlier)
\UseTblrLibrary{diagbox}                     % split desc for top-left cell
\UseTblrLibrary{varwidth}                    % can measure table dims if cells have pars
\RequirePackage[l3]{csvsimple}               % load CSV data

% typography
\RequirePackage{fvextra}                     % only needed to avoid warning in csquotes
\RequirePackage{csquotes}                    % quote environments [before: others?]
\RequirePackage{ellipsis}                    % no added space with \ldots in text mode
\RequirePackage{semantics}                   % academic links, etc.
\RequirePackage{siunitx}                     % pretty units

% optional features
\desert_load_feat:nn{newfloat}{minted}
\desert_load_feat:nn{xparse}{tcolorbox}
\desert_load_feat:nn{}{cryptocode}
\desert_load_feat:nn{}{chemmacros}
\desert_load_feat:nn{}{chemformula}
\desert_load_feat:nn{}{chemfig}


% should always be last:
\desert_load_feat:nn{}{varioref}
\desert_load_feat:nn{cleveref}{knowledge}
\RequirePackage[\baselanguage{\g_desert_language_str}]{cleveref}  % after: varioref

\NewDocumentCommand \DeclareEnTranslations {m}
{
    \clist_set:Nn \l_tmpa_clist {#1}
    \clist_map_inline:Nn \l_tmpa_clist
        { \DeclareTranslation{English}{##1}{##1} }
}
\NewDocumentCommand \DeclareTranslations { m m }
{
    \prop_set_from_keyval:Nn \l_tmpa_prop {#2}
    \prop_map_inline:Nn \l_tmpa_prop
        { \DeclareTranslation{#1}{##1}{##2} }
}
\NewDocumentCommand \Translate { m m }
    { \DeclareTranslations{#1}{#2} }

% unfortunately sentence-case is language-dependent
% All-caps are sometimes included too, for technical reasons
\DeclareEnTranslations
{
    by, in, for, of,
    abstract, Abstract, copyright, Copyright,
    abbreviation, Abbreviation, abbreviations, Abbreviations,
    list~of~abbreviations, List~of~abbreviations,
    nomenclature, Nomenclature,
    source~code, Source~code,
    list~of~source~code, List~of~source~code,
    list~of~theorems, ~List~of~theorems,
    algorithm, Algorithm, algorithms, Algorithms,
    list~of~algorithms, List~of~algorithms,
    definition, Definition, definitions, Definitions,
    list~of~definitions, List~of~definitions,
    chemical~diagram, Chemical~diagram,
    list~of~chemical~diagrams, List~of~chemical~diagrams,
    note, technical~note, caution, tip, example,  % default boxes
    Note, Technical~note, Caution, Tip, Example,
    NOTE, TECHNICAL~NOTE, CAUTION, TIP, EXAMPLE,
}
\NewDocumentCommand \trans {m}
    { \GetTranslationWarn{#1} }



\cs_generate_variant:Nn \skip_sub:Nn { NV }

\skip_sub:NV \g_desert_below_abstract_title_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_abstract_author_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_abstract_body_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_section_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_section_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_subsection_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_subsection_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_paragraph_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_front_chapter_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_chapter_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_theorem_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_theorem_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_algorithm_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_algorithm_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_definition_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_definition_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_remark_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_below_remark_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_list_skip \g_desert_between_paragraphs_skip
\skip_sub:NV \g_desert_above_multipar_list_skip \g_desert_between_paragraphs_skip


%========================================================================================
%                          fonts
%========================================================================================

\UseLatinModern
\DeclareLatinModerns
\txtstyles_declare_colors_from_prop:N \g_desert_color_prop
\txtstyles_declare_multiple_from_prop:N \g_desert_style_prop


%========================================================================================
%                          size and spacing
%========================================================================================

\exp_args:Nx \geometry {\g_desert_geometry_tl}


% NOTE: the order matters!!
% We must set parindent after the others

\txtstyles_use_font_size:V \g_desert_font_size_tl
\txtstyles_set_baselinestretch:V \g_desert_linespace_main_fp

\setlength \parindent {\dim_use:N \g_desert_indent_dim}
\setlength \parskip {\skip_use:N \g_desert_between_paragraphs_skip}

\setlength{\abovedisplayskip}{\g_desert_above_equation_skip}
\setlength{\belowdisplayskip}{\g_desert_below_equation_skip}

\setdisplayskipstretch{1.0}

\clist_const:Nn \c_desert_eqn_envs_clist
    { equation, equation*, multiline, multiline*, align, align*, gather, gather* }

\clist_map_inline:Nn \c_desert_eqn_envs_clist
{
    \AtBeginEnvironment {#1}
        { \txtstyles_use_baselinestretch:V \g_desert_linespace_equation_fp }
}

\bool_if:NF \g_desert_typo_allow_hyphens_bool
    { \txtstyles_disable_hyphens: }
    
\setlist
{
    itemsep=\g_desert_between_items_skip,
    topsep=\g_desert_above_list_skip,
    partopsep=0ex,
    parsep=\g_desert_between_paragraphs_skip,
}

\SetEnumitemKey{multipar}
{
    itemsep=\g_desert_between_multipar_items_skip,
    topsep=\g_desert_above_multipar_list_skip,
    partopsep=0ex,
    parsep=\g_desert_between_paragraphs_skip,
}



%========================================================================================
%                           section titles
%========================================================================================

\titleformat{name=\chapter}[block]
    { }   % code before
    {     % code for label
        \txtstyles_use:nn{chapter-label}{\chaptertitlename\ \thechapter}
        \skip_vertical:N \g_desert_below_chapter_label_skip
    }  %(TODO: \g_desert_below_chapter_label_skip doesn't work below?
    { 0pt }  % space between label and name
    { \txtstyles_use:nn{chapter-name}{#1} }  % code for name

\titleformat{name=\chapter,numberless}[display]
    { \filcenter }
    { }
    { 0pt }
    { \txtstyles_use:nn{front-chapter-title}{#1} }

\titleformat{\section}[hang]
    { }
    { \txtstyles_use:nn{section-title}{\thetitle} }
    { 1em }
    { \txtstyles_use:nn{section-title}{#1} }


\titleformat{\subsection}[hang]
    { }
    { \StyleTxt{subsection-title}{\thetitle} }
    { 1em }
    { \StyleTxt{subsection-title}{#1} }

\titleformat{\subsubsection}[hang]
    { }
    { \StyleTxt{subsubsection-title}{\thetitle} }
    { 1em }
    { \StyleTxt{subsubsection-title}{#1} }

\titleformat{\paragraph}[runin]
    { }
    { \StyleTxt{paragraph-title}{\thetitle} }
    { 1em }
    { \StyleTxt{paragraph-title}{#1.} }

\titleformat{\subparagraph}[runin]
    { }
    { \StyleTxtInline{italic}{\thetitle} }
    { 1em }
    { \StyleTxtInline{italic}{#1.} }

\titlespacing {name=\chapter}
    {0pt}                                       % left space
    {\skip_use:N \g_desert_above_chapter_skip}  % top space
    {\skip_use:N \g_desert_below_chapter_skip}  % bottom space

\titlespacing {name=\chapter,numberless}
    {0pt}
    {\skip_use:N \g_desert_above_front_chapter_skip}
    {\skip_use:N \g_desert_below_front_chapter_skip}

\titlespacing {\section}
    {0pt}
    {\skip_use:N \g_desert_above_section_skip}
    {\skip_use:N \g_desert_below_section_skip}

\titlespacing {\subsection}
    {0pt}
    {\skip_use:N \g_desert_above_subsection_skip}
    {\skip_use:N \g_desert_below_subsection_skip}

\titlespacing {\subsubsection}
    {0pt}
    {\skip_use:N \g_desert_above_subsubsection_skip}
    {\skip_use:N \g_desert_below_subsubsection_skip}

\titlespacing {\paragraph}
    {0pt}
    {\skip_use:N \g_desert_above_paragraph_skip}
    {1em}

\titlespacing {\subparagraph}  % not supported, but choose something reasonable
    {2em}
    {\skip_use:N \g_desert_above_paragraph_skip}
    {1em}



%========================================================================================
%                           TOC formatting
%========================================================================================

\titlecontents {chapter}
    [\g_desert_toc_chapter_dim]                                             % margin from left side
    { \addvspace{\g_desert_above_toc_chapter_skip} \DesertTocChapterHook }  % code before
    {                                                                       % code for label (if numbered)
        \contentslabel
            [
                \hyperlink
                    { chapter.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_desert_toc_chapter_dim}                                     % how big the label box is
    }
    { \hspace*{-\g_desert_toc_chapter_dim} }                                % code if unnumbered (subtract the box)
    { \DesertTocPageNumberHook \titlerule*[1pc]{.} \contentspage}           % code for page number

% The rest are all the same

\titlecontents {section}
    [ \dim_eval:n{\g_desert_toc_chapter_dim+\g_desert_toc_section_dim} ]
    { \addvspace{\g_desert_above_toc_section_skip} \DesertTocSectionHook }
    {
        \contentslabel
            [
                \hyperlink
                    { section.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_desert_toc_section_dim}
    }
    { \hspace*{-\g_desert_toc_section_dim} }
    {  \DesertTocPageNumberHook \titlerule*[1pc]{.} \contentspage }

\titlecontents {subsection}
    [
        \dim_eval:n
        {
             \g_desert_toc_chapter_dim
            +\g_desert_toc_section_dim
            +\g_desert_toc_subsection_dim
        }
    ]
    { \addvspace{\g_desert_above_toc_subsection_skip} \DesertTocSubsectionHook }
    {
        \contentslabel
            [
                \hyperlink
                    { subsection.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {g_desert_toc_subsection_dim}
    }
    { \hspace*{-g_desert_toc_subsection_dim} }
    {  \DesertTocPageNumberHook \titlerule*[1pc]{.} \contentspage }

\titlecontents {subsubsection}
    [
        \dim_eval:n
        {
             \g_desert_toc_chapter_dim
            +\g_desert_toc_section_dim
            +\g_desert_toc_subsection_dim
            +\g_desert_toc_subsubsection_dim
        }
    ]
    { \addvspace{\g_desert_above_toc_subsubsection_skip} \DesertTocSubsubsectionHook }
    {
        \contentslabel
            [
                \hyperlink
                    { subsubsection.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_desert_toc_subsubsection_dim}
    }
    { \hspace*{-\g_desert_toc_subsubsection_dim} }
    { \DesertTocPageNumberHook \titlerule*[1pc]{.} \contentspage }



%========================================================================================
%               header & footer
%========================================================================================

\renewcommand* \headrulewidth {0em}  % not professional

\cs_new:Npn \desert__set_fancy_page:VVVVVV #1#2#3#4#5#6
{
    \fancyhead{}
    \fancyhead [L] {#1}
    \fancyhead [C] {#2}
    \fancyhead [R] {#3}
    \fancyfoot{}
    \fancyfoot [L] {#4}
    \fancyfoot [C] {#5}
    \fancyfoot [R] {#6}
}

\desert__set_fancy_page:VVVVVV
    \g_desert_layout_header_left_tl 
    \g_desert_layout_header_center_tl
    \g_desert_layout_header_right_tl
    \g_desert_layout_footer_left_tl 
    \g_desert_layout_footer_center_tl
    \g_desert_layout_footer_right_tl

\fancypagestyle{plain}{}  % make plain be fancy
\pagestyle{plain}  % use plain
\assignpagestyle \chapter {plain}



%========================================================================================
%                           basic numbering
%========================================================================================

\txtstyles_set_section_depth:V \g_desert_numbering_depth_str
\txtstyles_set_toc_depth:V \g_desert_toc_depth_str

\cs_new:Npn \desert__number_within:nV #1#2
    { \numberwithin {#1} {#2} }

% provided by amsmath -- but works on all numbered environments
\str_if_eq:VnF \g_desert_numbering_float_within_str {none}
{
    \desert__number_within:nV {figure} \g_desert_numbering_float_within_str
    \desert__number_within:nV {table} \g_desert_numbering_float_within_str
}
\str_if_eq:VnF \g_desert_numbering_equation_within_str {none}
{
    \desert__number_within:nV {equation} \g_desert_numbering_equation_within_str
}


%========================================================================================
%                       footnote numbering and format
%========================================================================================

\cs_generate_variant:Nn \seq_if_in:NnTF { NVTF }

\seq_const_from_clist:Nn \c__desert_numeric_foonotes_clist
    { arabic, alph, Alph, roman, Roman }
    
\seq_if_in:NVTF \c__desert_numeric_foonotes_clist \g_desert_numbering_footnotes_str
    { \declarecommand \multfootsep {,} }           % e.g. 12,13
    { \declarecommand \multfootsep {\thinspace} }  % because some symbols are doubled


\str_if_eq:VnT \g_desert_numbering_footnote_within_str {page}
    { \MakePerPage[2]{footnote} } % otherwise we'll set in \Chapter


\seq_const_from_clist:Nn \g__desert_footsymbols_seq
    {lamport,lamport*,bringhurst,chicago,wiley }  % i.e. not arabic,roman,Roman,alph,Alph

\str_if_eq:VnF \g_desert_layout_footnote_placement_str {endnotes}
{
    \seq_if_in:NVTF \g__desert_footsymbols_seq \g_desert_numbering_footnotes_str
    {  % if it's a symbol style, we change symbols, then use \fnsymbol
        \setfnsymbol{\g_desert_numbering_footnotes_str}
        {
            \renewcommand \thefootnote
                { \txtstyles_use:nn{footnote-label}{\fnsymbol{footnote}} }
        }
    }
    {  % Otherwise just use the style (TODO: simplify)
        \str_if_eq:VnT \g_desert_numbering_footnotes_str {arabic}
        {
            \renewcommand \thefootnote
                { \txtstyles_use:nn{footnote-label}{\arabic{footnote}} }
        }
        \str_if_eq:VnT \g_desert_numbering_footnotes_str {Roman}
        {
            \renewcommand \thefootnote
                { \txtstyles_use:nn{footnote-label}{\Roman{footnote}} }
        }
        \str_if_eq:VnT \g_desert_numbering_footnotes_str {roman}
        {
            \renewcommand \thefootnote
                { \txtstyles_use:nn{footnote-label}{\roman{footnote}} }
        }
        \str_if_eq:VnT \g_desert_numbering_footnotes_str {Alph}
        {
            \renewcommand \thefootnote
                { \txtstyles_use:nn{footnote-label}{\Alph{footnote}} }
        }
        \str_if_eq:VnT \g_desert_numbering_footnotes_str {alph}
        {
            \renewcommand \thefootnote
                { \txtstyles_use:nn{footnote-label}{\alph{footnote}} }
        }
    }
}

% apply the footnote body format
\renewcommand*{\footnotelayout}
    { \txtstyles_run:n{footnote-body} }


% TODO: endnotes


%========================================================================================
%             equation labels
%========================================================================================

\newtagform{none}{}{}
\newtagform{round}{(}{)}
\newtagform{square}{[}{]}
\newtagform{curly}{\{}{\}}
\newtagform{none-bold}[\textbf]{}{}
\newtagform{round-bold}[\textbf]{(}{)}
\newtagform{square-bold}[\textbf]{[}{]}
\newtagform{curly-bold}[\textbf]{\{}{\}}

\exp_args:NV
    \usetagform \g_desert_numbering_equation_brackets_str



%========================================================================================
%                        bibliography
%========================================================================================

% don't show the language for every reference
\bool_if:NT \g_desert_bib_hide_language_bool
    { \AtEveryBibitem{\clearlist{language}} }

% Reference the title, date, journal, and authors
% Could alternatively use \DeclareCiteCommand
\ProvideDocumentCommand \chaptersource {m}
{
    \AtNextCite{\defcounter{maxnames}{60}}
    \fullcite{#1}
}
\ProvideDocumentCommand \reftitle {m} {``\citefield{#1}{title}"}
\ProvideDocumentCommand \refdoi {m} {\doi{\citefield{#1}{doi}}}
\ProvideDocumentCommand \refurl {m} {\citefield{\link{#1}{url}}}



%========================================================================================
%                     sections with labels
%========================================================================================

% These are like \chapter, etc., but can set a TOC entry even if unnumbered.
% ARGS:
%  * #1    Unnumbered
% ( #2 )   Label via \label
% [ #3 ]   TOC entry (used for TOC only if #4 is empty)
% { #4 }   Name to print (required but not printed if empty)
% If both #3 and #4 are empty, doesn't add to TOC.

\NewDocumentCommand \Section { s D(){} O{} m }
{
    % get an anchor either way -- either with \section[*] or with \phantomsection
    \tl_if_blank:nTF {#4}
        { \phantomsection }
        { \bool_if:nTF {#1} {\section*{#4}} {\section{#4}} }
    % if we didn't print a label, we want to add it to the TOC
    \tl_if_blank:nTF {#4}
    {
        % if it's not starred, increment even though there's no printable label
        \bool_if:nF {#1} { \addtocounter{section} }
        % use #3 (in square brackets) as the TOC label
        \tl_if_blank:nF {#3}
            { \addcontentsline{toc}{section}{#3} }
    }
    {  % if we DID print a label, BUT it's unnumbered, add it to the TOC
        \bool_if:nT {#1}
            { \addcontentsline{toc}{section}{#3} }
    }
    \tl_if_blank:nF{#2}{\label{#2}}
}

% This one is messier because it uses \g_desert_toc_front_chapters_bool
\NewDocumentCommand \Chapter { s D(){} O{} m }
{
    \str_if_eq:VnT \g_desert_numbering_footnote_within_str {chapter}
        { \setcounter{footnote}{0} }
    \tl_if_blank:nTF {#4}
        { \clearpage \phantomsection }
        { \bool_if:nTF {#1} {\chapter*{#4}} {\chapter{#4}} }
    \tl_if_blank:nTF {#4}
    {
        \bool_if:nF {#1} { \addtocounter{chapter} }
        \bool_if:NT \g_desert_toc_front_chapters_bool
        {
            \tl_if_blank:nF {#3}
                { \addcontentsline{toc}{chapter}{#3} }
        }
    }
    {
        \bool_if:nT {#1}
        {
            \bool_if:NT \g_desert_toc_front_chapters_bool
            {
                \addcontentsline{toc}{chapter}{#4}  % we know it's not blank
            }
        }
    }
    \tl_if_blank:nF{#2}{\label{#2}}
}

\NewDocumentCommand \SubSection { s D(){} O{} m }
{
    \tl_if_blank:nTF {#4}
        { \phantomsection }
        { \bool_if:nTF {#1} {\subsection*{#4}} {\subsection{#4}} }
    \tl_if_blank:nTF {#4}
    {
        \bool_if:nF {#1} { \addtocounter{subsection} }
        \tl_if_blank:nF {#3}
            { \addcontentsline{toc}{subsection}{#3} }
    }
    {
        \bool_if:nT {#1}
            { \addcontentsline{toc}{subsection}{#3} }
    }
    \tl_if_blank:nF{#2}{\label{#2}}
}

\NewDocumentCommand \SubSubSection { s D(){} O{} m }
{
    \tl_if_blank:nTF {#4}
        { \phantomsection }
        { \bool_if:nTF {#1} {\subsubsection*{#4}} {\subsubsection{#4}} }
    \tl_if_blank:nTF {#4}
    {
        \bool_if:nF {#1} { \addtocounter{subsubsection} }
        \tl_if_blank:nF {#3}
            { \addcontentsline{toc}{subsubsection}{#3} }
    }
    {
        \bool_if:nT {#1}
            { \addcontentsline{toc}{subsubsection}{#3} }
    }
    \tl_if_blank:nF{#2}{\label{#2}}
}

\NewDocumentCommand \Paragraph { s D(){} O{} m }
{
    \tl_if_blank:nTF {#4}
        { \phantomsection }
        { \bool_if:nTF {#1} {\paragraph*{#4}} {\paragraph{#4}} }
    \tl_if_blank:nTF {#4}
    {
        \bool_if:nF {#1} { \addtocounter{paragraph} }
        \tl_if_blank:nF {#3}
            { \addcontentsline{toc}{paragraph}{#3} }
    }
    {
        \bool_if:nT {#1}
            { \addcontentsline{toc}{paragraph}{#3} }
    }
    \tl_if_blank:nF{#2}{\label{#2}}
}


%========================================================================================
%                        front matter
%========================================================================================

\ProvideDocumentEnvironment {specialbox} { O{\textwidth} O{0ex} O{\fill} }
{
    \hbadness=10000  % we're likely to be underfull, and that's ok
    \vspace*{#2}
    \begin{center}
    \begin{minipage}{#1}
    \centering
}
{
    \end{minipage}
    \end{center}
    \vspace*{#3}
}


% Special chapters like acknowledgments
\ProvideDocumentEnvironment {FrontChapter} { D(){} O{} m }
    { \PreFrontChapterHook \Chapter*(#1)[#2]{#3} }
    { \acresetall }

% Super-special chapters, normally centered
\ProvideDocumentEnvironment {SpecialChapter} { D(){} O{} G{} O{\textwidth} O{0ex} O{\fill} }
{
    \PreSpecialChapterHook
    \Chapter*(#1)[#2]{#3}
    \begin{specialbox}[#4][#5][#6]
}
{
    \end{specialbox}
    \acresetall
}

\ProvideDocumentEnvironment {FrontCopyright} { D(){} O{} o o o  }
{
    \PreFrontCopyrightHook
    \begin{SpecialChapter}(#1)[#2]{}[#3][#4][#5]
}
{
    \bool_if:NT \g_desert_hide_copyright_page_footer_bool
        { \thispagestyle{empty} }
    \end{SpecialChapter}
}

% Abstract
\ProvideDocumentEnvironment {FrontAbstract} { D(){} O{Abstract} G{} }
{
    \PreFrontAbstractHook
    \begin{FrontChapter}(#1)[#2]{#3}
    \begin{center}
    \GetTitle[style=abstract-title]
    \skip_vertical:N \g_desert_below_abstract_title_skip
    \StyleTxt{abstract-by}{by}
    \skip_vertical:N \g_desert_above_abstract_author_skip
    \GetAuthors[style=abstract-authors]
    \skip_vertical:N \g_desert_above_abstract_body_skip
    \end{center}
    \end{FrontChapter}
    \acresetall  % though probably shouldn't use them
}{}

\NewDocumentEnvironment {FrontTitle} {}
{
    \clearpage
    \PreFrontTitleHook
}
{
    \bool_if:NT \g_desert_hide_title_page_footer_bool
        { \thispagestyle{empty} }
}

\ProvideDocumentCommand \TitleContents {}
{
    \GetTitle[style-inline={largerr,bold}]\\[\bigskipamount]
    by\\[\bigskipamount]
    \GetAuthors[style-inline={largerr}]\\
    \vspace{1cm}
    \large
    Submitted~on~\getplaindate\ in~partial~fulfillment~of\\
    the~requirements~for~the~degree~of
    \\[\bigskipamount]
    \Info{degree}~in~\getsubject\\
    \vspace{1cm}
    \StyleParInline{mono,202020}{Replace~this~temporary~title~page.}
}

% EXAMPLE title page
\ProvideDocumentCommand \ShowTitle {o}
{
    \begin{FrontTitle}
    \begin{specialbox}
    \rmfamily\largerr
    \TitleContents
    \end{specialbox}
    \end{FrontTitle}
}


\ProvideDocumentEnvironment {MainChapter} { D(){} O{} m }
{
    \PreMainChapterHook
    \bool_if:NT \g_desert_bib_per_chapter_bool { \begin{refsection} }
    \Chapter(#1)[#2]{#3}
}
{
    \bool_if:NT \g_desert_bib_per_chapter_bool
        { \ShowSubBib \end{refsection} }
}


%========================================================================================
%                        back matter
%========================================================================================

\ProvideDocumentCommand \ShowBackBib {}
{
    \bool_if:NF \g_desert_bib_per_chapter_bool
        { \ShowFullBib }
}

\NewDocumentEnvironment {Appendix} { s D(){} O{} m }
{
    \PreAppendixHook
    \begin{refsection}
    \bool_if:NTF {#1}
        { \Chapter*(#2)[#3]{#4} }
        { \Chapter(#2)[#3]{#4} }
}
{
    \ShowSubBib
    \end{refsection}
}

\NewDocumentEnvironment {Appendices} {}
    { \begin{appendices} }
    { \end{appendices} }

\NewDocumentCommand \ShowIndex {}
    { \desert_has_feat:nT {imakeidx} {\printindex} }



%========================================================================================
%                     lists of things
%========================================================================================

\cs_new:Npn \desert__lof_fix:n #1
{
    \renewcommand \listoffigures
    {
        \bool_if:nTF {#1}
            { \chapter{\listfigurename} }
            { \chapter*{\listfigurename} }
        \@mkboth
            {\MakeUppercase\listfigurename}
            {\MakeUppercase\listfigurename}
        \@starttoc{lof}
    }
}

\ProvideDocumentEnvironment {TocLikeListInternal} { m }
{
    \desert__lof_fix:n{#1}
    \txtstyles_set_baselinestretch:V \g_desert_linespace_list_of_fp
    \setlength{\parskip}{0ex}  % makes things confusing
    \PreTocLikeListHook
} {}

\ProvideDocumentEnvironment {TocLikeList} { t! }
    { \begin{TocLikeListInternal}{#1} }
    { \end{TocLikeListInternal} }

% Output table of contents
\ProvideDocumentCommand \ShowTableOfContents { t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_linespace_toc_fp
    \tableofcontents
    \end{TocLikeListInternal}
}

% Output list of figures
\ProvideDocumentCommand \ShowListOfFigures { t! }
{
    \begin{TocLikeListInternal}{#1}
    \listoffigures
    \end{TocLikeListInternal}
}

% Output list of tables
\ProvideDocumentCommand \ShowListOfTables { t! }
{
    \begin{TocLikeListInternal}{#1}
    \listoftables
    \end{TocLikeListInternal}
}

% Output list of abbreviations (via 'acro' package)
\ProvideDocumentCommand \ShowListOfAbbrevs { t! O{} }
{
    \begin{TocLikeListInternal}{#1}
    \bool_if:nTF {#1}
        { \printacronyms[heading=chapter, name=List~of~abbreviations, #2] }
        { \printacronyms[heading=chapter*, name=List~of~abbreviation, #2] }
    \end{TocLikeListInternal}
}

% Output nomenclature
\ProvideDocumentCommand \ShowNomenclature { t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_linespace_nomenclature_fp
    \bool_if:nTF {#1}
        { \printnomenclature[heading=chapter] }
        { \printnomenclature[heading=chapter*] }
    \end{TocLikeListInternal}
}

\ProvideDocumentCommand \ShowListOfTheoremLikeInternal { m m }
{
    \begin{TocLikeListInternal}{#1}
    \listoftheorems[#2]
    \end{TocLikeListInternal}
}

\ProvideDocumentCommand \ShowListOfTheoremLike { t! m }
    { \ShowListOfTheoremLikeInternal{#1}{#2} }

\ProvideDocumentCommand \ShowListOfTheorems {  t! O{} }
{
    \ShowListOfTheoremLikeInternal{#1}
    {
        ignoreall,
        show=\c_desert_theorem_like_clist,
        title=List~of~theorems,
        #2
    }
}

\ProvideDocumentCommand \ShowListOfAlgorithms { t! O{} }
{
    \ShowListOfTheoremLike{#1}
    {
        ignoreall,
        show=\c_desert_theorem_like_clist,
        title=List~of~algorithms,
        #2
    }
}

\ProvideDocumentCommand \ShowListOfDefinitions {  t! O{} }
{
    \ShowListOfTheoremLike{#1}
    {
        ignoreall,
        show=\c_desert_theorem_like_clist,
        title=List~of~definitions,
        #2
    }
}

% list of code
\ProvideDocumentCommand \ShowListOfSourceCode { t! }
{
    \desert_has_feat:nT {minted}
    {
        \begin{TocLikeListInternal}{#1}
        \listoflistings
        \end{TocLikeListInternal}
    }
}


%========================================================================================
%                     abbreviations
%========================================================================================

\acsetup
{
    single-style=long,     % NOTE: this might not always work
    make-links=false,
    list/sort=true,
    accsupp/use=true,     
    use-id-as-short=true,
    format/short=\txtuppertosc
}

\cs_generate_variant:Nn \prop_put_if_new:Nnn { NnV }


\NewDocumentCommand \indx { s m O{} }
{
    \bool_if:nTF {#1}
        { \StyleTxt{indx-starred}{#2} }
        { #2 }
    \desert_has_feat:nT {index}
        { \tl_if_blank:nTF{#3} { \index{#2} } { \index{#3} } }
}
\NewDocumentCommand \Indx { s m O{} }
{
    \bool_if:nTF {#1}
        {
            \StyleTxt
                {indx-starred}
                {\txtsentencecase*{#2}}
        }
        { \txtsentencecase*{#2} }
    \desert_has_feat:nT {index}
    {
        \tl_if_blank:nTF {#3} { \index{#2} } { \index{#3} }
    }
}


%========================================================================================
%                      captions (general)
%========================================================================================


\keys_define:nn { desert / capkeyval }
{
    label .tl_set:N = \l__label_tl,
    label .initial:n = {},
    entry .tl_set:N = \l__entry_tl,
    entry .initial:n = {},
    caption .tl_set:N = \l__caption_tl,
    caption .initial:n = {}
}

% TODO: 2022+ added these
\cs_generate_variant:Nn \tl_if_blank:nTF {VTF}
\cs_generate_variant:Nn \tl_if_blank:nT {VT}
\cs_generate_variant:Nn \tl_if_blank:nF {VF}

\cs_new:Nn \desert__capkeyval:
{
    \tl_if_blank:VTF \l__entry_tl
        { \caption{\l__caption_tl} }
        { \caption[\l__entry_tl]{\l__caption_tl} }
    \tl_if_blank:VF \l__label_tl
        { \label{\l__label_tl} }
}

% Simple caption and label
\ProvideDocumentCommand \capx { D(){} O{} m }
{
    \tl_if_blank:nTF {#2}
        { \caption{#2} }
        { \caption[#2]{#3} }
    \tl_if_blank:nF {#1}
        { \label{#1} }
}

% key-value caption and label
\ProvideDocumentCommand \capkeyval { m }
{
    \group_begin:
    \desert__capkeyval:
    \group_end:
}


% TODO: how do we use this?
\DeclareCaptionLabelSeparator {desert} {\g_desert_typo_caption_label_sep}

% Captions for everything but tables
% singlelinecheck: do what the user tells you
\txtstyles_declare_cap_style:nnn {desert} {caption-body} {caption-label}
\txtstyles_declare_cap_style:nnn {desert-subcap} {subcaption-body} {subcaption-label}

\DeclareCaptionLabelFormat {desert-subref}
{
    \txtstyles_use:nn
        {subref}
        { \g_desert_typo_subref_prefix_tl #2 \g_desert_typo_subref_suffix_tl }
}

\captionsetup
{
    singlelinecheck=false,
    skip=\g_desert_above_caption_skip,
    format=desert,
    labelsep=desert,
    subrefformat=desert-subref,
}

\DeclareCaptionSubType{figure}

\bool_if:NTF \g_desert_numbering_capitalize_panels_bool
    { \DeclareCaptionSubType[Alph]{figure} }
    { \DeclareCaptionSubType[alph]{figure} }

\captionsetup [subfigure]
{
    singlelinecheck=true,
    format=desert-subcap,
}


% Captions that go at the TOP of tables (LEGACY table environment)
\txtstyles_declare_cap_style:nnn {desert-top} {table-head-body} {table-head-label}
\captionsetup [table]
{
    skip=\g_desert_below_table_title_skip,
    format=desert-top,
    position=above,
}



%========================================================================================
%                 theorem-like
%========================================================================================

% define the styles suggested in the amsthm documentation
% • plain : italic text, extra space above and below;
% • definition : upright text, extra space above and below;
% • algorithm (NEW): same as definition;
% • remark : upright text, no extra space above or below.

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_theorem_skip,
        spacebelow=\g_desert_below_theorem_skip,
        postheadspace=\g_desert_glue_after_theorem_title_skip,
        headfont={\bfseries},
        bodyfont={\itshape},
    ]
    { plain }

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_algorithm_skip,
        spacebelow=\g_desert_below_algorithm_skip,
        postheadspace=\g_desert_glue_after_algorithm_title_skip,
        headfont={\bfseries},
        bodyfont={\upshape},
    ]
    { algorithm }

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_definition_skip,
        spacebelow=\g_desert_below_definition_skip,
        postheadspace=\g_desert_glue_after_definition_title_skip,
        headfont={\bfseries},
        bodyfont={\upshape},
    ]
    { definition }

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_remark_skip,
        spacebelow=\g_desert_below_remark_skip,
        postheadspace=\g_desert_glue_after_remark_title_skip,
        headfont={\bfseries},
        bodyfont={\upshape},
    ]
    { remark }

\clist_if_exist:NF \c_desert_theorem_like_clist
{
    \clist_const:Nn \c_desert_theorem_like_clist
        { theorem,lemma,corollary,proposition,conjecture,criterion,assertion }
}
\clist_if_exist:NF \c_desert_definition_like_clist
{
    \clist_const:Nn \c_desert_definition_like_clist
        {
            definition,condition,
            example,problem,exercise,question,
            axiom,property,assumption,hypothesis
        }
}
\clist_if_exist:NF \c_desert_algorithm_like_clist
{
    \clist_const:Nn \c_desert_algorithm_like_clist
        { algorithm, protocol,procedure,game,reduction }
}
\clist_if_exist:NF \c_desert_remark_like_clist
{
    \clist_const:Nn \c_desert_remark_like_clist
        { remark,note,notation,claim,summary,acknowledgment,case,conclusion }
}

\str_if_eq:VnTF \g_desert_numbering_theorem_within_str {none}
    { \declaretheorem [style=plain] {\c_desert_theorem_like_clist} }
    {
        \declaretheorem
            [ style=plain, parent=\g_desert_numbering_theorem_within_str ]
            { \c_desert_theorem_like_clist }
    }

% TODO: , refname=theorem, Refname=Theorem

\declaretheorem [style=definition,sibling=theorem] {\c_desert_algorithm_like_clist}
\declaretheorem [style=definition,sibling=theorem] {\c_desert_definition_like_clist}
\declaretheorem [style=remark,sibling=theorem] {\c_desert_remark_like_clist}


%========================================================================================
%                 figures -- single-panel
%========================================================================================

\AtBeginEnvironment {figure} {\centering}


\keys_define:nn { desert / one-panel-figure }
{
    file .tl_set:N = \l__file_tl,
    file .initial:n = {},
    graphicx .tl_set:N = \l__graphics_options_tl,
    graphicx .initial:n = {},
    label .tl_set:N = \l__label_tl,
    label .initial:n = {},
    entry .tl_set:N = \l__entry_tl,
    entry .initial:n = {},
    caption .tl_set:N = \l__caption_tl,
    caption .initial:n = {},
}

\NewDocumentEnvironment {OnePanelFigure} { s m }
{
    \bool_if:nTF {#1} {\begin{figure}} {\begin{figure*}}
    \keys_set:nn {desert / one-panel-figure} {#2}
    \tl_if_blank:VF \l__file_tl
        { \includegraphics[\l__graphics_options_tl]{\l__file_tl} }
}
{
    \desert__capkeyval:
    \bool_if:nTF {#1} {\end{figure}} {\end{figure*}}
}

\NewDocumentCommand \AddOnePanelFigure { s m }
{
    \begin{OnePanelFigure}\bool_if:nT{#1}{*}{#2}
    \end{OnePanelFigure}
}



%========================================================================================
%                 figures -- multi-panel (with real graphics)
%========================================================================================

\keys_define:nn { desert / multi-panel-figure }
{
    label .tl_set:N = \l__label_tl,
    label .initial:n = {},
    entry .tl_set:N = \l__entry_tl,
    entry .initial:n = {},
    caption .tl_set:N = \l__caption_tl,
    caption .initial:n = {},
}

\NewDocumentEnvironment {MultiPanelFigure} { s m }
{
    \bool_if:nTF {#1} {\begin{figure}} {\begin{figure*}}
    \keys_set:nn {desert / multi-panel-figure} {#2}
}
{
    \desert__capkeyval:
    \bool_if:nTF {#1} {\end{figure}} {\end{figure*}}
}

\keys_define:nn { desert / real-panel }
{
    file .tl_set:N = \l__panel_file_tl,
    file .initial:n = {...},
    graphicx .tl_set:N = \l__panel_graphics_options_tl,
    graphicx .initial:n = {},
    width .dim_set:N = \l__panel_width_dim,
    inner-pos .tl_set:N = \l__panel_innerpos_tl,
    label .tl_set:N = \l__panel_label_tl,
    entry .tl_set:N = \l__panel_entry_tl,
    caption .tl_set:N = \l__panel_caption_tl,
}

\NewDocumentCommand \AddPanel { m }
{
    \group_begin:
    \keys_set:nn {desert / real-panel} {#1}
    \subcaptionbox
        [\l__panel_entry_tl]
        {\l__panel_caption_tl}
        [\l__panel_width_dim]
        [\l__panel_innerpos_tl]
        {
            \includegraphics [\l__panel_graphics_options_tl] {\l__panel_file_tl}
            \tl_if_blank:VF \l__label_tl {\label{\l__label_tl}}
        }
    \group_end:
}



%========================================================================================
%                 phantom-panel figures -- 1 graphics file 
%========================================================================================

\keys_define:nn { desert / phantom-panel-figure }
{
    file .tl_set:N = \l__file_tl,
    file .initial:n = {},
    graphicx .tl_set:N = \l__graphics_options_tl,
    graphicx .initial:n = {},
    label .tl_set:N = \l__label_tl,
    label .initial:n = {},
    entry .tl_set:N = \l__entry_tl,
    entry .initial:n = {},
    caption .tl_set:N = \l__caption_tl,
    caption .initial:n = {},
}

%\prop_new:N \g__desert_panel_prop

\NewDocumentEnvironment {PhantomPanelFigure} { s m }
{
    \bool_if:nTF {#1} {\begin{figure}} {\begin{figure*}}
    \keys_set:nn {desert / phantom-panel-figure} {#2}
    \tl_if_blank:VF \l__file_tl
        { \includegraphics[\l__graphics_options_tl]{\l__file_tl} }
}
{
    \desert__capkeyval:
    \bool_if:nTF {#1} {\end{figure}} {\end{figure*}}
}

\keys_define:nn { desert / phantom-panel }
{
    label .tl_set:N = \l__panel_label_tl,
    entry .tl_set:N = \l__panel_entry_tl,
}

\NewDocumentCommand \AddPhantomPanel { m }
{
    \group_begin:
    \keys_set:nn {desert / phantom-panel} {#1}
     % add a LOF/TOC entry (if applicable), but don't show the text
    \captionlistentry {\l__panel_entry_tl}
    \tl_if_blank:VF \l__panel_label_tl {\label{\l__panel_label_tl}}
    \group_end:
}


\NewDocumentCommand \describepanel { m m }
{
    \subref{#1}\g_desert_typo_caption_label_sep_tl #2
}
\NewDocumentCommand \describepanels { m m }
{
    \txtstyles_use:nn
        {subref}
        {
            \g_desert_typo_subref_prefix_tl
            \g_desert_typo_caption_label_sep_tl
            #2
            \g_desert_typo_subref_suffix_tl
        }
}


%========================================================================================
%                            tables
%========================================================================================


\AtBeginEnvironment {table} {\centering}
\AtBeginEnvironment {tblr} {\centering}
% The other tblr environments use tblr internally

% Vertical spacing
\SetTblrOuter
{
    presep=\g_desert_above_table_title_skip,
    headsep=\g_desert_below_table_title_skip,
    footsep=\g_desert_above_table_footer_skip,
    postsep=\g_desert_below_table_footer_skip,
}

% Apply these font styles in all cases
\SetTblrStyle {caption-sep} {font={\txtstyles_run:n{table-head-label}}}
\SetTblrStyle {caption-tag} {font={\txtstyles_run:n{table-head-label}}}
\SetTblrStyle {caption-text} {font={\txtstyles_run:n{table-head-body}}}
\SetTblrStyle {lastfoot} {font={\txtstyles_run:n{table-footer}}}

% Fix the separators
% For caption, that's the only thing we'll do.
% (For notes and remarks, we'll do more after.)
\DefTblrTemplate {caption-sep} {default} {\g_desert_typo_table_note_sep_tl}
\DefTblrTemplate {note-sep} {default} {\g_desert_typo_table_note_sep_tl}   
\DefTblrTemplate {remark-sep} {default} {\g_desert_typo_table_remark_sep_tl}

% Now, simplify the footer ("last foot") template for a single-paragraph footer.
% This is the most common footer format journals use (that I'm familiar with).
% For this we'll need to:
% 1. Declare "note" and "remark" to replace the \par at the end with \space
%    We'll save these as a template called "shortfoot"
% 2. Use those in "lastfoot" as template "shortfoot"
% 3. Save the original as an "longfoot" template.
% 4. Declare "shortfoot" and "longfoot" themes.

\DefTblrTemplate {note} {shortfoot}
{
    \MapTblrNotes
    {
        \noindent  % fixed
        \UseTblrTemplate{note-tag}{default}
        \UseTblrTemplate{note-sep}{default}
        \UseTblrTemplate{note-text}{default}
        \space  % fixed
    }
}

\DefTblrTemplate {remark} {shortfoot}
{ 
    \MapTblrRemarks
    {
        \noindent  % fixed
        \UseTblrTemplate{remark-tag}{default}
        \UseTblrTemplate{remark-sep}{default}
        \UseTblrTemplate{remark-text}{default}
        \space  % fixed
    }
}

\DefTblrTemplate {lastfoot} {shortfoot}
{
    \UseTblrTemplate{remark}{shortfoot}
    \UseTblrTemplate{note}{shortfoot}
}
\DefTblrTemplate {lastfoot} {longfoot}
{
    \UseTblrTemplate{remark}{default}
    \UseTblrTemplate{note}{default}
}

\NewTblrTheme {shortfoot}
    { \UseTblrTemplate {lastfoot} {shortfoot} }

\NewTblrTheme {longfoot}
    { \UseTblrTemplate {lastfoot} {longfoot} }


\NewColumnType{L}{>{$}l<{$}}
\NewColumnType{C}{>{$}c<{$}}
\NewColumnType{R}{>{$}r<{$}}
\NewRowType{L}{>{$}l<{$}}
\NewRowType{C}{>{$}c<{$}}
\NewRowType{R}{>{$}r<{$}}

% Process an external table with csvsimple-l3.
%                    == ARGS ==                                       %
%  #      R? arg     description                                      %
% [ #1 ]  N  READER  key-value args to csvreader (e.g. separator=tab)
% { #2 }  Y  OUTER   key-value args to tblr outer[] (e.g. caption=)
% { #3 }  Y  INNER   key-value args to tblr inner{} (e.g. colspec=)
% < #4 >  Y  FILE    Path to file (e.g. cows.csv)
%
\ProvideDocumentCommand \loadtable { O{} m m r<> }
{
    \SetTblrOuter{#2}
    \csvreader
    [
        no~head,
        long~tabularray = {#3},
        table~head = {\hline},
        table~foot = {\hline},
        late~after~first~line = {\\\hline},
        #1
    ]
    {#4}
}


%========================================================================================
%                            boxes
%========================================================================================

\desert_has_feat:nT {tcolorbox}
{
    \cs_new:Npn \desert_declare_box:nnnn #1#2#3#4
    {
        \DeclareTColorBox {#1} { O{} }
        {
            title={#2~##1},
            colframe=#3,
            colupper=#3,
            colback=black!1!white,
            coltext=black,
            fonttitle={\normalsizerr\bfseries},
            fontlower={},
            arc=0.1pc,
            toptitle=0.2pc,
            bottomtitle=0.2pc,
            #4
        }
    }  % TODO: key-value
    \NewDocumentCommand \DeclareDesertBox { m m r[] O{} }
        { \desert_declare_box:nnnn {#1} {#2} {#3} {#4} }

    \DeclareDesertBox {BoxNote} {\trans{NOTE}} [xkcd chestnut]
    \DeclareDesertBox {BoxTechNote} {\trans{TECHNICAL~NOTE}} [xkcd charcoal]
    \DeclareDesertBox {BoxCaution} {\trans{CAUTION}} [xkcd brick red]
    \DeclareDesertBox {BoxTip} {\trans{TIP}} [xkcd prussian blue]
    \DeclareDesertBox {BoxExample} {\trans{EXAMPLE}} [xkcd spruce]
    
    \DeclareTColorBox {DesertMinted} { O{} }
    {
        colback=black!1!white,
        coltext=black,
        arc=1mm,
        #1
    }
}



%========================================================================================
%                    source code
%========================================================================================


\desert_has_feat:nT {minted}
{
    \crefname {listing} {\trans{source~code}} {\trans{source~code}}
    \Crefname {listing} {\trans{Source~code}} {\trans{Source~code}}
    \SetupFloatingEnvironment {listing}
    {
        name={{Source~code}},
        listname={{List~of~source~code}}
    }
    \setminted{python3=true}
}


\keys_define:nn { desert / sourcecode }
{
    lang .tl_set:N = \l__lang_tl,
    lang .initial:n = {text},
    label .tl_set:N = \l__label_tl,
    label .initial:n = {},
    entry .tl_set:N = \l__entry_tl,
    entry .initial:n = {},
    caption .tl_set:N = \l__caption_tl,
    caption .initial:n = {},
}

% Wrapper environment for minted and listing.
%                    == ARGS ==                            %
%  arg        description                                  %
%  label      Passed to \label
%  entry      TOC entry for \caption[]
%  caption    Value to \caption{}
%  language   Passed to \begin{minted}{}; default=text
%  <other>    Passed to \begin{minted}[]
%
\ProvideDocumentEnvironment {sourcecode} { O{} m }
{ \VerbatimEnvironment
    \captionsetup  % TODO: outside
        { format=desert-top, justification=raggedright, skip=\g_desert_below_table_title_skip }
    %\vspace{-\g_desert_between_paragraphs_skip}
    \begin{listing}
    \keys_set:nn {desert / sourcecode} {#2}
    \desert__capkeyval:
    \desert_has_feat:nT {tcolorbox}  % box even if minted is not enabled
        { \begin{DesertMinted} }
    \desert_has_feat:nT {minted}
    {
        \txtstyles_run:n{source-code}
        \setminted{baselinestretch=\g_desert_linespace_source_code_fp}
        \begin{minted}[#1]{\l__lang_tl}
    }
}
{
    \desert_has_feat:nT {minted}
        { \end{minted} }
    \desert_has_feat:nT {tcolorbox}
        { \end{DesertMinted} }
    \end{listing}
}

% Load minted code and put it in a listing.
%                    == ARGS ==                                       %
%  #      R? arg     description                                      %
% [ #1 ]  N  MINTED  key-value args to \begin{minted}[]
% { #2 }  Y  main    key-value args to \capkeyval / \begin{sourcecode}{}
% < #4 >  Y  FILE    Path to file (e.g. cows.java)
%
\ProvideDocumentCommand \loadsourcecode { O{} m r<> }
{
    \begin{listing}
    \keys_set:nn {desert / sourcecode} {#2}
    \desert__capkeyval:
    \desert_has_feat:nT {minted}
        { \inputminted[#1]{\l__lang_tl}{#3} }
    \end{listing}
}



%========================================================================================
%                               chemistry
%========================================================================================

\newcounter{chem}
\crefname {chem} {\trans{chemical~diagram}} {\trans{chemical~diagrams}}
\Crefname {chem} {\trans{Chemical~diagram}} {\trans{Chemical~diagrams}}


% We're only setting relative scale here
% These values were the defaults in ~2022-01
% We'll call this in \AtBeginDocument
\ProvideDocumentCommand \SetChemfigScale { >{\TrimSpaces}m >{\TrimSpaces}m }
{
    \setchemfig
    {                             % start with white:
        atom sep={3em#1},
        compound sep={5em#1},     % black from now on:
        cram width={1.5ex#2},
        cram dash width={1pt#2},
        cram dash sep={2pt#2},
        bond offset={2pt#2},
        double bond sep={2pt#2},
        arrow offset={1em#2},
        arrow double sep={2pt#2},
        arrow label sep={3pt#2},
        + sep left={0.5em#2},
        + sep right={0.5em#2}
    }
}

% Chemical diagram environment
%                    == ARGS ==                                       %
%  #      R? arg     description                                      %
% ( #1 )  N  LABEL   passed to \label{}
\ProvideDocumentEnvironment {Chemistry} { D(){} }
{
    \txtstyles_run:n {desert-chemistry}
    \refstepcounter{chem}
    \tl_if_blank:nF{#1}{\label{#1}}
}
{}


% Draw, name, and label a chemical structure from chemfig.
% This is pretty narrow-purpose command for doing only that.
%                    == ARGS ==                                       %
%  #      R? arg     description                                      %
% [ #1 ]  N  NAME    passed to \chemname{}
% ( #2 )  N  LABEL   passed to \label{}
% { #3 }  Y  STRUCT  Passed to \chemfig{}
%
\NewDocumentCommand \chemstructure { O{} D(){} m }
{
    \begin{chemistry}(#2)
    \tl_if_blank:nF{#1}{\chemname{#1}}
    \chemfig{#3}
    \end{chemistry}
}


%========================================================================================
%                    typography; units & numbers (SI)
%========================================================================================

\RenewDocumentCommand \foreign { m }
    { \txtstyles_use:nn{foreign-words}{#1} }  % e.g. "et al." or "in vivo"


% Really none of these should be changed, EXCEPT
% group-digits group-minimum-digits, and maybe group-separator.
% If in a US university: group-separator={,},group-digits=integer
\sisetup
{
    mode=match,               % stay in the current mode (all?)
    number-mode=match,        % stay in the current mode (digits)
    unit-mode=match,          % stay in the current mode (units)
    propagate-math-font=true, % these just retain the current font:
    reset-text-family=false,
    reset-text-series=false,
    reset-text-shape=false,
    retain-explicit-plus,     % +1 stays +1, not 1
    retain-zero-uncertainty,  % \pm 0 still shown
    group-minimum-digits=4,   % starting at this number (10,000)
    group-digits=all,         % 'all' is acceptable with thinspace
    group-separator=\thinspace,
}


%========================================================================================
%                       hyperlinks
%========================================================================================

% We pass the author, etc., at the preamble end, after the user set it.
\hypersetup
{
    linktoc=all,
    colorlinks,
    linkcolor=ref,
    citecolor=cite,
    urlcolor=url,
    filecolor=file,
    final=true, draft=false  % ignore global settings
}


%========================================================================================
%                front, main, back matter commands
%========================================================================================

\NewDocumentCommand \ShowSubBib {}
{
    \bool_if:NT \g_desert_bib_per_chapter_bool
        { \printbibliography[heading=subbibintoc] }
}

\NewDocumentCommand \ShowFullBib {}
{
    \bool_if:NF \g_desert_bib_per_chapter_bool
        { \printbibliography }
}

\NewDocumentCommand \StartFrontMatter {}
{
    \pagenumbering{\g_desert_numbering_front_str}
    \setcounter{page}{1}
}
\AtBeginDocument {\StartFrontMatter}

\NewDocumentCommand \StartMainMatter {}
{
    \str_if_eq:NNF \g_desert_numbering_front_str \g_desert_numbering_main_str
    {
        \pagenumbering{\g_desert_numbering_main_str}
        \setcounter{page}{1}
    }
}

\NewDocumentCommand \StartBackMatter {}
{
    \str_if_eq:NNF \g_desert_numbering_main_str \g_desert_numbering_back_str
        {
            \pagenumbering{\g_desert_numbering_back_str}
            \setcounter{page}{1}
        }
}



%========================================================================================
%                     setup commands
%========================================================================================

% We're just aliasing to make them consistent.
% Setup commands should end with 'Setup' and be camel-case.

\NewDocumentCommand \SiSetup {m}
    { \sisetup{#1} }

\NewDocumentCommand \HyperSetup {m}
    { \hypersetup{#1} }

\NewDocumentCommand \ChemSetup {m}
    { \chemsetup{#1} }

\NewDocumentCommand \ChemfigSetup {m}
    { \setchemfig{#1} }

\NewDocumentCommand \AcroSetup {m}
    { \acsetup{#1} }

\NewDocumentCommand \CaptionSetup { o m }
    { \captionsetup[#1]{#2} }

\NewDocumentCommand \MintedSetup {m}
    { \setminted{#1} }

\NewDocumentCommand \GeometrySetup {m}
    { \geometry{#1} }



%========================================================================================
%                    input and subfile wrapper commands
%========================================================================================

% See also: \LoadBib and \LoadTex.

% These just start the front, main, or back matter and load the listed files.

\NewDocumentCommand \LoadFrontDocs { >{\SplitList{,}}m }
{
    \StartFrontMatter
    \ProcessList{#1}{\input}
}

\NewDocumentCommand \LoadMainDocs { >{\SplitList{,}}m }
{
    \StartMainMatter
    \ProcessList{#1}{\input}
}

\NewDocumentCommand \LoadBackDocs { >{\SplitList{,}}m }
{
    \StartBackMatter
    \ProcessList{#1}{\input}
}


\NewDocumentCommand \StartSubFiles {}
    { \usepackage{subfiles} }  % usepackage on purpose -- don't allow in premable.


% These use \subfile instead of \input.

\NewDocumentCommand \LoadFrontSubdocs { >{\SplitList{,}}m }
{
    %\StartFrontMatter
    \ProcessList{#1}{\subfile}
}

\NewDocumentCommand \LoadMainSubdocs { >{\SplitList{,}}m }
{
    \StartMainMatter
    \ProcessList{#1}{\subfile}
}

\NewDocumentCommand \LoadBackSubdocs { >{\SplitList{,}}m }
{
    \StartBackMatter
    \ProcessList{#1}{\subfile}
}


\NewDocumentCommand \LoadBib {m}
    { \addbibresource{#1} }

\NewDocumentCommand \LoadTex {m}
    { \input{#1} }


% Defaults, which should be changed.
% These are all passed to \hypersetup at the end.
\SetInfo
{
    title = A Title,
    authors = An Author,
    subject = A Subject,
    keywords = {Several, Keywords},
    degree = some degree,
    university = some university
}



%========================================================================================
%                    final things
%========================================================================================

% Nomenclature!
\makenomenclature

% Run \makeindex
\desert_has_feat:nT {imakeidx}
{
    \tl_set_eq:NN \l_tmpa_tl \g_desert_layout_index_cols_int
    \tl_set:Nn \l_tmpb_tl {\dim_use:N \g_desert_layout_index_col_sep_dim}
    \bool_if:NTF \g_desert_toc_index_bool
        { \makeindex[columns={\l_tmpa_tl}, columnsep={\l_tmpb_tl},intoc] }
        { \makeindex[columns={\l_tmpa_tl}, columnsep={\l_tmpb_tl}] }
}


% Workaround for expansion issue in AddPdfHyperxmpData
\cs_new:Npn \desert__hyper:VVVV #1#2#3#4
{
    \hypersetup
    {
        pdftitle=#1,
        pdfauthor=#2,
        pdfkeywords=#3,
        pdfsubject=#4,
        pdfcreator=LuaLaTeX Desert class
    }
}
\info_get:nN {title} \g__desert_title_tl
\info_get:nN {authors} \g__desert_authors_tl
\info_get:nN {keywords} \g__desert_keywords_tl
\info_get:nN {subject} \g__desert_subject_tl

\AtEndPreamble
{
    % TODO: Get this working and remove workaround
    % \AddPdfHyperxmpData  % from info.sty
    \desert__hyper:VVVV
        \g__desert_title_tl
        \g__desert_authors_tl
        \g__desert_keywords_tl
        \g__desert_subject_tl
}
