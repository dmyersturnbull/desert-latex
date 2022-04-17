% Copyright 2022 Douglas Myers-Turnbull
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or
% (at your option) any later version. The latest version of this license is
% in http://www.latex-project.org/lppl.txt and version 1.3 or later is part of
% all distributions of LaTeX version 2005/12/01 or later.


%=======                                                   =======
%=======                      DESERT                       =======
%=======                                                   =======


%========================================================================================
%                    class declaration
%========================================================================================

\NeedsTeXFormat{LaTeX2e}[2020-10-01]
\ExplSyntaxOn
\RequirePackage{etoolbox}
\RequirePackage{l3keys2e}
\NeedsTeXFormat{LaTeX2e}

\ProvidesExplClass {desert} {2022-04-09} {0.1} {Desert~dissertation~template}



%========================================================================================
%                    new variants, etc.
%========================================================================================

\cs_generate_variant:Nn \tl_if_blank:nTF { VTF }
\cs_generate_variant:Nn \tl_if_blank:nT { VT }
\cs_generate_variant:Nn \tl_if_blank:nF { VF }
\cs_generate_variant:Nn \seq_if_in:NnTF { NVTF }
\cs_generate_variant:Nn \seq_if_in:NnT { NVT }
\cs_generate_variant:Nn \seq_if_in:NnF { NVF }
\cs_generate_variant:Nn \prop_put_if_new:Nnn { NnV }
\cs_generate_variant:Nn \skip_sub:Nn { NV }
\cs_generate_variant:Nn \skip_gsub:Nn { NV }
\cs_generate_variant:Nn \skip_add:Nn { NV }
\cs_generate_variant:Nn \skip_gadd:Nn { NV }

\exp_args_generate:n { cn,  co,  cV,  cv,  ce,  cf,  cx }
\exp_args_generate:n { ccn, cco, ccV, ccv, cce, ccf, ccx }
\exp_args_generate:n { Nen, Neo, NeV, Nev,    , Nef, Nex }
\exp_args_generate:n { cen, ceo, ceV, cev, cee, cef, cex }
\exp_args_generate:n { Nnee }

%\prg_new_conditional:Npnn \pkg_if_loaded:n #1 { T, F, TF }
%{
%    \@ifpackageloaded {#1}
%    { \prg_return_true: }
%    { \prg_return_false: }
%}



%========================================================================================
%                      errors, warnings, messages, etc.
%========================================================================================

\msg_new:nnn {desert} {nosuchpreset}
    {Preset~'#1'~not~available:~no~command~of~that~name.}

\cs_new_protected:Npn \__desert_warn_nosuchpreset:n #1
    { \msg_warning:nnn{desert}{nosuchpreset}{#1} }
\cs_generate_variant:Nn \__desert_warn_nosuchpreset:n { V, v }



%========================================================================================
%                    containers to store package options
%========================================================================================

% Saving optional features

\seq_new:N \g_desert_feature_seq

\prg_new_conditional:Npnn  \desert_if_feat_enabled:n #1 { T, F, TF }
{
    \seq_if_in:NnTF \g_desert_feature_seq {#1}
    { \prg_return_true: }
    { \prg_return_false: }
}

\cs_new_protected:Npn \desert_load_feat:nn #1#2
{
    \seq_if_in:NnT \g_desert_feature_seq {#2}
        { \RequirePackage[#1]{#2} }
}

\cs_new_protected:Npn \desert_load_feat:n #1
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
draft .bool_gset:N = \g_desert_draft_bool ,
draft .initial:n = false ,

language .tl_gset:N = \g_desert_lang_str ,
language .initial:n = USenglish ,

extra-languages .tl_gset:N = \g_desert_extra_languages_str ,
extra-languages .initial:n = {} ,

bidi .bool_gset:N = \g_desert_bidi_bool ,
bidi .initial:n = false ,

geometry .tl_gset:N = \g_desert_geometry_tl ,
geometry .initial:n = {} ,

preset .tl_set:N = \g_desert_preset_str ,
preset .initial:n = GenericAFourPreset ,

feature / svg .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {svg} } ,
feature / svg .value_forbidden:n = true ,

feature / kantlipsum .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {kantlipsum} } ,
feature / kantlipsum .value_forbidden:n = true ,

feature / chemformula .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {chemformula} } ,
feature / chemformula .value_forbidden:n = true ,

feature / chemfig .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {chemfig} } ,
feature / chemfig .value_forbidden:n = true ,

feature / chemmacros .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {chemmacros} } ,
feature / chemmacros .value_forbidden:n = true ,

feature / cryptocode .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {cryptocode} } ,
feature / cryptocode .value_forbidden:n = true ,

feature / imakeidx .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {imakeidx} } ,
feature / imakeidx .value_forbidden:n = true ,

feature / knowledge .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {knowledge} } ,
feature / knowledge .value_forbidden:n = true ,

feature / lettrine .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {lettrine} } ,
feature / lettrine .value_forbidden:n = true ,
feature / lettrine .initial:n = false ,

feature / minted .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {minted} } ,
feature / minted .value_forbidden:n = true ,

feature / tcolorbox .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {tcolorbox} } ,
feature / tcolorbox .value_forbidden:n = true ,

feature / ulem .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {ulem} } ,
feature / ulem .value_forbidden:n = true ,

feature / varioref .code:n =
    { \seq_gput_right:Nn \g_desert_feature_seq {varioref} } ,
feature / varioref .value_forbidden:n = true ,

bib / hide-language .bool_gset:N = \g_desert_bib_hide_language_bool ,
bib / hide-language .initial:n = false ,

bib / per-chapter .bool_gset:N = \g_desert_bib_per_chapter_bool ,
bib / per-chapter .initial:n = false ,

bib / style .tl_gset:N = \g_desert_bib_style_str ,
bib / style .initial:n = ieee ,

color / cite  .prop_gput:N = \g_desert_color_prop ,
color / cite  .initial:n  = 000060 ,

color / file  .prop_gput:N = \g_desert_color_prop ,
color / file  .initial:n  = red ,

color / ref   .prop_gput:N = \g_desert_color_prop ,
color / ref   .initial:n  = 000060 ,

color / url   .prop_gput:N = \g_desert_color_prop ,
color / url   .initial:n  = 0000A0 ,

cref / abbreviate .bool_gset:N = \g_desert_cref_abbreviate_bool ,
cref / abbreviate .initial:n = false ,

cref / capitalize .bool_gset:N = \g_desert_cref_capitalize_bool ,
cref / capitalize .initial:n = false ,

font-size / main .tl_gset:N = \g_desert_font_size_tl ,
font-size / main .initial:n = 11pt ,

layout / index-cols .int_gset:N = \g_desert_layout_index_cols_int ,
layout / index-cols .initial:n = 2 ,

layout / index-col-sep .dim_gset:N = \g_desert_layout_index_col_sep_dim ,
layout / index-col-sep .initial:n = 3em ,

layout / header-left .tl_gset:N = \g_desert_layout_header_left_tl ,
layout / header-left .initial:n = {} ,

layout / header-center .tl_gset:N = \g_desert_layout_header_center_tl ,
layout / header-center .initial:n = {} ,

layout / header-right .tl_gset:N = \g_desert_layout_header_right_tl ,
layout / header-right .initial:n = {} ,

layout / footer-left .tl_gset:N = \g_desert_layout_footer_left_tl ,
layout / footer-left .initial:n = {} ,

layout / footer-center .tl_gset:N = \g_desert_layout_footer_center_tl ,
layout / footer-center .initial:n = {} ,

layout / footer-right .tl_gset:N = \g_desert_layout_footer_right_tl ,
layout / footer-right .initial:n = \thepage ,
layout / footer-right .initial:n = {} ,

layout / hide-copyright-page-footer .bool_gset:N = \g_desert_hide_copyright_footer_bool ,
layout / hide-copyright-page-footer .initial:n = false ,

layout / hide-title-page-footer .bool_gset:N = \g_desert_hide_title_footer_bool ,
layout / hide-title-page-footer .initial:n = false ,

layout / footnotes-as-endnotes .bool_gset:N = \g_desert_force_endnotes_bool ,
layout / footnotes-as-endnotes .initial:n = false ,

layout / endnote-backrefs .bool_gset:N = \g_desert_endnote_backrefs_bool,
layout / endnote-backrefs .initial:n = false ,

layout / footnote-placement .choices:nn =
    {default, abovefloats, belowfloats, bottom, bottomfloats, bottomfootnotes}
    { \tl_gset_eq:NN \g_desert_footnote_placement_str \l_keys_choice_tl } ,
layout / footnote-placement .initial:n = default ,

layout / hide-links-in-title .bool_gset:N = \g_desert_hide_links_in_title_bool ,
layout / hide-links-in-title .initial:n = false ,

leading / main .tl_gset:N = \g_desert_leading_main_fp ,
leading / main .initial:n = 1.6 ,

leading / caption .tl_gset:N = \g_desert_leading_caption_fp ,
leading / caption .initial:n = 1.2 ,

leading / equation .tl_gset:N = \g_desert_leading_equation_fp ,
leading / equation .initial:n = 1.4 ,

leading / toc .tl_gset:N = \g_desert_leading_toc_fp ,
leading / toc .initial:n = 1.4 ,

leading / list-of .tl_gset:N = \g_desert_leading_list_of_fp ,
leading / list-of .initial:n = 1.4 ,

leading / abbreviations .tl_gset:N = \g_desert_leading_abbrevs_fp ,
leading / abbreviations .initial:n = 1.4 ,

leading / nomenclature .tl_gset:N = \g_desert_leading_nomenclature_fp ,
leading / nomenclature .initial:n = 1.4 ,

leading / source-code .tl_gset:N = \g_desert_leading_source_code_fp ,
leading / source-code .initial:n = 1.2 ,

numbering / depth .choices:nn =
    { none,chapter,section,subsection,subsubsection,paragraph,subparagraph }
    { \tl_gset_eq:NN \g_desert_numbering_depth_str \l_keys_choice_tl } ,
numbering / depth .initial:n = subparagraph ,

numbering / back-matter-pages .choices:nn =
    {arabic,roman,Roman,alph,Alph}
    { \tl_gset_eq:NN \g_desert_numbering_back_str \l_keys_choice_tl } ,
numbering / back-matter-pages .initial:n = arabic ,

numbering / main-matter-chapters .choices:nn =
    {arabic,roman,Roman,alph,Alph}
    { \tl_gset_eq:NN \g_desert_numbering_main_chapters_str \l_keys_choice_tl } ,
numbering / main-matter-chapters .initial:n = arabic ,

numbering / back-matter-chapters .choices:nn =
    {arabic,roman,Roman,alph,Alph}
    { \tl_gset_eq:NN \g_desert_numbering_back_chapters_str \l_keys_choice_tl } ,
numbering / back-matter-chapters .initial:n = Alph ,

numbering / figure-panels .tl_gset:N = \g_desert_numbering_panels_tl ,
numbering / figure-panels .initial:n = alph ,

numbering / equation-brackets .choices:nn =
    { none,round,square,curly,none-bold,round-bold,square-bold,curly-bold }
    { \tl_gset_eq:NN \g_desert_numbering_brackets_str \l_keys_choice_tl } ,
numbering / equation-brackets .initial:n = round ,

numbering / equation-within .choices:nn =
    { none,chapter,section,subsection,subsubsection }
    { \tl_gset_eq:NN \g_desert_equation_within_str \l_keys_choice_tl } ,
numbering / equation-within .initial:n = chapter ,

numbering / float-within .choices:nn =
    {none,chapter,section,subsection}
    { \tl_gset_eq:NN \g_desert_float_within_str \l_keys_choice_tl } ,
numbering / float-within .initial:n = chapter ,

numbering / footnote-within .choices:nn =
    { none,page,chapter }
    { \tl_gset_eq:NN \g_desert_footnote_within_str \l_keys_choice_tl } ,
numbering / footnote-within .tl_gset:N = \g_desert_footnote_within_str ,

numbering / footnotes .choices:nn =
    { arabic,roman,Roman,alph,Alph,lamport,lamport*,bringhurst,chicago,wiley }
    { \tl_gset_eq:NN \g_desert_numbering_footnotes_str \l_keys_choice_tl } ,
numbering / footnotes .initial:n = lamport* ,

numbering / front-matter-pages .choices:nn =
    {arabic,roman,Roman,alph,Alph}
    { \tl_gset_eq:NN \g_desert_numbering_front_str \l_keys_choice_tl } ,
numbering / front-matter-pages .initial:n = roman ,

numbering / main-matter-pages .choices:nn =
    { arabic,roman,Roman,alph,Alph }
    { \tl_gset_eq:NN \g_desert_numbering_main_str \l_keys_choice_tl } ,
numbering / main-matter-pages .initial:n = arabic ,

numbering / theorem-like-within .choices:nn =
    { none,chapter,section,subsection,subsubsection }
    { \tl_gset_eq:NN \g_desert_theorem_within_str \l_keys_choice_tl } ,
numbering / theorem-like-within .initial:n = chapter ,

style / abstract-by .prop_gput:N = \g_desert_style_prop ,
style / abstract-by .initial:n = {largerr} ,

style / abstract-authors .prop_gput:N = \g_desert_style_prop ,
style / abstract-authors .initial:n = {largerr} ,

style / abstract-title .prop_gput:N = \g_desert_style_prop ,
style / abstract-title .initial:n = {Large;bold} ,

style / caption-body .prop_gput:N = \g_desert_style_prop ,
style / caption-body .initial:n = {small;sans} ,

style / caption-label .prop_gput:N = \g_desert_style_prop ,
style / caption-label .initial:n = {small;sans;bold} ,

style / subcaption-body .prop_gput:N = \g_desert_style_prop ,
style / subcaption-body .initial:n = {small;sans} ,

style / subcaption-label .prop_gput:N = \g_desert_style_prop ,
style / subcaption-label .initial:n = {small;sans;bold} ,

style / subref .prop_gput:N = \g_desert_style_prop ,
style / subref .initial:n = {bold} ,

style / table-head-body .prop_gput:N = \g_desert_style_prop ,
style / table-head-body .initial:n = {small;sffamily;bfseries} ,

style / table-head-label .prop_gput:N = \g_desert_style_prop ,
style / table-head-label .initial:n = {small;sffamily;bfseries} ,

style / table-footer .prop_gput:N = \g_desert_style_prop ,
style / table-footer .initial:n = {small;sffamily} ,

style / box-label .prop_gput:N = \g_desert_style_prop ,
style / box-label .initial:n = {large, bold, allcaps} ,

style / box-name .prop_gput:N = \g_desert_style_prop ,
style / box-name .initial:n = {large, bold} ,

style / chapter-label .prop_gput:N = \g_desert_style_prop ,
style / chapter-label .initial:n = {Huge,606060,smallcaps} ,

style / chapter-name .prop_gput:N = \g_desert_style_prop ,
style / chapter-name .initial:n = {huge} ,

style / front-chapter-title .prop_gput:N = \g_desert_style_prop ,
style / front-chapter-title .initial:n = {huge;smallcaps} ,

style / chemical-diagram .prop_gput:N = \g_desert_style_prop ,
style / chemical-diagram .initial:n = {sans;small} ,

style / footnote-body .prop_gput:N = \g_desert_style_prop ,
style / footnote-body .initial:n = {footnotesize,sffamily} ,

style / foreign-words .prop_gput:N = \g_desert_style_prop ,
style / foreign-words .initial:n = {italic} ,

style / indx-starred .prop_gput:N = \g_desert_style_prop ,
style / indx-starred .initial:n = {italic} ,

style / nomenclature-group .prop_gput:N = \g_desert_style_prop ,
style / nomenclature-group .initial:n = {bold;large} ,

style / section-title .prop_gput:N = \g_desert_style_prop ,
style / section-title .initial:n = {LARGE;bold} ,

style / source-code .prop_gput:N = \g_desert_style_prop ,
style / source-code .initial:n = {small} ,

style / subsection-title .prop_gput:N = \g_desert_style_prop ,
style / subsection-title .initial:n = {Large;bold} ,

style / subsubsection-title .prop_gput:N = \g_desert_style_prop ,
style / subsubsection-title .initial:n = {large;bold} ,

style / paragraph-title .prop_gput:N = \g_desert_style_prop ,
style / paragraph-title .initial:n = {bold} ,

style / chapter-toc-label .prop_gput:N = \g_desert_style_prop ,
style / chapter-toc-label .initial:n = {large,bold} ,

toc / depth .choices:nn =
    { none,chapter,section,subsection,subsubsection }
    { \tl_gset_eq:NN \g_desert_toc_depth_str \l_keys_choice_tl } ,
toc / depth .initial:n = subsection ,

toc / references .bool_gset:N = \g_desert_toc_bib_bool ,
toc / references .initial:n = false ,

toc / index .bool_gset:N = \g_desert_toc_index_bool ,
toc / index .initial:n = false ,

toc / endnotes .bool_gset:N = \g_desert_toc_endnotes_bool ,
toc / endnotes .initial:n = false ,

toc / figure-panels .bool_gset:N = \g_desert_toc_panels_bool ,
toc / figure-panels .initial:n = false ,

typo / allow-hyphens .bool_gset:N = \g_desert_typo_allow_hyphens_bool ,
typo / allow-hyphens .initial:n = false ,

typo / caption-label-sep .tl_gset:N = \g_desert_typo_caption_label_sep_tl ,
typo / caption-label-sep .initial:n = {\quad} ,

typo / subref-format .tl_gset:N = \g_desert_typo_subref_format_tl ,
typo / subref-format .initial:n = {parens} ,

typo / caption-table-note-sep .tl_gset:N = \g_desert_typo_table_note_sep_tl ,
typo / caption-table-note-sep .initial:n = {\enspace} ,

typo / caption-table-remark-sep .tl_gset:N = \g_desert_typo_table_remark_sep_tl ,
typo / caption-table-remark-sep .initial:n = {\enspace} ,

glue / indent .skip_gset:N = \g_desert_indent_dim ,
glue / indent .initial:n = 0pt ,

glue-left / toc-chapter .dim_gset:N = \g_desert_toc_chapter_dim ,
glue-left / toc-chapter .initial:n = 3pc ,

glue-left / toc-section .dim_gset:N = \g_desert_toc_section_dim ,
glue-left / toc-section .initial:n = 3pc ,

glue-left / toc-subsection .dim_gset:N = \g_desert_toc_subsection_dim ,
glue-left / toc-subsection .initial:n = 3pc ,

glue-left / toc-subsubsection .dim_gset:N = \g_desert_toc_subsubsection_dim ,
glue-left / toc-subsubsection .initial:n = 3pc ,

glue-left / theorem-title .skip_gset:N = \g_desert_glue_after_theorem_title_skip ,
glue-left / theorem-title .initial:n = 0.8em plus 0.02em minus 0.01em ,

glue-left / definition-title .skip_gset:N = \g_desert_glue_after_definition_title_skip ,
glue-left / definition-title .initial:n = 0.8em plus 0.02em minus 0.01em ,

glue-left / remark-title .skip_gset:N = \g_desert_glue_after_remark_title_skip ,
glue-left / remark-title .initial:n = 0.8em plus 0.02em minus 0.01em ,

glue-between / paragraphs .skip_gset:N = \g_desert_between_paragraphs_skip ,
glue-between / paragraphs .initial:n = 2ex plus 0.2ex minus 0.2ex ,

glue-between / items .skip_gset:N = \g_desert_between_items_skip ,
glue-between / items .initial:n = -0.8ex plus 0.1ex minus 0.1ex,  % TODO

glue-between / multipar-items .skip_gset:N = \g_desert_between_multipar_items_skip ,
glue-between / multipar-items .initial:n = 1ex plus 0.1ex minus 0.025ex ,

glue-between / footnotes .skip_gset:N = \g_desert_between_footnotes_skip ,
glue-between / footnotes .initial:n = 0.4ex plus 0.05ex minus 0.0125ex ,

glue-between / refs .skip_gset:N = \g_desert_between_refs_skip ,
glue-between / refs .initial:n = 0.5ex plus 0.05ex minus 0.0125ex ,

glue-above / footnote-list .skip_gset:N = \g_desert_above_footnotes_skip ,
glue-above / footnote-list .initial:n = 4pc plus 4pc ,
glue-below / footnote-list .skip_gset:N = \g_desert_below_footnotes_skip ,
glue-below / footnote-list .initial:n = 4pc plus 12pc,  % only used when floats are below

glue-above / caption .skip_gset:N = \g_desert_above_caption_skip ,
glue-above / caption .initial:n = 1ex plus 0.5ex minus 0.125ex ,

glue-above / subcaption .skip_gset:N = \g_desert_above_subcaption_skip ,
glue-above / subcaption .initial:n = 0.6ex plus 0.1ex minus 0.025ex ,

glue-above / table-title .skip_gset:N = \g_desert_above_table_title_skip ,
glue-above / table-title .initial:n = 2ex plus 4ex minus 0.25ex ,
glue-below / table-title .skip_gset:N = \g_desert_below_table_title_skip ,
glue-below / table-title .initial:n = 2ex plus 1ex minus 0.25ex ,

glue-above / table-footer .skip_gset:N = \g_desert_above_table_footer_skip ,
glue-above / table-footer .initial:n = 1ex plus 0.5ex minus 0.125ex ,
glue-below / table-footer .skip_gset:N = \g_desert_below_table_footer_skip ,
glue-below / table-footer .initial:n = 2ex plus 4ex minus 0.25ex ,

glue-above / front-chapter .skip_gset:N = \g_desert_above_front_chapter_skip ,
glue-above / front-chapter .initial:n = -1ex ,  % TODO: why?
glue-below / front-chapter .skip_gset:N = \g_desert_below_front_chapter_skip ,
glue-below / front-chapter .initial:n = 4ex plus 0.4ex minus 0.1ex ,

glue-above / chapter .skip_gset:N = \g_desert_above_chapter_skip ,
glue-above / chapter .initial:n = 0pc ,
glue-below / chapter .skip_gset:N = \g_desert_below_chapter_skip ,
glue-below / chapter .initial:n = 6ex plus 1.5ex minus 0.375ex ,

glue-below / chapter-label .skip_gset:N = \g_desert_below_chapter_label_skip ,
glue-below / chapter-label .initial:n = 2ex plus 0.2ex minus 0.05ex ,

glue-above / section .skip_gset:N = \g_desert_above_section_skip ,
glue-above / section .initial:n = 8ex plus 2ex minus 0.5ex ,
glue-below / section .skip_gset:N = \g_desert_below_section_skip ,
glue-below / section .initial:n = 4ex plus 1ex minus 0.25ex ,

glue-above / subsection .skip_gset:N = \g_desert_above_subsection_skip ,
glue-above / subsection .initial:n = 6ex plus 3ex minus 0.75ex ,
glue-below / subsection .skip_gset:N = \g_desert_below_subsection_skip ,
glue-below / subsection .initial:n = 3ex plus 0.75ex minus 0.375ex ,

glue-above / subsubsection .skip_gset:N = \g_desert_above_subsubsection_skip ,
glue-below / subsubsection .initial:n = 2ex plus 0.2ex minus 0.2ex ,
glue-below / subsubsection .skip_gset:N = \g_desert_below_subsubsection_skip ,
glue-below / subsubsection .initial:n = 2ex plus 0.2ex minus 0.2ex ,

glue-above / paragraph .skip_gset:N = \g_desert_above_paragraph_skip ,
glue-above / paragraph .initial:n = 2ex plus 0.2ex minus 0.2ex ,

glue-above / theorem-like .skip_gset:N = \g_desert_above_theorem_skip ,
glue-above / theorem-like .initial:n = 3ex plus 0.375ex minus 0.1875ex ,
glue-below / theorem-like .skip_gset:N = \g_desert_below_theorem_skip ,
glue-below / theorem-like .initial:n = 3ex plus 0.375ex minus 0.1875ex ,

glue-above / algorithm-like .skip_gset:N = \g_desert_above_algorithm_skip ,
glue-above / algorithm-like .initial:n = 3ex plus 0.375ex minus 0.1875ex ,
glue-below / algorithm-like .skip_gset:N = \g_desert_below_algorithm_skip ,
glue-below / algorithm-like .initial:n = 3ex plus 0.375ex minus 0.1875ex ,

glue-above / definition-like .skip_gset:N = \g_desert_above_definition_skip ,
glue-above / definition-like .initial:n = 3ex plus 0.375ex minus 0.1875ex ,
glue-below / definition-like .skip_gset:N = \g_desert_below_definition_skip ,
glue-below / definition-like .initial:n = 3ex plus 0.375ex minus 0.1875ex ,

glue-above / remark-like .skip_gset:N = \g_desert_above_remark_skip ,
glue-above / remark-like .initial:n = 2ex plus 0.5ex minus 0.125ex ,
glue-below / remark-like .skip_gset:N = \g_desert_below_remark_skip ,
glue-below / remark-like .initial:n = 2ex plus 0.5ex minus 0.125ex ,

glue-above / equation .skip_gset:N = \g_desert_above_equation_skip ,
glue-above / equation .initial:n = 2ex plus 0.5ex minus 0.125ex ,
glue-below / equation .skip_gset:N = \g_desert_below_equation_skip ,
glue-below / equation .initial:n = 2ex plus 0.5ex minus 0.125ex ,

glue-above / list .skip_gset:N = \g_desert_above_list_skip ,
glue-above / list .initial:n = 1ex plus 0.2ex minus 0.05ex ,

glue-above / multipar-list .skip_gset:N = \g_desert_above_multipar_list_skip ,
glue-above / multipar-list .initial:n = 1ex plus 0.2ex minus 0.05ex ,

glue-below / abstract-title .skip_gset:N = \g_desert_below_abstract_title_skip ,
glue-below / abstract-title .initial:n = 2.5ex ,

glue-above / abstract-authors .skip_gset:N = \g_desert_above_abstract_author_skip ,
glue-above / abstract-authors .initial:n = 2.5ex ,

glue-above / abstract-body .skip_gset:N = \g_desert_above_abstract_body_skip ,
glue-above / abstract-body .initial:n = 7.5ex ,

glue-above / toc-chapter .skip_gset:N = \g_desert_above_toc_chapter_skip ,
glue-above / toc-chapter .initial:n = 1.8pc plus 0.16pc minus 0.04pc ,

glue-above / toc-section .skip_gset:N = \g_desert_above_toc_section_skip ,
glue-above / toc-section .initial:n = 0pc ,

glue-above / toc-subsection .skip_gset:N = \g_desert_above_toc_subsection_skip ,
glue-above / toc-subsection .initial:n = 0pc ,

glue-above / toc-subsubsection .skip_gset:N = \g_desert_above_toc_subsubsection_skip ,
glue-above / toc-subsubsection .initial:n = 0pc ,
}

\ProcessKeysOptions{desert}  % Process!




%========================================================================================
%                    hooks for fancy users
%========================================================================================

\ProvideDocumentCommand \BetweenChapters {}  % this one matters for articles
    { \clearpage }

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
%                    base presets
%========================================================================================

\cs_new_protected:Nn \desert_disable_number_within:
{
    \str_gset:Nn \g_desert_float_within_str {none}
    \str_gset:Nn \g_desert_equation_within_str {none}
    \str_gset:Nn \g_desert_theorem_within_str {none}
}

\cs_new_protected:Nn \desert_double_space:
{
    \tl_gset:Nn \g_desert_leading_main_fp {2.0}
    \tl_gset:Nn \g_desert_leading_toc_fp {2.0}
    \tl_gset:Nn \g_desert_leading_list_of_fp {2.0}
    \tl_gset:Nn \g_desert_leading_abbrevs_fp {2.0}
    \tl_gset:Nn \g_desert_leading_nomenclature_fp {2.0}
    \tl_gset:Nn \g_desert_leading_caption_fp {1.2}
    \tl_gset:Nn \g_desert_between_footnotes_skip {\baselineskip}
}


\tl_const:Nn \desert_afour_geometry_tl
{
    a4paper ,
    top=2cm ,
    bottom=2cm ,
    left=3cm ,
    right=3cm ,
    footskip=1cm ,
}

\tl_const:Nn \desert_letter_geometry_tl
{
    letterpaper ,
    top=1in ,
    bottom=1in ,
    left=1.5in ,
    right=1.5in ,
    footskip=0.5in ,
}

\NewDocumentCommand \GenericAFourPreset {}
{
    \tl_gset:NV \g_desert_geometry_tl \desert_afour_geometry_tl
}

\NewDocumentCommand \GenericAFourArticlePreset {}
{
    \tl_gset:Nv \g_desert_geometry_tl {\desert_afour_geometry_tl,twocolumn}
    \desert_disable_number_within:
    \str_gset:Nn \g_desert_numbering_front_str {arabic}
}

\NewDocumentCommand \GenericLetterPreset {}
{
    \tl_gset:Nv \g_desert_geometry_tl {\desert_letter_geometry_tl}
}

\NewDocumentCommand \GenericLetterArticlePreset {}
{
    \tl_gset:Nv \g_desert_geometry_tl {\desert_letter_geometry_tl,twocolumn}
    \desert_disable_number_within:
    \str_gset:Nn \g_desert_numbering_front_str {arabic}
}



%========================================================================================
%                    overly specific presets
%========================================================================================

% These may eventually be removed

\NewDocumentCommand \UcsfPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper,  margin=1in, footskip=0.5in }
    \bool_gset_true:N \g_desert_hide_title_footer_bool
    \bool_gset_false:N \g_desert_hide_copyright_footer_bool
    \desert_double_space:
}

\NewDocumentCommand \CmuPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper, margin=1in, footskip=0.25in }
    \str_gset:Nn \g_desert_footnote_placement_str {bottomfloats}
    \str_gset:Nn \g_desert_numbering_footnotes_str {arabic}
    \desert_disable_number_within:
    \bool_gset_true:N \g_desert_hide_title_footer_bool
    \bool_gset_true:N \g_desert_hide_copyright_footer_bool
    \desert_double_space:
}

\NewDocumentCommand \StanfordPreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { letterpaper, twoside, top=1in, bottom=1in, outer=1.5in, inner=1in, footskip=0.5in }
    \bool_gset_true:N \g_desert_hide_title_footer_bool
    \bool_gset_false:N \g_desert_hide_copyright_footer_bool
    \bool_gset:Nn \g_desert_leading_main_fp {1.5}
}

\NewDocumentCommand \CambridgePreset {}
{
    \tl_gset:Nn \g_desert_geometry_tl
        { a4paper, top=2cm, bottom=2cm, inner=3cm, outer=2cm, footskip=1cm }
    \str_gset:Nn \g_desert_numbering_front_str {arabic}
}

\cs_if_exist_use:cF { \g_desert_preset_str }
    { \__desert_warn_nosuchpreset:V \g_desert_preset_str }




%========================================================================================
%                    force some options
%========================================================================================

% Pass along options:
\clist_new:N \g_desert_all_lang_clist
\clist_gset:Nn \g_desert_all_lang_clist
    { \g_desert_extra_languages_str,\g_desert_lang_str }
\PassOptionsToPackage {\g_desert_all_lang_clist} {babel}

% disables shorthands in references and bib; strongly recommended
\PassOptionsToPackage{safe=none}{babel}  
\bool_if:NT \g_desert_bidi_bool
    { \PassOptionsToPackage {bidi=basic} {babel} }  % basic is strongly preferred
%\desert_if_feat_enabled:nT {varioref}  % TODO
%    { \PassOptionsToPackage {\g_desert_lang_str} {varioref} }
\PassOptionsToPackage {useregional} {datetime2}

\PassOptionsToPackage{babel=true}{microtype}
\bool_if:NT \g_desert_draft_bool
    { \PassOptionsToPackage {draft=true} {microtype} }
    
\PassOptionsToPackage {list} {subcaption}
\bool_if:NT \g_desert_toc_panels_bool
    { \PassOptionsToPackage{list}{subcaption} }
    
\bool_if:NF \g_desert_cref_abbreviate_bool
    { \PassOptionsToPackage{noabbrev}{cleveref} }
\bool_if:NT \g_desert_cref_capitalize_bool
    { \PassOptionsToPackage{capitalize}{cleveref} }
    
\desert_if_feat_enabled:nT {ulem}
    { \PassOptionsToPackage{markup}{txtstyles} }
    
\str_if_eq:VnF \g_desert_footnote_placement_str {default}  % for compatibility
    { \PassOptionsToPackage{\g_desert_footnote_placement_str}{footmisc} }




%========================================================================================
%                    load packages
%========================================================================================

% early and order-dependent:
%\RequirePackage{xpatch}                     % needed to patch commands
\RequirePackage{mathcommand}                 % prime, subscript, preserving commands

% language:
\RequirePackage{tracklang}                   % before packages that use it
\RequirePackage{babel}                       % Main multilingual support
\RequirePackage{translations}                % \gettranslation; after: Babel

% layout control:
\RequirePackage{fancyvrb}                    % _verbatim_ , etc.
\RequirePackage[newcommands]{ragged2e}       % full ragged environments; before: footmisc
\RequirePackage{newfloat}                    % declare new float environments
\RequirePackage{geometry}                    % \geometry
\RequirePackage{adjustbox}                   % resize boxes
\RequirePackage{perpage}                     % reset a counter every page
\RequirePackage{datetime2}                   % format dates and times (after: babel)

% xindy and hyperref
\desert_load_feat:nn{xindy}{imakeidx}        % index; before: knowledge
\RequirePackage{hyperxmp}
\RequirePackage{hyperref}                    % AFTER xindy

% font control and math
% loads amsmath, unicode-math, fontspec, microtype, and fontsize:
\RequirePackage[faces]{txtstyles}
\RequirePackage{info}                        % requires txtstyles
\RequirePackage{amsthm}                      % theorem-like environments
\RequirePackage{thmtools}                    % \declaretheorem
\RequirePackage{bm}                          % bold math
\RequirePackage{mathtools}                   % better theorem-like environments
\RequirePackage{lualatex-math}               % math-related patches

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
\RequirePackage{fancyhdr}                    % footer and header
\RequirePackage{enumitem}                    % control spacing for lists
\RequirePackage{footmisc}                    % footnote styling and counters
\RequirePackage{enotez}                      % fixed endnotes

% graphics
\RequirePackage[hypcap]{caption}             % needed for formatting; use hypcap option
\RequirePackage[hypcap]{subcaption}          % successor to subfig; use hypcap option
\RequirePackage{graphicx}                    % for, well, everything

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
\desert_load_feat:n{cryptocode}
\desert_load_feat:n{chemmacros}
\desert_load_feat:n{chemformula}
\desert_load_feat:n{chemfig}
\desert_load_feat:n{svg}  % \includesvg




%========================================================================================
%            misc language things ++ Babel, Cleveref, varioref, & knowledge
%========================================================================================

\NewExpandableDocumentCommand \MainLangBabelName {}
    { \g_desert_lang_str }

% TODO: need newest Babel to get bcp
%\txtstyles_set_case_lang:V \g_desert_bcp_str
%\AddBabelHook {casing} {patterns}
%    { \txtstyles_set_case_lang:V \languagename }

\str_new:N \g_desert_base_lang_str
\str_gset:Nx \g_desert_base_lang_str
    { \baselanguage{\g_desert_lang_str} }

\clist_new:N \g_desert_base_lang_clist
\clist_gset:Nx \g_desert_base_lang_clist
    { \clist_map_function:NN \g_desert_all_lang_clist \baselanguage }

% should always be last:
\desert_load_feat:nn{nospace,\g_desert_base_lang_clist}{varioref}
\desert_load_feat:n{knowledge}

\RequirePackage[\g_desert_base_lang_clist]{cleveref}  % after: varioref




%========================================================================================
%                    cleveref strings
%========================================================================================

\cs_new_protected:Npn \__desert_addto:Vn #1#2
{
    \exp_args:Ncn \addto {captions#1} {#2}
    %\addto \captionsenglish {#2}
}

\cs_new_protected:Npn \__desert_set_cref_aux:nVV #1#2#3
{
    % set both \Crefname and \crefname
    % using language-aware casing (via #1)
    \__desert_addto:Vn \g_desert_lang_str
    {
    \exp_args:Nnee
        \Crefname
        {#1}
        { \txtstyles_sentencecasefirst:n{#2} }
        { \txtstyles_sentencecasefirst:n{#3} }
    \exp_args:Nnee
        \crefname
        {#1}
        { \txtstyles_lowercase:n{#2} }
        { \txtstyles_lowercase:n{#3} }
    }
}

\cs_new_protected:Npn \__desert_set_cref:nn #1#2
{
    \__desert_addto:Vn \g_desert_lang_str
    {
        \seq_set_split:Nnn \l_tmpa_seq {/} {#2}
        \seq_get_left:NN \l_tmpa_seq \l_tmpa_tl
        \seq_get_right:NN \l_tmpa_seq \l_tmpb_tl  % could be the same
        \__desert_set_cref_aux:nVV {#1} \l_tmpa_tl \l_tmpb_tl
    }
}

\NewDocumentCommand \SetCrefStrings { m }
{
    \prop_set_from_keyval:Nn \l_tmpa_prop {#1}
    \prop_map_inline:Nn \l_tmpa_prop
        { \__desert_set_cref:nn{##1}{##2} }
}




%========================================================================================
%                    Biblatex, Babel, and Desert strings
%========================================================================================

\prop_new:N \g_desert_strings_prop

\cs_new:Npn \desert_string:n #1
    { \prop_item:Nn \g_desert_strings_prop {#1} }


\NewDocumentCommand \SetBiblatexStrings { m }
{
    \DefineBibliographyStrings{\g_desert_lang_str}{#1}
}

% Babel's \bbl@captionslist is:
% preface, ref, abstract, bib, chapter, appendix ,
% contents, listfigure, listtable, index,
% figure, table, part, encl, cc, headto, page ,
% see, also, proof, glossary ,
\NewDocumentCommand \SetBabelStrings { m }
{
    \prop_set_from_keyval:Nn \l_tmpa_prop {#1}
    \prop_map_inline:Nn \l_tmpa_prop
        { \setlocalecaption{\g_desert_lang_str}{##1}{##2} }
    \prop_map_inline:Nn \l_tmpa_prop
        { \prop_gput:Nnn \g_desert_strings_prop {##1} {##2} }
}

\SetBabelStrings
{
    listabbreviation = List~of~abbreviations ,
    listnomenclature = Nomenclature  ,
    structuralformula = Structural~formula ,
    liststructuralformula = List~of~structural~formulas ,
    reactionscheme = Reaction ,
    listreactionscheme = List~of~reactions ,
}



%========================================================================================
%                    fixing skips
%========================================================================================

\skip_gsub:NV \g_desert_below_abstract_title_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_abstract_author_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_abstract_body_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_section_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_section_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_subsection_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_subsection_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_paragraph_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_front_chapter_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_chapter_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_theorem_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_theorem_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_algorithm_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_algorithm_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_definition_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_definition_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_remark_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_below_remark_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_list_skip \g_desert_between_paragraphs_skip
\skip_gsub:NV \g_desert_above_multipar_list_skip \g_desert_between_paragraphs_skip



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
\txtstyles_set_baselinestretch:V \g_desert_leading_main_fp

\setlength \parindent {\dim_use:N \g_desert_indent_dim}
\setlength \parskip {\skip_use:N \g_desert_between_paragraphs_skip}

\setlength {\abovedisplayskip} {\g_desert_above_equation_skip}
\setlength {\belowdisplayskip} {\g_desert_below_equation_skip}

\setdisplayskipstretch{1.0}

\clist_const:Nn \c_desert_eqn_envs_clist
    { equation, equation*, multiline, multiline*, align, align*, gather, gather* }

\clist_map_inline:Nn \c_desert_eqn_envs_clist
{
    \AtBeginEnvironment {#1}
        { \txtstyles_use_baselinestretch:V \g_desert_leading_equation_fp }
}

\bool_if:NF \g_desert_typo_allow_hyphens_bool
    { \txtstyles_disable_hyphens: }

\setlist
{
    itemsep = \g_desert_between_items_skip ,
    topsep = \g_desert_above_list_skip ,
    partopsep = 0ex ,
    parsep = \g_desert_between_paragraphs_skip ,
}

\SetEnumitemKey {multipar}
{
    itemsep = \g_desert_between_multipar_items_skip ,
    topsep = \g_desert_above_multipar_list_skip ,
    partopsep = 0ex ,
    parsep = \g_desert_between_paragraphs_skip ,
}




%========================================================================================
%                           section titles
%========================================================================================

\titleformat {name=\chapter} [block]
    { }   % code before
    {     % code for label
        \txtstyles_use:nn{chapter-label}{\chaptertitlename\ \thechapter}
        \skip_vertical:N \g_desert_below_chapter_label_skip
    }  %(TODO: \g_desert_below_chapter_label_skip doesn't work below?
    { 0pt }  % space between label and name
    { \txtstyles_use:nn{chapter-name}{#1} }  % code for name

\titleformat {name=\chapter,numberless} [display]
    { \filcenter }
    { }
    { 0pt }
    { \txtstyles_use:nn{front-chapter-title}{#1} }

\titleformat {\section} [hang]
    { }
    { \txtstyles_use:nn{section-title}{\thetitle} }
    { 1em }
    { \txtstyles_use:nn{section-title}{#1} }


\titleformat {\subsection} [hang]
    { }
    { \StyleTxt{subsection-title}{\thetitle} }
    { 1em }
    { \StyleTxt{subsection-title}{#1} }

\titleformat {\subsubsection} [hang]
    { }
    { \StyleTxt{subsubsection-title}{\thetitle} }
    { 1em }
    { \StyleTxt{subsubsection-title}{#1} }

\titleformat {\paragraph} [runin]
    { }
    { \StyleTxt{paragraph-title}{\thetitle} }
    { 1em }
    { \StyleTxt{paragraph-title}{#1.} }

\titleformat {\subparagraph} [runin]
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
    {                                                                       % code for label if numbered
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
            {\g_desert_toc_subsection_dim}
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

\cs_new_protected:Npn \__desert_set_fancy_page:VVVVVV #1#2#3#4#5#6
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

\__desert_set_fancy_page:VVVVVV
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

\txtstyles_set_depth:nV {secnumdepth} \g_desert_numbering_depth_str
\txtstyles_set_depth:nV {tocdepth} \g_desert_toc_depth_str

\cs_new_protected:Npn \__desert_number_within:nV #1#2
    { \numberwithin {#1} {#2} }

% provided by amsmath -- but works on all numbered environments
\str_if_eq:VnF \g_desert_float_within_str {none}
{
    \__desert_number_within:nV {figure} \g_desert_float_within_str
    \__desert_number_within:nV {table} \g_desert_float_within_str
}
\str_if_eq:VnF \g_desert_equation_within_str {none}
{
    \__desert_number_within:nV {equation} \g_desert_equation_within_str
}



%========================================================================================
%                       footnote numbering and format
%========================================================================================

\str_if_eq:VnT \g_desert_footnote_within_str {page}
    { \MakePerPage[2]{footnote} }  % otherwise we'll set in \Chapter


\seq_const_from_clist:Nn \c__desert_numeric_foonotes_clist
    { arabic, alph, Alph, roman, Roman }
    
\seq_if_in:NVTF \c__desert_numeric_foonotes_clist \g_desert_numbering_footnotes_str
    { \declarecommand \multfootsep {,} }           % e.g. 12,13
    { \declarecommand \multfootsep {\thinspace} }  % because some symbols are doubled


\seq_const_from_clist:Nn \g__desert_footsymbols_seq
    {lamport,lamport*,bringhurst,chicago,wiley }  % i.e. not arabic,roman,Roman,alph,Alph

\cs_new_protected:Npn \__desert_footnote_num:N #1
{
    \renewcommand \thefootnote {#1{footnote}}
    \renewcommand \thempfootnote {#1{mpfootnote}}
}

\seq_if_in:NVTF \g__desert_footsymbols_seq \g_desert_numbering_footnotes_str
{
    % if it's a symbol style, we change symbols, then use \fnsymbol
    \setfnsymbol{\g_desert_numbering_footnotes_str}
    \__desert_footnote_num:N \fnsymbol
}
{
    \exp_args:Nc
        \__desert_footnote_num:N
        \g_desert_numbering_footnotes_str
}

\setlength {\skip\footins} {\g_desert_above_footnotes_skip}

\setlength \footnotesep {\g_desert_between_footnotes_skip}

% apply the footnote body format
\renewcommand* \footnotelayout
    { \txtstyles_run_nullary:n{footnote-body} }




%========================================================================================
%                 endnotes
%========================================================================================

\setenotez{reset=true}
\AtEndPreamble
    { \setenotez {list-name=\desert_string:n{listendnote}} }

\bool_if:NT \g_desert_endnote_backrefs_bool  % needs 2022+ !
    { \setenotez{backref=true} }

\bool_if:NT \g_desert_toc_endnotes_bool
    { \setenotez{totoc=section*} }

% We'll use these in \StartMainMatter if forcing endnotes
% written as commands for the user's convenience

\NewDocumentCommand \FootnotesAsEndnotes {}
{
    \let \truefootnote \footnote
    \let \truefootnotemark \footnotemark
    \let \truefootnotetext \footnotetext
    \let \footnote \endnote
    \let \footnotemark \endnotemark
    \let \footnotetext \endnotetext
}

\NewDocumentCommand \FootnotesAsFootnotes {}
{
    \cs_if_exist:NT \truefootnote
    {
        \let \footnote \truefootnote
        \let \footnotemark \truefootnotemark
        \let \endnotetext \truefootnotetext
    }
}



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
    \usetagform \g_desert_numbering_brackets_str




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

\ProvideDocumentCommand \reftitle {m}
    { ``\citefield{#1}{title}" }
    
\ProvideDocumentCommand \refdoi {m}
    { \doi{\citefield{#1}{doi}} }
    
\ProvideDocumentCommand \refurl {m}
    { \citefield{\link{#1}{url}} }





%========================================================================================
%                     sections with labels
%========================================================================================

\keys_define:nn { desert / section-like }
{
    title .tl_set:N = \l__title_tl ,
    title .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {*} ,
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {*} ,
    numberless .bool_set:N = \l__numberless_bool ,
    numberless .default:n = true ,
    numberless .initial:n = false ,
}

\cs_new:Npn \__desert_run_star:NV #1#2
    { #1*{#2} }

\cs_new:Npn \__desert_run_starless:NV #1#2
    { #1{#2} }

\cs_new_protected:Npn \__desert_run_section_like:NN #1#2
{
    \tl_set:Nx \l__level_tl {\cs_to_str:N #1}
    \tl_if_blank:VTF \l__title_tl
    {   % Method A: PHANTOM \section
        #2 \phantomsection
        \bool_if:NF \l__numberless_bool
            { \addtocounter{\l__level_tl} }
        \tl_if_blank:VF \l__entry_tl
            { \addcontentsline{toc}{\l__level_tl}{\l__entry_tl} }
    }
    {   % or Method B: REAL \section
        \bool_if:NTF \l__numberless_bool
            {
                \__desert_run_star:NV #1 \l__title_tl
                \tl_if_blank:VF \l__entry_tl
                    { \addcontentsline{toc}{\l__level_tl}{\l__entry_tl} }
            }
            { \__desert_run_starless:NV #1 \l__title_tl }
    }
    
    \tl_if_blank:VF \l__label_tl
        { \label{\l__label_tl} }
}

\cs_new_protected:Npn \__desert_set_section_like:nnnn #1#2#3#4
{
    \keys_set:nn {desert / section-like} {#3}
    \bool_if:NF \l__numberless_bool
        { \bool_set:Nn \l__numberless_bool {#2} }
    % Process displayed title
    \tl_if_blank:VT \l__title_tl
        { \tl_set:Nn \l__title_tl {#4} }
    % Process entry
    \tl_if_eq:NnT \l__entry_tl {*}
        { \tl_set_eq:NN \l__entry_tl \l__title_tl }
}

\cs_new_protected:Npn \__desert_section_like:nnnnNN #1#2#3#4#5#6
{
    \group_begin:
    \__desert_set_section_like:nnnn{#1}{#2}{#3}{#4}
    \__desert_run_section_like:NN #5#6
    \group_end:
}

\NewDocumentCommand \Chapter { s O{} G{} }
{
    \str_if_eq:VnT \g_desert_footnote_within_str {chapter}
        { \setcounter{footnote}{0} }
    \__desert_section_like:nnnnNN
        {chapter}{#1}{#2}{#3}
        \chapter\BetweenChapters
}

\NewDocumentCommand \Section { s O{} G{} }
{
    \__desert_section_like:nnnnNN
        {section}{#1}{#2}{#3}
        \section\prg_do_nothing:
}

\NewDocumentCommand \SubSection { s O{} G{} }
{
    \__desert_section_like:nnnnNN
        {subsection}{#1}{#2}{#3}
        \subsection\prg_do_nothing:
}
    
\NewDocumentCommand \SubSubSection { s O{} G{} }
{
    \__desert_section_like:nnnnNN
        {subsubsection}{#1}{#2}{#3}
        \subsubsection\prg_do_nothing:
}
    
\NewDocumentCommand \Paragraph { s O{} G{} }
{
    \__desert_section_like:nnnnNN
        {paragraph}{#1}{#2}{#3}
        \paragraph\prg_do_nothing:
}

\NewDocumentCommand \SubPParagraph { s O{} G{} }
{
    \__desert_section_like:nnnnNN
        {subparagraph}{#1}{#2}{#3}
        \subparagraph\prg_do_nothing:
}





%========================================================================================
%                        front matter
%========================================================================================

\keys_define:nn { desert / special-box }
{
    width .dim_set:N = \l__width_dim ,
    width .initial:n = {\textwidth} ,
    above .dim_set:N = \l__above_dim ,
    above .initial:n = 0pc ,
    below .dim_set:N = \l__below_dim ,
    below .initial:n = 0pc ,
    flush .bool_set:N = \l__flush_bool,
    flush .default:n = true ,
    flush .initial:n = false ,
    at .choice: ,
    at / top .code:n =
        { \dim_set:Nn\l__above_dim{0pc} \dim_set_eq:Nn\l__below_dim{\fill} } ,
    at / bottom .code:n =
        { \dim_set:Nn\l__below_dim{0pc} \dim_set:Nn\l__above_dim{\fill} } ,
    at / middle .code:n =
        { \dim_set:Nn\l__below_dim{0.5\fill} \dim_set_eq:Nn\l__above_dim{0.5\fill} } ,
}

\NewDocumentEnvironment {InternalSpecialBox} { }
{
    \dim_compare:nNnT {\l__width_dim} < {0.99\textwidth}
        { \hbadness=10000 }
    \vspace*{\l__above_dim}
    \bool_if:NF \l__flush_bool { \begin{center} }
    \begin{minipage}{\l__width_dim}
    \bool_if:NF \l__flush_bool { \centering }
}
{
    \end{minipage}
    \bool_if:NF \l__flush_bool { \end{center} }
    \vspace*{\l__below_dim}
}

\NewDocumentEnvironment {SpecialBox} { O{} }
{
    \keys_set:nn {desert / special-box} {#1}
    \begin{InternalSpecialBox}
}
{ \end{InternalSpecialBox} }


\NewDocumentEnvironment {FrontChapter} { O{} G{} }
{
    \PreFrontChapterHook
    \Chapter*[#1]{#2}
}
{ \acresetall }

\keys_define:nn { desert / special-chapter }
{
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {} ,
    title .tl_set:N = \l__title_tl ,
    title .initial:n = {} ,
    flush .bool_set:N = \l__flush_bool,
    flush .default:n = true,
    flush .initial:n = false,
    width .dim_set:N = \l__width_dim ,
    width .initial:n = {\textwidth} ,
    above .dim_set:N = \l__above_dim ,
    above .initial:n = 0pc ,
    below .dim_set:N = \l__below_dim ,
    below .initial:n = 0pc ,
    at .choice: ,
    at / top .code:n =
        { \dim_set:Nn\l__above_dim{0pc} \dim_set_eq:Nn\l__below_dim{\fill} } ,
    at / bottom .code:n =
        { \dim_set:Nn\l__below_dim{0pc} \dim_set:Nn\l__above_dim{\fill} } ,
    at / middle .code:n =
        { \dim_set:Nn\l__below_dim{0.5\fill} \dim_set_eq:Nn\l__above_dim{0.5\fill} } ,
}

\NewDocumentEnvironment {InternalSpecialChapter} { O{} G{} }
{
    \keys_set:nn {desert / special-chapter} {#1}
    \bool_set_true:N \l__numberless_bool  % force true
    \str_if_eq:VnT \g_desert_footnote_within_str {chapter}
        { \setcounter{footnote}{0} }
    \tl_if_blank:VT \l__title_tl
        { \tl_set:Nn \l__title_tl {#2} }
    \__desert_run_section_like:NN\chapter\BetweenChapters
    \begin{InternalSpecialBox}
}
{
    \end{InternalSpecialBox}
}

% Super-special chapters, normally centered
\NewDocumentEnvironment {SpecialChapter} { O{} G{} }
{
    \PreSpecialChapterHook
    \begin{InternalSpecialChapter}[#1]{#2}
}
{ \end{InternalSpecialChapter} \acresetall }

\NewDocumentEnvironment {FrontCopyright} { O{} }
{
    \PreFrontCopyrightHook
    \begin{InternalSpecialChapter}[#1]{}  % don't add a title
}
{ \end{InternalSpecialChapter} \acresetall }

% Abstract
\NewDocumentEnvironment {FrontAbstract} { O{} }
{
    \PreFrontAbstractHook
    \Chapter*[#1]{}  % if they want a title, they can pass title=
    \begin{center}
    \GetTitle[style=abstract-title]
    \skip_vertical:N \g_desert_below_abstract_title_skip
    \StyleTxt{abstract-by}{by}
    \skip_vertical:N \g_desert_above_abstract_author_skip
    \GetAuthors[style=abstract-authors]
    \skip_vertical:N \g_desert_above_abstract_body_skip
    \end{center}
}
{ \acresetall }

\NewDocumentEnvironment {FrontTitle} {}
{
    \PreFrontTitleHook
}
{
    \bool_if:NT \g_desert_hide_title_footer_bool
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
\NewDocumentCommand \ShowTitle { O{} }
{
    \begin{FrontTitle}
    \begin{SpecialBox}[#1]
    \rmfamily\largerr
    \TitleContents
    \end{SpecialBox}
    \end{FrontTitle}
}


\NewDocumentEnvironment {MainChapter} { O{} G{} }
{
    \PreMainChapterHook
    \bool_if:NT \g_desert_bib_per_chapter_bool { \begin{refsection} }
    \Chapter[#1]{#2}
}
{
    \ShowEndNotes
    \bool_if:NT \g_desert_bib_per_chapter_bool
        { \ShowSubBib \end{refsection} }
}




%========================================================================================
%                        back matter
%========================================================================================

\NewDocumentCommand \ShowBackBib {}
{
    \bool_if:NF \g_desert_bib_per_chapter_bool
        { \ShowFullBib }
}

\NewDocumentEnvironment {Appendix} { O{} G{} }
{
    \PreAppendixHook
    \begin{refsection}
    \Chapter[#1]{#2}
}
{
    \ShowSubBib
    \end{refsection}
}

\NewDocumentEnvironment {Appendices} {}
    {  }
    {  }

\NewDocumentCommand \ShowIndex {}
{
    \desert_if_feat_enabled:nT {imakeidx}
        {\printindex}
}




%========================================================================================
%                 theorem-like
%========================================================================================


% first, default style associations

\prop_const_from_keyval:Nn \c_desert_theorem_like_prop 
{
    Theorem=plain, Lemma=plain, Corollary=plain, Proposition=plain ,
    Conjecture=plain, Criterion=plain, Assertion=plain ,
    Definition=definition, Condition=definition ,
    Example=definition, Question=definition, Problem=definition, Exercise=definition ,
    Axiom=definition, Property=definition, Assumption=definition, Hypothesis=definition ,
    Algorithm=algorithm ,
    Protocol=algorithm, Procedure=algorithm, Game=algorithm, Reduction=algorithm ,
    Remark=remark, Note=remark, Notation=remark, Claim=remark, Summary=remark ,
    Acknowledgment=remark, Case=remark, Conclusion=remark ,
}

% define the styles suggested in the amsthm documentation
% • plain : italic text, extra space above and below;
% • definition : upright text, extra space above and below;
% • algorithm (NEW): same as definition;
% • remark : upright text, no extra space above or below.

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_theorem_skip ,
        spacebelow=\g_desert_below_theorem_skip ,
        postheadspace=\g_desert_glue_after_theorem_title_skip ,
        headfont={\bfseries} ,
        bodyfont={\itshape} ,
    ]
    { plain }

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_algorithm_skip ,
        spacebelow=\g_desert_below_algorithm_skip ,
        postheadspace=\g_desert_glue_after_algorithm_title_skip ,
        headfont={\bfseries} ,
        bodyfont={\upshape} ,
    ]
    { algorithm }

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_definition_skip ,
        spacebelow=\g_desert_below_definition_skip ,
        postheadspace=\g_desert_glue_after_definition_title_skip ,
        headfont={\bfseries} ,
        bodyfont={\upshape} ,
    ]
    { definition }

\declaretheoremstyle
    [
        spaceabove=\g_desert_above_remark_skip ,
        spacebelow=\g_desert_below_remark_skip ,
        postheadspace=\g_desert_glue_after_remark_title_skip ,
        headfont={\bfseries} ,
        bodyfont={\upshape} ,
    ]
    { remark }

\NewDocumentEnvironment{Proof} { o }
    { \begin{proof}[#1] }
    { \end{proof} }


\str_clear:N \l_tmpa_str
\str_if_eq:VnTF \g_desert_theorem_within_str {none}
    { \declaretheorem [style=plain] {theoremlike} }
    { \declaretheorem [style=plain,parent=\g_desert_theorem_within_str] {theoremlike} }

\keys_define:nn { desert / theorem-like-env }
{
    style .tl_set:N = \l__style_tl ,
    style .initial:n = {} ,
    unknown .code:n = {} ,  % OK
}

\NewDocumentCommand \NewTheoremEnvs { O{} m }
{
    \tl_set:Nn \l__style_tl {}
    \prop_set_from_keyval:Nn \l_tmpa_prop {#2}  % no \group_begin: to avoid weirdness in \declaretheorem
    \prop_map_inline:Nn \l_tmpa_prop
    {   % loop over env -> cref/cref-plural; guess style if not set from style= in [#1]
        \tl_set_eq:NN \l_tmpa_tl \l__style_tl
        \tl_if_blank:VT \l__style_tl
        {
            \prop_get:NnNF \c_desert_theorem_like_prop {##1} \l_tmpa_tl
                { \tl_set:Nn \l_tmpa_tl {plain} }
        }
        \declaretheorem [style=\l_tmpa_tl, sibling=theoremlike] {##1}
        \__desert_set_cref:nn{##1}{##2}
    }
    %
}



%========================================================================================
%                     lists of things
%========================================================================================

\cs_new_protected:Npn \__desert_fix_lof:n #1
{
    \renewcommand \listoffigures
    {   % listfigurename already gets set
        \bool_if:nTF {#1}
            { \chapter{\listfigurename} }
            { \chapter*{\listfigurename} }
        \@mkboth
            {\MakeUppercase\listfigurename}
            {\MakeUppercase\listfigurename}
        \@starttoc{lof}
    }
}

\NewDocumentEnvironment {TocLikeListInternal} { m }
{
    \__desert_fix_lof:n{#1}
    \setlength{\parskip}{0ex}  % makes things confusing
    \PreTocLikeListHook
} {}

\NewDocumentEnvironment {TocLikeList} { t! }
    { \begin{TocLikeListInternal}{#1} }
    { \end{TocLikeListInternal} }

% Output table of contents
\NewDocumentCommand \ShowTableOfContents { t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_toc_fp
    \tableofcontents
    \end{TocLikeListInternal}
}

% Output list of figures
\NewDocumentCommand \ShowListOfFigures { t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_list_of_fp
    \listoffigures
    \end{TocLikeListInternal}
}

% Output list of tables
\NewDocumentCommand \ShowListOfTables { t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_list_of_fp
    \listoftables
    \end{TocLikeListInternal}
}

% Output list of abbreviations (via 'acro' package)
\NewDocumentCommand \ShowListOfAbbrevs { t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_abbrevs_fp
    % template = description|tabular|longtable|supertabular|tabularray|lof|toc
    % acceptable choices are description, toc, lof, and tabularray
    % description is the default
    \tl_set:Nx \l_tmpa_tl { \desert_string:n{listabbreviation} }
    \tl_set:Nn \l_tmpb_tl
    {
        template = description ,  % the rest are all broken
        name = \l_tmpa_tl ,
        preamble = {\skip_vertical:N \g_desert_below_front_chapter_skip } ,
    }
    \bool_if:nTF {#1}
        { \exp_last_unbraced:Ne \printacronyms {[heading=chapter, \l_tmpb_tl]} }
        { \exp_last_unbraced:Ne \printacronyms {[heading=chapter*, \l_tmpb_tl]} }
    \end{TocLikeListInternal}
}

% Output nomenclature
\NewDocumentCommand \ShowNomenclature { t! }
{
    \begin{TocLikeListInternal}{#1}
    \renewcommand \nomname {\desert_string:n{listnomenclature}}
    \txtstyles_set_baselinestretch:V \g_desert_leading_nomenclature_fp
    \bool_if:nTF {#1}
        { \printnomenclature[heading=chapter] }
        { \printnomenclature[heading=chapter*] }
    \end{TocLikeListInternal}
}

\NewDocumentCommand \ShowListOfTheoremLike { t! m }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_list_of_fp
    \listoftheorems[ignoreall,#2]
    \end{TocLikeListInternal}
}

\NewDocumentCommand \ShowListOfSourceCode { t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_list_of_fp
    \listoflistings
    \end{TocLikeListInternal}
}

\NewDocumentCommand \ShowListOfReactionSchemes{ t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_list_of_fp
    \listofreactionschemes
    \end{TocLikeListInternal}
}

\NewDocumentCommand \ShowListOfStructuralFormulas{ t! }
{
    \begin{TocLikeListInternal}{#1}
    \txtstyles_set_baselinestretch:V \g_desert_leading_list_of_fp
    \listofstructuralformulas
    \end{TocLikeListInternal}
}




%========================================================================================
%                     abbreviations
%========================================================================================

\acsetup
{
    single-style = long,     % NOTE:
    make-links = false ,
    list/sort = true ,
    accsupp/use = true ,
    use-id-as-short = true ,
    index/use = indexed ,
    format/short = \txtuppertosc
}



\NewDocumentCommand \indx { s m O{} }
{
    \bool_if:nTF {#1}
        { \StyleTxt{indx-starred}{#2} }
        { #2 }
    \desert_if_feat_enabled:nT {imakeidx}
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
    \desert_if_feat_enabled:nT {imakeidx}
    {
        \tl_if_blank:nTF {#3} { \index{#2} } { \index{#3} }
    }
}




%========================================================================================
%                      caption and subcaption styling
%========================================================================================

\DeclareCaptionSubType [\g_desert_numbering_panels_tl] {figure}

\DeclareCaptionLabelSeparator {desert-sep} {\g_desert_typo_caption_label_sep_tl}

\txtstyles_declare_cap_style:nnn {desert-caption} {caption-body} {caption-label}
\txtstyles_declare_cap_style:nnn {desert-subcap} {subcaption-body} {subcaption-label}
\txtstyles_declare_cap_style:nnn {desert-table} {table-head-body} {table-head-label}  % legacy tables

% For all captions:
\captionsetup
{
    singlelinecheck = false,  % do what the user tells you
    format = desert-caption ,
    labelsep = desert-sep ,
}

\captionsetup [figure]
{
    skip = \g_desert_above_caption_skip ,
    subrefformat = \g_desert_typo_subref_format_tl,  % e.g. "parens"
}

\captionsetup [subfigure]
{
    format = desert-subcap ,
    skip = \g_desert_above_subcaption_skip
}

% Captions that go at the TOP of tables (legacy table environment)
\captionsetup [table]
{
    position = above ,
    format = desert-table ,
    justification = centering ,
    skip = 0ex ,  % TODO
}

% if no minted, make a fake listing so we can use it anyway
\desert_if_feat_enabled:nF {minted}
    { \DeclareFloatingEnvironment{listing} }

\captionsetup [listing]
{
    position = above ,  % special
    format = desert-table ,
    justification = centering ,
    skip = 0ex ,
}


\cs_new_protected:Npn \__desert_new_float_x:nVV #1#2#3
{
    \DeclareFloatingEnvironment
        [
            name = {#2} ,
            listname = {#3} ,
            within = \g_desert_float_within_str ,
        ]
        {#1}
}

\cs_new_protected:Npn \__desert_new_float:n #1
{
    \tl_set:Nx \l_tmpa_tl { \desert_string:n{#1} }
    \tl_set:Nx \l_tmpb_tl { \desert_string:n{list#1} }
    \__desert_new_float_x:nVV {#1} \l_tmpa_tl \l_tmpb_tl
    \captionsetup [#1]
    {
        position = below ,
        format = desert-table ,
        skip = \g_desert_below_table_title_skip ,
    }
}





%========================================================================================
%                      captioning commands
%========================================================================================


\keys_define:nn { desert / capkeyval }
{
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {} ,
    caption .tl_set:N = \l__caption_tl ,
    caption .initial:n = {}
}

\cs_new_protected:Nn \__desert_capkeyval:
{
    \tl_if_blank:VTF \l__entry_tl
        { \caption{\l__caption_tl} }
        { \caption[\l__entry_tl]{\l__caption_tl} }
    \tl_if_blank:VF \l__label_tl
        { \label{\l__label_tl} }
}

\NewDocumentCommand \captioning { O{} m }
{   % friendly version; directly swap with \caption
    \group_begin:
    \tl_if_in:nnTF {#2} {=}
        { \keys_set:nn {desert / capkeyval} {#2} }
        {  % alright, not key-value yet
            \tl_set:Nn \l__label_tl {}
            \tl_set:Nn \l__entry_tl {}
            \tl_set:Nn \l__caption_tl {#2}
        } 
    \tl_if_blank:VT \l__entry_tl
        { \tl_set:Nn \l__entry_tl {#1} }  % harmless at worst
    \__desert_capkeyval:
    \group_end:
}

\NewDocumentCommand \Caption { m }
{   % hardcore version; requires key-value
    \group_begin:
    \keys_set:nn {desert / capkeyval} {#1}
    \__desert_capkeyval:
    \group_end:
}




%========================================================================================
%                 figures -- single-panel
%========================================================================================

\AtBeginEnvironment {figure} {\centering}


\keys_define:nn { desert / one-panel-figure }
{
    file .tl_set:N = \l__file_tl ,
    file .initial:n = {} ,
    graphicx .tl_set:N = \l__graphics_options_tl ,
    graphicx .initial:n = {} ,
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {} ,
    caption .tl_set:N = \l__caption_tl ,
    caption .initial:n = {} ,
    full .bool_set:N = \l__full_page_bool,
    full .initial:n = false,
}

\NewDocumentEnvironment {OnePanelFigure} { s r[] }
{
    \keys_set:nn {desert / one-panel-figure} {#2}
    \str_set:Nn \__my_env_str {figure}
    \bool_if:nTF {#1}
        { \str_set:Nn \__my_env_str {figure*} }
        {
            \bool_if:NT \l__full_page_bool
                { \str_set:Nn \__my_env_str {figure*} }
        }
    \begin{\__my_env_str}
    \tl_if_blank:VF \l__file_tl
        { \includegraphics[\l__graphics_options_tl]{\l__file_tl} }
}
{
    \__desert_capkeyval:
    \end{\__my_env_str}
}

\NewDocumentCommand \AddOnePanelFigure { s r[] }
{
    \begin{OnePanelFigure}\bool_if:nT{#1}{*}[#2]
    \end{OnePanelFigure}
}




%========================================================================================
%                 figures -- multi-panel (with real graphics)
%========================================================================================

\keys_define:nn { desert / multi-panel-figure }
{
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {} ,
    caption .tl_set:N = \l__caption_tl ,
    caption .initial:n = {} ,
    full .bool_set:N = \l__full_page_bool,
    full .initial:n = false,
}

\NewDocumentEnvironment {MultiPanelFigure} { s r[] }
{
    \keys_set:nn {desert / multi-panel-figure} {#2}
    \bool_if:nTF {#1}
        { \str_set:Nn \__my_env_str {figure*} }
        {
            \bool_if:NT \l__full_page_bool
                { \str_set:Nn \__my_env_str {figure*} }
        }
    \begin{\__my_env_str}
}
{
    \__desert_capkeyval:
    \end{\l__my_env_str}
}

\keys_define:nn { desert / real-panel }
{
    file .tl_set:N = \l__panel_file_tl ,
    file .initial:n = {...} ,
    graphicx .tl_set:N = \l__panel_graphics_options_tl ,
    graphicx .initial:n = {} ,
    width .dim_set:N = \l__panel_width_dim ,
    inner-pos .tl_set:N = \l__panel_innerpos_tl ,
    label .tl_set:N = \l__panel_label_tl ,
    entry .tl_set:N = \l__panel_entry_tl ,
    caption .tl_set:N = \l__panel_caption_tl ,
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
    file .tl_set:N = \l__file_tl ,
    file .initial:n = {} ,
    graphicx .tl_set:N = \l__graphics_options_tl ,
    graphicx .initial:n = {} ,
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {} ,
    caption .tl_set:N = \l__caption_tl ,
    caption .initial:n = {} ,
    full .bool_set:N = \l__full_page_bool,
    full .initial:n = false,
}

%\prop_new:N \g__desert_panel_prop

\NewDocumentEnvironment {PhantomPanelFigure} { s r[] }
{
    \keys_set:nn {desert / phantom-panel-figure} {#2}
    \bool_if:nTF {#1}
        { \str_set:Nn \__my_env_str {figure*} }
        {
            \bool_if:NT \l__full_page_bool
                { \str_set:Nn \__my_env_str {figure*} }
        }
    \begin{\__my_env_str}
    \tl_if_blank:VF \l__file_tl
        { \includegraphics[\l__graphics_options_tl]{\l__file_tl} }
}
{
    \__desert_capkeyval:
    \end{\__my_env_str}
}

\keys_define:nn { desert / phantom-panel }
{
    label .tl_set:N = \l__panel_label_tl ,
    entry .tl_set:N = \l__panel_entry_tl ,
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
    \subref{#1}\g_desert_typo_subcaption_label_sep_tl #2
}
\NewDocumentCommand \describepanels { m m }
{
    \txtstyles_use:nn
        {subref}
        {
            \g_desert_typo_subref_prefix_tl
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
    presep=\g_desert_above_table_title_skip ,
    headsep=\g_desert_below_table_title_skip ,
    footsep=\g_desert_above_table_footer_skip ,
    postsep=\g_desert_below_table_footer_skip ,
}

% Apply these font styles in all cases
\SetTblrStyle {caption-sep} {font=\txtstyles_run_nullary:n{table-head-label}}
\SetTblrStyle {caption-tag} {font=\txtstyles_run_nullary:n{table-head-label}}
\SetTblrStyle {caption-text} {font=\txtstyles_run_nullary:n{table-head-body}}
\SetTblrStyle {lastfoot} {font=\txtstyles_run_nullary:n{table-footer}}

% Fix the separators
% For caption, that's the only thing we'll do.
% (For notes and remarks, we'll do more after.)
\DefTblrTemplate {caption-sep} {default} {\g_desert_typo_caption_label_sep_tl}
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


\DefTblrTemplate {lastfoot} {default}  % make default
{
    \txtstyles_set_baselinestretch:V \g_desert_leading_caption_fp
    \UseTblrTemplate{remark}{shortfoot}
    \UseTblrTemplate{note}{shortfoot}
    \par
}

\DefTblrTemplate {lastfoot} {shortfoot}
{
    \txtstyles_set_baselinestretch:V \g_desert_leading_caption_fp
    \UseTblrTemplate{remark}{shortfoot}
    \UseTblrTemplate{note}{shortfoot}
    \par
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

\NewDocumentEnvironment {Table} { O{} m }
    { \begin{booktabs}[#1]{#2} }
    { \end{booktabs} }
    
\NewDocumentEnvironment {LongTable} { O{} m }
    { \begin{longtabs}[#1]{#2} }
    { \end{longtabs} }
    
\NewDocumentEnvironment {TallTable} { O{} m }
    { \begin{talltabs}[#1]{#2} }
    { \end{talltabs} }

% Process an external table with csvsimple-l3.
%                    == ARGS ==                                       %
%  #      R? arg     description                                      %
% { #1 }  Y  OUTER   key-value args to tblr outer[] (e.g. caption=)
% { #2 }  Y  INNER   key-value args to tblr inner{} (e.g. colspec=)
% [ #3 ]  N  READER  key-value args to csvreader (e.g. separator=tab)
% < #4 >  Y  FILE    Path to file (e.g. cows.csv)
%
\NewDocumentCommand \LoadTable { r[] m O{} r<> }
{
    \SetTblrOuter{#1}
    \csvreader
    [
        no~head ,
        long~tabularray = {#2} ,
        table~head = {\toprule} ,
        table~foot = {\midrule} ,
        late~after~first~line = {\\\bottomrule} ,
        #3
    ]
    {#4}
}




%========================================================================================
%                            boxes
%========================================================================================

\keys_define:nn { desert / box }
{
    name .tl_set:N = \l__name_tl ,
    name .initial:n = {} ,
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
}
\dim_new:N \g_desert_box_border_dim
\dim_gset:Nn \g_desert_box_border_dim {1.5pt }
\dim_new:N \g_desert_box_arc_dim
\dim_gset:Nn \g_desert_box_arc_dim { 4pt }
\tl_new:N \g_desert_box_frame_color_tl
\tl_gset:Nn \g_desert_box_frame_color_tl { blue!50!black }
\cs_new_protected:Nn \desert_box_font_title: { \normalsizerr \bfseries }

% make consistently themed non-flashy boxes
% e.g. \DeclareDesertBox [color=xkcdalgae] {Hint}
\cs_new:Npn \desert__dec_box:nnnN #1#2#3#4
{
    #4 {#3} { O{} }
    {
        \keys_set:nn {desert / box} {##1}
        \begin{tcolorbox} [
            title       =
            {
                \txtstyles_use:nn{box-label}{#3 \g_desert_typo_caption_label_sep_tl}
                \txtstyles_use:nn{box-name}{\l__name_tl}
            } ,
            colframe    = {#1} ,
            colupper    = {#1} ,
            colback     = {#1!1!white} ,
            coltext     = black ,
            fonttitle   = {\desert_box_font_title:} ,
            fontlower   = {} ,
            boxrule     = {\dim_use:N \g_desert_box_border_dim} ,
            arc         = {\dim_use:N \g_desert_box_arc_dim} ,
            boxsep      = 0.5pt ,
            #2  % here the user can override any of the above-listed defaults
        ]
        \tl_if_blank:VF \l__label_tl
            { \label{\l__label_tl} }
    }
    { \end{tcolorbox} }
}
\NewDocumentCommand \DeclareDesertBox { D(){\g_desert_box_frame_color_tl} O{} m }
    { \desert__dec_box:nnnN{#1}{#2}{#3}\DeclareDocumentEnvironment} 

\NewDocumentCommand \NewDesertBox { D(){\g_desert_box_frame_color_tl} O{} m }
    { \desert__dec_box:nnnN{#1}{#2}{#3}\NewDocumentEnvironment} 

\NewDocumentCommand \ProvideDesertBox { D(){\g_desert_box_frame_color_tl} O{} m }
    { \desert__dec_box:nnnN{#1}{#2}{#3}\ProvideDocumentEnvironment} 

\NewDocumentCommand \RenewDesertBox { D(){\g_desert_box_frame_color_tl} O{} m }
    { \desert__dec_box:nnnN{#1}{#2}{#3}\RenewDocumentEnvironment} 


\dim_new:N \g_desert_minted_border_dim
\dim_gset:Nn \g_desert_minted_border_dim { 1.5pt }
\tl_gset:Nn \g_desert_minted_bg_color_tl { black!2!white }

\desert_if_feat_enabled:nT {tcolorbox}
{
    \DeclareTColorBox {DesertMinted} { O{} }
    {
        colback = \g_desert_minted_bg_color_tl ,
        coltext = black ,
        boxrule = {\dim_use:N \g_desert_minted_border_dim} ,
        arc     = 0pt ,
        boxsep  = 0pt ,
        #1
    }
}




%========================================================================================
%                    source code
%========================================================================================

\desert_if_feat_enabled:nT {minted}
{
    \setminted{python3=true}
}


\keys_define:nn { desert / source-code }
{
    lang .tl_set:N = \l__lang_tl ,
    lang .initial:n = {text} ,
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {} ,
    caption .tl_set:N = \l__caption_tl ,
    caption .initial:n = {} ,
    minted .tl_set:N = \l__minted_tl ,
    minted .initial:n = {} ,
    no-box .bool_set:N = \l__no_box_bool ,
    no-box .initial:n = false ,
}

\NewDocumentEnvironment {SourceCode} { O{} }
{
    \begin{listing}
    \__desert_capkeyval:
    \keys_set:nn {desert / source-code} {#1}
    \desert_if_feat_enabled:nT {tcolorbox}  % box even if minted is not enabled
        { \bool_if:NF \l__no_box_bool { \begin{DesertMinted} } }
    \desert_if_feat_enabled:nT {minted}
    {
        \txtstyles_run_nullary:n{source-code}
        \setminted{baselinestretch=\g_desert_leading_source_code_fp}
    }
}
{
    \desert_if_feat_enabled:nT {tcolorbox}
        { \bool_if:NF \l__no_box_bool { \end{DesertMinted} } }
    \end{listing}
}

\NewDocumentEnvironment {MintedCode} { O{} }
{   \VerbatimEnvironment
    \begin{SourceCode}
    \desert_if_feat_enabled:nT {minted}
        { \begin{minted} [\l__minted_tl] {\l__lang_tl} }
}
{
    \desert_if_feat_enabled:nT {minted}
        { \end{minted} }
    \end{SourceCode}
}

% Load minted code and put it in a sourcecode environment.
%                    == ARGS ==                                       %
%  #      R? arg     description                                      %
% [ #1 ]  N  MINTED  key-value args to \begin{minted}[]
% { #2 }  Y  main    key-value args to \capkeyval / \begin{SourceCode}[]
% < #4 >  Y  FILE    Path to file (e.g. cows.java)
%
\NewDocumentCommand \LoadSourceCode { O{} m r<> }
{
    \begin{SourceCode}
    \keys_set:nn {desert / source-code} {#2}
    \__desert_capkeyval:
    \desert_if_feat_enabled:nT {minted}
        { \inputminted[#1]{\l__lang_tl}{#3} }
    \end{SourceCode}
}




%========================================================================================
%                               chemistry
%========================================================================================


\keys_define:nn { desert / chem }
{
    label .tl_set:N = \l__label_tl ,
    label .initial:n = {} ,
    entry .tl_set:N = \l__entry_tl ,
    entry .initial:n = {} ,
    caption .tl_set:N = \l__caption_tl ,
    caption .initial:n = {} ,
    chemfig .tl_set:N = \l__chemfig_tl ,
    chemfig .initial:n = {} ,
}

\__desert_new_float:n {reactionscheme}
\__desert_new_float:n {structuralformula}

\NewDocumentEnvironment {ReactionScheme} { O{} }
{
    \keys_set:nn {desert / chem} {#1}
    \begin{reactionscheme}
    \txtstyles_run_nullary:n {desert-chemistry}
    \desert_has_feat:nT {chemfig}
    {
        \setchemfig{\l__chemfig_tl}
        \schemestart
    }
}
{
    \__desert_capkeyval:
    \end{reactionscheme}
    \desert_has_feat:nT {chemfig}
        { \schemestop }
}

\NewDocumentEnvironment {StructuralFormula} { O{} }
{
    \keys_set:nn {desert / chem} {#1}
    \begin{structuralformula}
    \txtstyles_run_nullary:n {desert-chemistry}
    \desert_has_feat:nT {chemfig}
        { \setchemfig{\l__chemfig_tl} }
}
{
    \__desert_capkeyval:
    \end{structuralformula}
}




%========================================================================================
%                    typography
%========================================================================================

\RenewDocumentCommand \foreign { m }
    { \txtstyles_use:nn{foreign-words}{#1} }  % e.g. "et al." or "in vivo"


% Really none of these should be changed, EXCEPT
% group-digits group-minimum-digits, and maybe group-separator.
% If in a US university: group-separator={,},group-digits=integer
\sisetup
{
    mode = match,               % stay in the current mode (all?)
    number-mode = match,        % stay in the current mode (digits)
    unit-mode = match,          % stay in the current mode (units)
    propagate-math-font = true, % these just retain the current font:
    reset-text-family = false ,
    reset-text-series = false ,
    reset-text-shape = false ,
    retain-explicit-plus,       % +1 stays +1, not 1
    retain-zero-uncertainty,    % \pm 0 still shown
    group-minimum-digits = 3,   % starting at this number (1,000)
    group-digits = all,         % 'all' is acceptable with thinspace
    group-separator = \thinspace ,
}


% We pass the author, etc., at the preamble end, after the user set it.
\hypersetup
{
    colorlinks ,
    linktoc   = all ,
    linkcolor = ref ,
    citecolor = cite ,
    urlcolor  = url ,
    filecolor = file ,
    final     = true ,  % ignore global settings
    draft     = false ,
}


\desert_if_feat_enabled:nT {kantlipsum}
{
    \int_gzero_new:N \g__desert_ikant_int
    
    \NewDocumentCommand \ikant { O{3} }
    {
        \int_compare:nNnTF {\g__desert_ikant_int} > {163}
            { \int_gset:Nn \g__desert_ikant_int {1} }
            { \int_gincr:N \g__desert_ikant_int }
        \kant[\g__desert_ikant_int][1--#1]
    }
    
    \NewDocumentCommand \rkant { O{3} }
    {
        \kant[\int_rand:nn{1}{164}][1--#1]
    }
}




%========================================================================================
%                front, main, back matter commands
%========================================================================================

\NewDocumentCommand \ShowSubBib {}
{
    \bool_if:NT \g_desert_bib_per_chapter_bool
        { \printbibliography[heading=subbibintoc] }
}

\NewDocumentCommand \ShowEndNotes {}
{
    \printendnotes  % does nothing there are no endnotes
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

\cs_new_protected:Npn \__desert_chapter_num:N #1
{
    \renewcommand \thechapter {#1{chapter}}
}

\NewDocumentCommand \StartMainMatter {}
{
    \str_if_eq:VVF \g_desert_numbering_front_str \g_desert_numbering_main_str
    {
        \pagenumbering{\g_desert_numbering_main_str}
        \setcounter{page}{1}
    }
    \bool_if:NT \g_desert_force_endnotes_bool
        { \FootnotesAsEndnotes }
    \setcounter{chapter}{0}
    \exp_args:Nc
        \__desert_chapter_num:N
        \g_desert_numbering_main_chapters_str
}

\NewDocumentCommand \StartBackMatter {}
{
    \str_if_eq:VVF \g_desert_numbering_main_str \g_desert_numbering_back_str
        {
            \pagenumbering{\g_desert_numbering_back_str}
            \setcounter{page}{1}
        }
    \setcounter{chapter}{0}
    \exp_args:Nc
        \__desert_chapter_num:N
        \g_desert_numbering_back_chapters_str
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

\NewDocumentCommand \AcroSetup {m}
    { \acsetup{#1} }

\NewDocumentCommand \CaptionSetup { o m }
    { \captionsetup[#1]{#2} }

\NewDocumentCommand \MintedSetup {m}
    { \setminted{#1} }

\NewDocumentCommand \GeometrySetup {m}
    { \geometry{#1} }

\NewDocumentCommand \ChemSetup {m}
    { \chemsetup{#1} }

\NewDocumentCommand \ListSetup { o m }
    { \setlist[#1]{#2} }  % enumitem


\NewDocumentCommand \ChemfigSetup { >{\TrimSpaces}O{1} m}
{
    \setchemfig{#2}
    % it's inconvenient to just say, "my diagrams are too big"
    % arg [#1] is a coefficient to rescale all lengths
    \fp_set:Nn \l_tmpa_fp {#1}  % make sure it's valid
    \tl_if_eq:nn {#1} {1} % cheat a bit for performance
    {
        \setchemfig
        {
            % whitespace:
            atom sep = {#1 \CF_atomsep} ,
            compound sep = {#1 \CF_compoundsep} ,
            % space between text and charge
            + sep left = {#1 \CF_signspaceante} ,    % these are a bit different
            + sep right = {#1 \CF_signspacepost} ,
            vshift = {#1 \CF_signvshift} ,
            % cram width (in ex):
            cram width = {#1 \CF_crambasewidth} ,
            % bond lengths and offsets:
            cram dash width = {#1 \CF_cramdashlength} ,
            cram dash sep = {#1 \CF_cramdashsep} ,
            bond offset = {#1 \CF_bondoffset} ,
            double bond sep = {#1 \CF_doublesep} ,
            arrow offset = {#1 \CF_arrowoffset} ,
            arrow double sep = {#1 \CF_arrowdoublesep} ,
            arrow label sep= {#1 \CF_arrowlabelsep} ,
            stack sep = {#1 \CF_stacksep} ,
        }
    }
}




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
    title = A Title ,
    author = An Author ,
    subject = A Subject ,
    keywords = {Several, Keywords} ,
    degree = some degree ,
    lang = \g_desert_lang_str ,
}




%========================================================================================
%                    final things
%========================================================================================

% Nomenclature!
\makenomenclature

% Run \makeindex
\desert_if_feat_enabled:nT {imakeidx}
{
    \tl_set_eq:NN \l_tmpa_tl \g_desert_layout_index_cols_int
    \tl_set:Nn \l_tmpb_tl {\dim_use:N \g_desert_layout_index_col_sep_dim}
    \bool_if:NTF \g_desert_toc_index_bool
        { \makeindex[columns={\l_tmpa_tl}, columnsep={\l_tmpb_tl},intoc] }
        { \makeindex[columns={\l_tmpa_tl}, columnsep={\l_tmpb_tl}] }
}


\AtEndPreamble
{
    \AddPdfHyperxmpData  % from info.styr
}

