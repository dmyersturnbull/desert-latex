% Copyright 2022 Douglas Myers-Turnbull
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or
% (at your option) any later version. The latest version of this license is
% in http://www.latex-project.org/lppl.txt and version 1.3 or later is part of
% all distributions of LaTeX version 2005/12/01 or later.
% See https://github.com/dmyersturnbull/dez-latex for the most recent code.


%=======                                                   =======
%=======                      Desert                       =======
%=======                                                   =======

\NeedsTeXFormat {LaTeX2e} [2020-10-01]
\ExplSyntaxOn
\ProvidesExplClass {desert} {2022-05-08} {0.1.0} { Desert~dissertation~template }


% Make _ and ^ inactive in text mode
\catcode`\_=\active
\def _ { \relax \ifmmode \sb \else \_ \fi }
\catcode`\^=\active
\def _ { \relax \ifmmode \sp \else \^ \fi }



%==================================================================================================
%                    meta utils
%==================================================================================================


\RequirePackage {etoolbox}
\RequirePackage {l3keys2e}

\cs_new_protected:Npn \dez_non_expl:n #1
{
    \ExplSyntaxOff
    #1
    \ExplSyntaxOn
}

\NewDocumentCommand \UseTikzLibrary {m}
    { \dez_non_expl:n {\usetikzlibrary{#1}} }

\NewDocumentCommand \UsePgfLibrary {m}
    { \dez_non_expl:n {\usepgflibrary{#1}} }

\NewDocumentCommand \UseGdLibrary {m}
    { \dez_non_expl:n {\usegdlibrary{#1}} }


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



%==================================================================================================
%                      errors, warnings, messages, etc.
%==================================================================================================

\msg_new:nnn {dez} {nosuchpreset}
    { Preset~'#1'~not~available:~no~command~of~that~name. }
\cs_new_protected:Npn \dez__warn_nosuchpreset:n #1
    { \msg_warning:nnn {dez} {nosuchpreset} {#1} }
\cs_generate_variant:Nn \dez__warn_nosuchpreset:n { V, v }

\msg_new:nnn {dez} {generic}
    { #1:~#2 }
\cs_new_protected:Npn \dez__info:nv #1#2
    { \msg_info:nnnn {dez} {generic} {#1} {#2} }
\cs_new_protected:Npn \dez__note:nv #1#2
    { \msg_note:nnnn {dez} {generic} {#1} {#2} }



%==================================================================================================
%                    containers to store package options
%==================================================================================================

\tl_new:N \g_dez__end_tl
\tl_gset:Nn \g_dez__end_tl {}

\NewDocumentCommand \DezAtEnd {m}
{
    \tl_put_right:Nn \g_dez__end_tl {~#1}
}

% STORE textiles AND COLORS
\prop_new:N \g_dez_style_prop
\prop_new:N \g_dez_color_prop


% Saving optional features

\seq_new:N \g_dez_feat_seq

\prg_new_conditional:Npnn  \dez_if_feat_enabled:n #1 { T, F, TF }
{
    \seq_if_in:NnTF \g_dez_feat_seq {#1}
    { \prg_return_true: }
    { \prg_return_false: }
}

\NewDocumentCommand \@DezLoadFeat { o m }
{
    \seq_if_in:NnT \g_dez_feat_seq {#2}
        { \RequirePackage [#1] {#2} }
}



%==================================================================================================
%                    Load report class!
%==================================================================================================

% Load report BEFORE DECLARING OPTIONS!!
% Otherwise em and ex units are zero.
\LoadClass {report}



%==================================================================================================
%                    internal aliases
%==================================================================================================

\let \@PP \PassOptionsToPackage
\let \@RP \RequirePackage
\let \@LF \@DezLoadFeat
\let \@TZ \UseTikzLibrary
\let \@PG \UsePgfLibrary
\let \@GD \UseGdLibrary

\cs_new_protected:Npn \dez__add_feat:n #1
    {  \seq_gput_right:Nn \g_dez_feat_seq {#1} }
\let \@add_feat \dez__add_feat:n
\let \@tl_to \tl_gset_eq:NN
\let \@str_to \str_gset_eq:NN



%==================================================================================================
%                    package options and setup
%==================================================================================================

\keys_define:nn {dez}
{

draft .bool_gset:N                       = \g_dez_draft_bool ,
draft .default:n                         = true ,
draft .initial:n                         = false ,
langs .tl_gset:N                         = \g_dez_langs_str ,
langs .initial:n                         = USenglish ,
preset .tl_gset:N                        = \g_dez_preset_str ,
preset .initial:n                        = AFour ,
mode .choices:nn                         = { thesis, article, book, }
                                           { \@str_to \g_dez_mode_str \l_keys_choice_tl } ,
mode .initial:n                          = thesis ,

pkg / svg .code:n                        = { \@add_feat {svg} } ,
pkg / kantlipsum .code:n                 = { \@add_feat {kantlipsum} } ,
pkg / imakeidx .code:n                   = { \@add_feat {imakeidx} } ,
pkg / knowledge .code:n                  = { \@add_feat {knowledge} } ,
pkg / lettrine .code:n                   = { \@add_feat {lettrine} } ,
pkg / ulem .code:n                       = { \@add_feat {ulem} } ,
pkg / varioref .code:n                   = { \@add_feat {varioref} } ,
pkg / tikz .code:n                       = { \@add_feat {tikz} } ,
pkg / graphs .code:n                     = { \@add_feat {graphs} } ,
pkg / tcolorbox .code:n                  = { \@add_feat {tcolorbox} } ,
pkg / minted .code:n                     = { \@add_feat {minted} } ,
pkg / chemformula .code:n                = { \@add_feat {chemformula} } ,
pkg / chemmacros .code:n                 = { \@add_feat {chemmacros} } ,
pkg / chemfig .code:n                    = { \@add_feat {chemfig} } ,
pkg / cryptocode .code:n                 = { \@add_feat {cryptocode} } ,
pkg / awesomebox .code:n                 = { \@add_feat {awesomebox} } ,

bib / hide-lang .bool_gset:N             = \g_dez_bib_hide_lang_bool ,
bib / hide-lang .default:n               = true ,
bib / hide-lang .initial:n               = false ,
bib / per-chap .bool_gset:N              = \g_dez_bib_per_chap_bool ,
bib / per-chap .default:n                = true ,
bib / per-chap .initial:n                = false ,
bib / style .tl_gset:N                   = \g_dez_bib_style_str ,
bib / style .initial:n                   = ieee ,

color / cite .prop_gput:N                = \g_dez_color_prop ,
color / cite .initial:n                  = blue ,
color / file .prop_gput:N                = \g_dez_color_prop ,
color / file .initial:n                  = red ,
color / ref .prop_gput:N                 = \g_dez_color_prop ,
color / ref .initial:n                   = blue ,
color / url .prop_gput:N                 = \g_dez_color_prop ,
color / url .initial:n                   = blue ,

cref / abbrev .bool_gset:N               = \g_dez_cref_abbrev_bool ,
cref / abbrev .default:n                 = true ,
cref / abbrev .initial:n                 = false ,
cref / capitalize .bool_gset:N           = \g_dez_cref_capitalize_bool ,
cref / capitalize .default:n             = true ,
cref / capitalize .initial:n             = false ,

font / size .tl_gset:N                   = \g_dez_font_size_tl ,
font / size .initial:n                   = 11pt ,
font / leading .tl_gset:N                = \g_dez_font_leading_tl ,
font / leading .initial:n                = {} ,  % empty ==> +20%

header / left .tl_gset:N                 = \g_dez_lay_header_left_tl ,
header / left .initial:n                 = {} ,
header / center .tl_gset:N               = \g_dez_lay_header_center_tl ,
header / center .initial:n               = {} ,
header / right .tl_gset:N                = \g_dez_lay_header_right_tl ,
header / right .initial:n                = {} ,
footer / left .tl_gset:N                 = \g_dez_lay_footer_left_tl ,
footer / left .initial:n                 = {} ,
footer / center .tl_gset:N               = \g_dez_lay_footer_center_tl ,
footer / center .initial:n               = {} ,
footer / right .tl_gset:N                = \g_dez_lay_footer_right_tl ,
footer / right .initial:n                = \small\thepage ,

layout / geometry .tl_gset:N             = \g_dez_geometry_tl ,
layout / geometry .initial:n             = {} ,
layout / nom-symbol-width .dim_gset:N    = \g_dez_nom_symbol_dim ,
layout / nom-symbol-width .initial:n     = 4em ,
layout / index-cols .int_gset:N          = \g_dez_lay_index_cols_int ,
layout / index-cols .initial:n           = 2 ,
layout / index-col-sep .dim_gset:N       = \g_dez_lay_index_col_sep_dim ,
layout / index-col-sep .initial:n        = 3em ,

layout / fnotes-to-endnotes .bool_gset:N = \g_dez_force_endnotes_bool ,
layout / fnotes-to-endnotes .default:n   = true ,
layout / fnotes-to-endnotes .initial:n   = false ,
layout / endnote-backrefs .bool_gset:N   = \g_dez_endnote_backrefs_bool,
layout / endnote-backrefs .default:n     = true ,
layout / endnote-backrefs .initial:n     = false ,
layout / show-toc-links .bool_gset:N     = \g_dez_show_toc_links_bool,
layout / show-toc-links .default:n       = true ,
layout / show-toc-links .initial:n       = false ,
layout / show-nom-links .bool_gset:N     = \g_dez_show_nom_links_bool,
layout / show-nom-links .default:n       = true ,
layout / show-nom-links .initial:n       = false ,
layout / fnote-align .choices:nn         = { justify, left, }
                                           { \@str_to \g_dez_fnote_align_str \l_keys_choice_tl } ,
layout / fnote-align .initial:n          = justify ,
layout / fnote-placement .choices:nn     = {
                                             default, abovefloats, belowfloats,
                                             bottom, bottomfloats, bottomfootnotes,
                                           }
                                           { \@str_to \g_dez_fnote_place_str \l_keys_choice_tl } ,
layout / fnote-placement .initial:n       = default ,

stretch / main .fp_gset:N                 = \g_dez_stretch_main_fp ,
stretch / main .initial:n                 = 1.5 ,
stretch / caption .fp_gset:N              = \g_dez_stretch_caption_fp ,
stretch / caption .initial:n              = 1.1 ,
stretch / eqn .fp_gset:N                  = \g_dez_stretch_eqn_fp ,
stretch / eqn .initial:n                  = 1.1 ,
stretch / toc .fp_gset:N                  = \g_dez_stretch_toc_fp ,
stretch / toc .initial:n                  = 1.1 ,
stretch / list-of .fp_gset:N              = \g_dez_stretch_lof_fp ,
stretch / list-of .initial:n              = 1.2 ,
stretch / abbrevs .fp_gset:N              = \g_dez_stretch_abbrevs_fp ,
stretch / abbrevs .initial:n              = 1.2 ,
stretch / nom .fp_gset:N                  = \g_dez_stretch_nom_fp ,
stretch / nom .initial:n                  = 1.1 ,
stretch / source-code .fp_gset:N          = \g_dez_stretch_code_fp ,
stretch / source-code .initial:n          = 1.0 ,

num / depth .choices:nn                  = {
                                             none, chapter, section, subsection, subsubsection ,
                                             paragraph, subparagraph,
                                           }
                                           { \@str_to \g_dez_n_depth_str \l_keys_choice_tl } ,
num / depth .initial:n                   = subparagraph ,
num / back-pages .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_back_str \l_keys_choice_tl } ,
num / back-pages .initial:n              = arabic ,
num / front-chaps .choices:nn            = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_front_chp_str \l_keys_choice_tl } ,
num / front-chaps .initial:n             = Roman ,
num / main-chaps .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_main_chps_str \l_keys_choice_tl } ,
num / main-chaps .initial:n              = arabic ,
num / back-chaps .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                          { \@str_to \g_dez_n_back_chp_str \l_keys_choice_tl } ,
num / back-chaps .initial:n              = Alph ,
num / fig-panels .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_panels_str \l_keys_choice_tl } ,
num / fig-panels .initial:n              = alph ,
num / eqn-brackets .choices:nn           = {
                                             none, round, square, curly, none-bold,
                                             round-bold, square-bold, curly-bold,
                                           }
                                           { \@str_to \g_dez_n_brackets_str \l_keys_choice_tl } ,
num / eqn-brackets .initial:n            = round ,
num / eqn-in .choices:nn                 = { none, chapter, section, subsection, subsubsection, }
                                           { \@str_to \g_dez_eqn_in_str \l_keys_choice_tl } ,
num / eqn-in .initial:n                  = chapter ,
num / float-in .choices:nn               = { none, chapter, section, subsection, subsubsection, }
                                           { \@str_to \g_dez_float_in_str \l_keys_choice_tl } ,
num / float-in .initial:n                = chapter ,
num / fnote-in .choices:nn               = { none, page, chapter, }
                                           { \@str_to \g_dez_fnote_in_str \l_keys_choice_tl } ,
num / fnote-in .initial:n                = page ,
num / fnotes .choices:nn                 = {
                                             arabic, roman, Roman, alph, Alph, lamport,
                                             lamport*, bringhurst, chicago, wiley,
                                           }
                                           { \@str_to \g_dez_n_fnotes_str \l_keys_choice_tl } ,
num / fnotes .initial:n                  = lamport* ,
num / front-pages .choices:nn            = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_front_str \l_keys_choice_tl } ,
num / front-pages .initial:n             = roman ,
num / main-pages .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_main_str \l_keys_choice_tl } ,
num / main-pages .initial:n              = arabic ,
num / thm-like-in .choices:nn            = { none, chapter, section, subsection, subsubsection, }
                                           { \@str_to \g_dez_thm_in_str \l_keys_choice_tl } ,
num / thm-like-in .initial:n             = chapter ,

sty / abstract-by .prop_gput:N           = \g_dez_style_prop ,
sty / abstract-by .initial:n             = largerr ,
sty / abstract-authors .prop_gput:N      = \g_dez_style_prop ,
sty / abstract-authors .initial:n        = largerr ,
sty / abstract-title .prop_gput:N        = \g_dez_style_prop ,
sty / abstract-title .initial:n          = Large; bold ,
sty / caption-body .prop_gput:N          = \g_dez_style_prop ,
sty / caption-body .initial:n            = small; sans ,
sty / caption-label .prop_gput:N         = \g_dez_style_prop ,
sty / caption-label .initial:n           = small; sans; bold ,
sty / subcaption-body .prop_gput:N       = \g_dez_style_prop ,
sty / subcaption-body .initial:n         = small; sans ,
sty / subcaption-label .prop_gput:N      = \g_dez_style_prop ,
sty / subcaption-label .initial:n        = small; sans; bold ,
sty / subref .prop_gput:N                = \g_dez_style_prop ,
sty / subref .initial:n                  = bold ,
sty / table-head-body .prop_gput:N       = \g_dez_style_prop ,
sty / table-head-body .initial:n         = small; sans; bold ,
sty / table-head-label .prop_gput:N      = \g_dez_style_prop ,
sty / table-head-label .initial:n        = small; sans; bold ,
sty / table-footer .prop_gput:N          = \g_dez_style_prop ,
sty / table-footer .initial:n            = small; sans ,
sty / box-label .prop_gput:N             = \g_dez_style_prop ,
sty / box-label .initial:n               = large; bold; allcaps ,
sty / box-name .prop_gput:N              = \g_dez_style_prop ,
sty / box-name .initial:n                = large; bold ,
sty / chap-label .prop_gput:N            = \g_dez_style_prop ,
sty / chap-label .initial:n              = Huge; 606060; smallcaps ,
sty / chap-name .prop_gput:N             = \g_dez_style_prop ,
sty / chap-name .initial:n               = huge ,
sty / front-chap-title .prop_gput:N      = \g_dez_style_prop ,
sty / front-chap-title .initial:n        = huge; smallcaps ,
sty / part-label .prop_gput:N            = \g_dez_style_prop ,
sty / part-label .initial:n              = Huge; bold ,
sty / part-name .prop_gput:N             = \g_dez_style_prop ,
sty / part-name .initial:n               = HUGE; bold ,
sty / chemical-diagram .prop_gput:N      = \g_dez_style_prop ,
sty / chemical-diagram .initial:n        = sans; small ,
sty / fnote-body .prop_gput:N            = \g_dez_style_prop ,
sty / fnote-body .initial:n              = mini; sans ,
sty / foreign-words .prop_gput:N         = \g_dez_style_prop ,
sty / foreign-words .initial:n           = italic ,
sty / indx-starred .prop_gput:N          = \g_dez_style_prop ,
sty / indx-starred .initial:n            = italic ,
sty / nom-group .prop_gput:N             = \g_dez_style_prop ,
sty / nom-group .initial:n               = bold; large ,
sty / section-title .prop_gput:N         = \g_dez_style_prop ,
sty / section-title .initial:n           = LARGE; bold ,
sty / source-code .prop_gput:N           = \g_dez_style_prop ,
sty / source-code .initial:n             = small ,
sty / subsec-title .prop_gput:N          = \g_dez_style_prop ,
sty / subsec-title .initial:n            = Large; bold ,
sty / subsubsec-title .prop_gput:N       = \g_dez_style_prop ,
sty / subsubsec-title .initial:n         = large; bold ,
sty / paragraph-title .prop_gput:N       = \g_dez_style_prop ,
sty / paragraph-title .initial:n         = bold ,
sty / toc-part .prop_gput:N              = \g_dez_style_prop ,
sty / toc-part .initial:n                = bold; large ,
sty / toc-chap .prop_gput:N              = \g_dez_style_prop ,
sty / toc-chap .initial:n                = bold; midrr ,
sty / toc-section .prop_gput:N           = \g_dez_style_prop ,
sty / toc-section .initial:n             = {} ,
sty / toc-subsec .prop_gput:N            = \g_dez_style_prop ,
sty / toc-subsec .initial:n              = {} ,
sty / toc-subsubsec .prop_gput:N         = \g_dez_style_prop ,
sty / toc-subsubsec .initial:n           = {} ,
sty / toc-page-num .prop_gput:N          = \g_dez_style_prop ,
sty / toc-page-num .initial:n            = {} ,

toc / refs .bool_gset:N                  = \g_dez_toc_bib_bool ,
toc / refs .default:n                    = true ,
toc / refs .initial:n                    = false ,
toc / index .bool_gset:N                 = \g_dez_toc_index_bool ,
toc / index .default:n                   = true ,
toc / index .initial:n                   = false ,
toc / depth .choices:nn                  = { none, chapter, section, subsection, subsubsection, }
                                           { \@str_to \g_dez_toc_depth_str \l_keys_choice_tl } ,
toc / depth .initial:n                   = subsection ,
toc / endnotes .bool_gset:N              = \g_dez_toc_endnotes_bool ,
toc / endnotes .default:n                = true ,
toc / endnotes .initial:n                = false ,
toc / fig-panels .bool_gset:N            = \g_dez_toc_panels_bool ,
toc / fig-panels .default:n              = true ,
toc / fig-panels .initial:n              = false ,

typo / ban-hyphens .bool_gset:N          = \g_dez_typo_ban_hyphens_bool ,
typo / ban-hyphens .default:n            = true ,
typo / ban-hyphens .initial:n            = false ,
typo / caption-label-sep .tl_gset:N      = \g_dez_typo_caption_label_sep_tl ,
typo / caption-label-sep .initial:n      = \quad ,
typo / subref-label-sep .tl_gset:N       = \g_dez_typo_subref_label_sep_tl ,
typo / subref-label-sep .initial:n       = :~ ,
typo / subref-format .tl_gset:N          = \g_dez_typo_subref_format_tl ,
typo / subref-format .initial:n          = parens ,
typo / table-note-sep .tl_gset:N         = \g_dez_typo_table_note_sep_tl ,
typo / table-note-sep .initial:n         = \thinspace ,
typo / table-rem-sep .tl_gset:N          = \g_dez_typo_table_remark_sep_tl ,
typo / table-rem-sep .initial:n          = :~ ,

glue> / indent .skip_gset:N              = \g_dez_indent_dim ,
glue> / indent .initial:n                = 0pt ,
glue> / indent .default:n                = 1em ,

glue< / toc-part .dim_gset:N             = \g_dez_toc_part_dim ,
glue< / toc-part .initial:n              = 0pc ,
glue< / toc-chap .dim_gset:N             = \g_dez_toc_chap_dim ,
glue< / toc-chap .initial:n              = 3pc ,
glue< / toc-section .dim_gset:N          = \g_dez_toc_section_dim ,
glue< / toc-section .initial:n           = 3pc ,
glue< / toc-subsec .dim_gset:N           = \g_dez_toc_subsec_dim ,
glue< / toc-subsec .initial:n            = 3pc ,
glue< / toc-subsubsec .dim_gset:N        = \g_dez_toc_subsubsec_dim ,
glue< / toc-subsubsec .initial:n         = 3pc ,
glue< / alg-title .skip_gset:N           = \g_dez_glue_before_alg_title_skip ,
glue< / alg-title .initial:n             = 0.8em plus 0.02em minus 0.01em ,
glue< / thm-title .skip_gset:N           = \g_dez_glue_before_thm_title_skip ,
glue< / thm-title .initial:n             = 0.8em plus 0.02em minus 0.01em ,
glue< / def-title .skip_gset:N           = \g_dez_glue_before_def_title_skip ,
glue< / def-title .initial:n             = 0.8em plus 0.02em minus 0.01em ,
glue< / rem-title .skip_gset:N           = \g_dez_glue_before_rem_title_skip ,
glue< / rem-title .initial:n             = 0.8em plus 0.02em minus 0.01em ,

glue: / paragraph .skip_gset:N            = \g_dez_btw_paragraphs_skip ,
glue: / paragraph .initial:n              = 2ex plus 0.2ex minus 0.2ex ,
glue: / item .skip_gset:N                 = \g_dez_btw_items_skip ,
glue: / item .initial:n                   = 0.8ex plus 0.1ex minus 0.1ex , % TODO
glue: / long-item .skip_gset:N            = \g_dez_btw_multipar_items_skip ,
glue: / long-item .initial:n              = 1ex plus 0.1ex minus 0.025ex ,
glue: / fnote .skip_gset:N                = \g_dez_btw_fnotes_skip ,
glue: / fnote .initial:n                  = 0.4ex plus 0.05ex minus 0.0125ex ,
glue: / ref .skip_gset:N                  = \g_dez_btw_refs_skip ,
glue: / ref .initial:n                    = 0.5ex plus 0.05ex minus 0.0125ex ,
glue' / fnote-list .skip_gset:N           = \g_dez_abv_fnote_list_skip ,
glue' / fnote-list .initial:n             = 4pc plus 4pc ,
glue. / fnote-list .skip_gset:N           = \g_dez_bel_fnote_list_skip ,
glue. / fnote-list .initial:n             = 4pc plus 12pc , % only if floats are below
glue' / caption .skip_gset:N              = \g_dez_abv_caption_skip ,
glue' / caption .initial:n                = 2ex plus 0.2ex minus 0.05ex ,
glue' / subcaption .skip_gset:N           = \g_dez_abv_subcaption_skip ,
glue' / subcaption .initial:n             = 1.5ex plus 0.15ex minus 0.0375ex ,
glue' / table-title .skip_gset:N          = \g_dez_abv_table_title_skip ,
glue' / table-title .initial:n            = 2ex plus 4ex minus 0.25ex ,
glue. / table-title .skip_gset:N          = \g_dez_bel_table_title_skip ,
glue. / table-title .initial:n            = 2ex plus 1ex minus 0.25ex ,
glue' / table-foot .skip_gset:N           = \g_dez_abv_table_footer_skip ,
glue' / table-foot .initial:n             = 1ex plus 0.5ex minus 0.125ex ,
glue. / table-foot .skip_gset:N           = \g_dez_bel_table_footer_skip ,
glue. / table-foot .initial:n             = 2ex plus 4ex minus 0.25ex ,
glue' / front-chap .skip_gset:N           = \g_dez_abv_front_chap_skip ,
glue' / front-chap .initial:n             = 0ex ,  % TODO -- why?
glue. / front-chap .skip_gset:N           = \g_dez_bel_front_chap_skip ,
glue. / front-chap .initial:n             = 4ex plus 0.4ex minus 0.1ex ,
glue' / chap .skip_gset:N                 = \g_dez_abv_chap_skip ,
glue' / chap .initial:n                   = 0ex ,
glue. / chap .skip_gset:N                 = \g_dez_bel_chap_skip ,
glue. / chap .initial:n                   = 6ex plus 1.5ex minus 0.375ex ,
glue. / chap-label .skip_gset:N           = \g_dez_bel_chap_label_skip ,
glue. / chap-label .initial:n             = 2ex plus 0.2ex minus 0.05ex ,
glue. / part-label .skip_gset:N           = \g_dez_bel_part_label_skip ,
glue. / part-label .initial:n             = 10ex,
glue' / section .skip_gset:N              = \g_dez_abv_section_skip ,
glue' / section .initial:n                = 8ex plus 2ex minus 0.5ex ,
glue. / section .skip_gset:N              = \g_dez_bel_section_skip ,
glue. / section .initial:n                = 4ex plus 1ex minus 0.25ex ,
glue' / subsec .skip_gset:N               = \g_dez_abv_subsec_skip ,
glue' / subsec .initial:n                 = 6ex plus 3ex minus 0.75ex ,
glue. / subsec .skip_gset:N               = \g_dez_bel_subsec_skip ,
glue. / subsec .initial:n                 = 3ex plus 0.75ex minus 0.375ex ,
glue' / subsubsec .skip_gset:N            = \g_dez_abv_subsubsec_skip ,
glue. / subsubsec .initial:n              = 2ex plus 0.2ex minus 0.05ex ,
glue. / subsubsec .skip_gset:N            = \g_dez_bel_subsubsec_skip ,
glue. / subsubsec .initial:n              = 2ex plus 0.2ex minus 0.05ex ,
glue' / nom-group .skip_gset:N            = \g_dez_abv_nomgroup_skip ,
glue' / nom-group .initial:n              = 2ex plus 0.2ex minus 0.05ex ,
glue' / paragraph .skip_gset:N            = \g_dez_abv_paragraph_skip ,
glue' / paragraph .initial:n              = 2ex plus 0.2ex minus 0.2ex ,
glue' / thm-like .skip_gset:N             = \g_dez_abv_thm_skip ,
glue' / thm-like .initial:n               = 3ex plus 0.375ex minus 0.1875ex ,
glue. / thm-like .skip_gset:N             = \g_dez_bel_thm_skip ,
glue. / thm-like .initial:n               = 3ex plus 0.375ex minus 0.1875ex ,
glue' / alg-like .skip_gset:N             = \g_dez_abv_alg_skip ,
glue' / alg-like .initial:n               = 3ex plus 0.375ex minus 0.1875ex ,
glue. / alg-like .skip_gset:N             = \g_dez_bel_alg_skip ,
glue. / alg-like .initial:n               = 3ex plus 0.375ex minus 0.1875ex ,
glue' / def-like .skip_gset:N             = \g_dez_abv_def_skip ,
glue' / def-like .initial:n               = 3ex plus 0.375ex minus 0.1875ex ,
glue. / def-like .skip_gset:N             = \g_dez_bel_def_skip ,
glue. / def-like .initial:n               = 3ex plus 0.375ex minus 0.1875ex ,
glue' / rem-like .skip_gset:N             = \g_dez_abv_remark_skip ,
glue' / rem-like .initial:n               = 2ex plus 0.5ex minus 0.125ex ,
glue. / rem-like .skip_gset:N             = \g_dez_bel_remark_skip ,
glue. / rem-like .initial:n               = 2ex plus 0.5ex minus 0.125ex ,
glue' / proof .skip_gset:N                = \g_dez_abv_proof_skip ,
glue' / proof .initial:n                  = 3ex plus 0.375ex minus 0.1875ex ,
glue. / proof .skip_gset:N                = \g_dez_bel_proof_skip ,
glue. / proof .initial:n                  = 3ex plus 0.375ex minus 0.1875ex ,
glue' / eqn .skip_gset:N                  = \g_dez_abv_eqn_skip ,
glue' / eqn .initial:n                    = 2ex plus 0.5ex minus 0.125ex ,
glue. / eqn .skip_gset:N                  = \g_dez_bel_eqn_skip ,
glue. / eqn .initial:n                    = 2ex plus 0.5ex minus 0.125ex ,
glue' / eqn-short .skip_gset:N            = \g_dez_abv_eqn_short_skip ,
glue' / eqn-short .initial:n              = 1ex plus 0.1ex minus 0.025ex ,
glue. / eqn-short .skip_gset:N            = \g_dez_bel_eqn_short_skip ,
glue. / eqn-short .initial:n              = 1ex plus 0.1ex minus 0.025ex ,
glue' / list .skip_gset:N                 = \g_dez_abv_list_skip ,
glue' / list .initial:n                   = 1ex plus 0.2ex minus 0.05ex ,
glue' / long-list .skip_gset:N            = \g_dez_abv_long_list_skip ,
glue' / long-list .initial:n              = 1ex plus 0.2ex minus 0.05ex ,
glue. / abstract-title .skip_gset:N       = \g_dez_bel_abstract_title_skip ,
glue. / abstract-title .initial:n         = 2.5ex ,
glue' / abstract-authors .skip_gset:N     = \g_dez_abv_abstract_author_skip ,
glue' / abstract-authors .initial:n       = 2.5ex ,
glue' / abstract-body .skip_gset:N        = \g_dez_abv_abstract_body_skip ,
glue' / abstract-body .initial:n          = 7.5ex ,
glue' / toc-part .skip_gset:N             = \g_dez_abv_toc_part_skip ,
glue' / toc-part .initial:n               = 0.6pc plus 0.06pc minus 0.015pc ,
glue' / toc-chapter .skip_gset:N          = \g_dez_abv_toc_chap_skip ,
glue' / toc-chapter .initial:n            = 0.3pc plus 0.03pc minus 0.0075pc ,
glue' / toc-section .skip_gset:N          = \g_dez_abv_toc_section_skip ,
glue' / toc-section .initial:n            = 0pc ,
glue' / toc-subsec .skip_gset:N           = \g_dez_abv_toc_subsec_skip ,
glue' / toc-subsec .initial:n             = 0pc ,
glue' / toc-subsubsec .skip_gset:N        = \g_dez_abv_toc_subsubsec_skip ,
glue' / toc-subsubsec .initial:n          = 0pc ,

}

\ProcessKeysOptions{dez}  % Process!


%==================================================================================================
%                    hooks for fancy users
%==================================================================================================

\ProvideDocumentCommand \DezPrePackagesHook {}
    {  }

\ProvideDocumentCommand \DezPostPackagesHook {}
    {  }

\ProvideDocumentCommand \DezPreTocLikeHook {}
    { }

\ProvideDocumentCommand \DezPreMainChapterHook {}
    { }

\ProvideDocumentCommand \DezPostMainChapterHook {}
    { }

\ProvideDocumentCommand \DezPreAppendixHook {}
    { }

\ProvideDocumentCommand \DezPostAppendixHook {}
    { }

% internal
\ProvideDocumentCommand \DezPartPageHook {}
    { \clearpage }
\ProvideDocumentCommand \DezChapterPageHook {}
    { \clearpage }

\cs_new_protected:Npn \dez__par_addvspace:N #1
{
    \skip_vertical:N #1
    % TODO
    %\par
    %\exp_args:Ne \addvspace { \skip_use:N #1 }
}


%==================================================================================================
%                    mode and preset support
%==================================================================================================


\cs_new_protected:Nn \dez_disable_number_within:
{
    \str_gset:Nn \g_dez_float_in_str {none}
    \str_gset:Nn \g_dez_eqn_in_str {none}
    \str_gset:Nn \g_dez_thm_in_str {none}
}

\cs_new_protected:Nn \dez_double_space:
{
    \fp_gset:Nn \g_dez_stretch_main_fp {2.0}
    \fp_gset:Nn \g_dez_stretch_toc_fp {2.0}
    \fp_gset:Nn \g_dez_stretch_lof_fp {2.0}
    \fp_gset:Nn \g_dez_stretch_abbrevs_fp {2.0}
    \fp_gset:Nn \g_dez_stretch_nom_tl {2.0}
    \fp_gset:Nn \g_dez_stretch_caption_fp {1.2}
    %\skip_gset:Nn \g_dez_btw_fnotes_skip {\baselineskip}  % TODO: broken
}


\cs_new_protected:Nn \dez_thesis_like:
    {}

\cs_new_protected:Nn \dez_article_like:
{
    \RenewDocumentCommand \DezChapterPageHook {}
    \dez_disable_number_within:
    \str_gset:Nn \g_dez_n_front_str {arabic}
    % put left so it's easy to override
    \tl_gput_left:Nn \g_dez_geometry_tl {twocolumn,}
    % we'll also convert \Chapter into \Section (later)
}

\cs_new_protected:Nn \dez_book_like:
{
    \tl_gput_left:Nn \g_dez_geometry_tl {twoside, openright,}
}

\cs_new_protected:Nn \dez_be_american:
{
    \DezAtEnd { \sisetup {group-separator = {,}} }
}


% A4     = 21.00 x 29.70 cm
% letter = 21.59 x 27.94 cm
\tl_const:Nn \dez_afour_geometry_tl
{
    a4paper ,
    vmargin      = 2.5cm ,
    hmargin      = 3cm ,
    headheight   = 1cm ,
}

\tl_const:Nn \dez_letter_geometry_tl
{
    letterpaper ,
    vmargin      = 1.25in ,
    hmargin      = 1.5in ,
    headheight   = 0.5in ,
}



%==================================================================================================
%                    presets
%==================================================================================================

% A4 paper size with 2cm left/right margin and 3cm top/bottom
\NewDocumentCommand \AFour {}
{
    \tl_gset:NV \g_dez_geometry_tl \dez_afour_geometry_tl
}


% letterpaper (8.5x11") paper with 1.5in left/right and 1in top/bottom
\NewDocumentCommand \LetterPaper {}
{
    \tl_gset:Nv \g_dez_geometry_tl {\dez_letter_geometry_tl}
}

% These may eventually be removed

\NewDocumentCommand \Ucsf {}
{
    \tl_gset:Nn \g_dez_mode_str {thesis}
    \tl_gput_left:Nn \g_dez_geometry_tl { letterpaper, margin=1in, footskip=0.5in, }
    \dez_double_space:
    \dez_be_american:
}

% CMU has requirements for footnotes that I doubt I'm handling correctly
\NewDocumentCommand \Cmu {}
{
    \tl_gset:Nn \g_dez_mode_str {thesis}
    \tl_gput_left:Nn \g_dez_geometry_tl { letterpaper, margin=1in, footskip=0.25in, }
    \str_gset:Nn \g_dez_fnote_place_str {bottomfloats}
    \str_gset:Nn \g_dez_n_fnotes_str {arabic}
    \dez_disable_number_within:
    \dez_double_space:
    \dez_be_american:
}

% Stanford wants 2-sided for binding
\NewDocumentCommand \Stanford {}
{
    \tl_gset:Nn \g_dez_mode_str {thesis}
    \tl_gput_left:Nn \g_dez_geometry_tl
    {
        letterpaper, twoside,
        top=1in, bottom=1in, outer=1.5in, inner=1in, footskip=0.5in,
    }
    \bool_gset:Nn \g_dez_stretch_main_tl {1.5}
    \dez_be_american:
}

% Cambridge's choices aren't completely clear
\NewDocumentCommand \Cambridge {}
{
    \tl_gset:Nn \g_dez_mode_str {thesis}
    \tl_gput_left:Nn \g_dez_geometry_tl
        { a4paper, top=2cm, bottom=2cm, inner=3cm, outer=2cm, footskip=1cm, }
    \str_gset:Nn \g_dez_n_front_str {arabic}
}

\cs_if_exist_use:cF { \g_dez_preset_str }
    { \dez__warn_nosuchpreset:V \g_dez_preset_str }


\str_const:Nn \c_dez_article_str {article}
\str_const:Nn \c_dez_thesis_str {thesis}
\str_const:Nn \c_dez_book_str {book}
\tl_case:Nn \g_dez_mode_str
{
    \c_dez_article_str {\dez_article_like:}
    \c_dez_thesis_str {\dez_thesis_like:}
    \c_dez_book_str {\dez_book_like:}
}



%==================================================================================================
%                    some options
%==================================================================================================

\bool_if:NT \g_dez_draft_bool                   { \@PP {draft=true}             {microtype}  }
\bool_if:NT \g_dez_toc_panels_bool              { \@PP {list}                   {subcaption} }
\bool_if:NF \g_dez_cref_abbrev_bool             { \@PP {noabbrev}               {cleveref}   }
\bool_if:NT \g_dez_cref_capitalize_bool         { \@PP {capitalize}             {cleveref}   }
\dez_if_feat_enabled:nT {ulem}                  { \@PP {markup}                 {textiles}   }
\str_if_eq:VnF \g_dez_fnote_align_str {left}    { \@PP {ragged}                 {footmisc}   }
\str_if_eq:VnF \g_dez_fnote_place_str {default}  % for compatibility
                                                { \@PP {\g_dez_fnote_place_str} {footmisc}   }



%==================================================================================================
%                    load packages
%==================================================================================================

% Run our friendly hook:
\DezPrePackagesHook

% language via pidgin
% pidgin uses babel, tracklang, and translations
% we use it to load cleveref etc. at the end
\@RP {pidgin}
\pidgin_set_langs:e { \g_dez_langs_str }
\pidgin_start:

% layout control:
\@RP {fancyvrb}                    % _verbatim_ , etc.
\@RP [newcommands] {ragged2e}      % full ragged environments; before: footmisc
\@RP {newfloat}                    % declare new float environments
\@RP {geometry}                    % \geometry
\@RP {adjustbox}                   % resize boxes
\@RP {perpage}                     % reset a counter every page
\@RP {datetime2}                   % format dates and times (after: babel)

% xindy and hyperref
\@LF [xindy] {imakeidx}            % index; before: knowledge
\@RP {hyperxmp}
\@RP {hyperref}                    % AFTER xindy

% font control and math
\@PP {babel=true} {microtype}
\@RP [faces] {textiles}
%\@RP {glue}
\@RP {mathcommand}                 % prime, subscript, preserving commands
\@RP {info}                        % requires textiles
\@RP {amsthm}                      % theorem-like environments
\@RP {thmtools}                    % \declaretheorem
\@RP {mathtools}                   % better theorem-like environments
\@RP {lualatex-math}               % math-related patches
\@RP {uspace}                      % give correct meanings to Unicode space chars
\@RP {fnpct}                       % move footnote marks

% acro, index, nomenclature, etc.
\@RP [backend=biber] {biblatex}    % BibLaTeX! after: hyperref
\@RP {accsupp}                     % before: acro
\@RP {acro}                        % for all abbreviations
\@RP {noms}                        % nomenclature groups and utils

% layout & spacing
\@RP [explicit] {titlesec}         % to format headers; explicit: use #1
\@RP {titletoc}                    % to format TOC
\@RP [titles] {tocloft}            % prevent loading without titles
\@RP {tarmac}
\@RP {fancyhdr}                    % footer and header
\@RP {enumitem}                    % control spacing for lists
\@RP {footmisc}                    % footnote styling and counters
\@RP {enotez}                      % fixed endnotes
%\@RP {lua-widow-control}
\bool_if:NT \g_dez_draft_bool
    { \@RP {showframe} }


% graphics
\@RP [hypcap=true] {caption}       % needed for formatting; use hypcap option
\@RP [hypcap=true] {subcaption}    % successor to subfig; use hypcap option
\@RP {graphicx}                    % for, well, everything

% tables
\@RP {csvsimple-l3}                % load CSV data
\@RP {tabularx}                    % For specialized environments only
\@RP {tabularray}                  % LaTeX3 tabular and table replacement
\let \@TL \UseTblrLibrary
\@TL {babel}
\@TL {amsmath}                     % (amsmath loaded earlier)
\@TL {counter}                     % get row and col counters
\@TL {booktabs}                    % \toprule, etc. and envs
\@TL {siunitx}                     % (siunitx loaded earlier)
\@TL {diagbox}                     % split desc for top-left cell
\@TL {varwidth}                    % can measure table dims if cells have pars

% typography
\@RP {fvextra}                     % only needed to avoid warning in csquotes
\@RP {csquotes}                    % quote environments [before: others?]
\@RP {ellipsis}                    % no added space with \ldots in text mode
\@RP {semantic}                    % academic links, etc.
\@RP {siunitx}                     % pretty units

% optional features
\@LF [newfloat] {minted}
\@LF [xparse] {tcolorbox}
\@LF {cryptocode}
\@LF {chemmacros}
\@LF {chemformula}
\@LF {chemfig}
\@LF {svg}
\@LF {awesomebox}  % also loads fontawesome5

\dez_if_feat_enabled:nT {tikz}
{
    % core
    \@RP      { tikz }
    \@TZ      { babel, fpu, calc, external, }
    \DezAtEnd {\tikzexternalize}
    % basic
    \@TZ     { scopes, backgrounds, positioning, intersections, through, chains, matrix, fit, }
    % shapes and arrows
    \@PG     { shapes.geometric, arrows, }
    \@TZ     { decorations.markings, decorations.pathmorphing, decorations.pathreplacing, }
    % specific
    \@RP     { tikz-cd }
    %  graphs
    \dez_if_feat_enabled:nT {graphs}
    {
        \@TZ { graphs, graphdrawing, }
        \@GD { force, layered, circular, routing, }
    }
}



%==================================================================================================
%                          finalize things
%==================================================================================================

\@LF {varioref}
\@LF [ no~patch, electronic ] {knowledge}
% Load cleveref via pidgin
\pidgin_close:

% it's utterly weird that these can be different
% report and book use bibname, while article uses refname
\let \bibname \refname

% Run our friendly hook:
\DezPostPackagesHook

% Send our dez options to textiles!
% The colors are saved to both xcolor and l3color.
%\prop_log:N \g_dez_color_prop
%\textiles_declare_colors_from_prop:N \g_dez_color_prop
\textiles_declare_multiple_from_prop:N \g_dez_style_prop
\prop_map_inline:Nn \g_dez_color_prop
{
    \colorlet {#1} {#2}
}

\tl_gset:Nx  \g_dez_stretch_main_tl      { \fp_use:N \g_dez_stretch_main_fp }
\tl_gset:Nx  \g_dez_stretch_eqn_tl       { \fp_use:N \g_dez_stretch_eqn_fp }
\tl_gset:Nx  \g_dez_stretch_toc_tl       { \fp_use:N \g_dez_stretch_toc_fp }
\tl_gset:Nx  \g_dez_stretch_lof_tl       { \fp_use:N \g_dez_stretch_lof_fp }
\tl_gset:Nx  \g_dez_stretch_abbrevs_tl   { \fp_use:N \g_dez_stretch_abbrevs_fp }
\tl_gset:Nx  \g_dez_stretch_nom_tl       { \fp_use:N \g_dez_stretch_nom_fp }
\tl_gset:Nx  \g_dez_stretch_code_tl      { \fp_use:N \g_dez_stretch_code_fp }
\tl_gset:Nx  \g_dez_stretch_caption_tl   { \fp_use:N \g_dez_stretch_caption_fp }



% Some skips always appear with paragraph skips,
% so we'll subtract those paragraph skips.
% It's unclear why this is needed: Tex should be 'adding' vspace with max{last, next}
\skip_gsub:NV \g_dez_bel_abstract_title_skip   \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_abstract_author_skip  \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_abstract_body_skip    \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_section_skip          \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_section_skip          \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_subsec_skip           \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_subsec_skip           \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_subsubsec_skip        \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_subsubsec_skip        \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_paragraph_skip        \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_front_chap_skip       \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_chap_skip             \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_thm_skip              \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_thm_skip              \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_alg_skip              \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_alg_skip              \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_def_skip              \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_def_skip              \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_remark_skip           \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_bel_remark_skip           \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_list_skip             \g_dez_btw_paragraphs_skip
\skip_gsub:NV \g_dez_abv_long_list_skip        \g_dez_btw_paragraphs_skip




%==================================================================================================
%                          fonts and tarmac
%==================================================================================================

% Latin modern fonts should always be present
\UseLatinModern

% Set the depth of the Table of Contents and section numbering.

\tarmac_set_depth:nV {secnumdepth} \g_dez_n_depth_str
\tarmac_set_depth:nV {tocdepth} \g_dez_toc_depth_str

% Note \SetTexParams from tarmac

\bool_if:NT \g_dez_typo_ban_hyphens_bool
    { \BanHyphens }

\exp_args:Ne \geometry {\g_dez_geometry_tl}

\tarmac_set:e
{
    font             =             \g_dez_font_size_tl  ,
    leading          =             \g_dez_font_leading_tl ,
    leading-ratio    =             1.2 ,
    stretch          =             \g_dez_stretch_main_tl  ,
    dm-stretch       =             \g_dez_stretch_eqn_tl  ,
    parskip          = \skip_use:N \g_dez_btw_paragraphs_skip  ,
    indent           = \dim_use:N  \g_dez_indent_dim  ,
    above-dm         = \skip_use:N \g_dez_abv_eqn_skip  ,
    below-dm         = \skip_use:N \g_dez_bel_eqn_skip  ,
    above-short-dm   = \skip_use:N \g_dez_abv_eqn_short_skip  ,
    below-short-dm   = \skip_use:N \g_dez_bel_eqn_short_skip  ,
}

% Our everyday lists and enums, where items are ==1 paragraph at most
\exp_args:Ne
\setlist
{
    itemsep     = {\skip_use:N \g_dez_btw_items_skip} ,
    topsep      = \g_dez_abv_list_skip ,
    partopsep   = 0ex ,
    parsep      = {\skip_use:N \g_dez_btw_paragraphs_skip} ,
}

% Enums where individual items may span multiple paragraphs.
\exp_args:Nne
\SetEnumitemKey {long}
{
    itemsep     = {\skip_use:N \g_dez_btw_multipar_items_skip} ,
    topsep      = {\skip_use:N \g_dez_abv_long_list_skip} ,
    partopsep   = 0ex ,
    parsep      = {\skip_use:N \g_dez_btw_paragraphs_skip} ,
}

% https://tex.stackexchange.com/questions/95838/how-to-write-a-perfect-equation-parameters-description
\NewDocumentEnvironment {where} { m }
    {
      \tabularx { \textwidth } [t]
          { >{$}l<{$} @{${}={}$} X@{} }
    }
    { \endtabularx }


% Set nomenclature spacing
\cs_new:Npn \dez__nomgroup_header:n #1
{
    \textiles_use:nn {nom-group} {#1}
}
\NomsSetup
{
    header-skip   = \g_dez_abv_nomgroup_skip ,
    header-format = dez__nomgroup_header:n ,
}
\def \nomlabelwidth {\dim_use:N \g_dez_nom_symbol_dim}
\setlength \nomitemsep {0ex}



%==================================================================================================
%                           section titles
%==================================================================================================

\titleformat { name=\part } [block]
    { \filcenter }
    {
        \textiles_run_nullary:n {part-label}
        \pidgin_string:n{part} ~ \thepart
        \dez__par_addvspace:N \g_dez_bel_part_label_skip
    }
    { 0pt }
    { \textiles_run_nullary:n{part-name} #1 }

\titleformat { name=\part, numberless } [display]
    { \filcenter }
    { }
    { 0pt }
    { \textiles_run_nullary:n{part-name} #1 }

\titleformat { name=\chapter } [block]
    { } % code before
    {   % code for label
        \textiles_run_nullary:n{chap-label}
        \chaptertitlename\ \thechapter
        \dez__par_addvspace:N \g_dez_bel_chap_label_skip
    }  %(TODO: \g_dez_bel_chap_label_skip doesn't work below?
    { 0pt }  % space between label and name
    { \textiles_run_nullary:n{chap-name} #1 }  % code for name

\titleformat { name=\chapter, numberless } [display]
    { \filcenter }
    { }
    { 0pt }
    { \textiles_run_nullary:n{front-chap-title} #1 }

\titleformat {\section} [hang]
    { }
    { \textiles_run_nullary:n{section-title} \thetitle }
    { 1em }
    { \textiles_run_nullary:n{section-title} #1 }

\titleformat {\subsection} [hang]
    { }
    { \textiles_run_nullary:n{subsec-title} \thetitle }
    { 1em }
    { \textiles_run_nullary:n{subsec-title} #1 }

\titleformat {\subsubsection} [hang]
    { }
    { \textiles_run_nullary:n{subsubsec-title} \thetitle }
    { 1em }
    { \textiles_run_nullary:n{subsubsec-title} #1 }

\titleformat {\paragraph} [runin]
    { }
    { \textiles_run_nullary:n{paragraph-title} \thetitle }
    { 1em }
    { \textiles_run_nullary:n{paragraph-title} #1. }

\titleformat {\subparagraph} [runin]
    { }
    { \textiles_run_nullary_inline:n{italic} \thetitle }
    { 1em }
    { \textiles_run_nullary_inline:n{italic} #1. }

\titlespacing { name=\chapter }
    { 0pt }                                     % left space
    { \skip_use:N \g_dez_abv_chap_skip }  % top space
    { \skip_use:N \g_dez_bel_chap_skip }  % bottom space

%\skip_gsub:Nn \g_dez_abv_front_chap_skip {6ex}

%\exp_args:Nnnee
\titlespacing { name=\chapter, numberless }
    { 0pt }
    { \skip_use:N \g_dez_abv_front_chap_skip }
    { \skip_use:N \g_dez_bel_front_chap_skip }

%\exp_args:Nnnee
\titlespacing {\section}
    { 0pt }
    { \skip_use:N \g_dez_abv_section_skip }
    { \skip_use:N \g_dez_bel_section_skip }

%\exp_args:Nnnee
\titlespacing {\subsection}
    { 0pt }
    { \skip_use:N \g_dez_abv_subsec_skip }
    { \skip_use:N \g_dez_bel_subsec_skip }

%\exp_args:Nnnee
\titlespacing {\subsubsection}
    { 0pt }
    { \skip_use:N \g_dez_abv_subsubsec_skip }
    { \skip_use:N \g_dez_bel_subsubsec_skip }

%\exp_args:Nnnee
\titlespacing {\paragraph}
    { 0pt }
    { \skip_use:N \g_dez_abv_paragraph_skip }
    { 1em }

%\exp_args:Nnnee
\titlespacing {\subparagraph}  % not supported, but choose something reasonable
    { 2em }
    { \skip_use:N \g_dez_abv_paragraph_skip }
    { 1em }




%==================================================================================================
%                           TOC formatting
%==================================================================================================

\titlecontents {part}
    [ \g_dez_toc_part_dim ]                     % margin from left side
    {   % code before
        \dez__par_addvspace:N \g_dez_abv_toc_part_skip
        \textiles_run_nullary:n {toc-part}
    }
    {                                              % code for label if numbered
        \contentslabel
            [
                \hyperlink
                    { part.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_dez_toc_part_dim}               % how big the label box is
    }
    { \hspace*{-\g_dez_toc_part_dim} }          % code if unnumbered (subtract the box)
    {                                              % code for page number
        \textiles_run_nullary:n {toc-page-num}
        \titlerule*[1pc]{.} \contentspage
    }

\titlecontents {chapter}
    [ \dim_eval:n { \g_dez_toc_part_dim + \g_dez_toc_chap_dim } ]
    {   % code before
        \dez__par_addvspace:N \g_dez_abv_toc_chap_skip
        \textiles_run_nullary:n {toc-chap}
    }
    {
        \contentslabel
            [
                \hyperlink
                    { chapter.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_dez_toc_chap_dim}
    }
    { \hspace*{-\g_dez_toc_chap_dim} }
    {
        \textiles_run_nullary:n {toc-page-num}
        \titlerule*[1pc]{.} \contentspage
    }

% The rest are all the same

\titlecontents {section}
    [
        \dim_eval:n
        {
             \g_dez_toc_part_dim
            +\g_dez_toc_chap_dim
            +\g_dez_toc_section_dim
        }
    ]
    {   % code before
        \addvspace {\g_dez_abv_toc_section_skip}
        \textiles_run_nullary:n {toc-section}
    }
    {
        \contentslabel
            [
                \hyperlink
                    { section.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_dez_toc_section_dim}
    }
    { \hspace*{-\g_dez_toc_section_dim} }
    {
        \textiles_run_nullary:n {toc-page-num}
        \titlerule*[1pc]{.} \contentspage
    }

\titlecontents {subsection}
    [
        \dim_eval:n
        {
             \g_dez_toc_part_dim
            +\g_dez_toc_chap_dim
            +\g_dez_toc_section_dim
            +\g_dez_toc_subsec_dim
        }
    ]
    {   % code before
        \dez__par_addvspace:N \g_dez_abv_toc_subsec_skip
        \textiles_run_nullary:n {toc-subsec}
    }
    {
        \contentslabel
            [
                \hyperlink
                    { subsection.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_dez_toc_subsec_dim}
    }
    { \hspace*{-g_dez_toc_subsec_dim} }
    {
        \textiles_run_nullary:n {toc-page-num}
        \titlerule*[1pc]{.} \contentspage
    }

\titlecontents {subsubsection}
    [
        \dim_eval:n
        {
             \g_dez_toc_part_dim
            +\g_dez_toc_chap_dim
            +\g_dez_toc_subsec_dim
            +\g_dez_toc_subsubsec_dim
        }
    ]
    {   % code before
        \dez__par_addvspace:N \g_dez_abv_toc_subsubsec_skip
        \textiles_run_nullary:n {toc-subsubsec}
    }
    {
        \contentslabel
            [
                \hyperlink
                    { subsubsection.\thecontentslabel }
                    { \thecontentslabel }
            ]
            {\g_dez_toc_subsubsec_dim}
    }
    { \hspace*{-\g_dez_toc_subsubsec_dim} }
    {
        \textiles_run_nullary:n {toc-page-num}
        \titlerule*[1pc]{.} \contentspage
    }




%==================================================================================================
%               header & footer
%==================================================================================================

\renewcommand* \headrulewidth {0em}  % not professional

\cs_new_protected:Npn \dez__set_fancy_page:VVVVVV #1#2#3#4#5#6
{
    \fancyhead {}
    \fancyhead [L] {#1}
    \fancyhead [C] {#2}
    \fancyhead [R] {#3}
    \fancyfoot {}
    \fancyfoot [L] {#4}
    \fancyfoot [C] {#5}
    \fancyfoot [R] {#6}
}

\dez__set_fancy_page:VVVVVV
    \g_dez_lay_header_left_tl 
    \g_dez_lay_header_center_tl
    \g_dez_lay_header_right_tl
    \g_dez_lay_footer_left_tl 
    \g_dez_lay_footer_center_tl
    \g_dez_lay_footer_right_tl

\fancypagestyle {plain} {}  % make plain be fancy
\pagestyle {plain}  % use plain
\assignpagestyle \chapter {plain}




%==================================================================================================
%                           basic numbering
%==================================================================================================

\cs_new_protected:Npn \dez__number_within:nV #1#2
    { \numberwithin {#1} {#2} }

% provided by amsmath -- but works on all numbered environments
\str_if_eq:VnF \g_dez_float_in_str {none}
{
    \dez__number_within:nV {figure} \g_dez_float_in_str
    \dez__number_within:nV {table}  \g_dez_float_in_str
}
\str_if_eq:VnF \g_dez_eqn_in_str {none}
{
    \dez__number_within:nV {equation} \g_dez_eqn_in_str
}



%==================================================================================================
%                       footnote numbering and format
%==================================================================================================

\str_if_eq:VnT \g_dez_fnote_in_str {page}
    { \MakePerPage [2] {footnote} }  % otherwise we'll set in \Chapter


\seq_const_from_clist:Nn \c__dez_numeric_fnotes_clist
    { arabic, alph, Alph, roman, Roman }
    
\seq_if_in:NVTF \c__dez_numeric_fnotes_clist \g_dez_n_fnotes_str
    { \declarecommand \multfootsep {,} }           % e.g. 12,13
    { \declarecommand \multfootsep {\thinspace} }  % because some symbols are doubled


\seq_const_from_clist:Nn \g__dez_footsymbols_seq
    {lamport, lamport*, bringhurst, chicago, wiley }  % i.e. not arabic, roman, etc.

\cs_new_protected:Npn \dez__fnote_num:N #1
{
    \renewcommand \thefootnote {#1{footnote}}
    \renewcommand \thempfootnote {#1{mpfootnote}}
}

\seq_if_in:NVTF \g__dez_footsymbols_seq \g_dez_n_fnotes_str
{
    % if it's a symbol style, we change symbols, then use \fnsymbol
    \setfnsymbol {\g_dez_n_fnotes_str}
    \dez__fnote_num:N \fnsymbol
}
{
    \exp_args:Nc
        \dez__fnote_num:N
        \g_dez_n_fnotes_str
}

% TODO: I don't understand this
\setlength {\skip\footins} {\g_dez_abv_fnote_list_skip}

\setlength \footnotesep {\g_dez_btw_fnotes_skip}

% apply the footnote body format
\renewcommand* \footnotelayout
    { \textiles_run_nullary:n {fnote-body} }




%==================================================================================================
%                 endnotes
%==================================================================================================

\setenotez {reset=true}
\AtEndPreamble
    { \setenotez { list-name = \pidgin_string:n{listendnote} } }

\bool_if:NT \g_dez_endnote_backrefs_bool  % needs 2022+ !
    { \setenotez {backref=true} }

\bool_if:NT \g_dez_toc_endnotes_bool
    { \setenotez {totoc=section*} }

% We'll use these in \StartMainMatter if forcing endnotes
% written as commands for the user's convenience

\NewDocumentCommand \FootnotesAsEndnotes {}
{
    \let \truefootnote     \footnote
    \let \truefootnotemark \footnotemark
    \let \truefootnotetext \footnotetext
    \let \footnote         \endnote
    \let \footnotemark     \endnotemark
    \let \footnotetext     \endnotetext
}

\NewDocumentCommand \FootnotesAsFootnotes {}
{
    \cs_if_exist:NT \truefootnote
    {
        \let \footnote     \truefootnote
        \let \footnotemark \truefootnotemark
        \let \endnotetext  \truefootnotetext
    }
}



%==================================================================================================
%             equation labels
%==================================================================================================

\newtagform {none}                   {}    {}
\newtagform {round}                  {(}   {)}
\newtagform {square}                 {[}   {]}
\newtagform {curly}                  {\{}  {\}}
\newtagform {none-bold}   [\textbf]  {}    {}
\newtagform {round-bold}  [\textbf]  {(}   {)}
\newtagform {square-bold} [\textbf]  {[}   {]}
\newtagform {curly-bold}  [\textbf]  {\{}  {\}}

\exp_args:NV
    \usetagform \g_dez_n_brackets_str




%==================================================================================================
%                        bibliography
%==================================================================================================

% don't show the language for every reference
\bool_if:NT \g_dez_bib_hide_lang_bool
    { \AtEveryBibitem { \clearlist {language} } }

% Reference the title, date, journal, and authors
% Could alternatively use \DeclareCiteCommand
\NewDocumentCommand \chaptersource {m}
{
    \AtNextCite { \defcounter {maxnames} {60} }
    \fullcite{#1}
}

\NewDocumentCommand \reftitle {m}
    { `` \citefield {#1} {title} " }
    
\NewDocumentCommand \refdoi {m}
    { \doi { \citefield {#1} {doi} } }
    
\NewDocumentCommand \refurl {m}
    { \link { \citefield {#1} {url} } }





%==================================================================================================
%                     sections with labels
%==================================================================================================

\keys_define:nn { dez / section-like }
{
    title .tl_set:N          = \l__title_tl ,
    title .initial:n         = {} ,
    no-title .bool_set:N     = \l__no_title_bool,  % overrides any title
    no-title .default:n      = true ,
    no-title .initial:n      = false ,
    entry .tl_set:N          = \l__entry_tl ,
    entry .initial:n         = * ,
    no-entry .bool_set:N     = \l__no_entry_bool,  % overrides any entry
    no-entry .default:n      = true ,
    no-entry .initial:n      = false ,
    label .tl_set:N          = \l__label_tl ,
    label .initial:n         = * ,
    numberless .bool_set:N   = \l__numberless_bool ,
    numberless .default:n    = true ,
    numberless .initial:n    = false ,
    numbered .code:n         = { \bool_set_false:N \l__numberless_bool } ,
    hide-links .bool_set:N   = \l__hide_links_bool ,
    hide-links .default:n    = true ,
    hide-links .initial:n    = false ,
}

\cs_new:Npn \dez__run_star:NV #1#2
    { #1*{#2} }

\cs_new:Npn \dez__run_starless:NV #1#2
    { #1{#2} }

\cs_new_protected:Npn \dez__run_section_like:NN #1#2
{
    \tl_set:Nx \l__level_tl {\cs_to_str:N #1}
    % Set entry to title
    \tl_if_eq:NnT \l__entry_tl {*}
        { \tl_set_eq:NN \l__entry_tl \l__title_tl }
    % Set the label to entry (preferred) or title
    \tl_if_eq:NnT \l__label_tl {*}
    {
        \tl_if_blank:VF \l__title_tl
            { \tl_set_eq:NN \l__label_tl \l__title_tl }
        \tl_if_blank:VF \l__entry_tl
            { \tl_set_eq:NN \l__label_tl \l__entry_tl }
    }
    % Clear title or entry if requested
    \bool_if:NT \l__no_title_bool
        { \tl_clear:N \l__title_tl }
    \bool_if:NT \l__no_entry_bool
        { \tl_clear:N \l__entry_tl }
    % okay, let's go:
    \tl_if_blank:VTF \l__title_tl
    {   % Method A: PHANTOM \section
        #2 \phantomsection
        \bool_if:NF \l__numberless_bool
            { \addtocounter {\l__level_tl} }
        \tl_if_blank:VF \l__entry_tl
            { \addcontentsline {toc} {\l__level_tl} {\l__entry_tl} }
    }
    {   % or Method B: REAL \section
        \bool_if:NTF \l__numberless_bool
            {
                \dez__run_star:NV #1 \l__title_tl
                \tl_if_blank:VF \l__entry_tl
                    { \addcontentsline {toc} {\l__level_tl} {\l__entry_tl} }
            }
            { \dez__run_starless:NV #1 \l__title_tl }
    }
    
    \tl_if_blank:VF \l__label_tl
        { \label {\l__label_tl} }
    \bool_if:NT \l__hide_links_bool
        { \hypersetup {hidelinks} }
}

\cs_new_protected:Npn \dez__set_section_like:nnnn #1#2#3#4
{
    \keys_set:nn {dez / section-like} {#3}
    \bool_if:NF \l__numberless_bool
        { \bool_set:Nn \l__numberless_bool {#2} }
    % Process displayed title
    \tl_if_blank:VT \l__title_tl
        { \tl_set:Nn \l__title_tl {#4} }
    % The rest goes in run_section_like
}

\cs_new_protected:Npn \dez__section_like:nnnnNN #1#2#3#4#5#6
{
    \group_begin:
    \dez__set_section_like:nnnn {#1} {#2} {#3} {#4}
    \dez__run_section_like:NN #5 #6
    \group_end:
}

\NewDocumentCommand \Part { s O{} G{} }
{
    \dez__section_like:nnnnNN
        {part} {#1} {#2} {#3} \part \DezPartPageHook
}

\NewDocumentCommand \Chapter { s O{} G{} }
{
    \str_if_eq:VnT \g_dez_fnote_in_str {chapter}
        { \setcounter {footnote} {0} }
    \dez__section_like:nnnnNN
        {chapter} {#1} {#2} {#3} \chapter \DezChapterPageHook
}

\NewDocumentCommand \Section { s O{} G{} }
{
    \dez__section_like:nnnnNN
        {section} {#1} {#2} {#3} \section \prg_do_nothing:
}

\NewDocumentCommand \SubSection { s O{} G{} }
{
    \dez__section_like:nnnnNN
        {subsection} {#1} {#2} {#3} \subsection \prg_do_nothing:
}
    
\NewDocumentCommand \SubSubSection { s O{} G{} }
{
    \dez__section_like:nnnnNN
        {subsubsection} {#1} {#2} {#3} \subsubsection \prg_do_nothing:
}

\NewDocumentCommand \Paragraph { s O{} G{} }
{
    \dez__section_like:nnnnNN
        {paragraph} {#1} {#2} {#3} \paragraph \prg_do_nothing:
}

\NewDocumentCommand \SubParagraph { s O{} G{} }
{
    \dez__section_like:nnnnNN
        {subparagraph} {#1} {#2} {#3} \subparagraph \prg_do_nothing:
}




%==================================================================================================
%                  alignment commands and environments
%==================================================================================================

% like the other ragged2e commands
\let \Justifying \justifying

\NewDocumentEnvironment {Justify} {}
    { \begin {justify} }
    { \end {justify} }

\prop_const_from_keyval:Nn \c_dez__align_to_cmd_prop
{
    left         = RaggedRight ,
    Left         = RaggedRight ,
    flushleft    = RaggedRight ,
    FlushLeft    = RaggedRight ,
    raggedright  = RaggedRight ,
    RaggedRight  = RaggedRight ,
    right        = RaggedLeft ,
    Right        = RaggedLeft ,
    flushright   = RaggedLeft ,
    FlushRight   = RaggedLeft ,
    raggedleft   = RaggedLeft ,
    RaggedLeft   = RaggedLeft ,
    center       = Centering ,
    Center       = Centering ,
    centering    = Centering ,
    Centering    = Centering ,
    centered     = Centering ,
    Centered     = Centering ,
    justify      = justifying ,
    Justify      = justifying ,
    justifying   = justifying ,
    Justifying   = justifying ,
    justified    = justifying ,
    Justified    = justifying ,
}

\prop_const_from_keyval:Nn \c_dez__align_to_env_prop
{
    flushleft     = FlushLeft ,
    FlushLeft     = FlushLeft ,
    left          = FlushLeft ,
    Left          = FlushLeft ,
    raggedright   = FlushLeft ,
    RaggedRight   = FlushLeft ,
    right         = FlushRight ,
    Right         = FlushRight ,
    flushright    = FlushRight ,
    raggedleft    = FlushRight ,
    RaggedLeft    = FlushRight ,
    FlushRight    = FlushRight ,
    center        = Center ,
    Center        = Center ,
    centering     = Center ,
    Centering     = Center ,
    centered      = Center ,
    Centered      = Center ,
    justify       = justify ,
    Justify       = Justify ,
    justifying    = justify ,
    Justifying    = justify ,
    justified     = justify ,
    Justified     = justify ,
}

\cs_new:Npn \dez_align:n #1
{
    \prop_get:NnN \c_dez__align_to_cmd_prop {#1} \l_tmpa_tl
    \cs_if_exist_use:N \l_tmpb_str
}
\cs_generate_variant:Nn \dez_align:n { V }

\cs_new:Npn \dez__align_begin:n #1
{
    \prop_get:NnN \c_dez__align_to_env_prop {#1} \l_tmpa_tl
    \exp_args:NV \begin \l_tmpa_tl
}
\cs_generate_variant:Nn \dez__align_begin:n { V }

\cs_new:Npn \dez__align_end:n #1
{
    \prop_get:NnN \c_dez__align_to_env_prop {#1} \l_tmpa_tl
    \exp_args:NV \end \l_tmpa_tl
}
\cs_generate_variant:Nn \dez__align_end:n { V }

\NewDocumentCommand \Aligning { m }
    { \dez_align:n {#1} }

\NewDocumentEnvironment {Align} { m }
    { \dez__align_begin:n {#1} }
    { \dez__align_end:n {#1} }



%==================================================================================================
%                         SpecialBox
%==================================================================================================

\keys_define:nn { dez / special-box }
{
    width .dim_set:N         = \l__width_dim ,
    width .initial:n         = {\textwidth} ,
    above .dim_set:N         = \l__above_dim ,
    above .initial:n         = 0pc ,
    below .dim_set:N         = \l__below_dim ,
    below .initial:n         = 0pc ,
    hide-links .bool_set:N   = \l__hide_links_bool ,
    hide-links .default:n    = true ,
    hide-links .initial:n    = false ,
    textile .tl_set:N        = \l__textile_tl ,
    textile .default:n       = {} ,
    style .tl_set:N          = \l__style_tl ,
    style .initial:n         = {} ,
    align .choices:nn        = { left, center, right, justify }
                               { \tl_set_eq:NN \l__align_tl \l_keys_choice_tl } ,
    align .initial:n         = center ,
    at .choices:nn           = { top, bottom, middle }
                               { \tl_set_eq:NN \l__at_tl \l_keys_choice_tl } ,
    at .initial:n            = middle ,
}


\NewDocumentEnvironment {InternalSpecialBox} { +b }
{
    \bool_if:NT \l__hide_links_bool
        { \hypersetup {hidelinks} }
    \tl_if_eq:NnF \l__align_tl {justify}
        { \hbadness=10000 }
    \dez_align:V \l__align_tl
    \tl_if_eq:NnTF \l__at_tl {top}
        { \skip_vertical:N \l__above_dim }
        { \vspace*{\fill} }
    \begin {minipage} {\l__width_dim}
    \dez__align_begin:V \l__align_tl
    \textiles_use_or_inline:VVn \l__textile_tl \l__style_tl {#1\par}
}
{
    \dez__align_end:V \l__align_tl
    \end {minipage}
    \tl_if_eq:NnTF \l__at_tl {bottom}
        { \skip_vertical:N \l__below_dim }
        { \vfill }
}

\NewDocumentEnvironment {SpecialBox} { O{} }
{
    \keys_set:nn {dez / special-box} {#1}
    \begin {InternalSpecialBox}
}
{
    \end {InternalSpecialBox}
}


%==================================================================================================
%                        front-matter chapters
%==================================================================================================

\NewDocumentEnvironment {FrontChapter} { O{} G{} }
{
    \bool_if:NT \g_dez_bib_per_chap_bool { \begin {refsection} }
    \Chapter* [numberless, #1] {#2}  % add numbered in #1
}
{
    \ShowEndNotes
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \ShowSubBib \end{refsection} }
    \acresetall
}

\keys_define:nn { dez / special-chapter }
{
    label .tl_set:N                = \l__label_tl ,
    label .initial:n               = * ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .initial:n               = * ,
    title .tl_set:N                = \l__title_tl ,
    title .initial:n               = {} ,
    no-title .bool_set:N           = \l__no_title_bool,
    no-title .default:n            = true ,
    no-title .initial:n            = false ,
    no-entry .bool_set:N           = \l__no_entry_bool,  % overrides any entry
    no-entry .default:n            = true ,
    no-entry .initial:n            = false ,
    numberless .bool_set:N         = \l__numberless_bool ,
    numberless .default:n          = true ,
    numberless .initial:n          = false ,
    numbered .code:n               = {\bool_set_false:N \l__numberless_bool} ,
    width .dim_set:N               = \l__width_dim ,
    width .initial:n               = {\textwidth} ,
    above .dim_set:N               = \l__above_dim ,
    above .initial:n               = 0pc ,
    below .dim_set:N               = \l__below_dim ,
    below .initial:n               = 0pc ,
    hide-links .bool_set:N         = \l__hide_links_bool ,
    hide-links .default:n          = true ,
    hide-links .initial:n          = false ,
    empty-page-style .bool_set:N   = \l__hide_header_and_footer_bool ,
    empty-page-style .default:n    = true ,
    empty-page-style .initial:n    = false ,
    textile .tl_set:N              = \l__textile_tl ,
    textile .default:n             = {} ,
    style .tl_set:N                = \l__style_tl ,
    style .initial:n               = {} ,
    align .choices:nn              = { left, center, right, justify }
                                     { \tl_set_eq:NN \l__align_tl \l_keys_choice_tl } ,
    align .initial:n               = center ,
    at .choices:nn                 = { top, bottom, middle }
                                     { \tl_set_eq:NN \l__at_tl \l_keys_choice_tl } ,
    at .initial:n                  = top ,
}


% Super-special chapters, normally centered
\NewDocumentEnvironment {SpecialChapter} { O{} G{} }
{
    \keys_set:nn {dez / special-chapter} {numberless, #1}  % add numbered in #1
    \tl_if_blank:VT \l__title_tl
        { \tl_set:Nn \l__title_tl {#2} }
    \str_if_eq:VnT \g_dez_fnote_in_str {chapter}
        { \setcounter {footnote} {0} }  % otherwise they'll continue from the last chapter
    \dez__run_section_like:NN \chapter \DezChapterPageHook
    \begin {InternalSpecialBox}
}
{
    \bool_if:NT \l__hide_header_and_footer_bool  % TODO
        { \clearpage \thispagestyle{empty} }
    \end {InternalSpecialBox}
    \ShowEndNotes  % really, these shouldn't be used
    %\bool_if:NT \l__hide_header_and_footer_bool  % TODO
    %    { \clearpage \pagestyle{empty} }
    \acresetall
}


\NewDocumentCommand \NewFrontChapter { m O{} O{} }
{
    % any title= will override G{#1}
    % e.g. \NewFrontMatter{Abstract}[title=Abstracto]
    \NewDocumentEnvironment {#1} { O{#3} G{#1} } 
        { \begin {FrontChapter} [#2, ##1] {##2} }
        { \end   {FrontChapter} }
}

\NewDocumentCommand \NewSpecialChapter { m O{} O{} }
{
    % any title= will override G{#1}
    % e.g. \NewSpecialChapter{Dedication}[title={}]
    \NewDocumentEnvironment {#1} { O{#3} G{#1} }
        { \begin {SpecialChapter} [#2, ##1] {##2} }
        { \end   {SpecialChapter} }
}

\NewFrontChapter   {Preface}           [ entry=Preface, ]
\NewFrontChapter   {Acknowledgments}   [ entry=Acknowledgments, ]
\NewFrontChapter   {Contributions}     [ entry=Contributions, ]
\NewFrontChapter   {Abstract}          [ entry=Abstract, no-title, numberless, ]
\NewSpecialChapter {Epigraph}          [ entry=Epigraph, no-title, at=middle, style=sans;large, ]
\NewSpecialChapter {Dedication}        [ entry=Dedication, no-title, at=middle,
                                         style=sans;large;italic, ]
\NewSpecialChapter {Copyright}         [ no-entry, no-title, at=middle, hide-links, ]
\NewSpecialChapter {Title}             [ no-entry, no-title, hide-links, empty-page-style, ]




%==================================================================================================
%                        abstract and title
%==================================================================================================

\NewDocumentCommand \AbstractHeader {}
{
    \begin {center}
    \GetTitle [ textile = abstract-title ]
    \dez__par_addvspace:N \g_dez_bel_abstract_title_skip
    \StyleTxt {abstract-by} {by}
    \dez__par_addvspace:N \g_dez_abv_abstract_author_skip
    \GetAuthors [ textile = abstract-authors ]
    \dez__par_addvspace:N \g_dez_abv_abstract_body_skip
    \end {center}
}

\NewDocumentCommand \TitleContents {}
{
    \GetTitle [style=largerr;bold] \par
    \addvspace{\bigskipamount}
    by \par
    \addvspace{\bigskipamount}
    \GetAuthors [style=largerr] \par
    \addvspace{1cm}
    \large Submitted~on~\getplaindate\ ~in~partial~fulfillment~of \par
    the~requirements~for~the~degree~of \par
    \addvspace{\bigskipamount}
    \Info{degree}~in~\getsubject \par
    \addvspace{1cm}
    \StyleParInline {mono,202020} { Replace~this~temporary~title~page. }
}

% EXAMPLE title page
\NewDocumentCommand \ShowTitle { O{} }
{
    \begin {Title} [#1]
    \TitleContents
    \end {Title}
}




%==================================================================================================
%                        main matter
%==================================================================================================


\NewDocumentCommand \StartChapter { O{} G{} }
{
    \DezPreMainChapterHook
    \bool_if:NT \g_dez_bib_per_chap_bool { \begin{refsection} }
    \Chapter [#1] {#2}
}

\NewDocumentCommand \EndChapter {}
{
    \ShowEndNotes
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \ShowSubBib \end{refsection} }
    \DezPostMainChapterHook
}

\NewDocumentEnvironment {MainChapter} { O{} G{} }
    { \StartChapter [#1] {#2} }
    { }



%==================================================================================================
%                        back matter
%==================================================================================================

\NewDocumentCommand \ShowBackBib {}
{
    \bool_if:NF \g_dez_bib_per_chap_bool
        { \ShowFullBib }
}

\NewDocumentEnvironment {Appendix} { O{} G{} }
{
    \DezPreAppendixHook
    \begin{refsection}
    \Chapter [#1] {#2}
}
{
    \ShowSubBib
    \end{refsection}
    \DezPostAppendixHook
}

\NewDocumentEnvironment {Appendices} {}
    {  }
    {  }

\NewDocumentCommand \ShowIndex {}
{
    \dez_if_feat_enabled:nT {imakeidx}
        {\printindex}
}




%==================================================================================================
%                 theorem-like
%==================================================================================================


% first, default style associations

\prop_const_from_keyval:Nn \c_dez_theorem_like_prop 
{
    Theorem         = plain ,
    Lemma           = plain ,
    Corollary       = plain,
    Proposition     = plain ,
    Conjecture      = plain ,
    Criterion       = plain ,
    Assertion       = plain ,
    Definition      = definition,
    Condition       = definition ,
    Example         = definition ,
    Question        = definition ,
    Problem         = definition ,
    Exercise        = definition ,
    Axiom           = definition,
    Property        = definition ,
    Assumption      = definition ,
    Hypothesis      = definition ,
    Algorithm       = algorithm ,  % changed to algorithm (in cryptocode)
    Protocol        = algorithm ,  % added (in cryptocode)
    Procedure       = algorithm ,  % added (in cryptocode)
    Game            = algorithm ,  % added (in cryptocode)
    Reduction       = algorithm ,  % added (in cryptocode)
    Remark          = remark ,
    Note            = remark ,
    Notation        = remark ,
    Claim           = remark ,
    Summary         = remark ,
    Acknowledgment  = remark ,
    Case            = remark ,
    Conclusion      = remark ,
    Result          = remark ,     % added (in cleveref)
}

% These ones are defined in cleveref, so don't set names for them
\seq_const_from_clist:Nn \c_dez_theorem_like_names_in_cref_seq
{
    Theorem, Lemma, Corollary, Proposition,
    Definition, Example ,
    Remark, Result ,
    Algorithm ,
}

\prop_const_from_keyval:Nn \c_dez_theorem_like_names_prop 
{
    % Theorem, Lemma, Corollary, Proposition are defined above
    Conjecture      = Conjecture/Conjectures ,
    Criterion       = Criterion/Criteria ,
    Assertion       = Assertion/Assertions ,
    % Definition defined above
    Condition       = Condition/Conditions ,
    % Example defined above
    Question        = Question/Questions ,
    Problem         = Problem/Problems ,
    Exercise        = Exercise/Exercises ,
    Axiom           = Axiom/Axioms ,
    Property        = Property/Properties ,
    Assumption      = Assumption/Assumptions ,
    Hypothesis      = Hypothesis/Hypotheses ,
    % Algorithm defined above
    Protocol        = Protocol/Protocols ,
    Procedure       = Procedure/Procedures ,
    Game            = Game/Games ,
    Reduction       = Reduction/Reductions ,
    % Remark defined above
    Note            = Note/Notes ,
    Notation        = Notation/Notations ,
    Claim           = Claim/Claims ,
    Summary         = Summary/Summaries ,
    Acknowledgment  = Acknowledgment/Acknowledgments ,
    Case            = Case/Cases ,
}

% define the styles suggested in the amsthm documentation
% • plain : italic text, extra space above and below;
% • definition : upright text, extra space above and below;
% • algorithm (NEW): same as definition;
% • remark : upright text, no extra space above or below.

\declaretheoremstyle
    [
        spaceabove     = \g_dez_abv_thm_skip ,
        spacebelow     = \g_dez_bel_thm_skip ,
        postheadspace  = \g_dez_glue_before_thm_title_skip ,
        headfont       = \bfseries ,
        bodyfont       = \itshape ,
    ]
    { plain }

\declaretheoremstyle
    [
        spaceabove     = \g_dez_abv_alg_skip ,
        spacebelow     = \g_dez_bel_alg_skip ,
        postheadspace  = \g_dez_glue_after_alg_title_skip ,
        headfont       = \bfseries ,
        bodyfont       = \upshape ,
    ]
    { algorithm }

\declaretheoremstyle
    [
        spaceabove     = \g_dez_abv_def_skip ,
        spacebelow     = \g_dez_bel_def_skip ,
        postheadspace  = \g_dez_glue_before_def_title_skip ,
        headfont       = \bfseries ,
        bodyfont       = \upshape ,
    ]
    { definition }

\declaretheoremstyle
    [
        spaceabove     = \g_dez_abv_remark_skip ,
        spacebelow     = \g_dez_bel_remark_skip ,
        postheadspace  = \g_dez_glue_before_rem_title_skip ,
        headfont       = \bfseries ,
        bodyfont       = \upshape ,
    ]
    { remark }

% amsthm defines this; renew so we can set the space
\RenewDocumentEnvironment {proof} { O{\proofname} }
{
    \par
    \dez__par_addvspace:N \g_dez_abv_proof_skip
    %\vspace {-\topsep}% remove the space after the theorem
    \pushQED{\qed}
    \normalfont
    \topsep 0pt
    \partopsep 0pt % no space before
    \trivlist
    \item
    [
        \hskip \labelsep
        \itshape
        #1 \@addpunct{.}
    ]
    \ignorespaces
}
{
    \popQED \endtrivlist \@endpefalse
    \dez__par_addvspace:N \g_dez_bel_proof_skip
}

\NewDocumentEnvironment {Proof} { o }
    { \begin {proof} [#1] }
    { \end {proof} }


\str_clear:N \l_tmpa_str
\str_if_eq:VnTF \g_dez_thm_in_str {none}
    { \declaretheorem [                           style=plain ] {theoremlike} }
    { \declaretheorem [ parent=\g_dez_thm_in_str, style=plain ] {theoremlike} }

\keys_define:nn { dez / theorem-like-env }
{
    style .tl_set:N    = \l__style_tl ,
    style .initial:n   = {} ,
    unknown .code:n    = {} ,  % OK
}

\cs_new_protected:Npn \dez_new_thm:nn #1#2
{
    \tl_set:Nn \l_tmpa_tl {#2}
    \tl_if_blank:VT \l__style_tl
    {
        \prop_get:NnNF \c_dez_theorem_like_prop {##1} \l_tmpa_tl
            { \tl_set:Nn \l_tmpa_tl {plain} }
    }
    \declaretheorem [ style=\l_tmpa_tl, sibling=theoremlike ] {#1}
}

\NewDocumentCommand \NewTheoremEnvs { O{} m }
{
    \tl_set:Nn \l__style_tl {}
    \prop_set_from_keyval:Nn \l_tmpa_prop {#2}  % no \group_begin: to avoid weirdness in \declaretheorem
    \prop_map_inline:Nn \l_tmpa_prop
    {   % loop over env -> cref/cref-plural; guess style if not set from style= in [#1]
        \exp_args:NnV \dez_new_thm:nn {##1} \l_tmpa_tl
        \pidgin__set_cref:nn {##1} {##2}
    }
}

\NewDocumentCommand \StandardTheoremEnvs { O{} m }
{
    \seq_map_inline:Nn \c_dez_theorem_like_names_in_cref_seq
    {
        \exp_args:NnV \dez_new_thm:nn {##1} {}
        % no cleveref call
    }
    \prop_map_inline:Nn \c_dez_theorem_like_names_prop
    {
        \exp_args:NnV \dez_new_thm:nn {##1} {}
        \pidgin__set_cref:nn {##1} {##2}
    }
}



%==================================================================================================
%                     lists of things
%==================================================================================================

\cs_new_protected:Npn \dez__fix_lof:n #1
{
    \renewcommand \listoffigures
    {   % listfigurename already gets set
        \bool_if:nTF {#1}
            { \chapter  {\listfigurename} }
            { \chapter* {\listfigurename} }
        \@mkboth
            {\listfigurename}
            {\listfigurename}
        \@starttoc {lof}
    }
}

\cs_new_protected:Npn \dez__fix_lot:n #1
{
    \renewcommand \listoftables
    {   % listfigurename already gets set
        \bool_if:nTF {#1}
            { \chapter  {\listtablename} }
            { \chapter* {\listtablename} }
        \@mkboth
            {\listtablename}
            {\listtablename}
        \@starttoc {lot}
    }
}

\NewDocumentEnvironment {LofLikeListInternal} { m }
{
    \bool_if:NF \g_dez_show_toc_links_bool
        { \hypersetup {hidelinks} }
    \dez__fix_lof:n{#1}
    \setlength {\parskip} {0ex}  % makes things confusing
    \DezPreTocLikeHook
} {}

\NewDocumentEnvironment {TocLikeList} { t! }
    { \begin {LofLikeListInternal} {#1} }
    { \end {LofLikeListInternal} }

\cs_new:Npn \dez_maybe_add_toc:nnn #1#2#3
{
    \bool_if:nF {#1}
    {
        \bool_if:nT {#2}
            { \addcontentsline {toc} {chapter} {#3} }
    }
}

% Output table of contents
\NewDocumentCommand \ShowTableOfContents { }
{
    % We're just not going to allow ! or + here --
    % It's the table of contents for God's sake.
    \group_begin:
    \bool_if:NF \g_dez_show_toc_links_bool
        { \hypersetup {hidelinks} }
    \setlength {\parskip} {0ex}  % makes things confusing
    \DezPreTocLikeHook
    \exp_args:NV \setstretch \g_dez_stretch_toc_tl
    \tableofcontents
    \group_end:
}

% Output list of figures
\NewDocumentCommand \ShowListOfFigures { t! t+ }
{
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \listoffigures
    \dez_maybe_add_toc:nnn {#1} {#2} {\listfigurename}
    %\addcontentsline{toc}{chapter}{\listfigurename}
    \end {LofLikeListInternal}
}

% Output list of tables
\NewDocumentCommand \ShowListOfTables { t! t+ }
{
    % \listoftables doesn't use \listoffigures
    % so we follow the same logic as in LofLikeListInternal
    \group_begin:
    \bool_if:NF \g_dez_show_toc_links_bool
        { \hypersetup {hidelinks} }
    \dez__fix_lot:n{#1}
    \setlength {\parskip} {0ex}  % makes things confusing
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \DezPreTocLikeHook
    \listoftables
    %\addcontentsline{toc}{chapter}{\listtablename}
    \dez_maybe_add_toc:nnn {#1} {#2} {\listtablename}
    \group_end:
}

% Output list of abbreviations (via 'acro' package)
\NewDocumentCommand \ShowListOfAbbreviations { t! t+ }
{
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_abbrevs_tl
    % template = description|tabular|longtable|supertabular|tabularray|lof|toc
    % acceptable choices are description, toc, lof, and tabularray
    % description is the default
    \tl_set:Nx \l_tmpa_tl { \pidgin_string:n {listabbreviation} }
    \tl_set:Nn \l_tmpb_tl
    {
        template = description ,  % the rest are all broken
        name = \l_tmpa_tl ,
        preamble =
            {
              \skip_vertical:N \g_dez_bel_front_chap_skip
            } ,
    }
    \bool_if:nTF {#1}
        {
          \exp_last_unbraced:Ne
              \printacronyms
              { [ heading=chapter,  \l_tmpb_tl ] }
        }
        {
          \exp_last_unbraced:Ne
              \printacronyms
              { [ heading=chapter*, \l_tmpb_tl ] }
        }
    \dez_maybe_add_toc:nnn {#1} {#2} { \pidgin_string:n {listabbreviation} }
    \end {LofLikeListInternal}
}

% Output nomenclature
\NewDocumentCommand \ShowNomenclature { t! t+ }
{
    % nomencl doesn't use \listoffigures
    % so, we'll turn \chapter* into \chapter
    \group_begin:
    \setlength {\parskip} {0ex}
    \DezPreTocLikeHook
    \bool_if:nT {#1}
    {
        \let \oldchapter \chapter
        \renewcommand {\chapter}
            { {  % both braces
                 \oldchapter { \pidgin_string:n {listnomenclature} }
            } }
    }
    \exp_args:NV \setstretch \g_dez_stretch_nom_tl
    \bool_if:NF \g_dez_show_nom_links_bool
        { \hypersetup{hidelinks} }
    % also uses \nomitemsep, which we earlier set to baselineskip
    \printnomenclature
    \dez_maybe_add_toc:nnn {#1} {#2} { \pidgin_string:n {listnomenclature} }
    \group_end:
}

\NewDocumentCommand \ShowListOfTheoremLike { t! O{} m }
{
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \listoftheorems[#3]
    \bool_if:nF {#1}
    {
        \tl_if_blank:nF {#2}
            { \addcontentsline {toc} {chapter} {#2} }
    }
    \end {LofLikeListInternal}
}

\NewDocumentCommand \ShowListOfSourceCode { t! t+ }
{
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \listoflistings
    \dez_maybe_add_toc:nnn {#1} {#2} { \pidgin_string:n {listlisting} }
    \end {LofLikeListInternal}
}

\NewDocumentCommand \ShowListOfReactionSchemes { t! t+ }
{
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \listofreactionschemes
    \dez_maybe_add_toc:nnn {#1} {#2} { \pidgin_string:n {listreactionscheme} }
    \end {LofLikeListInternal}
}

\NewDocumentCommand \ShowListOfStructuralFormulas { t! t+ }
{
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \listofstructuralformulas
    \dez_maybe_add_toc:nnn {#1} {#2} { \pidgin_string:n {liststructuralformula} }
    \end {LofLikeListInternal}
}




%==================================================================================================
%                     abbreviations
%==================================================================================================

\acsetup
{
    single-style       = long,     % NOTE:
    make-links         = false ,
    list / sort        = true ,
    accsupp / use      = true ,
    use-id-as-short    = true ,
    index / use        = indexed ,
    format / short     = \txtuppertosc ,
}


\NewDocumentCommand \indx { s m O{} }
{
    \bool_if:nTF {#1}
        { \StyleTxt {indx-starred} {#2} }
        { #2 }
    \dez_if_feat_enabled:nT {imakeidx}
        { \tl_if_blank:nTF {#3} { \index{#2} } { \index{#3} } }
}
\NewDocumentCommand \Indx { s m O{} }
{
    \bool_if:nTF {#1}
        {
            \StyleTxt
                { indx-starred }
                { \txtsentencecase*{#2} }
        }
        { \txtsentencecase*{#2} }
    \dez_if_feat_enabled:nT {imakeidx}
    {
        \tl_if_blank:nTF {#3} { \index{#2} } { \index{#3} }
    }
}

\dez_if_feat_enabled:nT {knowledge}
{
    \knowledgeconfigure { visible~anchor~points = \g_dez_draft_bool }
}


%==================================================================================================
%                      caption and subcaption styling
%==================================================================================================

\DeclareCaptionSubType [\g_dez_n_panels_str] {figure}

\DeclareCaptionLabelSeparator {dez-sep} {\g_dez_typo_caption_label_sep_tl}

\textiles_declare_cap_style:nnn {dez-caption} {caption-body}    {caption-label}
\textiles_declare_cap_style:nnn {dez-subcap}  {subcaption-body} {subcaption-label}
\textiles_declare_cap_style:nnn {dez-table}   {table-head-body} {table-head-label}  % legacy tables

% For all captions:
\captionsetup
{
    singlelinecheck  = false,  % do what the user tells you
    format           = dez-caption ,
    labelsep         = dez-sep ,
    justification    = centering ,
}

\captionsetup [figure]
{
    skip             = { \skip_use:N \g_dez_abv_caption_skip } ,
    subrefformat     = \g_dez_typo_subref_format_tl ,  % e.g. "parens"
}

\captionsetup [subfigure]
{
    format =   dez-subcap ,
    skip   =   \g_dez_abv_subcaption_skip ,
}

% Captions that go at the TOP of tables (legacy table environment)
\captionsetup [table]
{
    position         = above ,
    format           = dez-table ,
    justification    = centering ,
    skip             = 0ex ,  % TODO
}

% if no minted, make a fake listing so we can use it anyway
\dez_if_feat_enabled:nF {minted}
    { \DeclareFloatingEnvironment {listing} }

\captionsetup [listing]
{
    position         = above ,  % special
    format           = dez-table ,
    justification    = centering ,
    skip             = 0ex ,
}


\cs_new_protected:Npn \dez__new_float_x:nVV #1#2#3
{
    \DeclareFloatingEnvironment
        [
            name       = {#2} ,
            listname   = {#3} ,
            within     = \g_dez_float_in_str ,
        ]
        {#1}
}

\cs_new_protected:Npn \dez__new_float:n #1
{
    \tl_set:Nx \l_tmpa_tl { \pidgin_string:n{#1} }
    \tl_set:Nx \l_tmpb_tl { \pidgin_string:n{list#1} }
    \dez__new_float_x:nVV {#1} \l_tmpa_tl \l_tmpb_tl
    \captionsetup [#1]
    {
        position   = below ,
        format     = dez-table ,
        skip       = \g_dez_bel_table_title_skip ,
    }
}

% make specifying e.g. align= (inner-pos) easier
\DeclareCaptionJustification {left}    {\RaggedRight}
\DeclareCaptionJustification {right}   {\RaggedLeft}
\DeclareCaptionJustification {center}  {\centering}
\DeclareCaptionJustification {justify} {\justified}
% caption also provides \centerfirst and \centerlast



%==================================================================================================
%                      captioning commands
%==================================================================================================


\keys_define:nn { dez / capkeyval }
{
    label .tl_set:N      = \l__label_tl ,
    label .initial:n     = {} ,
    entry .tl_set:N      = \l__entry_tl ,
    entry .initial:n     = {} ,
    caption .tl_set:N    = \l__caption_tl ,
    caption .initial:n   = {} ,
}

\cs_new_protected:Nn \dez__capkeyval:
{
    \tl_if_blank:VTF \l__entry_tl
        { \caption                {\l__caption_tl} }
        { \caption [\l__entry_tl] {\l__caption_tl} }
    \tl_if_blank:VF \l__label_tl
        { \label {\l__label_tl} }
}

\NewDocumentCommand \captioning { O{} m }
{   % friendly version; directly swap with \caption
    \group_begin:
    \tl_if_in:nnTF {#2} {=}
        { \keys_set:nn {dez / capkeyval} {#2} }
        {  % alright, not key-value yet
            \tl_set:Nn \l__label_tl {}
            \tl_set:Nn \l__entry_tl {}
            \tl_set:Nn \l__caption_tl {#2}
        } 
    \tl_if_blank:VT \l__entry_tl
        { \tl_set:Nn \l__entry_tl {#1} }  % harmless at worst
    \dez__capkeyval:
    \group_end:
}

\NewDocumentCommand \Caption { m }
{   % hardcore version; requires key-value
    \group_begin:
    \keys_set:nn {dez / capkeyval} {#1}
    \dez__capkeyval:
    \group_end:
}




%==================================================================================================
%                 figures -- single-panel
%==================================================================================================

\g@addto@macro \@floatboxreset \centering
% This one no longer works!
%\g@addto@macro\@subfloatboxreset{\centering}
% https://tex.stackexchange.com/questions/144853/add-centering-to-all-subfigures-in-subcaption-using-gaddtomacro
\apptocmd \subcaption@iiminipage {\centering} {} {}


\keys_define:nn { dez / one-panel-figure }
{
    file .tl_set:N          = \l__file_tl ,
    file .initial:n         = {} ,
    graphicx .tl_set:N      = \l__graphics_options_tl ,
    graphicx .initial:n     = {} ,
    label .tl_set:N         = \l__label_tl ,
    label .initial:n        = {} ,
    entry .tl_set:N         = \l__entry_tl ,
    entry .initial:n        = {} ,
    caption .tl_set:N       = \l__caption_tl ,
    caption .initial:n      = {} ,
    full .bool_set:N        = \l__full_page_bool,
    full .default:n         = true ,
    full .initial:n         = false,
}

\cs_new:Npn \dez__include_graphics:nn #1#2
{
    \includegraphics [#2] {#1}
}
\cs_generate_variant:Nn \dez__include_graphics:nn { Ve }


\NewDocumentEnvironment {OnePanelFigure} { s r[] }
{
    \keys_set:nn {dez / one-panel-figure} {#2}
    \str_set:Nn \l__my_env_str {figure}
    \bool_if:nTF {#1}
        { \str_set:Nn \l__my_env_str {figure*} }
        {
            \bool_if:NT \l__full_page_bool
                { \str_set:Nn \l__my_env_str {figure*} }
        }
    \begin{\l__my_env_str}
    \tl_if_blank:VF \l__file_tl
        { \dez__include_graphics:Ve \l__file_tl {\l__graphics_options_tl} }
}
{
    \dez__capkeyval:
    \end{\l__my_env_str}
}

\NewDocumentCommand \AddOnePanelFigure { s r[] }
{
    \begin {OnePanelFigure} \bool_if:nT{#1}{*}[#2]
    \end {OnePanelFigure}
}




%==================================================================================================
%                 figures -- multi-panel (with real graphics)
%==================================================================================================

\keys_define:nn { dez / multi-panel-figure }
{
    label .tl_set:N        = \l__label_tl ,
    label .initial:n       = {} ,
    entry .tl_set:N        = \l__entry_tl ,
    entry .initial:n       = {} ,
    caption .tl_set:N      = \l__caption_tl ,
    caption .initial:n     = {} ,
    full .bool_set:N       = \l__full_page_bool ,
    full .default:n        = true ,
    full .initial:n        = false ,
}

\NewDocumentEnvironment {MultiPanelFigure} { s r[] }
{
    \keys_set:nn {dez / multi-panel-figure} {#2}
    \bool_if:nTF {#1}
        { \str_set:Nn \l__my_env_str {figure*} }
        {
            \bool_if:NT \l__full_page_bool
                { \str_set:Nn \l__my_env_str {figure*} }
        }
    \begin {\l__my_env_str}
}
{
    \dez__capkeyval:
    \end {\l__my_env_str}
}

% align (inner-pos) can be 'l', 'c, 'r', or anything declared via \DeclareCaptionJustification
% we declared some aliases in the captioning section above
\keys_define:nn { dez / real-panel }
{
    file  .tl_set:N            = \l__panel_file_tl ,
    file .initial:n            = {} ,  % optional, but clearly wanted
    graphicx .tl_set:N         = \l__panel_graphics_options_tl ,
    graphicx .initial:n        = {} ,
    width .dim_set:N           = \l__panel_width_dim ,
    align .tl_set:N            = \l__panel_innerpos_tl ,
    align .default:n           = center ,
    label .tl_set:N            = \l__panel_label_tl ,
    label .initial:n           = {} ,
    entry .tl_set:N            = \l__panel_entry_tl ,
    entry .initial:n           = {} ,
    caption .tl_set:N          = \l__panel_caption_tl ,
    caption .initial:n         = {} ,
}

\NewDocumentCommand \AddPanel { m }
{
    \group_begin:
    \keys_set:nn {dez / real-panel} {#1}
    \subcaptionbox
        [\l__panel_entry_tl]
        {\l__panel_caption_tl}
        [\l__panel_width_dim]
        [\l__panel_innerpos_tl]
        {
            \tl_if_blank:VF \l__file_tl
                { \dez__include_graphics:Ve \l__file_tl {\l__graphics_options_tl} }
            \tl_if_blank:VF \l__label_tl
                { \label {\l__label_tl} }
        }
    \group_end:
}




%==================================================================================================
%                 phantom-panel figures -- 1 graphics file 
%==================================================================================================

\keys_define:nn { dez / phantom-panel-figure }
{
    file .tl_set:N            = \l__file_tl ,
    file .initial:n           = {} ,                        % "optional, but clearly wanted
    graphicx .tl_set:N        = \l__graphics_options_tl ,
    graphicx .initial:n       = {} ,
    label .tl_set:N           = \l__label_tl ,
    label .initial:n          = {} ,
    entry .tl_set:N           = \l__entry_tl ,
    entry .initial:n          = {} ,
    caption .tl_set:N         = \l__caption_tl ,
    caption .initial:n        = {} ,
    full .bool_set:N          = \l__full_page_bool ,
    full .default:n           = true ,
    full .initial:n           = false ,
}

%\prop_new:N \g__dez_panel_prop

\NewDocumentEnvironment {PhantomPanelFigure} { s r[] }
{
    \keys_set:nn {dez / phantom-panel-figure} {#2}
    \bool_if:nTF {#1}
        { \str_set:Nn \l__my_env_str {figure*} }
        {
            \bool_if:NT \l__full_page_bool
                { \str_set:Nn \l__my_env_str {figure*} }
        }
    \begin {\l__my_env_str}
    \tl_if_blank:VF \l__file_tl
        { \dez__include_graphics:Ve \l__file_tl {\l__graphics_options_tl} }
}
{
    \dez__capkeyval:
    \end {\l__my_env_str}
}

\keys_define:nn { dez / phantom-panel }
{
    label .tl_set:N      = \l__panel_label_tl ,
    label .initial:n     = {} ,
    entry .tl_set:N      = \l__panel_entry_tl ,
    entry .initial:n     = {} ,
}

\NewDocumentCommand \AddPhantomPanel { m }
{
    \group_begin:
    \keys_set:nn {dez / phantom-panel} {#1}
     % add a LOF/TOC entry (if applicable), but don't show the text
    \captionlistentry {\l__panel_entry_tl}
    \tl_if_blank:VF \l__panel_label_tl { \label{\l__panel_label_tl} }
    \group_end:
}


\NewDocumentCommand \describepanels { m m }
{
    % TODO: split by --
    \textiles_use:nn
        {subref}
        {
            \ProcessList {#1} {\subref}
            \g_dez_typo_subref_label_sep_tl
        }
        #2
}
\NewDocumentCommand \describepanel { m m }
    { \describepanels {#1} {#2} }

\NewDocumentCommand \describepanelrange { m m m }
{
    \textiles_use:nn
        {subref}
        {
            \subref{#1}--\subref{#2}
            \g_dez_typo_subref_label_sep_tl
        }
        #3
}



%==================================================================================================
%                            tables
%==================================================================================================

% Vertical spacing
\SetTblrOuter
{
    presep    = \g_dez_abv_table_title_skip ,
    headsep   = \g_dez_bel_table_title_skip ,
    footsep   = \g_dez_abv_table_footer_skip ,
    postsep   = \g_dez_bel_table_footer_skip ,
}

% Apply these font styles in all cases
\SetTblrStyle {caption-sep}  { font=\textiles_run_nullary:n {table-head-label} }
\SetTblrStyle {caption-tag}  { font=\textiles_run_nullary:n {table-head-label} }
\SetTblrStyle {caption-text} { font=\textiles_run_nullary:n {table-head-body} }
\SetTblrStyle {lastfoot}     { font=\textiles_run_nullary:n {table-footer} }

% Fix the separators
% For caption, that's the only thing we'll do.
% (For notes and remarks, we'll do more after.)
\DefTblrTemplate {caption-sep} {default} {\g_dez_typo_caption_label_sep_tl}
\DefTblrTemplate {note-sep}    {default} {\g_dez_typo_table_note_sep_tl}   
\DefTblrTemplate {remark-sep}  {default} {\g_dez_typo_table_remark_sep_tl}

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
        \UseTblrTemplate {note-tag}  {default}
        \UseTblrTemplate {note-sep}  {default}
        \UseTblrTemplate {note-text} {default}
        \space  % fixed
    }
}

\DefTblrTemplate {remark} {shortfoot}
{ 
    \MapTblrRemarks
    {
        \noindent  % fixed
        \UseTblrTemplate {remark-tag}  {default}
        \UseTblrTemplate {remark-sep}  {default}
        \UseTblrTemplate {remark-text} {default}
        \space  % fixed
    }
}


\DefTblrTemplate {lastfoot} {default}  % make default
{
    \exp_args:NV \setstretch \g_dez_stretch_caption_tl
    \UseTblrTemplate {remark} {shortfoot}
    \UseTblrTemplate {note}   {shortfoot}
    \par
}

\DefTblrTemplate {lastfoot} {shortfoot}
{
    \exp_args:NV \setstretch \g_dez_stretch_caption_tl
    \UseTblrTemplate {remark} {shortfoot}
    \UseTblrTemplate {note}   {shortfoot}
    \par
}

\DefTblrTemplate {lastfoot} {longfoot}
{
    \UseTblrTemplate {remark} {default}
    \UseTblrTemplate {note}   {default}
}

\NewTblrTheme {shortfoot}
    { \UseTblrTemplate {lastfoot} {shortfoot} }

\NewTblrTheme {longfoot}
    { \UseTblrTemplate {lastfoot} {longfoot} }


\NewColumnType {L}  { >{$} l <{$} }
\NewColumnType {C}  { >{$} c <{$} }
\NewColumnType {R}  { >{$} r <{$} }
\NewRowType    {L}  { >{$} l <{$} }
\NewRowType    {C}  { >{$} c <{$} }
\NewRowType    {R}  { >{$} r <{$} }

\NewDocumentEnvironment {Table} { o m }
    { \begin {tblr} [#1] {#2} }
    { \end {tblr} }
    
\NewDocumentEnvironment {LongTable} { o m }
    { \begin {longtblr} [#1] {#2} }
    { \end  }
    
\NewDocumentEnvironment {TallTable} { o m }
    { \begin {talltblr} [#1] {#2} }
    { \end {talltblr} }

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
    \SetTblrOuter {#1}
    \csvreader
    [
        no~head ,
        long~tabularray         = {#2} ,
        table~head              = {\toprule} ,
        table~foot              = {\midrule} ,
        late~after~first~line   = {\\\bottomrule} ,
        #3
    ]
    {#4}
}




%==================================================================================================
%                            boxes
%==================================================================================================

\keys_define:nn { dez / box }
{
    name .tl_set:N     = \l__name_tl ,
    name .initial:n    = {} ,
    label .tl_set:N    = \l__label_tl ,
    label .initial:n   = {} ,
}
\dim_new:N   \g_dez_box_border_dim
\dim_gset:Nn \g_dez_box_border_dim {1.2pt }
\dim_new:N   \g_dez_box_arc_dim
\dim_gset:Nn \g_dez_box_arc_dim { 0pt }
\tl_new:N    \g_dez_box_frame_color_tl
\tl_gset:Nn  \g_dez_box_frame_color_tl { blue!50!black }
\cs_new_protected:Nn \dez_box_font_title:
    { \normalsizerr \bfseries }

% make consistently themed non-flashy boxes
% e.g. \DeclaredezBox [color=xkcd~algae] {Hint}
\cs_new:Npn \dez__dec_box:nnnN #1#2#3#4
{
    #4 {#3} { O{} }
    {
        \keys_set:nn {dez / box} {##1}
        \begin {tcolorbox}
        [
            title       =
            {
                \textiles_use:nn {box-label} {#3 \g_dez_typo_caption_label_sep_tl}
                \textiles_use:nn {box-name}  {\l__name_tl}
            } ,
            colframe     = {#1} ,
            colupper     = {#1} ,
            colback      = {#1!1!white} ,
            coltext      = black ,
            fontlower    = {} ,
            boxrule      = { \dim_use:N \g_dez_box_border_dim } ,
            arc          = { \dim_use:N \g_dez_box_arc_dim } ,
            boxsep       = 0.25pc ,
            #2 ,         % here the user can override any of the above-listed defaults
        ]
        \tl_if_blank:VF \l__label_tl
            { \label {\l__label_tl} }
    }
    { \end {tcolorbox} }
}
\NewDocumentCommand \DeclareDezBox { D(){\g_dez_box_frame_color_tl} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \DeclareDocumentEnvironment } 

\NewDocumentCommand \NewDezBox { D(){\g_dez_box_frame_color_tl} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \NewDocumentEnvironment } 

\NewDocumentCommand \ProvideDezBox { D(){\g_dez_box_frame_color_tl} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \ProvideDocumentEnvironment }

\NewDocumentCommand \RenewDezBox { D(){\g_dez_box_frame_color_tl} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \RenewDocumentEnvironment } 


\dim_new:N   \g_dez_minted_border_dim
\dim_gset:Nn \g_dez_minted_border_dim { 1.2pt }
\tl_gset:Nn  \g_dez_minted_bg_color_tl { black!1!white }

\dez_if_feat_enabled:nT {tcolorbox}
{
    \DeclareTColorBox {DezMinted} { O{} }
    {
        colback    = \g_dez_minted_bg_color_tl ,
        coltext    = black ,
        boxrule    = { \dim_use:N \g_dez_minted_border_dim } ,
        arc        = 0pt ,
        boxsep     = 0pt ,
        #1 ,
    }
}




%==================================================================================================
%                    source code
%==================================================================================================

\dez_if_feat_enabled:nT {minted}
{
    \setminted {python3=true}
}


\keys_define:nn { dez / source-code }
{
    lang .tl_set:N       = \l__lang_tl ,
    lang .initial:n      = text ,
    label .tl_set:N      = \l__label_tl ,
    label .initial:n     = {} ,
    entry .tl_set:N      = \l__entry_tl ,
    entry .initial:n     = {} ,
    caption .tl_set:N    = \l__caption_tl ,
    caption .initial:n   = {} ,
    minted .tl_set:N     = \l__minted_tl ,
    minted .initial:n    = {} ,
    no-box .bool_set:N   = \l__no_box_bool ,
    no-box .default:n    = true ,
    no-box .initial:n    = false ,
}

\NewDocumentEnvironment {SourceCode} { O{} }
{
    \begin {listing}
    \keys_set:nn {dez / source-code} {#1}
    \dez__capkeyval:
    \dez_if_feat_enabled:nT {tcolorbox}  % box even if minted is not enabled
        { \bool_if:NF \l__no_box_bool { \begin{DezMinted} } }
    \dez_if_feat_enabled:nT {minted}
    {
        \textiles_run_nullary:n {source-code}
        \setminted { baselinestretch = \g_dez_stretch_code_tl }
    }
}
{
    \dez_if_feat_enabled:nT {tcolorbox}
        { \bool_if:NF \l__no_box_bool { \end{DezMinted} } }
    \end{listing}
}

\NewDocumentEnvironment {MintedCode} { O{} }
{   \VerbatimEnvironment
    \begin {SourceCode} [#1]
    \dez_if_feat_enabled:nT {minted}
        { \begin{minted} [\l__minted_tl] {\l__lang_tl} }
}
{
    \dez_if_feat_enabled:nT {minted}
        { \end{minted} }
    \end {SourceCode}
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
    \begin {SourceCode}
    \keys_set:nn {dez / source-code} {#2}
    \dez__capkeyval:
    \dez_if_feat_enabled:nT {minted}
        { \inputminted [#1] {\l__lang_tl} {#3} }
    \end {SourceCode}
}




%==================================================================================================
%                               chemistry
%==================================================================================================


\keys_define:nn { dez / chem }
{
    label .tl_set:N       = \l__label_tl ,
    label .initial:n      = {} ,
    entry .tl_set:N       = \l__entry_tl ,
    entry .initial:n      = {} ,
    caption .tl_set:N     = \l__caption_tl ,
    caption .initial:n    = {} ,
    chemfig .tl_set:N     = \l__chemfig_tl ,
    chemfig .initial:n    = {} ,
}

\dez__new_float:n {reactionscheme}
\dez__new_float:n {structuralformula}

\NewDocumentEnvironment {ReactionScheme} { O{} }
{
    \keys_set:nn {dez / chem} {#1}
    \begin{reactionscheme}
    \textiles_run_nullary:n {dez-chemistry}
    \dez_if_feat_enabled:nT {chemfig}
    {
        \setchemfig {\l__chemfig_tl}
        \schemestart
    }
}
{
    \dez__capkeyval:
    \end{reactionscheme}
    \dez_if_feat_enabled:nT {chemfig}
        { \schemestop }
}

\NewDocumentEnvironment {StructuralFormula} { O{} }
{
    \keys_set:nn {dez / chem} {#1}
    \begin {structuralformula}
    \textiles_run_nullary:n {dez-chemistry}
    \dez_if_feat_enabled:nT {chemfig}
        { \setchemfig {\l__chemfig_tl} }
}
{
    \dez__capkeyval:
    \end {structuralformula}
}




%==================================================================================================
%                    typography
%==================================================================================================

\RenewDocumentCommand \foreign { m }
{
    \textiles_use:nn {foreign-words} {#1}  % e.g. "et al." or "in vivo"
}


% Really none of these should be changed, EXCEPT
% group-digits group-minimum-digits, and maybe group-separator.
% If in a US university: group-separator={,},group-digits=integer
\sisetup
{
    mode                      = match ,      % stay in the current mode (all?)
    number-mode               = match ,      % stay in the current mode (digits)
    unit-mode                 = match ,      % stay in the current mode (units)
    propagate-math-font       = true ,       % these just retain the current font:
    reset-text-family         = false ,
    reset-text-series         = false ,
    reset-text-shape          = false ,
    retain-explicit-plus      = true ,       % +1 stays +1, not 1
    retain-zero-uncertainty   = true ,       % \pm 0 still shown
    group-minimum-digits      = 3 ,          % starting at this number (1,000)
    group-digits              = all ,        % 'all' is acceptable with thinspace
    group-separator           = \thinspace ,
}


% We pass the author, etc., at the preamble end, after the user set it.
\hypersetup
{
    colorlinks ,
    linktoc       = all ,
    linkcolor     = ref ,  % TODO
    citecolor     = cite ,
    urlcolor      = url ,
    filecolor     = file ,
    final         = true ,  % ignore global settings
    draft         = false ,
}


\dez_if_feat_enabled:nT {kantlipsum}
{
    \int_const:Nn \c_dez_max_kant_int {164}
    % Get kant paragraphs sequentially;
    % Increment this counter each time a paragraph is used
    \int_gzero_new:N \g__dez_ikant_int
    
    \cs_new_protected:Npn \dez__kant_aux:ee
        { \kant [#1] [#2] }
    
    \NewDocumentCommand \ikant { O{3} }
    {
        \int_compare:nNnTF {\g__dez_ikant_int} > {\c_dez_max_kant_int-1}
            { \int_gset:Nn \g__dez_ikant_int {1} }
            { \int_gincr:N \g__dez_ikant_int }
        \dez__kant_aux:ee P \g__dez_ikant_int {1--#1}
    }
    
    % This command instead chooses random paragraphs
    \NewDocumentCommand \rkant { O{3} }
    {
        \dez__kant_aux:ee
            { \int_rand:nn {1} {\c_dez_max_kant_int} }
            { 1--#1 }
    }
}




%==================================================================================================
%                front, main, back matter commands
%==================================================================================================

% Shows the bibliography at the end of the chapter, if \g_dez_bib_per_chap_bool
\NewDocumentCommand \ShowSubBib {}
{
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \printbibliography [heading=subbibintoc] }
}

\NewDocumentCommand \ShowEndNotes {}
{
    \printendnotes  % does nothing if there are no endnotes
}
\NewDocumentCommand \ShowEndnotes {}
    { \ShowEndNotes }

% Shows the bibliography at the end of the document
\NewDocumentCommand \ShowFullBib {}
{
    \bool_if:NF \g_dez_bib_per_chap_bool
        { \printbibliography }
}

\cs_new_protected:Npn \dez__chap_num:N #1
{
    \renewcommand \thechapter { #1{chapter} }
}

\NewDocumentCommand \StartFrontMatter {}
{
    \exp_args:Nc
        \dez__chap_num:N
        \g_dez_n_front_chp_str
    \pagenumbering {\g_dez_n_front_str}
    \setcounter {page} {1}
}

\AtBeginDocument {\StartFrontMatter}

\NewDocumentCommand \StartMainMatter {}
{
    \DezChapterPageHook  % clear page BEFORE changing the page numbering!
    \str_if_eq:VVF \g_dez_n_front_str \g_dez_n_main_str
    {
        \pagenumbering {\g_dez_n_main_str}
        \setcounter {page} {1}
    }
    \exp_args:Nc
        \dez__chap_num:N
        \g_dez_n_main_chps_str
    \bool_if:NT \g_dez_force_endnotes_bool
        { \FootnotesAsEndnotes }
    \setcounter {chapter} {0}
}

\NewDocumentCommand \StartBackMatter {}
{
    \DezChapterPageHook  % clear page BEFORE changing the page numbering!
    \str_if_eq:VVF \g_dez_n_main_str \g_dez_n_back_str
        {
            \pagenumbering {\g_dez_n_back_str}
            \setcounter {page} {1}
        }
    \exp_args:Nc
        \dez__chap_num:N
        \g_dez_n_back_chp_str
    \setcounter {chapter} {0}
}




%==================================================================================================
%                     setup commands
%==================================================================================================

% We're just aliasing to make them consistent.
% Setup commands should end with 'Setup' and be camel-case.

\NewDocumentCommand \KnowledgeSetup {m}
    { \knowledgeconfigure {#1} }

\NewDocumentCommand \SiSetup {m}
    { \sisetup {#1} }

\NewDocumentCommand \HyperSetup {m}
    { \hypersetup {#1} }

\NewDocumentCommand \AcroSetup {m}
    { \acsetup {#1} }

\NewDocumentCommand \CaptionSetup { o m }
    { \captionsetup [#1] {#2} }

\NewDocumentCommand \MintedSetup {m}
    { \setminted {#1} }

\NewDocumentCommand \GeometrySetup {m}
    { \geometry {#1} }

\NewDocumentCommand \ChemSetup {m}
    { \chemsetup {#1} }

\NewDocumentCommand \ListSetup { o m }
    { \setlist [#1] {#2} }  % enumitem


\cs_new_protected:Npn \dez__chemfig_aux:n #1
{
    \setchemfig
    {
        % whitespace:
        atom sep          = {#1 \CF_atomsep} ,
        compound sep      = {#1 \CF_compoundsep} ,
        % space between text and charge
        + sep left        = {#1 \CF_signspaceante} ,    % these are a bit different
        + sep right       = {#1 \CF_signspacepost} ,
        vshift            = {#1 \CF_signvshift} ,
        % cram width (in ex):
        cram width        = {#1 \CF_crambasewidth} ,
        % bond lengths and offsets:
        cram dash width   = {#1 \CF_cramdashlength} ,
        cram dash sep     = {#1 \CF_cramdashsep} ,
        bond offset       = {#1 \CF_bondoffset} ,
        double bond sep   = {#1 \CF_doublesep} ,
        arrow offset      = {#1 \CF_arrowoffset} ,
        arrow double sep  = {#1 \CF_arrowdoublesep} ,
        arrow label sep   = {#1 \CF_arrowlabelsep} ,
        stack sep         = {#1 \CF_stacksep} ,
    }
}

\NewDocumentCommand \ChemfigSetup { >{\TrimSpaces}O{1} m}
{
    \setchemfig{#2}
    % it's inconvenient to just say, "my diagrams are too big"
    % arg [#1] is a coefficient to rescale all lengths
    \fp_set:Nn \l_tmpa_fp {#1}  % make sure it's valid
    \tl_if_eq:nn {#1} {1}  % cheat a bit for performance
        { \dez__chemfig_aux:n {#1} }
}




%==================================================================================================
%                    input and subfile wrapper commands
%==================================================================================================

% See also: \LoadBib and \LoadTex.

% These just start the front, main, or back matter and load the listed files.

\NewDocumentCommand \LoadFrontDocs { >{\SplitList{,}}m }
{
    \StartFrontMatter
    \ProcessList {#1} {\input}
}

\NewDocumentCommand \LoadMainDocs { >{\SplitList{,}}m }
{
    \StartMainMatter
    \ProcessList {#1} {\input}
}

\NewDocumentCommand \LoadBackDocs { >{\SplitList{,}}m }
{
    \StartBackMatter
    \ProcessList {#1} {\input}
}


\NewDocumentCommand \StartSubFiles {}
    { \usepackage {subfiles} }  % usepackage on purpose -- don't allow in premable.


% These use \subfile instead of \input.

\NewDocumentCommand \LoadFrontSubdocs { >{\SplitList{,}}m }
{
    %\StartFrontMatter
    \ProcessList {#1} {\subfile}
}

\NewDocumentCommand \LoadMainSubdocs { >{\SplitList{,}}m }
{
    \StartMainMatter
    \ProcessList {#1} {\subfile}
}

\NewDocumentCommand \LoadBackSubdocs { >{\SplitList{,}}m }
{
    \StartBackMatter
    \ProcessList {#1} {\subfile}
}


\NewDocumentCommand \LoadBib {m}
    { \addbibresource {#1} }

\NewDocumentCommand \LoadTex {m}
    { \input {#1} }


% Defaults, which should be changed.
% These are all passed to \hypersetup at the end.
\SetInfo
{
    title       = A Title ,
    author      = An Author ,
    subject     = A Subject ,
    keywords    = {Several, Keywords} ,
    degree      = some degree ,
    lang        = \g_dez_lang_str ,
}




%==================================================================================================
%                    final things
%==================================================================================================

% Nomenclature!
\makenomenclature

% Run \makeindex
\dez_if_feat_enabled:nT {imakeidx}
{
    \tl_set_eq:NN \l_tmpa_tl \g_dez_lay_index_cols_int
    \tl_set:Nx \l_tmpb_tl { \dim_use:N \g_dez_lay_index_col_sep_dim }
    \bool_if:NTF \g_dez_toc_index_bool
        {
            \makeindex [ intoc, columns = {\l_tmpa_tl},  columnsep = {\l_tmpb_tl} ]
        }
        { 
            \makeindex [        columns = {\l_tmpa_tl},  columnsep = {\l_tmpb_tl} ]
        }
}


\AtEndPreamble
{
    \AddPdfHyperxmpData  % from info.sty
}

\g_dez__end_tl
