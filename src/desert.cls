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
\ProvidesExplClass {desert} {2022-07-04} {0.1.0} { Desert~dissertation~template }



%======================================================================================================================
%                    hooks for fancy users
%======================================================================================================================

\hook_new:n { dez / before }
\hook_new:n { dez / after }

\hook_new:n { dez / front-matter / early }
\hook_new:n { dez / front-matter / late }

\hook_new:n { dez / main-matter / early }
\hook_new:n { dez / main-matter / late }

\hook_new:n { dez / back-matter / early }
\hook_new:n { dez / back-matter / late }

\hook_new:n { dez / packages / before }
\hook_new:n { dez / packages / after }

\hook_new:n { dez / lof-like / before }
\hook_new:n { dez / lof-like / after }
\hook_new:n { dez / lof-like / pre }
\hook_new:n { dez / lof-like / post }

\hook_new:n { dez / show-bib / before }
\hook_new:n { dez / show-bib / after }
\hook_new:n { dez / show-bib / pre }
\hook_new:n { dez / show-bib / post }

\hook_new:n { dez / show-endnotes / before }
\hook_new:n { dez / show-endnotes / after }
\hook_new:n { dez / show-endnotes / pre }
\hook_new:n { dez / show-endnotes / post }


% internal
\ProvideDocumentCommand \DezPartPageCmd {}
    { \cleardoublepage }
    
\ProvideDocumentCommand \DezMainChapterPageCmd {}
    { \cleardoublepage }
    
\ProvideDocumentCommand \DezChapterPageCmd {}
    { \clearpage }

\cs_new_protected:Nn \dez__one_col:
{
    %\newgeometry{onecolumn}  % TODO: should we?
}
\cs_new_protected:Nn \dez__restore_col:
{
    %\restoregeometry
}

\hook_use:n { dez / before }


% Make _ and ^ inactive in text mode
%\catcode`\_=\active
%\def _ { \relax \ifmmode \sb \else \_ \fi }
%\catcode`\^=\active
%\def _ { \relax \ifmmode \sp \else \^ \fi }

% https://tex.stackexchange.com/questions/245880/repeated-labels-may-have-changed-when-using-catcode-12-underscore-hack-wi
%\hook_gput_code:nnn
%{begindocument/end}
%{dez/fix-cat-codes}
%{
%    \catcode`_=12
%    \begingroup\lccode`~=`_
%    \lowercase{\endgroup\let~}\sb
%    \mathcode`_="8000
%    \immediate\write\@auxout{\catcode`_=12 }
%}


%======================================================================================================================
%                    meta utils
%======================================================================================================================


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
\cs_generate_variant:Nn \prop_gset_from_keyval:Nn { NV }
\cs_generate_variant:Nn \prop_gput_if_new:Nnn { NnV }

\exp_args_generate:n { cn,  co,  cV,  cv,  ce,  cf,  cx }
\exp_args_generate:n { ccn, cco, ccV, ccv, cce, ccf, ccx }
\exp_args_generate:n { Nen, Neo, NeV, Nev,    , Nef, Nex }
\exp_args_generate:n { cen, ceo, ceV, cev, cee, cef, cex }
\exp_args_generate:n { Nnee }

\cs_new_protected:Npn \begin_:n #1
    { \begin {#1} }
\cs_generate_variant:Nn \begin_:n { V }

\cs_new_protected:Npn \begin_r:nn #1#2
    { \begin {#1} {#2} }
\cs_generate_variant:Nn \begin_r:nn { nV, Vn, VV }

\cs_new_protected:Npn \begin_o:nn #1#2
    { \begin {#1} [#2] }
\cs_generate_variant:Nn \begin_o:nn { nV, Vn, VV }

\cs_new_protected:Npn \begin_rr:nnn #1#2#3
    { \begin {#1} {#2} {#3} }
\cs_generate_variant:Nn \begin_rr:nnn { nnV, nVn, Vnn, nVV, VnV, VVn, VVV }

\cs_new_protected:Npn \begin_ro:nnn #1#2#3
    { \begin {#1} {#2} [#3] }
\cs_generate_variant:Nn \begin_ro:nnn { nnV, nVn, Vnn, nVV, VnV, VVn, VVV }

\cs_new_protected:Npn \begin_or:nnn #1#2#3
    { \begin {#1} [#2] {#3} }
\cs_generate_variant:Nn \begin_or:nnn { nnV, nVn, Vnn, nVV, VnV, VVn, VVV }

\cs_new_protected:Npn \begin_oo:nnn #1#2#3
    { \begin {#1} [#2] [#3] }
\cs_generate_variant:Nn \begin_oo:nnn { nnV, nVn, Vnn, nVV, VnV, VVn, VVV }

\cs_new_protected:Npn \end_:n #1
    { \end {#1} }
\cs_generate_variant:Nn \end_:n { V }



%\prg_new_conditional:Npnn \pkg_if_loaded:n #1 { T, F, TF }
%{
%    \@ifpackageloaded {#1}
%    { \prg_return_true: }
%    { \prg_return_false: }
%}



%======================================================================================================================
%                      errors, warnings, messages, etc.
%======================================================================================================================

\msg_new:nnn {dez} {nosuchpreset}
    { Preset~'#1'~not~available:~no~command~of~that~name. }
\cs_new_protected:Npn \dez__warn_nosuchpreset:n #1
    { \msg_warning:nnn {dez} {nosuchpreset} {#1} }
\cs_generate_variant:Nn \dez__warn_nosuchpreset:n { V, v }

\msg_new:nnn {dez} {generic}
    { #1 }
\cs_new_protected:Npn \dez__info:n #1
    { \msg_info:nnn {dez} {generic} {#1} }
\cs_new_protected:Npn \dez__note:n #1
    { \msg_note:nnn {dez} {generic} {#1} }
\cs_new_protected:Npn \dez__warning:n #1
    { \msg_warning:nnn {dez} {generic} {#1} }

\msg_new:nnn {dez} {cmdneedspkg}
    { \c_backslash_str #1~requires~option~'pkg/#2' }
\cs_new_protected:Npn \dez__warn_cmdneedspkg:nn #1#2
    { \msg_warning:nnnn {dez} {cmdneedspkg} {#1} {#2} }

\msg_new:nnn {dez} {envneedspkg}
    { Environment~#1~requires~option~'pkg/#2' }
\cs_new_protected:Npn \dez__warn_envneedspkg:nn #1#2
    { \msg_warning:nnnn {dez} {envneedspkg} {#1} {#2} }



%======================================================================================================================
%                    Load report class!
%======================================================================================================================

% Load report BEFORE DECLARING OPTIONS!!
% Otherwise em and ex units are zero.
\LoadClass {report}



%======================================================================================================================
%                    internal aliases and containers
%======================================================================================================================

% containers to store package options
\tl_new:N \g_dez__end_tl
\tl_gset:Nn \g_dez__end_tl {}

\prop_new:N \g_dez_unary_prop
\prop_new:N \g_dez_color_prop

\prop_new:N \g_dez_header_front_prop
\prop_new:N \g_dez_header_main_prop
\prop_new:N \g_dez_header_back_prop

\prop_new:N \g_dez_footer_front_prop
\prop_new:N \g_dez_footer_main_prop
\prop_new:N \g_dez_footer_back_prop


% Saving optional features

\seq_new:N \g_dez_feat_seq

\prg_new_conditional:Npnn  \dez_if_feat_enabled:n #1 { T, F, TF }
{
    \seq_if_in:NnTF \g_dez_feat_seq {#1}
    { \prg_return_true: }
    { \prg_return_false: }
}

\NewDocumentCommand \@DezLoadFeat { O{} m }
{
    \seq_if_in:NnT \g_dez_feat_seq {#2}
        { \RequirePackage [#1] {#2} }
}

\let \@PP \PassOptionsToPackage
\let \@RP \RequirePackage
\let \@LF \@DezLoadFeat
\let \@TZ \UseTikzLibrary
\let \@PG \UsePgfLibrary
\let \@GD \UseGdLibrary

\cs_new_protected:Npn \dez__add_feat:nn #1#2
{
    \seq_gput_right:Nn \g_dez_feat_seq {#1}
    \tl_if_blank:nF {#2} { \@PP{#2}{#1} }  % guard -- sometimes not a real package
}

\cs_new_protected:Npn \dez__add_feet:n #1
{
    \seq_gput_right:Nn \g_dez_feat_seq {#1}
}

\let \@add_feat  \dez__add_feat:nn
\let \@add_feet  \dez__add_feet:n
\let \@tl_to     \tl_gset_eq:NN
\let \@str_to    \str_gset_eq:NN
\let \@prop_to   \prop_gset_from_keyval:NV


%======================================================================================================================
%                    package options and setup
%======================================================================================================================

\keys_define:nn {dez}
{

draft .bool_gset:N                       = \g_dez_draft_bool ,
draft .default:n                         = true ,
draft .initial:n                         = false ,
preset .tl_gset:N                        = \g_dez_preset_str ,
preset .initial:n                        = AFour ,
preset .value_required:n                 = true ,
mode .choices:nn                         = { thesis, article, book, }
                                           { \@str_to \g_dez_mode_str \l_keys_choice_tl } ,
mode .initial:n                          = thesis ,
mode .value_required:n                   = true ,

lang / main .tl_gset:N                   = \g_dez_lang_str ,
lang / main .initial:n                   = american ,
lang / main .value_required:n            = true ,
lang / extras .tl_gset:N                 = \g_dez_langs_str ,
lang / extras .initial:n                 = {} ,
lang / extras .value_required:n          = true ,

pkg / svg .code:n                        = { \@add_feat {svg} {#1} } ,
pkg / noms .code:n                       = { \@add_feat {noms} {#1} } ,
pkg / kantlipsum .code:n                 = { \@add_feat {kantlipsum} {#1} } ,
pkg / imakeidx .code:n                   = { \@add_feat {imakeidx} {#1} } ,
pkg / tikz-cd .code:n                    = { \@add_feat {tikz-cd} {#1} } ,
pkg / knowledge .code:n                  = { \@add_feat {knowledge} {#1} } ,
pkg / lettrine .code:n                   = { \@add_feat {lettrine} {#1} } ,
pkg / ulem .code:n                       = { \@add_feat {ulem} {#1} } ,
pkg / varioref .code:n                   = { \@add_feat {varioref} {#1} } ,
pkg / tikz .code:n                       = { \@add_feat {tikz} {#1} } ,
pkg / graphs .code:n                     = { \@add_feet {graphs} } ,
pkg / fontawesome5 .code:n               = { \@add_feat {fontawesome5} {#1} } ,
pkg / tcolorbox .code:n                  = { \@add_feat {tcolorbox} {#1} } ,
pkg / minted .code:n                     = { \@add_feat {minted} {#1} } ,
pkg / chemformula .code:n                = { \@add_feat {chemformula} {#1} } ,
pkg / chemmacros .code:n                 = { \@add_feat {chemmacros} {#1} } ,
pkg / chemfig .code:n                    = { \@add_feat {chemfig} {#1} } ,
pkg / circuitikz .code:n                 = { \@add_feat {circuitikz} {#1} } ,
pkg / cryptocode .code:n                 = { \@add_feat {cryptocode} {#1} } ,

bib / hide-lang .bool_gset:N             = \g_dez_bib_hide_lang_bool ,
bib / hide-lang .default:n               = true ,
bib / hide-lang .initial:n               = false ,
bib / per-chap .bool_gset:N              = \g_dez_bib_per_chap_bool ,
bib / per-chap .default:n                = true ,
bib / per-chap .initial:n                = false ,
bib / style .tl_gset:N                   = \g_dez_bib_style_str ,
bib / style .initial:n                   = ieee ,
bib / style .value_required:n            = true ,

color / off .meta:n                      = {
                                            color/even-row=white, color/cite={}, color/file={},
                                            color/run={}, color/ref={}, color/url={},
                                           } ,
color / off .bool_gset:N                 = \g_dez_color_no_bool ,
color / off .value_forbidden:n           = true ,
color / even-row .tl_gset:N              = \g_dez_even_row_bg_tl ,
color / even-row .default:n              = black!2!white ,
color / even-row .initial:n              = white ,
color / cite .prop_gput:N                = \g_dez_color_prop ,
color / cite .default:n                  = blue ,
color / cite .initial:n                  = blue ,
color / file .prop_gput:N                = \g_dez_color_prop ,
color / file .default:n                  = red ,
color / file .initial:n                  = red ,
color / run .prop_gput:N                 = \g_dez_color_prop ,
color / run .default:n                   = red ,
color / run .initial:n                   = red ,
color / ref .prop_gput:N                 = \g_dez_color_prop ,
color / ref .default:n                   = blue ,
color / ref .initial:n                   = blue ,
color / url .prop_gput:N                 = \g_dez_color_prop ,
color / url .default:n                   = blue ,
color / url .initial:n                   = blue ,

font / math .choices:nn                  = { Noto, LatinModern, STIX, Bonum, Pagella, Schola, Termes, DejaVu, }
                                           { \@str_to \g_dez_font_math_str \l_keys_choice_tl } ,
font / math .initial:n                   = STIX ,
font / math .value_required:n            = true ,
font / serif .choices:nn                 = { Noto, LatinModern, STIX, SourcePro, Plex, }
                                           { \@str_to \g_dez_font_serif_str \l_keys_choice_tl } ,
font / serif .initial:n                  = Noto ,
font / serif .value_required:n           = true ,
font / sans .choices:nn                  = { Noto, LatinModern, SourcePro, Plex, }
                                           { \@str_to \g_dez_font_sans_str \l_keys_choice_tl } ,
font / sans .initial:n                   = Noto ,
font / sans .value_required:n            = true ,
font / mono .choices:nn                  = { Noto, Noto/serif, Noto/serif, LatinModern, SourcePro, Plex, Cascadia, }
                                           { \@str_to \g_dez_font_mono_str \l_keys_choice_tl } ,
font / mono .initial:n                   = Noto ,
font / mono .value_required:n            = true ,
font / size .tl_gset:N                   = \g_dez_font_size_tl ,
font / size .initial:n                   = 11pt ,
font / size .value_required:n            = true ,
font / leading .tl_gset:N                = \g_dez_font_leading_tl ,
font / leading .initial:n                = {} ,  % empty ==> +20%
font / leading .value_required:n         = true ,

header / L .meta:n                       = { header/front/L={#1},  header/main/L={#1},  header/back/L={#1}  } ,
header / L .value_required:n             = true ,
header / LE .meta:n                      = { header/front/LE={#1}, header/main/LE={#1}, header/back/LE={#1} } ,
header / LE .value_required:n            = true ,
header / LO .meta:n                      = { header/front/LO={#1}, header/main/LO={#1}, header/back/LO={#1} } ,
header / LO .value_required:n            = true ,
header / R .meta:n                       = { header/front/R={#1},  header/main/R={#1},  header/back/R={#1}  } ,
header / R .value_required:n             = true ,
header / RE .meta:n                      = { header/front/RE={#1}, header/main/RE={#1}, header/back/RE={#1} } ,
header / RE .value_required:n            = true ,
header / RO .meta:n                      = { header/front/RO={#1}, header/main/RO={#1}, header/back/RO={#1} } ,
header / RO .value_required:n            = true ,
header / C .meta:n                       = { header/front/E={#1},  header/main/C={#1},  header/back/C={#1}  } ,
header / C .value_required:n             = true ,
header / CE .meta:n                      = { header/front/CE={#1}, header/main/CE={#1}, header/back/CE={#1} } ,
header / CE .value_required:n            = true ,
header / CO .meta:n                      = { header/front/CO={#1}, header/main/CO={#1}, header/back/CO={#1} } ,
header / CO .value_required:n            = true ,
header / front / L .prop_gput:N          = \g_dez_header_front_prop ,
header / front / L .value_required:n     = true ,
header / front / LE .prop_gput:N         = \g_dez_header_front_prop ,
header / front / LE .value_required:n    = true ,
header / front / LO .prop_gput:N         = \g_dez_header_front_prop ,
header / front / LO .value_required:n    = true ,
header / front / R .prop_gput:N          = \g_dez_header_front_prop ,
header / front / R .value_required:n     = true ,
header / front / RE .prop_gput:N         = \g_dez_header_front_prop ,
header / front / RE .value_required:n    = true ,
header / front / RO .prop_gput:N         = \g_dez_header_front_prop ,
header / front / RO .value_required:n    = true ,
header / front / C .prop_gput:N          = \g_dez_header_front_prop ,
header / front / C .value_required:n     = true ,
header / front / CE .prop_gput:N         = \g_dez_header_front_prop ,
header / front / CE .value_required:n    = true ,
header / front / CO .prop_gput:N         = \g_dez_header_front_prop ,
header / front / CO .value_required:n    = true ,
header / main / L .prop_gput:N           = \g_dez_header_main_prop ,
header / main / L .value_required:n      = true ,
header / main / LE .prop_gput:N          = \g_dez_header_main_prop ,
header / main / LE .value_required:n     = true ,
header / main / LO .prop_gput:N          = \g_dez_header_main_prop ,
header / main / LO .value_required:n     = true ,
header / main / R .prop_gput:N           = \g_dez_header_main_prop ,
header / main / R .value_required:n      = true ,
header / main / RE .prop_gput:N          = \g_dez_header_main_prop ,
header / main / RE .value_required:n     = true ,
header / main / RO .prop_gput:N          = \g_dez_header_main_prop ,
header / main / RO .value_required:n     = true ,
header / main / C .prop_gput:N           = \g_dez_header_main_prop ,
header / main / C .value_required:n      = true ,
header / main / CE .prop_gput:N          = \g_dez_header_main_prop ,
header / main / CE .value_required:n     = true ,
header / main / CO .prop_gput:N          = \g_dez_header_main_prop ,
header / back / CO .value_required:n     = true ,
header / back / L .prop_gput:N           = \g_dez_header_back_prop ,
header / back / L .value_required:n      = true ,
header / back / LE .prop_gput:N          = \g_dez_header_back_prop ,
header / back / LE .value_required:n     = true ,
header / back / LO .prop_gput:N          = \g_dez_header_back_prop ,
header / back / LO .value_required:n     = true ,
header / back / R .prop_gput:N           = \g_dez_header_back_prop ,
header / back / R .value_required:n      = true ,
header / back / RE .prop_gput:N          = \g_dez_header_back_prop ,
header / back / RE .value_required:n     = true ,
header / back / RO .prop_gput:N          = \g_dez_header_back_prop ,
header / back / RO .value_required:n     = true ,
header / back / C .prop_gput:N           = \g_dez_header_back_prop ,
header / back / C .value_required:n      = true ,
header / back / CE .prop_gput:N          = \g_dez_header_back_prop ,
header / back / CE .value_required:n     = true ,
header / back / CO .prop_gput:N          = \g_dez_header_back_prop ,
header / back / CO .value_required:n     = true ,

footer / L .meta:n                       = { footer/front/L={#1},  footer/main/L={#1},  footer/back/L={#1}  } ,
footer / L .value_required:n             = true ,
footer / LE .meta:n                      = { footer/front/LE={#1}, footer/main/LE={#1}, footer/back/LE={#1} } ,
footer / LE .value_required:n            = true ,
footer / LO .meta:n                      = { footer/front/LO={#1}, footer/main/LO={#1}, footer/back/LO={#1} } ,
footer / LO .value_required:n            = true ,
footer / R .meta:n                       = { footer/front/R={#1},  footer/main/R={#1},  footer/back/R={#1}  } ,
footer / R .value_required:n             = true ,
footer / RE .meta:n                      = { footer/front/RE={#1}, footer/main/RE={#1}, footer/back/RE={#1} } ,
footer / RE .value_required:n            = true ,
footer / RO .meta:n                      = { footer/front/RO={#1}, footer/main/RO={#1}, footer/back/RO={#1} } ,
footer / RO .value_required:n            = true ,
footer / C .meta:n                       = { footer/front/E={#1},  footer/main/C={#1},  footer/back/C={#1}  } ,
footer / C .value_required:n             = true ,
footer / CE .meta:n                      = { footer/front/CE={#1}, footer/main/CE={#1}, footer/back/CE={#1} } ,
footer / CE .value_required:n            = true ,
footer / CO .meta:n                      = { footer/front/CO={#1}, footer/main/CO={#1}, footer/back/CO={#1} } ,
footer / CO .value_required:n            = true ,
footer / front / L .prop_gput:N          = \g_dez_footer_front_prop ,
footer / front / L .value_required:n     = true ,
footer / front / LE .prop_gput:N         = \g_dez_footer_front_prop ,
footer / front / LE .value_required:n    = true ,
footer / front / LO .prop_gput:N         = \g_dez_footer_front_prop ,
footer / front / LO .value_required:n    = true ,
footer / front / R .prop_gput:N          = \g_dez_footer_front_prop ,
footer / front / R .value_required:n     = true ,
footer / front / RE .prop_gput:N         = \g_dez_footer_front_prop ,
footer / front / RE .value_required:n    = true ,
footer / front / RO .prop_gput:N         = \g_dez_footer_front_prop ,
footer / front / RO .value_required:n    = true ,
footer / front / C .prop_gput:N          = \g_dez_footer_front_prop ,
footer / front / C .value_required:n     = true ,
footer / front / CE .prop_gput:N         = \g_dez_footer_front_prop ,
footer / front / CE .value_required:n    = true ,
footer / front / CO .prop_gput:N         = \g_dez_footer_front_prop ,
footer / front / CO .value_required:n    = true ,
footer / main / L .prop_gput:N           = \g_dez_footer_main_prop ,
footer / main / L .value_required:n      = true ,
footer / main / LE .prop_gput:N          = \g_dez_footer_main_prop ,
footer / main / LE .value_required:n     = true ,
footer / main / LO .prop_gput:N          = \g_dez_footer_main_prop ,
footer / main / LO .value_required:n     = true ,
footer / main / R .prop_gput:N           = \g_dez_footer_main_prop ,
footer / main / R .value_required:n      = true ,
footer / main / RE .prop_gput:N          = \g_dez_footer_main_prop ,
footer / main / RE .value_required:n     = true ,
footer / main / RO .prop_gput:N          = \g_dez_footer_main_prop ,
footer / main / RO .value_required:n     = true ,
footer / main / C .prop_gput:N           = \g_dez_footer_main_prop ,
footer / main / C .value_required:n      = true ,
footer / main / CE .prop_gput:N          = \g_dez_footer_main_prop ,
footer / main / CE .value_required:n     = true ,
footer / main / CO .prop_gput:N          = \g_dez_footer_main_prop ,
footer / back / CO .value_required:n     = true ,
footer / back / L .prop_gput:N           = \g_dez_footer_back_prop ,
footer / back / L .value_required:n      = true ,
footer / back / LE .prop_gput:N          = \g_dez_footer_back_prop ,
footer / back / LE .value_required:n     = true ,
footer / back / LO .prop_gput:N          = \g_dez_footer_back_prop ,
footer / back / LO .value_required:n     = true ,
footer / back / R .prop_gput:N           = \g_dez_footer_back_prop ,
footer / back / R .value_required:n      = true ,
footer / back / RE .prop_gput:N          = \g_dez_footer_back_prop ,
footer / back / RE .value_required:n     = true ,
footer / back / RO .prop_gput:N          = \g_dez_footer_back_prop ,
footer / back / RO .value_required:n     = true ,
footer / back / C .prop_gput:N           = \g_dez_footer_back_prop ,
footer / back / C .value_required:n      = true ,
footer / back / CE .prop_gput:N          = \g_dez_footer_back_prop ,
footer / back / CE .value_required:n     = true ,
footer / back / CO .prop_gput:N          = \g_dez_footer_back_prop ,
footer / back / CO .value_required:n     = true ,

layout / geometry .tl_gset:N             = \g_dez_geometry_tl ,
layout / geometry .initial:n             = {} ,
layout / geometry .value_required:n      = true ,
layout / nom-sym-width .dim_gset:N       = \g_dez_nom_symbol_dim ,
layout / nom-sym-width .initial:n        = 4em ,
layout / nom-sym-width .value_required:n = true ,
layout / index-cols .int_gset:N          = \g_dez_lay_index_cols_int ,
layout / index-cols .initial:n           = 2 ,
layout / index-cols .value_required:n    = true ,
layout / index-col-sep .dim_gset:N       = \g_dez_lay_index_col_sep_dim ,
layout / index-col-sep .initial:n        = 3em ,
layout / index-col-sep .value_required:n = true ,

layout / subsec-runin .bool_gset:N       = \g_dez_subsec_runin_bool ,
layout / subsec-runin .default:n         = true ,
layout / subsec-runin .initial:n         = false ,
layout / subsubsec-runin .bool_gset:N    = \g_dez_subsubsec_runin_bool ,
layout / subsubsec-runin .default:n      = true ,
layout / subsubsec-runin .initial:n      = false ,
layout / fnotes-to-endnotes .bool_gset:N = \g_dez_force_endnotes_bool ,
layout / fnotes-to-endnotes .default:n   = true ,
layout / fnotes-to-endnotes .initial:n   = false ,
layout / endnote-backrefs .bool_gset:N   = \g_dez_endnote_backrefs_bool,
layout / endnote-backrefs .default:n     = true ,
layout / endnote-backrefs .initial:n     = false ,
layout / show-toc-links .bool_gset:N     = \g_dez_show_toc_links_bool,
layout / show-toc-links .default:n       = true ,
layout / show-toc-links .initial:n       = false ,
layout / fnote-align .choices:nn         = { justify, left, right, center }
                                           { \@str_to \g_dez_fnote_align_str \l_keys_choice_tl } ,
layout / fnote-align .initial:n          = left ,
layout / fnote-align .value_required:n   = true ,
layout / fnote-place .choices:nn         = {
                                             default, abovefloats, belowfloats,
                                             bottom, bottomfloats, bottomfootnotes,
                                           }
                                           { \@str_to \g_dez_fnote_place_str \l_keys_choice_tl } ,
layout / fnote-place .initial:n           = default ,
layout / fnote-place .value_required:n    = true ,

stretch / single .meta:n                  = { stretch/main=1.0, stretch/cap=1.0, stretch/eqn=1.0 ,
                                              stretch/toc=1.0, stretch/list-of=1.0, stretch/nom=1.0,
                                              stretch/table=1.0, stretch/refs=1.0, stretch/code=1.0 ,
                                              font / leading = {} ,
                                            } ,
stretch / single .value_forbidden:n       = true ,
stretch / one-half .meta:n                = { stretch/main=1.25, stretch/cap=1.25, stretch/eqn=1.25 ,
                                              stretch/toc=1.25, stretch/list-of=1.25, stretch/nom=1.25,
                                              stretch/table=1.0, stretch/refs=1.0, stretch/code=1.0 ,
                                              font / leading = {} ,
stretch / one-half .value_forbidden:n     = true ,
                                            } ,
stretch / double .meta:n                  = { stretch/main=1.66667, stretch/cap=1.0, stretch/eqn=1.66667 ,
                                              stretch/toc=1.66667, stretch/list-of=1.66667, stretch/nom=1.66667,
                                              stretch/table=1.0, stretch/refs=1.0, stretch/code=1.0 ,
                                              font / leading = {} ,
                                            } ,
stretch / double .value_forbidden:n      = true ,
stretch / main .fp_gset:N                = \g_dez_stretch_main_fp ,
stretch / main .initial:n                = 1.5 ,
stretch / main .value_required:n         = true ,
stretch / cap .fp_gset:N                 = \g_dez_stretch_caption_fp ,
stretch / cap .initial:n                 = 1.25 ,
stretch / cap .value_required:n          = true ,
stretch / eqn .fp_gset:N                 = \g_dez_stretch_eqn_fp ,
stretch / eqn .initial:n                 = 1.25 ,
stretch / eqn .value_required:n          = true ,
stretch / toc .fp_gset:N                 = \g_dez_stretch_toc_fp ,
stretch / toc .initial:n                 = 1.25 ,
stretch / toc .value_required:n          = true ,
stretch / list-of .fp_gset:N             = \g_dez_stretch_lof_fp ,
stretch / list-of .initial:n             = 1.25 ,
stretch / list-of .value_required:n      = true ,
stretch / nom .fp_gset:N                 = \g_dez_stretch_nom_fp ,
stretch / nom .initial:n                 = 1.25 ,
stretch / nom .value_required:n          = true ,
stretch / table .fp_gset:N               = \g_dez_stretch_table_fp ,
stretch / table .initial:n               = 1.25 ,
stretch / table .value_required:n        = true ,
stretch / refs .fp_gset:N                = \g_dez_stretch_refs_fp ,
stretch / refs .initial:n                = 1.25 ,
stretch / refs .value_required:n         = true ,
stretch / code .fp_gset:N                = \g_dez_stretch_code_fp ,
stretch / code .initial:n                = 1.25 ,
stretch / code .value_required:n         = true ,

num / depth .choices:nn                  = {
                                             none, chapter, section, subsection, subsec, subsubsection,
                                             subsubsec, paragraph, par, subparagraph, subpar,
                                           }
                                           { \@str_to \g_dez_n_depth_str \l_keys_choice_tl } ,
num / depth .initial:n                   = subparagraph ,
num / depth .value_required:n            = true ,
num / back-pages .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_back_str \l_keys_choice_tl } ,
num / back-pages .initial:n              = arabic ,
num / back-pages .value_required:n       = true ,
num / front-chaps .choices:nn            = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_front_chp_str \l_keys_choice_tl } ,
num / front-chaps .initial:n             = Roman ,
num / front-chaps .value_required:n      = true ,
num / main-chaps .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_main_chps_str \l_keys_choice_tl } ,
num / main-chaps .initial:n              = arabic ,
num / main-chaps .value_required:n       = true ,
num / back-chaps .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_back_chp_str \l_keys_choice_tl } ,
num / back-chaps .initial:n              = Alph ,
num / back-chaps .value_required:n       = true ,
num / panels .choices:nn                 = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_panels_str \l_keys_choice_tl } ,
num / panels .initial:n                  = alph ,
num / panels .value_required:n           = true ,
num / eqn-brackets .choices:nn           = {
                                             none, round, square, curly, none-bold,
                                             round-bold, square-bold, curly-bold,
                                           }
                                           { \@str_to \g_dez_n_brackets_str \l_keys_choice_tl } ,
num / eqn-brackets .initial:n            = round ,
num / eqn-brackets .value_required:n     = true ,
num / eqn-in .choices:nn                 = { none, chapter, section, subsection, subsec, subsubsection, subsubsec, }
                                           { \@str_to \g_dez_eqn_in_str \l_keys_choice_tl } ,
num / eqn-in .initial:n                  = chapter ,
num / eqn-in .value_required:n           = true ,
num / float-in .choices:nn               = { none, chapter, section, subsection, subsec, subsubsection, subsubsec, }
                                           { \@str_to \g_dez_float_in_str \l_keys_choice_tl } ,
num / float-in .initial:n                = chapter ,
num / float-in .value_required:n         = true ,
num / fnote-in .choices:nn               = { none, page, chapter, }
                                           { \@str_to \g_dez_fnote_in_str \l_keys_choice_tl } ,
num / fnote-in .initial:n                = page ,
num / fnote-in .value_required:n         = true ,
num / fnotes .choices:nn                 = {
                                             arabic, roman, Roman, alph, Alph, lamport, lamport*,
                                             bringhurst, chicago, wiley, dez-fancy ,
                                           }
                                           { \@str_to \g_dez_n_fnotes_str \l_keys_choice_tl } ,
num / fnotes .initial:n                  = lamport* ,
num / fnotes .value_required:n           = true ,
num / front-pages .choices:nn            = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_front_str \l_keys_choice_tl } ,
num / front-pages .initial:n             = roman ,
num / front-pages .value_required:n      = true ,
num / main-pages .choices:nn             = { arabic, roman, Roman, alph, Alph, }
                                           { \@str_to \g_dez_n_main_str \l_keys_choice_tl } ,
num / main-pages .initial:n              = arabic ,
num / main-pages .value_required:n       = true ,
num / thm-like-in .choices:nn            = { none, chapter, section, subsection, subsec, subsubsection, subsubsec, }
                                           { \@str_to \g_dez_thm_in_str \l_keys_choice_tl } ,
num / thm-like-in .initial:n             = chapter ,
num / thm-like-in .value_required:n      = true ,

ref / abbrev .bool_gset:N                = \g_dez_cref_abbrev_bool ,
ref / abbrev .default:n                  = true ,
ref / abbrev .initial:n                  = false ,
ref / capitalize .bool_gset:N            = \g_dez_cref_capitalize_bool ,
ref / capitalize .default:n              = true ,
ref / capitalize .initial:n              = false ,

sty / abs-by .prop_gput:N                = \g_dez_unary_prop ,
sty / abs-by .initial:n                  = largerr ,
sty / abs-authors .prop_gput:N           = \g_dez_unary_prop ,
sty / abs-authors .initial:n             = largerr ,
sty / abs-title .prop_gput:N             = \g_dez_unary_prop ,
sty / abs-title .initial:n               = Large; bold ,
sty / caption-body .prop_gput:N          = \g_dez_unary_prop ,
sty / caption-body .initial:n            = small; sans ,
sty / caption-label .prop_gput:N         = \g_dez_unary_prop ,
sty / caption-label .initial:n           = small; sans; bold ,
sty / subcap-body .prop_gput:N           = \g_dez_unary_prop ,
sty / subcap-body .initial:n             = small; sans ,
sty / subcap-label .prop_gput:N          = \g_dez_unary_prop ,
sty / subcap-label .initial:n            = small; sans; bold ,
sty / subref .prop_gput:N                = \g_dez_unary_prop ,
sty / subref .initial:n                  = bold ,
sty / table-head-body .prop_gput:N       = \g_dez_nullary_prop ,
sty / table-head-body .initial:n         = small; sans; bold ,
sty / table-head-label .prop_gput:N      = \g_dez_nullary_prop ,
sty / table-head-label .initial:n        = small; sans; bold ,
sty / table-footer .prop_gput:N          = \g_dez_nullary_prop ,
sty / table-footer .initial:n            = small; sans ,
sty / admonition-label .prop_gput:N      = \g_dez_unary_prop ,
sty / admonition-label .initial:n        = large; bold; allcaps ,
sty / admonition-name .prop_gput:N       = \g_dez_unary_prop ,
sty / admonition-name .initial:n         = large; bold ,
sty / chap-label .prop_gput:N            = \g_dez_nullary_prop ,
sty / chap-label .initial:n              = Huge; 606060; smallcaps ,
sty / chap-name .prop_gput:N             = \g_dez_nullary_prop ,
sty / chap-name .initial:n               = huge ,
sty / front-chap-title .prop_gput:N      = \g_dez_nullary_prop ,
sty / front-chap-title .initial:n        = huge; smallcaps ,
sty / part-label .prop_gput:N            = \g_dez_nullary_prop ,
sty / part-label .initial:n              = Huge; bold ,
sty / part-name .prop_gput:N             = \g_dez_nullary_prop ,
sty / part-name .initial:n               = HUGE; bold ,
sty / fnote-body .prop_gput:N            = \g_dez_nullary_prop ,
sty / fnote-body .initial:n              = mini; sans ,
sty / indexed-starred .prop_gput:N       = \g_dez_unary_prop ,
sty / indexed-starred .initial:n         = italic ,
sty / nom-group .prop_gput:N             = \g_dez_unary_prop ,
sty / nom-group .initial:n               = bold; large ,
sty / section-title .prop_gput:N         = \g_dez_nullary_prop ,
sty / section-title .initial:n           = LARGE; bold ,
sty / code .prop_gput:N                  = \g_dez_nullary_prop ,
sty / code .initial:n                    = small; mono ,  %  mono is implied
sty / code-line-num .prop_gput:N         = \g_dez_nullary_prop ,
sty / code-line-num .initial:n           = small; mono ,  % mono is not implied
sty / subsec-title .prop_gput:N          = \g_dez_nullary_prop ,
sty / subsec-title .initial:n            = Large; bold ,
sty / subsubsec-title .prop_gput:N       = \g_dez_nullary_prop ,
sty / subsubsec-title .initial:n         = large; bold ,
sty / paragraph-title .prop_gput:N       = \g_dez_nullary_prop ,
sty / paragraph-title .initial:n         = bold ,
sty / toc-part .prop_gput:N              = \g_dez_nullary_prop ,
sty / toc-part .initial:n                = bold; large ,
sty / toc-chap .prop_gput:N              = \g_dez_nullary_prop ,
sty / toc-chap .initial:n                = bold; midrr ,
sty / toc-section .prop_gput:N           = \g_dez_nullary_prop ,
sty / toc-section .initial:n             = {} ,
sty / toc-subsec .prop_gput:N            = \g_dez_nullary_prop ,
sty / toc-subsec .initial:n              = {} ,
sty / toc-subsubsec .prop_gput:N         = \g_dez_nullary_prop ,
sty / toc-subsubsec .initial:n           = {} ,
sty / toc-page-num .prop_gput:N          = \g_dez_nullary_prop ,
sty / toc-page-num .initial:n            = {} ,
sty / tikz .prop_gput:N                  = \g_dez_nullary_prop ,
sty / tikz .initial:n                    = {} ,
sty / chem-name .prop_gput:N             = \g_dez_unary_prop ,
sty / chem-name .initial:n               = small; sans ,
sty / chemfig .tl_gset:N                 = \g_dez_sty_chemfig_tl,  % TODO
sty / chemfig .initial:n                 = mathrm ,

toc / bib .bool_gset:N                   = \g_dez_toc_bib_bool ,
toc / bib .default:n                     = true ,
toc / bib .initial:n                     = false ,
toc / index .bool_gset:N                 = \g_dez_toc_index_bool ,
toc / index .default:n                   = true ,
toc / index .initial:n                   = false ,
toc / depth .choices:nn                  = { none, chapter, section, subsection, subsec, subsubsection, subsubsec, }
                                           { \@str_to \g_dez_toc_depth_str \l_keys_choice_tl } ,
toc / depth .initial:n                   = subsection ,
toc / depth .value_required:n            = true ,
toc / endnotes .bool_gset:N              = \g_dez_toc_endnotes_bool ,
toc / endnotes .default:n                = true ,
toc / endnotes .initial:n                = false ,
toc / fig-panels .bool_gset:N            = \g_dez_toc_panels_bool ,
toc / fig-panels .default:n              = true ,
toc / fig-panels .initial:n              = false ,

typo / siunitx-match-mode .bool_gset:N   = \g_dez_typo_siunitx_match_bool ,
typo / siunitx-match-mode .default:n     = true ,
typo / siunitx-match-mode .initial:n     = false ,
typo / siunitx-group .choices:nn         = { none, all, decimal, integer, }
                                           { \@str_to \g_dez_typo_siunitx_group_str \l_keys_choice_tl } ,
typo / siunitx-group .initial:n          = all ,
typo / siunitx-group .value_required:n   = true ,
typo / max-quote-lines .int_gset:N       = \g_dez_typo_display_quote_lines_int ,
typo / max-quote-lines .initial:n        = 3 ,
typo / max-quote-lines .value_required:n = true ,
typo / ban-hyphens .bool_gset:N          = \g_dez_typo_ban_hyphens_bool ,
typo / ban-hyphens .default:n            = true ,
typo / ban-hyphens .initial:n            = false ,
typo / cap-label-sep .tl_gset:N          = \g_dez_typo_caption_label_sep_tl ,
typo / cap-label-sep .initial:n          = \quad ,
typo / cap-label-sep .value_required:n   = true ,
typo / subref-label-sep .tl_gset:N       = \g_dez_typo_subref_label_sep_tl ,
typo / subref-label-sep .initial:n       = {:~} ,
typo / subref-label-sep .value_required:n = true ,
typo / subref-format .tl_gset:N          = \g_dez_typo_subref_format_tl ,
typo / subref-format .initial:n          = parens ,
typo / subref-format .value_required:n   = true ,
typo / table-note-sep .tl_gset:N         = \g_dez_typo_table_note_sep_tl ,
typo / table-note-sep .initial:n         = {}\thinspace ,
typo / table-note-sep .value_required:n  = true ,
typo / table-rem-sep .tl_gset:N          = \g_dez_typo_table_remark_sep_tl ,
typo / table-rem-sep .initial:n          = {:~} ,
typo / table-rem-sep .value_required:n   = true ,

glue< / indent .dim_gset:N               = \g_dez_indent_dim ,
glue< / indent .default:n                = 1em ,
glue< / indent .initial:n                = 0pt ,
glue< / fnote-indent .dim_gset:N         = \g_dez_fnote_indent_dim ,
glue< / fnote-indent .default:n          = 1em ,
glue< / fnote-indent .initial:n          = 0pt ,
glue< / fnote-text .dim_gset:N           = \g_dez_fnote_left_dim ,
glue< / fnote-text .initial:n            = 0.5em ,
glue< / fnote-text .value_required:n     = true ,
glue< / runin-title .skip_gset:N         = \g_dez_runin_dim ,
glue< / runin-title .initial:n           = 1em ,
glue< / runin-title .value_required:n    = true ,
glue< / toc-part .dim_gset:N             = \g_dez_toc_part_dim ,
glue< / toc-part .initial:n              = 0pc ,
glue< / toc-part .value_required:n       = true ,
glue< / toc-chap .dim_gset:N             = \g_dez_toc_chap_dim ,
glue< / toc-chap .initial:n              = 3pc ,
glue< / toc-chap .value_required:n       = true ,
glue< / toc-section .dim_gset:N          = \g_dez_toc_section_dim ,
glue< / toc-section .initial:n           = 3pc ,
glue< / toc-section .value_required:n    = true ,
glue< / toc-subsec .dim_gset:N           = \g_dez_toc_subsec_dim ,
glue< / toc-subsec .initial:n            = 3pc ,
glue< / toc-subsec .value_required:n     = true ,
glue< / toc-subsubsec .dim_gset:N        = \g_dez_toc_subsubsec_dim ,
glue< / toc-subsubsec .initial:n         = 3pc ,
glue< / toc-subsubsec .value_required:n  = true ,
glue< / thm-like-title .skip_gset:N      = \g_dez_glue_before_thm_title_skip ,
glue< / thm-like-title .initial:n        = 1em ,
glue< / thm-like-title .value_required:n = true ,

glue: / code-rule .dim_gset:N            = \g_dez_rule_pad_dim ,
glue: / code-rule .initial:n             = 1ex ,
glue: / code-rule .value_required:n      = true ,
glue: / float-float .skip_gset:N         = \g_dez_float_float_skip ,
glue: / float-float .initial:n           = 9pt plus 6pt minus 2pt,
glue: / float-float .value_required:n    = true ,
glue: / float-text .skip_gset:N          = \g_dez_float_text_skip ,
glue: / float-text .initial:n            = 12pt plus 9pt minus 3pt ,
glue: / float-text .value_required:n     = true ,
glue: / paragraph .skip_gset:N           = \g_dez_btw_paragraphs_skip ,
glue: / paragraph .initial:n             = 2ex plus 0.2ex minus 0.2ex ,
glue: / paragraph .value_required:n      = true ,
glue: / item .skip_gset:N                = \g_dez_btw_items_skip ,
glue: / item .initial:n                  = 0ex plus 0.1ex ,
glue: / item .value_required:n           = true ,
glue: / long-item .skip_gset:N           = \g_dez_btw_multipar_items_skip ,
glue: / long-item .initial:n             = 1ex plus 0.1ex,
glue: / long-item .value_required:n      = true ,
glue: / fnote .skip_gset:N               = \g_dez_btw_fnotes_skip ,
glue: / fnote .initial:n                 = 1ex plus 0.1ex minus 0.025ex ,
glue: / fnote .value_required:n          = true ,
glue: / fnote-pars .skip_gset:N          = \g_dez_btw_fnote_paragraphs_skip ,
glue: / fnote-pars .initial:n            = 0.8ex plus 0.08ex minus 0.02ex ,
glue: / fnote-pars .value_required:n     = true ,
glue: / lof-like .skip_gset:N            = \g_dez_btw_lof_items_skip ,
glue: / lof-like .initial:n              = 0ex ,
glue: / lof-like .value_required:n       = true ,
glue: / ref .skip_gset:N                 = \g_dez_btw_refs_skip ,
glue: / ref .initial:n                   = 0.5ex plus 0.05ex minus 0.0125ex ,
glue: / ref .value_required:n            = true ,
glue' / fnote-list .skip_gset:N          = \g_dez_abv_fnote_list_skip ,
glue' / fnote-list .initial:n            = 16pt plus 16pt ,
glue: / fnote-list .value_required:n     = true ,
glue. / fnote-list .skip_gset:N          = \g_dez_bel_fnote_list_skip ,
glue. / fnote-list .initial:n            = 12pt plus 12pt , % only if floats are below
glue: / fnote-lit .value_required:n      = true ,
glue' / cap .skip_gset:N                 = \g_dez_abv_caption_skip ,
glue' / cap .initial:n                   = 2ex plus 0.2ex minus 0.05ex ,
glue' / cap .value_required:n            = true ,
glue' / subcap .skip_gset:N              = \g_dez_abv_subcaption_skip ,
glue' / subcap .initial:n                = 2ex plus 0.2ex minus 0.05ex ,
glue' / subcap .value_required:n         = true ,
glue' / table-title .skip_gset:N         = \g_dez_abv_table_title_skip ,
glue' / table-title .initial:n           = 2ex plus 4ex minus 0.25ex ,
glue' / table-title .value_required:n    = true ,
glue. / table-title .skip_gset:N         = \g_dez_bel_table_title_skip ,
glue. / table-title .initial:n           = 2ex plus 1ex minus 0.25ex ,
glue. / table-title .value_required:n    = true ,
glue' / table-foot .skip_gset:N          = \g_dez_abv_table_footer_skip ,
glue' / table-foot .initial:n            = 1ex plus 0.5ex minus 0.125ex ,
glue' / table-foot .value_required:n     = true ,
glue. / table-foot .skip_gset:N          = \g_dez_bel_table_footer_skip ,
glue. / table-foot .initial:n            = 2ex plus 4ex minus 0.25ex ,
glue. / table-title .value_required:n    = true ,
glue' / front-chap .skip_gset:N          = \g_dez_abv_front_chap_skip ,
glue' / front-chap .initial:n            = 0ex ,  % TODO -- why?
glue' / front-chap .value_required:n     = true ,
glue. / front-chap .skip_gset:N          = \g_dez_bel_front_chap_skip ,
glue. / front-chap .initial:n            = 4ex plus 0.4ex minus 0.1ex ,
glue. / front-chap .value_required:n     = true ,
glue' / chap .skip_gset:N                = \g_dez_abv_chap_skip ,
glue' / chap .initial:n                  = 0ex ,
glue' / chap .value_required:n           = true ,
glue. / chap .skip_gset:N                = \g_dez_bel_chap_skip ,
glue. / chap .initial:n                  = 6ex plus 1.5ex minus 0.375ex ,
glue. / chap .value_required:n           = true ,
glue. / chap-label .skip_gset:N          = \g_dez_bel_chap_label_skip ,
glue. / chap-label .initial:n            = 2ex plus 0.2ex minus 0.05ex ,
glue. / chap-label .value_required:n     = true ,
glue. / part-label .skip_gset:N          = \g_dez_bel_part_label_skip ,
glue. / part-label .initial:n            = 10ex,
glue. / part-label .value_required:n     = true ,
glue' / section .skip_gset:N             = \g_dez_abv_section_skip ,
glue' / section .initial:n               = 8ex plus 2ex minus 0.5ex ,
glue' / section .value_required:n        = true ,
glue. / section .skip_gset:N             = \g_dez_bel_section_skip ,
glue. / section .initial:n               = 4ex plus 1ex minus 0.25ex ,
glue. / section .value_required:n        = true ,
glue' / subsec .skip_gset:N              = \g_dez_abv_subsec_skip ,
glue' / subsec .initial:n                = 6ex plus 3ex minus 0.75ex ,
glue' / subsec .value_required:n         = true ,
glue. / subsec .skip_gset:N              = \g_dez_bel_subsec_skip ,
glue. / subsec .initial:n                = 3ex plus 0.75ex minus 0.375ex ,
glue. / subsec .value_required:n         = true ,
glue' / subsubsec .skip_gset:N           = \g_dez_abv_subsubsec_skip ,
glue. / subsubsec .initial:n             = 2ex plus 0.2ex minus 0.05ex ,
glue' / subsubsec .value_required:n      = true ,
glue. / subsubsec .skip_gset:N           = \g_dez_bel_subsubsec_skip ,
glue. / subsubsec .initial:n             = 2ex plus 0.2ex minus 0.05ex ,
glue. / subsubsec .value_required:n      = true ,
glue' / nom-group .skip_gset:N           = \g_dez_abv_nomgroup_skip ,
glue' / nom-group .initial:n             = 2ex plus 0.2ex minus 0.05ex ,
glue' / nom-group .value_required:n      = true ,
glue' / lof-chap-group .skip_gset:N      = \g_dez_lof_chap_skip ,
glue' / lof-chap-group .default:n        = 2ex plus 0.2ex minus 0.05ex ,  % built-in was 10pt
glue' / lof-chap-group .initial:n        = 0ex ,
glue' / par-title .skip_gset:N           = \g_dez_abv_paragraph_skip ,
glue' / par-title .initial:n             = 2ex plus 0.2ex minus 0.2ex ,
glue' / par-title .value_required:n      = true ,
glue' / thm-like .skip_gset:N            = \g_dez_abv_thm_skip ,
glue' / thm-like .initial:n              = 3ex plus 0.375ex minus 0.1875ex ,
glue' / thm-like .value_required:n       = true ,
glue. / thm-like .skip_gset:N            = \g_dez_bel_thm_skip ,
glue. / thm-like .initial:n              = 3ex plus 0.375ex minus 0.1875ex ,
glue. / thm-like .value_required:n       = true ,
glue' / alg-like .skip_gset:N            = \g_dez_abv_alg_skip ,
glue' / alg-like .initial:n              = 3ex plus 0.375ex minus 0.1875ex ,
glue' / alg-like .value_required:n       = true ,
glue. / alg-like .skip_gset:N            = \g_dez_bel_alg_skip ,
glue. / alg-like .initial:n              = 4ex plus 1ex minus 0.25ex ,
glue. / alg-like .value_required:n       = true ,
glue' / def-like .skip_gset:N            = \g_dez_abv_def_skip ,
glue' / def-like .initial:n              = 3ex plus 0.375ex minus 0.1875ex ,
glue' / def-like .value_required:n       = true ,
glue. / def-like .skip_gset:N            = \g_dez_bel_def_skip ,
glue. / def-like .initial:n              = 3ex plus 0.375ex minus 0.1875ex ,
glue. / def-like .value_required:n       = true ,
glue' / rem-like .skip_gset:N            = \g_dez_abv_remark_skip ,
glue' / rem-like .initial:n              = 2ex plus 0.5ex minus 0.125ex ,
glue' / rem-like .value_required:n       = true ,
glue. / rem-like .skip_gset:N            = \g_dez_bel_remark_skip ,
glue. / rem-like .initial:n              = 2ex plus 0.5ex minus 0.125ex ,
glue. / rem-like .value_required:n       = true ,
glue' / proof .skip_gset:N               = \g_dez_abv_proof_skip ,
glue' / proof .initial:n                 = 2ex plus 0.5ex minus 0.125ex ,
glue' / proof .value_required:n          = true ,
glue. / proof .skip_gset:N               = \g_dez_bel_proof_skip ,
glue. / proof .initial:n                 = 2ex plus 0.5ex minus 0.125ex ,
glue. / proof .value_required:n          = true ,
glue' / eqn .skip_gset:N                 = \g_dez_abv_eqn_skip ,
glue' / eqn .initial:n                   = 2ex plus 0.5ex minus 0.125ex ,
glue' / eqn .value_required:n            = true ,
glue. / eqn .skip_gset:N                 = \g_dez_bel_eqn_skip ,
glue. / eqn .initial:n                   = 2ex plus 0.5ex minus 0.125ex ,
glue. / eqn .value_required:n            = true ,
glue' / eqn-short .skip_gset:N           = \g_dez_abv_eqn_short_skip ,
glue' / eqn-short .initial:n             = 1ex plus 0.1ex minus 0.025ex ,
glue' / eqn-short .value_required:n      = true ,
glue. / eqn-short .skip_gset:N           = \g_dez_bel_eqn_short_skip ,
glue. / eqn-short .initial:n             = 1ex plus 0.1ex minus 0.025ex ,
glue. / eqn-short .value_required:n      = true ,
glue' / list .skip_gset:N                = \g_dez_abv_list_skip ,
glue' / list .initial:n                  = 1ex plus 0.2ex minus 0.05ex ,
glue' / list .value_required:n           = true ,
glue' / long-list .skip_gset:N           = \g_dez_abv_long_list_skip ,
glue' / long-list .initial:n             = 1ex plus 0.2ex minus 0.05ex ,
glue' / long-list .value_required:n      = true ,
glue. / abs-title .skip_gset:N           = \g_dez_bel_abstract_title_skip ,
glue' / abs-title .initial:n             = 2ex ,
glue' / abs-title .value_required:n      = true ,
glue' / abs-authors .skip_gset:N         = \g_dez_abv_abstract_author_skip ,
glue' / abs-author .initial:n            = 2ex ,
glue' / abs-author .value_required:n     = true ,
glue' / abs-body .skip_gset:N            = \g_dez_abv_abstract_body_skip ,
glue' / abs-body .initial:n              = 7ex ,
glue' / abs-body .value_required:n       = true ,
glue' / toc-part .skip_gset:N            = \g_dez_abv_toc_part_skip ,
glue' / toc-part .default:n              = 2.5pc plus 0.25pc minus 0.0625pc ,
glue' / toc-part .initial:n              = 0pc ,
glue' / toc-chapter .skip_gset:N         = \g_dez_abv_toc_chap_skip ,
glue' / toc-chapter .default:n           = 0.5pc plus 0.05pc minus 0.0125 ,
glue' / toc-chapter .initial:n           = 0pc ,
glue' / toc-section .skip_gset:N         = \g_dez_abv_toc_section_skip ,
glue' / toc-section .default:n           = 0.1pc plus 0.01pc minus 0.0025pc ,
glue' / toc-section .initial:n           = 0pc ,
glue' / toc-subsec .skip_gset:N          = \g_dez_abv_toc_subsec_skip ,
glue' / toc-subsec .default:n            = 0.02pc ,
glue' / toc-subsec .initial:n            = 0pc ,
glue' / toc-subsubsec .skip_gset:N       = \g_dez_abv_toc_subsubsec_skip ,
glue' / toc-subsubsec .default:n         = 0pc ,
glue' / toc-subsubsec .initial:n         = 0pc ,
glue. / fnote-rule .skip_gset:N          = \g_dez_bel_fnote_rule_skip ,
glue. / fnote-rule .initial:n            = 3pt ,
glue' / fnote-rule .value_required:n     = true ,

rule / top .dim_gset:N                   = \g_dez_toprule_dim ,
rule / top .initial:n                    = 0.2ex ,
rule / top .value_required:n             = true ,
rule / mid .dim_gset:N                   = \g_dez_midrule_dim ,
rule / mid .initial:n                    = 0.1ex ,
rule / mid .value_required:n             = true ,
rule / cmid .dim_gset:N                  = \g_dez_cmidrule_dim ,
rule / cmid .initial:n                   = 0.05ex ,
rule / cmid .value_required:n             = true ,
rule / header .dim_gset:N                = \g_dez_header_dim ,
rule / header .default:n                 = 0.2ex ,
rule / header .initial:n                 = 0ex ,
rule / footer .dim_gset:N                = \g_dez_footer_dim ,
rule / footer .default:n                 = 0.2ex ,
rule / footer .initial:n                 = 0ex ,
rule / fnote .dim_gset:N                 = \g_dez_fnote_rule_dim ,
rule / fnote .initial:n                  = 0.4pt ,
rule / fnote .value_required:n           = true ,
}

\ProcessKeysOptions {dez}  % Process!


\newlength \tmpdezlength
\cs_new_protected:Npn \dez__par_addvspace:N #1
{
    \setlength \tmpdezlength { \skip_use:N #1 }
    \par
    \addvspace \tmpdezlength
}


%======================================================================================================================
%                    mode and preset support
%======================================================================================================================


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
    \fp_gset:Nn \g_dez_stretch_nom_tl {2.0}
    \fp_gset:Nn \g_dez_stretch_caption_fp {1.2}
    %\skip_gset:Nn \g_dez_btw_fnotes_skip {\baselineskip}  % TODO: broken
}


\cs_new_protected:Nn \dez_thesis_like:
    {}

\cs_new_protected:Nn \dez_article_like:
{
    \RenewDocumentCommand \DezChapterPageCmd {}
    \dez_disable_number_within:
    \str_gset:Nn \g_dez_n_front_str {arabic}
    % put left so it's easy to override
    \tl_gput_left:Nn \g_dez_geometry_tl {twocolumn,}
    \ProvideDocumentCommand \DezChapterPageCmd {}
        { \newpage }
    % we'll also convert \Chapter into \Section (later)
}

% replace all L with LE and R with RO
\cs_new_protected:Npn \dez__book_like_fancy:N #1
{
    \prop_set_eq:NN \l_tmpa_prop #1
    \prop_clear:N #1
    \prop_map_inline:Nn \l_tmpa_prop
    {
        \tl_set:Nn \l_tmpa_tl {##1}
        \tl_if_eq:nnT {##1} {L} { \tl_set:Nn \l_tmpa_tl {LE} }
        \tl_if_eq:nnT {##1} {R} { \tl_set:Nn \l_tmpa_tl {RO} }
        \prop_gput:NVn #1 \l_tmpa_tl {##2}
    }
}

\cs_new_protected:Nn \dez_book_like:
{
    \tl_gput_left:Nn \g_dez_geometry_tl {twoside, openright,}
    \dez__book_like_fancy:N \g_dez_header_front_prop
    \dez__book_like_fancy:N \g_dez_header_main_prop
    \dez__book_like_fancy:N \g_dez_header_back_prop
    \dez__book_like_fancy:N \g_dez_footer_front_prop
    \dez__book_like_fancy:N \g_dez_footer_main_prop
    \dez__book_like_fancy:N \g_dez_footer_back_prop
    
}

\cs_new_protected:Nn \dez_be_american:
{
    \tl_put_right:Nn \g_dez__end_tl { \sisetup {group-separator = {,}} }
    \str_if_eq:VnF \g_dez_typo_siunitx_group_str {none}  % can't group decimal
        { \str_gset:Nn \g_dez_typo_siunitx_group_str {integer} }
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



%======================================================================================================================
%                    presets
%======================================================================================================================

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

\NewDocumentCommand \UCSF {}
{
    \tl_gset:Nn \g_dez_mode_str {thesis}
    \tl_gput_left:Nn \g_dez_geometry_tl { letterpaper, margin=1in, footskip=0.5in, }
    \dez_double_space:
    \dez_be_american:
}

% CMU has requirements for footnotes that I doubt I'm handling correctly
\NewDocumentCommand \CMU {}
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
    \fp_gset:Nn \g_dez_stretch_main_tl {1.5}
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


\cs_undefine:N \LetterPaper
\cs_undefine:N \AFour
\cs_undefine:N \UCSF
\cs_undefine:N \CMU
\cs_undefine:N \Stanford
\cs_undefine:N \Cambridge


%======================================================================================================================
%                    some options
%======================================================================================================================

\bool_if:NT \g_dez_draft_bool                   { \@PP {draft=true}             {microtype}  }
\bool_if:NT \g_dez_toc_panels_bool              { \@PP {list}                   {subcaption} }
\bool_if:NF \g_dez_cref_abbrev_bool             { \@PP {noabbrev}               {cleveref}   }
\bool_if:NT \g_dez_cref_capitalize_bool         { \@PP {capitalize}             {cleveref}   }
\dez_if_feat_enabled:nT {ulem}                  { \@PP {markup}                 {textiles}   }
\str_if_eq:VnF \g_dez_fnote_align_str {left}    { \@PP {ragged}                 {footmisc}   }
\str_if_eq:VnF \g_dez_fnote_place_str {default}  % for compatibility
                                                { \@PP {\g_dez_fnote_place_str} {footmisc}   }



%======================================================================================================================
%                    load packages
%======================================================================================================================

% Run our friendly hook:
\hook_use_once:n { dez / packages / before }

% language via pidgin
% pidgin uses babel, tracklang, and translations
% we use it to load cleveref etc. at the end
\@RP {pidgin}
\pidgin_set_main_lang:V  \g_dez_lang_str
\pidgin_set_langs:V      \g_dez_langs_str
\pidgin_start:

% layout control:
\@RP {fancyvrb}                    % _verbatim_ , etc.
\@RP [newcommands] {ragged2e}      % full ragged environments; before: footmisc
\@RP {newfloat}                    % declare new float environments
\@RP {geometry}                    % \geometry
\@RP [Export] {adjustbox}          % resize boxes
\@RP {perpage}                     % reset a counter every page
\@RP {datetime2}                   % format dates and times (after: babel)

% xindy and hyperref
\@LF [xindy] {imakeidx}            % index; before: knowledge
\@RP {hyperxmp}
\@RP {hyperref}                    % AFTER xindy and geometry

% font control and math
\@PP {babel=true} {microtype}
\@RP [faces] {textiles}
%\@RP {glue}
\@RP {mathcommand}                 % prime, subscript, preserving commands
\@RP {info}                        % requires textiles
\@RP {amsthm}                      % theorem-like environments
\@RP {thmtools}                    % \declaretheorem
\@RP {thm-restate}
\@RP {mathtools}                   % misc. math macros
\@RP {lualatex-math}               % math-related patches
\@RP {uspace}                      % give correct meanings to Unicode space chars
\@RP {fnpct}                       % move footnote marks

% acro, index, nomenclature, etc.
\@RP [backend=biber] {biblatex}    % BibLaTeX! after: hyperref
\@RP {accsupp}                     % before: acro
\@RP {acro}                        % for all abbreviations

% layout & spacing
\@RP [explicit] {titlesec}         % to format headers; explicit: use #1
\@RP {titletoc}                    % to format TOC
\@RP [titles] {tocloft}            % prevent loading without titles
\@RP {tarmac}
\@RP {fancyhdr}                    % footer and header
\@RP {enumitem}                    % control spacing for lists
\@RP [hang] {footmisc}             % footnote styling and counters
\@RP {enotez}                      % fixed endnotes
\@RP {chngcntr}
%\@RP {lua-widow-control}
\@RP {lscape}                      % {landscape} env
\@RP {pdflscape}                   % gives {landscape} env PDF attr '\Rotate'
\@RP {multicol}
\bool_if:NT \g_dez_draft_bool
    { \@RP {showframe} }


% graphics
\@RP [hypcap=true] {caption}       % needed for formatting; use hypcap option
\@RP [hypcap=true] {subcaption}    % successor to subfig; use hypcap option
\@RP {graphicx}                    % for, well, everything

% tables
%\@RP {csvsimple-l3}                % load CSV data
\@RP {tabularray}                  % LaTeX3 tabular and table replacement
\let \@TL \UseTblrLibrary
\@TL {babel}
\@TL {amsmath}                     % (amsmath loaded earlier)
\@TL {booktabs}                    % \toprule, etc. and envs
%\@TL {counter}                     % get row and col counters
\@TL {siunitx}                     % (siunitx loaded earlier)
%\@TL {counter}                     % get row and col counters
%\@TL {diagbox}                     % split desc for top-left cellS

% typography
\@RP {fvextra}                     % only needed to avoid warning in csquotes
\@RP {csquotes}                    % quote environments [before: others?]
\@RP {ellipsis}                    % no added space with \ldots in text mode
\@RP {semantic}                    % academic links, etc.
\@RP {siunitx}                     % pretty units
\@RP {alphalph}

% shell
% https://tex.stackexchange.com/questions/365777/cannot-run-tikz-externalize-with-lualatex-but-it-used-to-work
%\@RP {shellesc}

% optional features
\@LF {noms}                        % nomenclature groups and utils
\@LF {multicol}
\@LF [newfloat] {minted}
\@LF [xparse] {tcolorbox}
\dez_if_feat_enabled:nT {cryptocode}
{
    % https://tex.stackexchange.com/questions/605616/how-to-remove-the-etex-warning-when-using-cryptocode-with-the-llncs-document-cla
    \exp_after:wN \def \csname ver@etex.sty \endcsname {}
    \RequirePackage {cryptocode}
}
\@LF {chemmacros}
\@LF {chemformula}
\@LF {chemfig}
\@LF {svg}
\@LF {tcolorbox}
\@LF {fontawesome5}
\@LF [siunitx] {circuitikz}
\@LF {tikz-cd}

\dez_if_feat_enabled:nT {tikz}
{
    % core
    \@RP      { tikz }
    \@TZ      { babel, fpu, calc, }
    %\@TZ      { external }
    %\tl_put_right:Nn \g_dez__end_tl {\tikzexternalize}
    % basic
    \@TZ     { scopes, backgrounds, positioning, intersections, through, chains, matrix, fit, }
    % shapes and arrows
    \@PG     { shapes.geometric, arrows, }
    \@TZ     { decorations.markings, decorations.pathmorphing, decorations.pathreplacing, }
    %  graphs
    \dez_if_feat_enabled:nT {graphs}
    {
        \@TZ { graphs, graphdrawing, }
        \@GD { force, layered, circular, routing, }
    }
}



%======================================================================================================================
%                          finalize things
%======================================================================================================================

\@LF {varioref}
\@LF [ no~patch, electronic ] {knowledge}

\pidgin_close:

\cs_undefine:N \@RP
\cs_undefine:N \@PP
\cs_undefine:N \@LF
\cs_undefine:N \@TL
\cs_undefine:N \@PG
\cs_undefine:N \@TZ
\cs_undefine:N \@GD


% it's utterly weird that these can be different
% report and book use bibname, while article uses refname
\let \bibname \refname

% Run our friendly hook:
\hook_use_once:n { dez / packages / after }


% Send our dez options to textiles!
% The colors are saved to both xcolor and l3color.
%\prop_log:N \g_dez_color_prop
%\textiles_declare_colors_from_prop:N \g_dez_color_prop
\textiles_declare_multiple_from_prop:N \g_dez_unary_prop
\textiles_declare_nullary_from_prop:N \g_dez_nullary_prop
\prop_map_inline:Nn \g_dez_color_prop
{
    \colorlet {#1} {#2}
}

\tl_gset:Nx  \g_dez_stretch_main_tl      { \fp_use:N \g_dez_stretch_main_fp }
\tl_gset:Nx  \g_dez_stretch_eqn_tl       { \fp_use:N \g_dez_stretch_eqn_fp }
\tl_gset:Nx  \g_dez_stretch_toc_tl       { \fp_use:N \g_dez_stretch_toc_fp }
\tl_gset:Nx  \g_dez_stretch_lof_tl       { \fp_use:N \g_dez_stretch_lof_fp }
\tl_gset:Nx  \g_dez_stretch_nom_tl       { \fp_use:N \g_dez_stretch_nom_fp }
\tl_gset:Nx  \g_dez_stretch_code_tl      { \fp_use:N \g_dez_stretch_code_fp }
\tl_gset:Nx  \g_dez_stretch_caption_tl   { \fp_use:N \g_dez_stretch_caption_fp }
\tl_gset:Nx  \g_dez_stretch_refs_tl      { \fp_use:N \g_dez_stretch_refs_fp }
\tl_gset:Nx  \g_dez_stretch_table_tl     { \fp_use:N \g_dez_stretch_table_fp }



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




%======================================================================================================================
%                         tarmac
%======================================================================================================================


% Set the depth of the Table of Contents and section numbering.

\tarmac_set_depth:nV {secnumdepth} \g_dez_n_depth_str
\tarmac_set_depth:nV {tocdepth} \g_dez_toc_depth_str

% Note \SetTexParams from tarmac

\bool_if:NT \g_dez_typo_ban_hyphens_bool
    { \BanHyphens }

\tl_replace_all:Nnn \g_dez_geometry_tl {;} {,}
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

\exp_args:NNe \setlength \floatsep         { \skip_use:N \g_dez_float_float_skip }
\exp_args:NNe \setlength \textfloatsep     { \skip_use:N \g_dez_float_text_skip }
\exp_args:NNe \setlength \intextsep        { \skip_use:N \g_dez_float_float_skip }
\exp_args:NNe \setlength \dbltextfloatsep  { \skip_use:N \g_dez_float_text_skip }

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
        \begin {tabularray}
            {
            width      = \linewidth ,
            colspec    = { >{$}l<{$} @{${}={}$} X@{} }
            }
    }
    { \end {tabularray} }

\dez_if_feat_enabled:nT {noms}
{
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
    \skip_set:Nn \l_tmpa_skip {-\parsep + \g_dez_btw_lof_items_skip}
    \exp_args:NNe \setlength \nomitemsep { \skip_use:N \l_tmpa_skip }
}

\renewcommand \cftfigafterpnum
    { \dez__par_addvspace:N \g_dez_btw_lof_items_skip \par }
\renewcommand \cfttabafterpnum
    { \dez__par_addvspace:N \g_dez_btw_lof_items_skip \par }


%======================================================================================================================
%                           section titles
%======================================================================================================================

% \titleformat {command} [shape]
%    {format}       1
%    {label}        2
%    {sep}          3 sep between label and title
%    {before-code}  4

%   % % % % % % % % % % % % % % % % %   %
%    ====         PART          ====    %

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


%   % % % % % % % % % % % % % % % % %   %
%    ====        CHAPTER        ====    %

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


%   % % % % % % % % % % % % % % % % %   %
%    ====        SECTION        ====    %

\titleformat {\section} [hang]
    { }
    { \textiles_run_nullary:n{section-title} \thetitle }
    { 1em }
    { \textiles_run_nullary:n{section-title} #1 }


%   % % % % % % % % % % % % % % % % %   %
%    ====      SUB-SECTION      ====    %

\bool_if:NTF \g_dez_subsec_runin_bool
{
    \titleformat {\subsection} [runin]
        { }
        { \textiles_run_nullary:n{subsec-title} \thetitle }
        { 1em }
        { \textiles_run_nullary:n{subsec-title} #1. }
}
{
    \titleformat {\subsection} [hang]
        { }
        { \textiles_run_nullary:n{subsec-title} \thetitle }
        { 1em }
        { \textiles_run_nullary:n{subsec-title} #1 }
}


%   % % % % % % % % % % % % % % % % %   %
%    ====    SUB-SUB-SECTION    ====    %

\bool_if:NTF \g_dez_subsubsec_runin_bool
{
    \titleformat {\subsubsection} [runin]
        { }
        { \textiles_run_nullary:n{subsubsec-title} \thetitle }
        { 1em }
        { \textiles_run_nullary:n{subsubsec-title} #1. }
}
{
    \titleformat {\subsubsection} [hang]
        { }
        { \textiles_run_nullary:n{subsubsec-title} \thetitle }
        { 1em }
        { \textiles_run_nullary:n{subsubsec-title} #1 }
}


%   % % % % % % % % % % % % % % % % %   %
%    ====       PARAGRAPH       ====    %

\titleformat {\paragraph} [runin]
    { }
    { \textiles_run_nullary:n{paragraph-title} \thetitle }
    { 1em }
    { \textiles_run_nullary:n{paragraph-title} #1. }


%   % % % % % % % % % % % % % % % % %   %
%    ====     SUB-PARAGRAPH     ====    %

\titleformat {\subparagraph} [runin]
    { }
    { \textiles_run_nullary_inline:n{italic} \thetitle }
    { 1em }
    { \textiles_run_nullary_inline:n{italic} #1. }



%======================================================================================================================
%                           section spacing
%======================================================================================================================

%\titlespacing {command}
%    {left}       1
%    {before-sep} 2
%    {after-sep}  3


%   % % % % % % % % % % % % % % % % %   %
%    ====         PART          ====    %

% All good -- we assume it takes the whole page


%   % % % % % % % % % % % % % % % % %   %
%    ====        CHAPTER        ====    %

\titlespacing { name=\chapter }
    { 0pt }                               % left space
    { \skip_use:N \g_dez_abv_chap_skip }  % top space
    { \skip_use:N \g_dez_bel_chap_skip }  % bottom space

\titlespacing { name=\chapter, numberless }
    { 0pt }
    { \skip_use:N \g_dez_abv_front_chap_skip }
    { \skip_use:N \g_dez_bel_front_chap_skip }


%   % % % % % % % % % % % % % % % % %   %
%    ====        SECTION        ====    %

\titlespacing {\section}
    { 0pt }
    { \skip_use:N \g_dez_abv_section_skip }
    { \skip_use:N \g_dez_bel_section_skip }


%   % % % % % % % % % % % % % % % % %   %
%    ====      SUB-SECTION      ====    %

\bool_if:NTF \g_dez_subsec_runin_bool
{
    \titlespacing {\subsection}
        { 0pt }
        { \skip_use:N \g_dez_abv_subsec_skip }
        { \dim_use:N \g_dez_runin_dim }         % runin, so horizontal after
}
{
    \titlespacing {\subsection}
        { 0pt }
        { \skip_use:N \g_dez_abv_subsec_skip }
        { \skip_use:N \g_dez_bel_subsec_skip }  % hang, so vertical after
}


%   % % % % % % % % % % % % % % % % %   %
%    ====    SUB-SUB-SECTION    ====    %

\bool_if:NTF \g_dez_subsec_runin_bool
{
    \titlespacing {\subsubsection}
        { 0pt }
        { \skip_use:N \g_dez_abv_subsubsec_skip }
        { \dim_use:N \g_dez_runin_dim }
}
{
    \titlespacing {\subsubsection}
        { 0pt }
        { \skip_use:N \g_dez_abv_subsubsec_skip }
        { \skip_use:N \g_dez_bel_subsubsec_skip }
}


%   % % % % % % % % % % % % % % % % %   %
%    ====       PARAGRAPH       ====    %

\titlespacing {\paragraph}
    { 0pt }
    { \skip_use:N \g_dez_abv_paragraph_skip }
    { \dim_use:N \g_dez_runin_dim  }


%   % % % % % % % % % % % % % % % % %   %
%    ====     SUB-PARAGRAPH     ====    %

\titlespacing {\subparagraph}  % not supported, but choose something reasonable
    { \dim_use:N \g_dez_runin_dim  }           % indent to left
    { \skip_use:N \g_dez_abv_paragraph_skip }
    { \dim_use:N \g_dez_runin_dim  }




%======================================================================================================================
%                           TOC formatting
%======================================================================================================================

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





%======================================================================================================================
%               header & footer
%======================================================================================================================

\renewcommand* \headrulewidth { \dim_use:N \g_dez_header_dim }
\renewcommand* \footrulewidth { \dim_use:N \g_dez_footer_dim }

\fancyhf{} % kill the default

\fancypagestyle {plain} {}  % make plain be fancy
\pagestyle {plain}  % use plain

\assignpagestyle  \part     {plain}  % or empty
\assignpagestyle  \chapter  {plain}

\cs_new_protected:Npn \dez__fancyhead:en #1#2
{
    % Force cat code to letter
    \exp_args:NNe \str_set:Nn \l_tmpa_str {\str_uppercase:n{#1}}
    % TODO: I can't explain why this is needed
    % Calling an aux fn with \fancyhead[#1]{#2}
    % results in "illegal char `R'"
    \str_if_eq:VnT \l_tmpa_str {L}
        { \fancyhead [L] {#2} }
    \str_if_eq:VnT \l_tmpa_str {R}
        { \fancyhead [R] {#2} }
    \str_if_eq:VnT \l_tmpa_str {C}
        { \fancyhead [C] {#2} }
    \str_if_eq:VnT \l_tmpa_str {LE}
        { \fancyhead [LE] {#2} }
    \str_if_eq:VnT \l_tmpa_str {RO}
        { \fancyhead [RO] {#2} }
    % these aren't normal:
    \str_if_eq:VnT \l_tmpa_str {LO}
        { \fancyhead [LO] {#2} }
    \str_if_eq:VnT \l_tmpa_str {RE}
        { \fancyhead [RE] {#2} }
    \str_if_eq:VnT \l_tmpa_str {CO}
        { \fancyhead [CO] {#2} }
    \str_if_eq:VnT \l_tmpa_str {CE}
        { \fancyhead [CE] {#2} }
}

\cs_new_protected:Npn \dez__fancyfoot:en #1#2
{
    % Force cat code to letter
    \exp_args:NNe \str_set:Nn \l_tmpa_str {\str_uppercase:n{#1}}
    % TODO: I can't explain why this is needed
    % Calling an aux fn with \fancyfoot[#1]{#2}
    % results in "illegal char `R'"
    \str_if_eq:VnT \l_tmpa_str {L}
        { \fancyfoot [L] {#2} }
    \str_if_eq:VnT \l_tmpa_str {R}
        { \fancyfoot [R] {#2} }
    \str_if_eq:VnT \l_tmpa_str {C}
        { \fancyfoot [C] {#2} }
    \str_if_eq:VnT \l_tmpa_str {LE}
        { \fancyfoot [LE] {#2} }
    \str_if_eq:VnT \l_tmpa_str {RO}
        { \fancyfoot [RO] {#2} }
    \str_if_eq:VnT \l_tmpa_str {LO}
        { \fancyfoot [LO] {#2} }
    \str_if_eq:VnT \l_tmpa_str {RE}
        { \fancyfoot [RE] {#2} }
    \str_if_eq:VnT \l_tmpa_str {CO}
        { \fancyfoot [CO] {#2} }
    \str_if_eq:VnT \l_tmpa_str {CE}
        { \fancyfoot [CE] {#2} }
}

\cs_new_protected:Nn \dez__front_page_style:
{
    \fancyhf{}
    \prop_map_function:NN \g_dez_header_front_prop \dez__fancyhead:en
    \prop_map_function:NN \g_dez_footer_front_prop \dez__fancyfoot:en
    %\prop_map_inline:Nn \g_dez_footer_front_prop { \fancyfoot [##1] {\HideLinks ##2} }
    %\addtolength{\headwidth}{\marginparsep}
    %\addtolength{\headwidth}{\marginparwidth}
}


\cs_new_protected:Nn \dez__main_page_style:
{
    \fancyhf{}
    \prop_map_function:NN \g_dez_header_main_prop \dez__fancyhead:en
    \prop_map_function:NN \g_dez_footer_main_prop \dez__fancyfoot:en
}
\cs_new_protected:Nn \dez__back_page_style:
{
    \fancyhf{}
    \prop_map_function:NN \g_dez_header_back_prop \dez__fancyhead:en
    \prop_map_function:NN \g_dez_footer_back_prop \dez__fancyfoot:en
}





%======================================================================================================================
%                           basic numbering
%======================================================================================================================

\cs_new_protected:Npn \dez_counter_within:nV #1#2
{
    \str_if_eq:nnTF {#2} {none}
        { \counterwithout {#1} {#2} }
        { \counterwithin {#1} {#2} }
        % there's also \numberwithin
}

\NewDocumentCommand \SetCounterWithin { m m }
{
    \dez_counter_within:nn {#1} {#2}
}

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

%\counterwithout {table} {chapter}
%\counterwithout {figure} {chapter}


%======================================================================================================================
%                       footnote numbering and format
%======================================================================================================================


% NotoSansSymbol is defined if dez-fancy is used (or in other cases, defined wayy below)
\cs_new_protected:Npn \dez__sym:n #1
    { { \NotoSansSymbol \text{#1} } }

\str_if_eq:VnT \g_dez_n_fnotes_str {dez-fancy}
    { \setfontfamily \NotoSansSymbol {Noto Sans Symbols 2} }

\DefineFNsymbols* {dez-fancy}
{
    { \dez__sym:n{ *} }
    { \dez__sym:n{ †} }
    { \dez__sym:n{ ‡} }
    { \dez__sym:n{ §} }
    { \dez__sym:n{ ❘ } }
    { \dez__sym:n{ ∥} }
    { \dez__sym:n{ ¶} }
    { \dez__sym:n{ ⟡ } }
    { \dez__sym:n{ ✩} }
    { \dez__sym:n{ ♯} }
    { \dez__sym:n{ =} }
    { \dez__sym:n{ ≡} }
    { \dez__sym:n{ ≣} }
    { \dez__sym:n{ ≀} }
    { \dez__sym:n{ ⋮} }
    { \dez__sym:n{ ★ } }
    { \dez__sym:n{ ✹} }
    { \dez__sym:n{ ⯅ } }
    { \dez__sym:n{ ♦} }
    { \dez__sym:n{ ♠ } }
    { \dez__sym:n{ ♣ } }
    { \dez__sym:n{ ☘} }
    { \dez__sym:n{ ⚑} }
    { \dez__sym:n{ ⫝} }
    { \dez__sym:n{ ⥾} }
    { \dez__sym:n{ ⚳} }
    { \dez__sym:n{ ⩆} }
    { \dez__sym:n{ ⚵} }
    { \dez__sym:n{ ⚶ } }
    { \dez__sym:n{ ⚷} }
    { \dez__sym:n{ ⚸} }
}

\str_if_eq:VnT \g_dez_fnote_in_str {page}
    { \MakePerPage [2] {footnote} }  % otherwise we'll set in \Chapter


\seq_const_from_clist:Nn \c__dez_numeric_fnotes_clist
    { arabic, alph, Alph, roman, Roman }
    
\seq_if_in:NVTF \c__dez_numeric_fnotes_clist \g_dez_n_fnotes_str
    { \declarecommand \multfootsep {,} }           % e.g. 12,13
    { \declarecommand \multfootsep {\thinspace} }  % because some symbols are doubled


\seq_const_from_clist:Nn \g__dez_footsymbols_seq
    { lamport, lamport*, bringhurst, chicago, wiley, dez-fancy }  % i.e. not arabic, roman, etc.

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
\setlength {\skip\footins} {\skip_use:N \g_dez_abv_fnote_list_skip}
% there's also \footskip, which should be \baselineskip

\exp_args:NNe \setlength \footnotesep    {\skip_use:N \g_dez_btw_fnotes_skip}
\exp_args:NNe \setlength \footnotemargin {\dim_use:N \g_dez_fnote_left_dim}

\exp_args:NNe \renewcommand \hangfootparindent {\dim_use:N \g_dez_fnote_indent_dim}
\exp_args:NNe \renewcommand \hangfootparskip   {\skip_use:N \g_dez_btw_fnote_paragraphs_skip}

% apply the footnote body format
\renewcommand* \footnotelayout
    { \textiles_run_nullary:n {fnote-body} }

\cs_new_protected:Npn \dez__set_fnote_rule_aux:eee #1#2#3
{
    \renewcommand \footnoterule
    {
        \kern #1
        \hrule width \textwidth height #2
        \kern #3
    }
}

\cs_new_protected:Npn \dez__set_fnote_rule:NN #1#2
{
    \dez__set_fnote_rule_aux:eee
        { \skip_eval:n {-1#2-#1} }  % kern back
        { \dim_use:N #1 }           % thickness
        { \skip_eval:n {1#2} }      % kern forward
}
\dez__set_fnote_rule:NN \g_dez_fnote_rule_dim \g_dez_bel_fnote_rule_skip



%======================================================================================================================
%                 endnotes
%======================================================================================================================

\setenotez {reset=true}

\hook_gput_code:nnn
    {begindocument/before}
    {dez/fix-enotez}
    { \setenotez { list-name = \crtcrefpluralname{note} } }

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



%======================================================================================================================
%             equation labels
%======================================================================================================================

\newtagform {none}                   {}    {}
\newtagform {round}                  {(}   {)}
\newtagform {square}                 {[}   {]}
\newtagform {curly}                  {\{}  {\}}
\newtagform {bar}                    {|}   {|}
\newtagform {none-bold}   [\textbf]  {}    {}
\newtagform {round-bold}  [\textbf]  {(}   {)}
\newtagform {square-bold} [\textbf]  {[}   {]}
\newtagform {curly-bold}  [\textbf]  {\{}  {\}}
\newtagform {bar-bold}    [\textbf]  {|}   {|}

\exp_args:NV
    \usetagform \g_dez_n_brackets_str




%======================================================================================================================
%                        bibliography
%======================================================================================================================

% don't show the language for every reference
\bool_if:NT \g_dez_bib_hide_lang_bool
    { \AtEveryBibitem { \clearlist {language} } }

% Reference the title, date, journal, and authors
% Could alternatively use \DeclareCiteCommand
\NewDocumentCommand \reffull {m}
{
    \AtNextCite { \defcounter {maxnames} {60} }
    \fullcite{#1}
}

\NewDocumentCommand \rrefttitle {m}
    { `` \citefield {#1} {title} " }
    
\NewDocumentCommand \refdoi {m}
    { \doi { \citefield {#1} {doi} } }
    
\NewDocumentCommand \refurl {m}
    { \link { \citefield {#1} {url} } }





%======================================================================================================================
%                     sections with labels
%======================================================================================================================

\keys_define:nn { dez / section-like }
{
    title .tl_set:N                = \l__title_tl ,
    title .initial:n               = {} ,
    title .value_required:n        = true ,
    no-title .bool_set:N           = \l__no_title_bool,  % overrides any title
    no-title .default:n            = true ,
    no-title .initial:n            = false ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    no-entry .bool_set:N           = \l__no_entry_bool,  % overrides any entry
    no-entry .default:n            = true ,
    no-entry .initial:n            = false ,
    label .tl_set:N                = \l__label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    label .value_required:n        = true ,
    numberless .bool_set:N         = \l__numberless_bool ,
    numberless .default:n          = true ,
    numberless .initial:n          = false ,
    numbered .meta:n               = { numberless=false } ,
    hide-links .bool_set:N         = \l__hide_links_bool ,
    hide-links .default:n          = true ,
    hide-links .initial:n          = false ,
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
        { \HideLinks }
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
        {part} {#1} {#2} {#3} \part \DezPartPageCmd
}

\NewDocumentCommand \Chapter { s O{} G{} }
{
    \str_if_eq:VnT \g_dez_fnote_in_str {chapter}
        { \setcounter {footnote} {0} }
    \dez__section_like:nnnnNN
        {chapter} {#1} {#2} {#3} \chapter \DezChapterPageCmd
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




%======================================================================================================================
%                  alignment commands and environments
%======================================================================================================================

\NewDocumentEnvironment {BigPages} { O{vmargin=1ex, hmargin=1em} }
{
    \pagestyle {empty}
    \assignpagestyle \chapter {empty}
    \newgeometry{#1}
}
{
    \restoregeometry
    %\assignpagestyle \chapter {plain}
}


% like the other ragged2e commands
\let \Justifying \justifying

\NewDocumentEnvironment {Justify} {}
    { \begin {justify} }
    { \end   {justify} }

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

\cs_new_protected:Npn \dez_align:n #1
{
    \prop_get:NnN \c_dez__align_to_cmd_prop {#1} \l_tmpa_tl
    \cs_if_exist_use:N \l_tmpb_str
}
\cs_generate_variant:Nn \dez_align:n { V }

\cs_new_protected:Npn \dez__align_begin:n #1
{
    \prop_get:NnN \c_dez__align_to_env_prop {#1} \l_tmpa_tl
    \begin_:V \l_tmpa_tl
}
\cs_generate_variant:Nn \dez__align_begin:n { V }

\cs_new:Npn \dez__align_end:n #1
{
    \prop_get:NnN \c_dez__align_to_env_prop {#1} \l_tmpa_tl
    \end_:V \l_tmpa_tl
}
\cs_generate_variant:Nn \dez__align_end:n { V }

%\NewDocumentCommand \Aligning { m }
%    { \dez_align:n {#1} }

\NewDocumentEnvironment {Align} { m }
    { \dez__align_begin:n {#1} }
    { \dez__align_end:n   {#1} }



%======================================================================================================================
%                         SpecialBox
%======================================================================================================================

\keys_define:nn { dez / special-box }
{
    width .dim_set:N              = \l__width_dim ,
    width .initial:n              = {\textwidth} ,
    width .value_required:n       = true ,
    above .dim_set:N              = \l__above_dim ,
    above .initial:n              = 0pc ,
    above .value_required:n       = true ,
    below .dim_set:N              = \l__below_dim ,
    below .initial:n              = 0pc ,
    below .value_required:n       = true ,
    hide-links .bool_set:N        = \l__hide_links_bool ,
    hide-links .default:n         = true ,
    hide-links .initial:n         = false ,
    textile .tl_set:N             = \l__textile_tl ,
    textile .default:n            = {} ,
    textile .value_required:n     = true ,
    style .tl_set:N               = \l__style_tl ,
    style .initial:n              = {} ,
    style .value_required:n       = true ,
    align .choices:nn             = { left, center, right, justify }
                                    { \tl_set_eq:NN \l__align_tl \l_keys_choice_tl } ,
    align .default:n              = left ,
    align .initial:n              = center ,
    at .choices:nn                = { top, bottom, middle }
                                    { \tl_set_eq:NN \l__at_tl \l_keys_choice_tl } ,
    at .initial:n                 = middle ,
    at .value_required:n          = true ,
}


\NewDocumentEnvironment {InternalSpecialBox} { +b }
{
    \bool_if:NT \l__hide_links_bool
        { \HideLinks }
    \tl_if_eq:NnF \l__align_tl {justify}
        { \hbadness=10000 }
    \dez_align:V \l__align_tl
    \tl_if_eq:NnTF \l__at_tl {top}
        { \dez__par_addvspace:N \l__above_dim }
        { \vspace*{\fill} }
    \begin_r:nV {minipage} \l__width_dim
    \dez__align_begin:V \l__align_tl
    \textiles_use_or_inline:VVn \l__textile_tl \l__style_tl {#1\par}
}
{
    \dez__align_end:V \l__align_tl
    \end {minipage}
    \tl_if_eq:NnTF \l__at_tl {bottom}
        { \dez__par_addvspace:N \l__below_dim }
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


%======================================================================================================================
%                        front-matter chapters
%======================================================================================================================

\NewDocumentEnvironment {FrontChapter} { O{} G{} }
{
    \DezMainChapterPageCmd
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \begin {refsection} }
    \Chapter* [numberless, #1] {#2}  % add numbered in #1
}
{
    \ShowEndnotes
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \ShowSubBib \end{refsection} }
    \acresetall
}

\keys_define:nn { dez / special-chapter }
{
    label .tl_set:N                     = \l__label_tl ,
    label .default:n                    = * ,
    label .initial:n                    = {} ,
    entry .tl_set:N                     = \l__entry_tl ,
    entry .default:n                    = * ,
    entry .initial:n                    = {} ,
    title .tl_set:N                     = \l__title_tl ,
    title .initial:n                    = {} ,
    title .value_required:n             = true ,
    no-title .bool_set:N                = \l__no_title_bool,
    no-title .default:n                 = true ,
    no-title .initial:n                 = false ,
    no-entry .bool_set:N                = \l__no_entry_bool,  % overrides any entry
    no-entry .default:n                 = true ,
    no-entry .initial:n                 = false ,
    numberless .bool_set:N              = \l__numberless_bool ,
    numberless .default:n               = true ,
    numberless .initial:n               = false ,
    numbered .meta:n                    = { numberless=false } ,
    width .dim_set:N                    = \l__width_dim ,
    width .initial:n                    = {\textwidth} ,
    width .value_required:n             = true ,
    above .dim_set:N                    = \l__above_dim ,
    above .initial:n                    = 0pc ,
    above .value_required:n             = true ,
    below .dim_set:N                    = \l__below_dim ,
    below .initial:n                    = 0pc ,
    below .value_required:n             = true ,
    hide-links .bool_set:N              = \l__hide_links_bool ,
    hide-links .default:n               = true ,
    hide-links .initial:n               = false ,
    empty-page-style .bool_set:N        = \l__empty_page_style_bool ,
    empty-page-style .default:n         = true ,
    empty-page-style .initial:n         = false ,
    textile .tl_set:N                   = \l__textile_tl ,
    textile .default:n                  = {} ,
    textile .value_required:n           = true ,
    style .tl_set:N                     = \l__style_tl ,
    style .initial:n                    = {} ,
    style .value_required:n             = true ,
    align .choices:nn                   = { left, center, right, justify }
                                          { \tl_set_eq:NN \l__align_tl \l_keys_choice_tl } ,
    align .default:n                    = left ,
    align .initial:n                    = center ,
    at .choices:nn                      = { top, bottom, middle }
                                          { \tl_set_eq:NN \l__at_tl \l_keys_choice_tl } ,
    at .initial:n                       = top ,
    at .value_required:n                = true ,
}


% Super-special chapters, normally centered
\NewDocumentEnvironment {SpecialChapter} { O{} G{} }
{
    \keys_set:nn {dez / special-chapter} {numberless, #1}  % add numbered in #1
    \tl_if_blank:VT \l__title_tl
        { \tl_set:Nn \l__title_tl {#2} }
    \str_if_eq:VnT \g_dez_fnote_in_str {chapter}
        { \setcounter {footnote} {0} }  % otherwise they'll continue from the last chapter
    \dez__run_section_like:NN \chapter \DezChapterPageCmd
    \bool_if:NT \l__empty_page_style_bool  % TODO
        { \clearpage \pagestyle{empty} }
    \begin {InternalSpecialBox}
}
{
    \end {InternalSpecialBox}
    \ShowEndnotes  % really, these shouldn't be used
    %\bool_if:NT \l__empty_page_style_bool  % TODO
    %    { \clearpage \pagestyle{empty} }
    \acresetall
}

\cs_new_protected:Npn \dez__newfrontchap:nnN #1#2#3
{
    #3 {#1} { O{} G{#1} } 
        { \begin {FrontChapter} [#2, ##1] {##2} }
        { \end   {FrontChapter} }
}

\NewDocumentCommand \NewFrontChapter { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \NewDocumentEnvironment }

\NewDocumentCommand \DeclareFrontChapter { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \DeclareDocumentEnvironment }

\NewDocumentCommand \RenewFrontChapter { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \RenewDocumentEnvironment }

\NewDocumentCommand \ProvideFrontChapter { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \ProvideDocumentEnvironment }


\cs_new_protected:Npn \dez__newspecialchap:nnN #1#2#3
{
    #3 {#1} { O{} G{#1} } 
        { \begin {SpecialChapter} [#2, ##1] {##2} }
        { \end   {SpecialChapter} }
}

\NewDocumentCommand \NewSpecialChapter { m O{} }
    { \dez__newspecialchap:nnN {#1} {#2} \NewDocumentEnvironment }

\NewDocumentCommand \DeclareSpecialChapter { m O{} }
    { \dez__newspecialchap:nnN {#1} {#2} \DeclareDocumentEnvironment }

\NewDocumentCommand \RenewSpecialChapter { m O{} }
    { \dez__newspecialchap:nnN {#1} {#2} \RenewDocumentEnvironment }

\NewDocumentCommand \ProvideSpecialChapter { m O{} }
    { \dez__newspecialchap:nnN {#1} {#2} \ProvideDocumentEnvironment }


\cs_new_protected:Npn \dez__newappendix:nnN #1#2#3
{
    #3 {#1} { O{} G{#1} } 
        { \begin {Appendix} [#2, ##1] {##2} }
        { \end   {Appendix} }
}

\NewDocumentCommand \NewAppendix { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \NewDocumentEnvironment }

\NewDocumentCommand \DeclareAppendix { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \DeclareDocumentEnvironment }

\NewDocumentCommand \RenewAppendix { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \RenewDocumentEnvironment }

\NewDocumentCommand \ProvideAppendix { m O{} }
    { \dez__newfrontchap:nnN {#1} {#2} \ProvideDocumentEnvironment }


\NewFrontChapter   {Preface}           [ entry=Preface, ]
\NewFrontChapter   {Acknowledgments}   [ entry=Acknowledgments, ]
\NewFrontChapter   {Contributions}     [ entry=Contributions, ]
\NewFrontChapter   {Abstract}          [ entry=Abstract, no-title, numberless, ]
\NewAppendix       {Errata}            [ entry=Errata, ]
\NewSpecialChapter {Epigraph}          [ entry=Epigraph, no-title, at=middle, style=sans;large, ]
\NewSpecialChapter {Dedication}        [ entry=Dedication, no-title, at=middle,
                                         style=sans;large;italic, ]
\NewSpecialChapter {Copyright}         [ no-entry, no-title, at=middle, ]
\NewSpecialChapter {Title}             [ no-entry, no-title, hide-links, ]




%======================================================================================================================
%                        abstract and title
%======================================================================================================================

\NewDocumentCommand \AbstractHeader {}
{
    \begin {center}
    \GetTitle [ textile = abs-title ]
    \dez__par_addvspace:N \g_dez_bel_abstract_title_skip
    \StyleTxt {abs-by} {by}
    \dez__par_addvspace:N \g_dez_abv_abstract_author_skip
    \GetAuthors [ textile = abs-authors ]
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




%======================================================================================================================
%                        main matter
%======================================================================================================================


\NewDocumentCommand \StartChapter { O{} G{} }
{
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \begin{refsection} }
    \Chapter [#1] {#2}
}

\NewDocumentCommand \EndChapter {}
{
    \ShowEndnotes
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \ShowSubBib \end{refsection} }
}

\NewDocumentEnvironment {MainChapter} { O{} G{} }
    { \StartChapter [#1] {#2} }
    { }



%======================================================================================================================
%                        back matter
%======================================================================================================================

\NewDocumentCommand \ShowBackBib {}
{
    \bool_if:NF \g_dez_bib_per_chap_bool
        { \ShowFullBib }
}

\NewDocumentEnvironment {Appendix} { O{} G{} }
{
    \begin {refsection}
    \Chapter [#1] {#2}
}
{
    \ShowSubBib
    \end {refsection}
}

\NewDocumentEnvironment {Appendices} {}
    { }
    { }

\NewDocumentCommand \ShowIndex {}
{
    \dez_if_feat_enabled:nT {imakeidx}
        {\printindex}
}




%======================================================================================================================
%                 theorem-like
%======================================================================================================================


% first, default style associations

% from amsthm PDF:
% https://ctan.mirrors.hoobly.com/macros/latex/required/amscls/doc/amsthdoc.pdf
%  
%  plain        italic text, extra space above and below:
%               Theorem, Lemma, Corollary, Proposition, Conjecture, Criterion, Assertion
%  definition   upright text, extra space above and below:
%               Definition, Condition, Problem, Example, Exercise, Algorithm,
%               Question, Axiom, Property, Assumption, Hypothesis
%  remark       upright text, no extra space above or below.
%               Remark, Note, Notation, Claim, Summary, Acknowledgment, Case, Conclusion

% Changes to these recommendations:
% - added Postulate (definition style)
% - added algorithm style to facilitate CS and cryptocode
%    i)  set Algorithm to algorithm
%    ii) added Protocol, Procedure, Game, and Reduction

\prop_const_from_keyval:Nn \c_dez_theorem_like_prop 
{
    Algorithm       = algorithm ,   % changed to algorithm
    Theorem         = plain ,
    Lemma           = plain ,
    Corollary       = plain,
    Proposition     = plain ,
    Criterion       = plain ,
    Assertion       = plain ,
    Conjecture      = plain ,
    Question        = definition ,
    Example         = definition ,
    Definition      = definition,
    Hypothesis      = definition ,
    Condition       = definition ,
    Axiom           = definition,
    Postulate       = definition ,  % added
    Property        = definition ,
    Assumption      = definition ,
    Exercise        = definition ,
    Remark          = remark ,
    Note            = remark ,
    Claim           = remark ,
    Case            = remark ,
    Notation        = remark ,
    Summary         = remark ,
    Acknowledgment  = remark ,
    Conclusion      = remark ,
}

% These ones are defined in cleveref, so don't set names for them
\seq_const_from_clist:Nn \c_dez_theorem_like_names_in_cref_seq
{
    Theorem, Lemma, Corollary, Proposition,
    Definition, Example ,
    Remark ,
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
    Axiom           = Axiom/Axioms ,
    Property        = Property/Properties ,
    Assumption      = Assumption/Assumptions ,
    Hypothesis      = Hypothesis/Hypotheses ,
    Exercise        = Exercise/Exercises ,
    % Algorithm defined above
    % Remark defined above
    Note            = Note/Notes ,
    Claim           = Claim/Claims ,
    Case            = Case/Cases ,
    Postulate       = Postulate/Postulates ,  % added; not recommended by amsthm
}

% define the styles suggested in the amsthm documentation
% • plain : italic text, extra space above and below;
% • definition : upright text, extra space above and below;
% • algorithm (NEW): like definition, but a little more space below;
% • remark : upright text, no extra space above or below

\NewDocumentCommand \DeclareTheoremStyle { m O{} }
{
    \declaretheoremstyle
        [
            spaceabove     = \g_dez_abv_thm_skip ,
            spacebelow     = \g_dez_bel_thm_skip ,
            postheadspace  = \g_dez_glue_before_thm_title_skip ,
            headfont       = \bfseries ,
            notefont       = \bfseries ,
            bodyfont       = \upshape ,
            #2
        ]
        { #1 }
}

\DeclareTheoremStyle
    { plain }
    [
        spaceabove     = \g_dez_abv_thm_skip ,
        spacebelow     = \g_dez_bel_thm_skip ,
        bodyfont       = \itshape ,
    ]

\DeclareTheoremStyle
    { algorithm }
    [
        spaceabove     = \g_dez_abv_alg_skip ,
        spacebelow     = \g_dez_bel_alg_skip ,
    ]

\DeclareTheoremStyle
    { definition }
    [
        spaceabove     = \g_dez_abv_def_skip ,
        spacebelow     = \g_dez_bel_def_skip ,
    ]

\DeclareTheoremStyle
    { remark }
    [
        spaceabove     = \g_dez_abv_remark_skip ,
        spacebelow     = \g_dez_bel_remark_skip ,
    ]

% amsthm defines this; renew so we can set the space
% note: we alias Proof (capitalized) later
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


\str_if_eq:VnTF \g_dez_thm_in_str {none}
    { \declaretheorem [                           style=plain ] {theoremlike} }
    { \declaretheorem [ parent=\g_dez_thm_in_str, style=plain ] {theoremlike} }

\NewDocumentCommand \NewTheoremEnv { m O{} }
{
    \declaretheorem [ sibling=theoremlike, #2 ] {#1}
}

\cs_new_protected:Npn \dez__new_thm_aux:Vn #1#2
{
    \declaretheorem [ sibling=theoremlike, style=#1 ] {#2}
}

\cs_new_protected:Npn \dez_new_thm:n #1
{
    \prop_get:NnNF \c_dez_theorem_like_prop {#1} \l_tmpa_tl
        { \tl_set:Nn \l_tmpa_tl {remark} }
     \dez__new_thm_aux:Vn \l_tmpa_tl {#1}
}
\cs_generate_variant:Nn \dez_new_thm:nn { nV }

\NewDocumentCommand \NewDefaultTheoremEnvs { }
{
    \seq_map_inline:Nn \c_dez_theorem_like_names_in_cref_seq
    {
        \dez_new_thm:n {##1}
        % no cleveref call
    }
    \prop_map_inline:Nn \c_dez_theorem_like_names_prop
    {
        \dez_new_thm:n {##1}
        \pidgin__set_cref:nn {##1} {##2}
    }
}


%======================================================================================================================
%                     lists of things
%======================================================================================================================

% replace the 10pt extra space
% https://tex.stackexchange.com/questions/784/how-to-change-the-line-spacing-in-my-list-of-figures
\patchcmd
    { \@chapter }
    { \addtocontents {lof}
    { \protect \addvspace {10\p@}} }
    { \dez__par_addvspace:N \g_dez_lof_chap_skip }
    {}
    {}

\patchcmd
    { \@chapter }
    { \addtocontents {lot}
    { \protect \addvspace {10\p@}} }
    { \dez__par_addvspace:N \g_dez_lof_chap_skip }
    {}
    {}

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
        { \HideLinks }
    \dez__fix_lof:n{#1}
    \setlength {\parskip} {0ex}  % makes things confusing
    \hook_use:n { dez / lof-like / pre }
}
{ \hook_use:n { dez / lof-like / post } }

\NewDocumentEnvironment {TocLikeList} { t! }
    { \begin {LofLikeListInternal} {#1} }
    { \end   {LofLikeListInternal} }

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
    \hook_use:n { dez / lof-like / before }
    % We're just not going to allow ! or + here --
    % It's the table of contents for God's sake.
    \group_begin:
    \bool_if:NF \g_dez_show_toc_links_bool
        { \HideLinks }
    \setlength {\parskip} {0ex}  % makes things confusing
    \exp_args:NV \setstretch \g_dez_stretch_toc_tl
    \hook_use:n { dez / lof-like / pre }
    \tableofcontents
    \hook_use:n { dez / lof-like / post }
    \group_end:
    \hook_use:n { dez / lof-like / after }
}

% Output list of figures
\NewDocumentCommand \ShowListOfFigures { t! t+ }
{
    \hook_use:n { dez / lof-like / before }
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \listoffigures
    \dez_maybe_add_toc:nnn {#1} {#2} {\listfigurename}
    %\addcontentsline{toc}{chapter}{\listfigurename}
    \end {LofLikeListInternal}
    \hook_use:n { dez / lof-like / after }
}

% Output list of tables
\NewDocumentCommand \ShowListOfTables { t! t+ }
{
    \hook_use:n { dez / lof-like / before }
    % \listoftables doesn't use \listoffigures
    % so we follow the same logic as in LofLikeListInternal
    \group_begin:
    \bool_if:NF \g_dez_show_toc_links_bool
        { \HideLinks }
    \dez__fix_lot:n{#1}
    \setlength {\parskip} {0ex}  % makes things confusing
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \hook_use:n { dez / lof-like / pre }
    \listoftables
    %\addcontentsline{toc}{chapter}{\listtablename}
    \dez_maybe_add_toc:nnn {#1} {#2} {\listtablename}
    \hook_use:n { dez / lof-like / post }
    \group_end:
    \hook_use:n { dez / lof-like / after }
}

% Output list of abbreviations (via 'acro' package)
\NewDocumentCommand \ShowListOfAbbreviations { t! t+ }
{
    \hook_use:n { dez / lof-like / before }
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
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
              \dez__par_addvspace:N \g_dez_bel_front_chap_skip
            } ,
    }
    \exp_args:Ne
        \setlist
        {
            itemsep     = {\skip_use:N \g_dez_btw_lof_items_skip} ,
            topsep      = 0pc ,
            partopsep   = 0pc ,
            parsep      = 0pc ,
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
    \hook_use:n { dez / lof-like / after }
}

% Output nomenclature
\NewDocumentCommand \ShowNomenclature { t! t+ }
{
    \hook_use:n { dez / lof-like / before }
    % nomencl doesn't use \listoffigures
    % so, we'll turn \chapter* into \chapter
    \group_begin:
    \setlength {\parskip} {0ex}
    \bool_if:nT {#1}
    {
        \let \oldchapter \chapter
        \renewcommand {\chapter}
            { {  % both braces
                 \oldchapter { \pidgin_string:n {nomenclature} }
            } }
    }
    \exp_args:NV \setstretch \g_dez_stretch_nom_tl
    \bool_if:NF \g_dez_show_toc_links_bool
        { \HideLinks }
    % also uses \nomitemsep, which we set earlier
    \exp_args:Ne
        \setlist
        {
            itemsep     = 0pc ,
            topsep      = 0pc ,
            partopsep   = 0pc ,
            parsep      = 0pc ,
        }
    \hook_use:n { dez / lof-like / pre }
    \printnomenclature
    \dez_maybe_add_toc:nnn {#1} {#2} { \pidgin_string:n {nomenclature} }
    \hook_use:n { dez / lof-like / post }
    \group_end:
    \hook_use:n { dez / lof-like / after }
}


\keys_define:nn { dez / list-of-theorems }
{
    title .tl_set:N     = \l__title_tl ,
    unknown .code:n     = { \exp_args:NNo \tl_put_right:Nn \l__unknown_tl { \l_keys_key_str={#1}, } } ,
}

\cs_new_protected:Npn \dez__listoftheorems:V #1
{
    \dez_non_expl:n { \listoftheorems [#1] }
}

\cs_new_protected:Npn \dez__list_of_thm_like:nnn #1#2#3
{
    \hook_use:n { dez / lof-like / before }
    \begin {LofLikeListInternal} {#1}
    \tl_set:Nn \l__unknown_tl {}
    \tl_set:Nn \l__title_tl { \pidgin_string:n {List~of~Theorems}  }
    \keys_set:nn {dez / list-of-theorems} {#3}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \tl_put_right:Nn \l__unknown_tl { , title={\l__title_tl} }
    \exp_args:NV \dez__listoftheorems:V \l__unknown_tl
    \bool_if:nF {#1}
        { \exp_args:NnnV \addcontentsline {toc} {chapter} \l__title_tl }
    \dez_maybe_add_toc:nnn {#1} {#2} { \l__title_tl }
    \end {LofLikeListInternal}
    \hook_use:n { dez / lof-like / after }
}

\NewDocumentCommand \ShowListOfTheoremLike { t! t+ O{} }
{
    \dez__list_of_thm_like:nnn {#1} {#2} {#3}
}

\NewDocumentCommand \ShowListOfResults { t! t+ O{} }
{
    \dez__list_of_thm_like:nnn
        {#1}
        {#2}
        {
          ignoreall,
          showonly   = { Theorem, Lemma, Corollary, Proposition, Criterion, Assertion } ,  % no Conjecture
          title      = List~of~results ,
          #3 ,
        }
}

\NewDocumentCommand \ShowListOfAlgorithms { t! t+ O{} }
{
    \dez__list_of_thm_like:nn
        {#1}
        {#2}
        { ignoreall, showonly=Algorithm, title=List~of~algorithms, #3 }
}

\NewDocumentCommand \ShowListOfDefinitions { t! t+ O{} }
{
    \dez__list_of_thm_like:nn
        {#1}
        {#2}
        { ignoreall, showonly=Definition, title=List~of~definitions, #3 }
}

\NewDocumentCommand \ShowListOfExamples { t! t+ O{} }
{
    \dez__list_of_thm_like:nn
        {#1}
        {#2}
        { ignoreall, showonly=Example, title=List~of~examples, #3 }
}

\NewDocumentCommand \ShowListOfCode { t! t+ }
{
    \hook_use:n { dez / lof-like / before }
    \begin {LofLikeListInternal} {#1}
    \exp_args:NV \setstretch \g_dez_stretch_lof_tl
    \listoflistings
    \dez_maybe_add_toc:nnn {#1} {#2} { \pidgin_string:n {listlisting} }
    \end {LofLikeListInternal}
    \hook_use:n { dez / lof-like / after }
}

\NewDocumentCommand \NewListOfNewfloatCmd { m m }
{
    \exp_args:Ncnn \NewDocumentCommand {#1} { t! t+ }
    {
        \hook_use:n { dez / lof-like / before }
        \begin {LofLikeListInternal} {##1}
        \exp_args:NV \setstretch \g_dez_stretch_lof_tl
        \cs:w listof #2 \cs_end:
        \dez_maybe_add_toc:nnn {##1} {##2} { \pidgin_string:n {list#2} }
        \end {LofLikeListInternal}
        \hook_use:n { dez / lof-like / after }
    }
}

\NewDocumentCommand \NewListOfCmd { m m }
{
    \exp_args:Ncnn \NewDocumentCommand {#1} { t! t+ O{} }
    {
        \hook_use:n { dez / lof-like / before }
        \begin {LofLikeListInternal} {##1}
        \exp_args:NV \setstretch \g_dez_stretch_lof_tl
        \cs:w #2 \cs_end: \bool_if:nT {##1} {!} \bool_if:nT {##2} {+} ##3
        \end {LofLikeListInternal}
        \hook_use:n { dez / lof-like / after }
    }
}



%======================================================================================================================
%                     abbreviations
%======================================================================================================================

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


\NewDocumentCommand \indexed { s m O{} }
{
    \bool_if:nTF {#1}
        { \textiles_use:nn {indexed-starred} {#2} }
        { #2 }
    \dez_if_feat_enabled:nT {imakeidx}
        { \tl_if_blank:nTF {#3} { \index{#2} } { \index{#3} } }
}

\NewDocumentCommand \Indexed { s m O{} }
{
    \bool_if:nTF {#1}
        {
            \textiles_use:nn
                { indexed-starred }
                { \txtsentencecasefirst{#2} }
        }
        { \txtsentencecasefirst{#2} }
    \dez_if_feat_enabled:nT {imakeidx}
    {
        \tl_if_blank:nTF {#3} { \index{#2} } { \index{#3} }
    }
}

\dez_if_feat_enabled:nT {knowledge}
{
    \knowledgeconfigure { visible~anchor~points = \g_dez_draft_bool }
}


%======================================================================================================================
%                      caption and subcaption styling
%======================================================================================================================

\tl_new:N \CurrentFloatOptions

\DeclareCaptionSubType [\g_dez_n_panels_str] {figure}

\DeclareCaptionLabelSeparator {dez-sep} {\g_dez_typo_caption_label_sep_tl}

\textiles_declare_cap_style:nnn {dez-caption} {caption-body}    {caption-label}
\textiles_declare_cap_style:nnn {dez-subcap}  {subcap-body}     {subcap-label}
\textiles_declare_cap_style:nnn {dez-table}   {table-head-body} {table-head-label}

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

% Captions that go at the TOP of tables
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
    \exp_args:NNe \tl_set:Nn \l_tmpa_tl { \pidgin_string:n{#1} }
    \exp_args:NNe \tl_set:Nn \l_tmpb_tl { \pidgin_string:n{list#1} }
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

\cs_new_protected:Npn \dez__begin_float:nn #1#2
{
    \bool_if:nT {#2} { \bool_set_true:N \l__twocol_bool }
    \bool_if:NTF \l__twocol_bool
        { \tl_set:Nn \l_my_env_tl {#1*} }
        { \tl_set:Nn \l_my_env_tl {#1} }
    \tl_if_blank:VTF \l__placement_tl  % avoid warning
        { \begin_:V \l_my_env_tl }
        { \begin_o:VV \l_my_env_tl \l__placement_tl }
}

\cs_new_protected:Npn \dez__end_float:n #1
{
    \bool_if:NTF \l__twocol_bool
        { \tl_set:Nn \l_my_env_tl {#1*} }
        { \tl_set:Nn \l_my_env_tl {#1} }
    \end_:V \l_my_env_tl
}



%======================================================================================================================
%                      captioning commands
%======================================================================================================================


\keys_define:nn { dez / capkeyval }
{
    label .tl_set:N            = \l__label_tl ,
    label .default:n           = * ,
    label .initial:n           = {} ,
    entry .tl_set:N            = \l__entry_tl ,
    entry .default:n           = * ,
    entry .initial:n           = {} ,
    caption .tl_set:N          = \l__caption_tl ,
    caption .initial:n         = {} ,
    caption .value_required:n  = true ,
    caption+ .tl_set:N         = \l__caption_plus_tl ,
    caption+ .default:n        = {} ,
    caption+ .initial:n        = {!!!!!} ,
}

\cs_new_protected:Nn \dez__fix_cap_args:
{
    \tl_if_eq:NnF \l__caption_plus_tl {!!!!!}
    {
        \tl_if_blank:VF \l__caption_tl
        {
            \exp_args:NNo
                \tl_set:Nn
                \l__caption_tl
                { \l__entry_tl\l__caption_plus_tl }
        }
    }
    \tl_if_eq:NnT \l__caption_tl {*}
    {
        \tl_set_eq:NN \l__caption_tl \l__entry_tl
    }
    \tl_if_eq:NnT \l__label_tl {*}
    {
        \tl_set_eq:NN \l__label_tl \l__entry_tl
        \tl_replace_all:Nnn \l__label_tl {~} {-}  % TODO: improve
    }
}

\cs_new_protected:Nn \dez__capkeyval:
{
    \dez__fix_cap_args:
    \bool_set_false:N \l_tmpa_bool
    \tl_if_blank:VF \l__caption_tl { \bool_set_true:N \l_tmpa_bool }
    \tl_if_blank:VF \l__entry_tl   { \bool_set_true:N \l_tmpa_bool }
    \bool_if:NT \l_tmpa_bool
    {
        \tl_if_blank:VTF \l__entry_tl
            { \caption                {\l__caption_tl} }
            { \caption [\l__entry_tl] {\l__caption_tl} }

    }
    \tl_if_blank:VTF \l__label_tl
        { \label {\l__label_tl} }  % TODO: if no anchor?
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



%======================================================================================================================
%                 equations
%======================================================================================================================


\keys_define:nn { dez / equation }
{
    numberless .bool_set:N         = \l__numberless_bool ,
    numberless .default:n          = true ,
    numberless .initial:n          = false ,
    name .tl_set:N                 = \l__name_tl ,
    name .initial:n                = {} ,
    name .value_required:n         = true ,
    tag .meta:n                    = { name=#1 } ,
    tag .value_required:n          = true ,
    label .tl_set:N                = \l__label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
}


\NewDocumentEnvironment {Equation} { s O{} }
{
    \keys_set:nn {dez / equation} {#2}
    \bool_if:NT {#1}
        { \bool_set_true:N \l__numberless_bool }
    \bool_if:NTF \l__numberless_bool
        { \tl_set:Nn \l__myenv_tl {equation*} }
        { \tl_set:Nn \l__myenv_tl {equation}  }
    \begin_:V \l__myenv_tl
    \tl_if_blank:VF \l__name_tl
        { \exp_args:NV \tag \l__name_tl }
}
{
    \tl_if_blank:VF \l__label_tl
        { \exp_args:NV \label \l__label_tl }
    \end_:V \l__myenv_tl
}

\NewDocumentEnvironment {Equation*} { O{} }
    { \begin {Equation} [#1,numberless] }
    { \end {Equation} }




%======================================================================================================================
%                 figures -- single-panel
%======================================================================================================================

\g@addto@macro \@floatboxreset \centering
% This one no longer works!
%\g@addto@macro\@subfloatboxreset{\centering}
% https://tex.stackexchange.com/questions/144853/add-centering-to-all-subfigures-in-subcaption-using-gaddtomacro
\apptocmd \subcaption@iiminipage {\centering} {} {}

\keys_define:nn { dez / figure }
{
    at .tl_set:N                   = \l__placement_tl ,
    at .initial:n                  = {} ,
    at .value_required:n           = true ,
    label .tl_set:N                = \l__label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    caption .tl_set:N              = \l__caption_tl ,
    caption .initial:n             = {} ,
    caption .value_required:n      = true ,
    caption+ .tl_set:N             = \l__caption_plus_tl ,
    caption+ .default:n            = {} ,
    caption+ .initial:n            = {!!!!!} ,
    2col .bool_set:N               = \l__twocol_bool ,
    2col .default:n                = true ,
    2col .initial:n                = false ,
}

\cs_new:Npn \dez__include_graphics:nn #1#2
{
	% passed "Export" to adjustbox, so \includgraphics is \adjincludegraphics
    \includegraphics [#2] {#1}
}
\cs_generate_variant:Nn \dez__include_graphics:nn { VV }

\NewDocumentEnvironment {Figure} { s O{} }
{
    \keys_set:nn {dez / figure} {#2}
    \dez__begin_float:nn {figure} {#1}
}
{
    \dez__capkeyval:
    \dez__end_float:n {figure}
}

\NewDocumentEnvironment {Figure*} { O{} }
    { \begin {Figure} [ #1, full ] }
    { \end   {Figure} }

\keys_define:nn { dez / chem-figure }
{
    at .tl_set:N                   = \l__placement_tl ,
    at .initial:n                  = {} ,
    at .value_required:n           = true ,
    options .tl_set:N              = \CurrentFloatOptions ,
    options .initial:n             = {} ,
    label .value_required:n        = true ,
    label .tl_set:N                = \l__label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    caption .tl_set:N              = \l__caption_tl ,
    caption .initial:n             = {} ,
    caption .value_required:n      = true ,
    caption+ .tl_set:N             = \l__caption_plus_tl ,
    caption+ .default:n            = {} ,
    caption+ .initial:n            = {!!!!!} ,
    2col .bool_set:N               = \l__twocol_bool,
    2col .default:n                = true ,
    2col .initial:n                = false,
}

\NewDocumentEnvironment {ChemFigure} { s O{} }
{
    \keys_set:nn {dez / figure} {#2}
    \dez__begin_float:nn {figure} {#1}
    \exp_args:NV \setchemfig \CurrentFloatOptions
    \schemestart
}
{
    \schemestop
    \chemnameinit{}
    \dez__capkeyval:
    \dez__end_float:n {figure}
}


\NewDocumentCommand \Chem { D(){} m }
{
    \tl_if_blank:nTF {#1}
        { \chemfig {#2} }
        {
            \chemname
                { \chemfig {#2} }
                { \textiles_use:nn {chem-name} {#1} }
        }
}



%======================================================================================================================
%                 figures -- multi-panel (with real graphics)
%======================================================================================================================

\keys_define:nn { dez / multi-panel-figure }
{
    at .tl_set:N                   = \l__placement_tl ,
    at .initial:n                  = {} ,
    at .value_required:n           = true ,
    label .tl_set:N                = \l__label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    caption .tl_set:N              = \l__caption_tl ,
    caption .initial:n             = {} ,
    caption .value_required:n      = true ,
    caption+ .tl_set:N             = \l__caption_plus_tl ,
    caption+ .default:n            = {} ,
    caption+ .initial:n            = {!!!!!} ,
    2col .bool_set:N               = \l__twocol_bool ,
    2col .default:n                = true ,
    2col .initial:n                = false ,
}


\NewDocumentEnvironment {MultiPanelFigure} { s O{} }
{
    \keys_set:nn {dez / multi-panel-figure} {#2}
    \dez__begin_float:nn {figure} {#1}
}
{
    \dez__capkeyval:
    \dez__end_float:n {figure}
}

% align (inner-pos) can be 'l', 'c, 'r', or anything declared via \DeclareCaptionJustification
% we declared some aliases in the captioning section above
\keys_define:nn { dez / real-panel }
{
    file  .tl_set:N                = \l__panel_file_tl ,
    file .initial:n                = {} ,  % optional, but clearly wanted
    file .value_required:n        = true ,
    options .tl_set:N              = \CurrentFloatOptions ,
    options .initial:n             = {} ,
    options .value_required:n      = true ,
    width .tl_set:N                = \l__panel_width_tl ,
    width .initial:n               = {} ,
    width .value_required:n        = true ,
    align .tl_set:N                = \l__panel_innerpos_tl ,
    align .default:n               = left ,
    align .initial:n               = center ,
    label .tl_set:N                = \l__panel_label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    entry .tl_set:N                = \l__panel_entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    caption .tl_set:N              = \l__panel_caption_tl ,
    caption .initial:n             = {} ,
    caption .value_required:n      = true ,
    caption+ .tl_set:N             = \l__panel_caption_plus_tl ,
    caption+ .default:n            = {} ,
    caption+ .initial:n            = {!!!!!} ,
}

\NewDocumentCommand \Panel { m }
{
    \group_begin:
    \keys_set:nn {dez / real-panel} {#1}
    \tl_if_blank:VT \l__caption_tl
    {
        \tl_if_eq:NnF \l__panel_caption_plus_tl {!!!!!}
        {
            \exp_args:NNo
            \tl_set:Nn
            \l__caption_tl
            { \l__panel_entry_tl.~\l__panel_entry_tl }
        }
    }
    \subcaptionbox
        [\l__panel_entry_tl]
        {\l__panel_caption_tl}
        [\l__panel_width_tl]
        [\l__panel_innerpos_tl]
        {
            \tl_if_blank:VF \l__file_tl
                { \dez__include_graphics:VV \l__file_tl \CurrentFloatOptions }
            \tl_if_blank:VF \l__label_tl
                { \label {\l__label_tl} }
        }
    \group_end:
}




%======================================================================================================================
%                 phantom-panel figures -- 1 graphics file 
%======================================================================================================================

\keys_define:nn { dez / phantom-panel-figure }
{
    at .tl_set:N                   = \l__placement_tl ,
    at .initial:n                  = {} ,
    at .value_required:n           = true ,
    label .tl_set:N                = \l__label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    caption .tl_set:N              = \l__caption_tl ,
    caption .initial:n             = {} ,
    caption .value_required:n      = true ,
    caption+ .tl_set:N             = \l__caption_plus_tl ,
    caption+ .default:n            = {} ,
    caption+ .initial:n            = {!!!!!} ,
    2col .bool_set:N               = \l__twocol_bool ,
    2col .default:n                = true ,
    2col .initial:n                = false ,
}

%\prop_new:N \g__dez_panel_prop

\NewDocumentEnvironment {PhantomPanelFigure} { s O{} }
{
    \keys_set:nn {dez / phantom-panel-figure} {#2}
    \dez__begin_float:nn {figure} {#1}
}
{
    \dez__capkeyval:
    \dez__end_float:n {figure}
}


\keys_define:nn { dez / phantom-panel }
{
    label .tl_set:N                = \l__panel_label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    entry .tl_set:N                = \l__panel_entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
}

\NewDocumentCommand \PhantomPanel { m }
{
    \group_begin:
    \keys_set:nn {dez / phantom-panel} {#1}
     % add a LOF/TOC entry (if applicable), but don't show the text
    \captionlistentry {\l__panel_entry_tl}
    \tl_if_blank:VF \l__panel_label_tl
        { \label{\l__panel_label_tl} }
    \group_end:
}


% TODO: not possible
%\NewDocumentCommand \Graphics { O{} m }
%{
%    \dez__include_graphics:nn [#1] {#2}
%}



%======================================================================================================================
%                            panel captioning
%======================================================================================================================

\regex_const:Nn \c_dez__endash_regex {--}

\NewDocumentCommand \panel { O{} m O{} }
{
    \textiles_use:nn {subref} { #1 \subref{#2} #3 }
}

\NewDocumentCommand \panels { O{} m O{} }
{
    \textiles_use:nn {subref}
    {
        #1
        \clist_map_inline:nn {#2}
        {
            \regex_split:NnNTF \c_dez__endash_regex {##1} \l_tmpa_seq
                {
                  \exp_args:Nx \subref { \seq_pop_left:N \l_tmpa_seq \l_tmpa_tl }
                  --
                  \exp_args:Nx \subref { \seq_pop_left:N \l_tmpa_seq \l_tmpb_tl }
                }
                { \subref{##1} }
        }
        #3
    }
}

\NewDocumentCommand \panelcaption { m m }
{
    \panels {#1} [\g_dez_typo_subref_label_sep_tl]
    #2
}




%======================================================================================================================
%                            tables
%======================================================================================================================

% Vertical spacing
\SetTblrOuter
{
    presep    = \g_dez_abv_table_title_skip ,
    headsep   = \g_dez_bel_table_title_skip ,
    footsep   = \g_dez_abv_table_footer_skip ,
    postsep   = \g_dez_bel_table_footer_skip ,
}

% from booktabs source:
% \heavyrulewidth=.08em
% \lightrulewidth=.05em
% \cmidrulewidth=.03em
% \belowrulesep=.65ex
% \belowbottomsep=0pt
% \aboverulesep=.4ex
% \abovetopsep=0pt
% \cmidrulesep=\doublerulesep
% \cmidrulekern=.5em
% \defaultaddspace=.5em

\cs_new_protected:Npn \dez__booktabs_widths:VVV #1#2#3
{
    \heavyrulewidth  = #1
    \lightrulewidth  = #2
    \cmidrulewidth   = #3
}

\tl_new:N \g_dez__top_tl
\tl_new:N \g_dez__mid_tl
\tl_new:N \g_dez__cmid_tl
\tl_gset:Nx \g_dez__top_tl    { \dim_use:N \g_dez_toprule_dim }
\tl_gset:Nx \g_dez__mid_tl    { \dim_use:N \g_dez_midrule_dim }
\tl_gset:Nx \g_dez__cmid_tl   { \dim_use:N \g_dez_cmidrule_dim }
\dez__booktabs_widths:VVV \g_dez__top_tl \g_dez__mid_tl \g_dez__cmid_tl

%\exp_args:Ne \aboverulesep {\dim_use:N \g_dez_above_rule_dim}
%\exp_args:Ne \belowrulesep {\dim_use:N \g_dez_below_rule_dim}

% Apply these font styles in all cases
\SetTblrStyle {caption-tag}    { font=\textiles_run_nullary:n {table-head-label} }
\SetTblrStyle {caption-sep}    { font=\textiles_run_nullary:n {table-head-label} }
\SetTblrStyle {conthead-text}  { font=\textiles_run_nullary:n {table-head-label} }
\SetTblrStyle {caption-text}   { font=\textiles_run_nullary:n {table-head-body} }
\SetTblrStyle {lastfoot}       { font=\textiles_run_nullary:n {table-footer} }
% let contfoot-text be the normal text font

% Fix the separators
% For caption, that's the only thing we'll do.
% (For notes and remarks, we'll do more after.)
\DefTblrTemplate {caption-sep} {default} { \g_dez_typo_caption_label_sep_tl }
\DefTblrTemplate {note-sep}    {default} { \g_dez_typo_table_note_sep_tl }   
\DefTblrTemplate {remark-sep}  {default} { \g_dez_typo_table_remark_sep_tl }
\DefTblrTemplate {note-tag}    {default} { \textsuperscript{\InsertTblrNoteTag} }
\DefTblrTemplate {remark-tag}  {default} { \InsertTblrRemarkTag }

% Now, simplify the footer ("last foot") template for a single-paragraph footer.
% This is the most common footer format journals use (that I'm familiar with).

\NewTblrTheme {longfoot}
{
    \DefTblrTemplate {note} {default}
    {
        \MapTblrNotes
        {
            \noindent
            \UseTblrTemplate {note-tag}  {default}
            \UseTblrTemplate {note-sep}  {default}
            \UseTblrTemplate {note-text} {default}
            \par
        }
    }
    \DefTblrTemplate {remark} {default}
    { 
        \MapTblrRemarks
        {
            \noindent
            \UseTblrTemplate {remark-tag}  {default}
            \UseTblrTemplate {remark-sep}  {default}
            \UseTblrTemplate {remark-text} {default}
            \par
        }
    }

    \DefTblrTemplate {lastfoot} {default}
    {
        \exp_args:NV \setstretch \g_dez_stretch_caption_tl
        \UseTblrTemplate {note}   {default}
        \UseTblrTemplate {remark} {default}
    }
}

\NewTblrTheme {shortfoot}
{
    \DefTblrTemplate {note} {default}
    {
        \MapTblrNotes
        {
            \UseTblrTemplate {note-tag}  {default}
            \UseTblrTemplate {note-sep}  {default}
            \UseTblrTemplate {note-text} {default}
            {}\ {}% no \par
        }
    }
    \DefTblrTemplate {remark} {default}
    { 
        \MapTblrRemarks
        {
            \UseTblrTemplate {remark-tag}  {default}
            \UseTblrTemplate {remark-sep}  {default}
            \UseTblrTemplate {remark-text} {default}
            {}\ {}% no \par
        }
    }

    \DefTblrTemplate {lastfoot} {default}
    {
        \exp_args:NV \setstretch \g_dez_stretch_caption_tl
        \noindent
        \UseTblrTemplate {note}   {default}
        \UseTblrTemplate {remark} {default}
    }
}


\NewColumnType {L}  { >{$} l <{$} }
\NewColumnType {C}  { >{$} c <{$} }
\NewColumnType {R}  { >{$} r <{$} }
\NewRowType    {L}  { >{$} l <{$} }
\NewRowType    {C}  { >{$} c <{$} }
\NewRowType    {R}  { >{$} r <{$} }

\exp_args:NnV \colorlet {evenrow} \g_dez_even_row_bg_tl

% https://tex.stackexchange.com/questions/634497/define-a-style-in-tabularray
\NewDocumentCommand \NewTableStyle { m O{} m }
{
    \NewTblrEnviron {#1}
    \SetTblrOuter   [#1] {#2}
    \SetTblrInner   [#1] {#3}
}

\exp_args:Nne
    \NewTableStyle
    {DezTblr}
    {
        rowsep        = 0pt ,
        cells         = { font=\exp_not:n{\sffamily\small} } ,
        stretch       = \g_dez_stretch_table_tl ,
    }


\exp_args:Nne
    \NewTableStyle
    {DezSimpleTblr}
    {
        rowsep        = 0pt ,
        rowhead       = {1} ,
        width         = \linewidth ,
        hline{1,Z}    = \g_dez__top_tl ,
        hline{2}      = \g_dez__mid_tl ,
        cells         = { font      = \exp_not:n{\sffamily\small} } ,
        row{1}        = {
                          abovesep+ = {\g_dez__top_tl} ,
                          belowsep+ = {\g_dez__mid_tl} ,
                        } ,
        row{2}        = { abovesep+ = \g_dez__mid_tl } ,
        row{Z}        = { belowsep+ = \g_dez__top_tl } ,
        cells         = { font      = \exp_not:n{\sffamily\small} } ,
        row{even}     = { bg        = evenrow } ,
        stretch       = \g_dez_stretch_table_tl ,
    }

\exp_args:Nne
    \NewTableStyle
    {DezPlainTblr}
    {
        rowsep        = 0pt ,
        rowhead       = {1} ,
        width         = \linewidth ,
        hline{1,Z}    = \g_dez__top_tl ,
        cells         = { font      = \exp_not:n{\sffamily\small} } ,
        row{1}        = {
                          abovesep+ = {\g_dez__top_tl} ,
                        } ,
        row{Z}        = { belowsep+ = \g_dez__top_tl } ,
        cells         = { font      = \exp_not:n{\sffamily\small} } ,
        row{even}     = { bg        = evenrow } ,
        stretch       = \g_dez_stretch_table_tl ,
    }

% for some reason, this gets ignored in the e-context with \exp_not:n above
% fortunately, \SetTblrInner concats
\SetTblrInner [DezSimpleTblr]
{
    row{1}        = { font      = {\sffamily\small\bfseries} } ,
}


\hook_gput_code:nnn {env/tblr/begin}          {dez/table-stretch}  { \setstretch {1.0} }
\hook_gput_code:nnn {env/longtblr/begin}      {dez/table-stretch}  { \setstretch {1.0} }
\hook_gput_code:nnn {env/talltblr/begin}      {dez/table-stretch}  { \setstretch {1.0} }
\hook_gput_code:nnn {env/booktabs/begin}      {dez/table-stretch}  { \setstretch {1.0} }
\hook_gput_code:nnn {env/longtabs/begin}      {dez/table-stretch}  { \setstretch {1.0} }
\hook_gput_code:nnn {env/talltabs/begin}      {dez/table-stretch}  { \setstretch {1.0} }
\hook_gput_code:nnn {env/DezTblr/begin}       {dez/table-stretch}  { \setstretch {1.0} }
\hook_gput_code:nnn {env/DezSimpleTblr/begin} {dez/table-stretch}  { \setstretch {1.0} }


\keys_define:nn { dez / table }
{
    at .tl_set:N                   = \l__placement_tl ,
    at .initial:n                  = {} ,
    at .value_required:n           = true ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    caption .tl_set:N              = \l__caption_tl ,
    caption .initial:n             = {} ,
    caption .value_required:n      = true ,
    caption+ .tl_set:N             = \l__caption_plus_tl ,
    caption+ .default:n            = {} ,
    caption+ .initial:n            = {!!!!!} ,
    simple .bool_set:N             = \l__simple_bool ,
    simple .default:n              = true ,
    simple .initial:n              = false ,
    plain .bool_set:N              = \l__plain_bool ,
    plain .default:n               = true ,
    plain .initial:n               = false ,
    2col .bool_set:N               = \l__twocol_bool ,
    2col .default:n                = true ,
    2col .initial:n                = false ,
    unknown .code:n                = { \exp_args:NNo \tl_put_right:Nn \l__unknown_tl { \l_keys_key_str={#1}, } } ,
}

\cs_new_protected:Nn \dez__fix_tblr_cap:
{
    \dez__fix_cap_args:
    \tl_if_blank:VF \l__entry_tl
    {
        \exp_args:NNo
            \tl_put_right:Nn
            \l__unknown_tl
            { , entry={\l__entry_tl} }
    }
    \tl_if_blank:VF \l__caption_tl
    {
        \exp_args:NNo
            \tl_put_right:Nn
            \l__unknown_tl
            { , caption={\l__caption_tl} }
    }
}

\NewDocumentEnvironment {Table} { s O{} G{} }
{
    \tl_set:Nn \l__unknown_tl {}
    \keys_set:nn {dez / table} {#2}
    \dez__begin_float:nn {table} {#1}
    %\dez__capkeyval:
    \bool_if:NTF \l__plain_bool
        { \tl_set:Nn \l_my_tblr_tl {DezPlainTblr} }
        {
          \bool_if:NTF \l__simple_bool
                { \tl_set:Nn \l_my_tblr_tl {DezSimpleTblr} }
                { \tl_set:Nn \l_my_tblr_tl {DezTblr} }
        }
    \dez__fix_tblr_cap:
    \tl_put_right:Nn \l__unknown_tl { , tall }
    \begin_or:VVn \l_my_tblr_tl \l__unknown_tl {#3}
}
{
    \end_:V \l_my_tblr_tl
    \dez__end_float:n {table}
}

\NewDocumentEnvironment {LongTable} { s O{} G{} }
{
    \tl_set:Nn \l__unknown_tl {}
    \keys_set:nn {dez / table} {#2}
    \bool_if:NTF \l__plain_bool
        { \tl_set:Nn \l_my_tblr_tl {DezPlainTblr} }
        {
          \bool_if:NTF \l__simple_bool
                { \tl_set:Nn \l_my_tblr_tl {DezSimpleTblr} }
                { \tl_set:Nn \l_my_tblr_tl {DezTblr} }
        }
    \bool_if:NT \l__twocol_bool
        { \onecolumn }
    \tl_if_blank:VF \l__placement_tl
    {
        % TODO: warn?
    }
    % we have to do some work so that we can use caption=* and caption+
    % like with our floats
    \tl_put_right:Nn \l__unknown_tl { , long }
    \dez__fix_tblr_cap:
    \begin_or:VVn \l_my_tblr_tl \l__unknown_tl {#3}
}
{
    \end_:V \l_my_tblr_tl
}




%======================================================================================================================
%                            admonitions
%======================================================================================================================

\keys_define:nn { dez / declare-admonition }
{
    header .tl_set:N            = \l_dez__box_header_tl ,
    header .value_required:n    = true ,
    shade .tl_set:N             = \l_dez__box_shade_tl ,
    shade .initial:n            = black ,
    shade .value_required:n     = true ,
}

\keys_define:nn { dez / admonition }
{
    name .tl_set:N             = \l__name_tl ,
    name .initial:n            = {} ,
    name .value_required:n     = true ,
    label .tl_set:N            = \l__label_tl ,
    label .default:n           = * ,
    label .initial:n           = {} ,
}
\dim_new:N       \g_dez_box_border_dim
\dim_gset:Nn     \g_dez_box_border_dim     { \g_dez_toprule_dim }
\dim_new:N       \g_dez_box_arc_dim
\dim_gset:Nn     \g_dez_box_arc_dim        { 0pt }
\cs_new_protected:Nn \dez_box_font_title:
    { \normalsizer \bfseries }

\cs_new:Npn \dez__dec_box:nnnN #1#2#3#4
{
    \tl_set:Nn \l_dez__box_header_tl {#3}
    \keys_set:nn {dez / declare-admonition} {#1}
    \tl_gset_eq:cN {g_dez__box_#3_hdr_tl} \l_dez__box_header_tl
    \exp_args:NnV \colorlet {dez-admonition-#3} \l_dez__box_shade_tl
    \colorlet {dez-admonition-#3-bg} {dez-admonition-#3!2!white}

    #4 {#3} { O{} }
    {
        \keys_set:nn {dez / admonition} {##1}
        \tl_if_eq:NnT \l__label_tl {*}
            {
              \tl_set_eq:NN \l__label_tl \l__name_tl
              \tl_replace_all:Nnn \l__label_tl {~} {-}
            }
        \begin {tcolorbox}
        [
            title       =
            {
                \exp_args:Nne
                    \textiles_use:nn {admonition-label}
                    {\use:c{g_dez__box_#3_hdr_tl}
                    \g_dez_typo_caption_label_sep_tl}
                \textiles_use:nn {admonition-name}  {\l__name_tl}
            } ,
            colframe     = {dez-admonition-#3} ,
            colupper     = {dez-admonition-#3} ,
            colback      = {dez-admonition-#3-bg} ,
            coltext      = black ,
            fontlower    = {} ,
            boxrule      = { \dim_use:N \g_dez_box_border_dim } ,
            arc          = { \dim_use:N \g_dez_box_arc_dim } ,
            boxsep       = 0.2pc ,
            #2 ,         % here the user can override any of the above-listed defaults
        ]
        \tl_if_blank:VF \l__label_tl
            { \label {\l__label_tl} }
    }
    { \end {tcolorbox} }
}

\NewDocumentCommand \DeclareAdmonitionEnv { D(){} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \DeclareDocumentEnvironment } 

\NewDocumentCommand \NewAdmonitionEnv { D(){} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \NewDocumentEnvironment } 

\NewDocumentCommand \ProvideAdmonitionEnv { D(){} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \ProvideDocumentEnvironment }

\NewDocumentCommand \RenewAdmonitionEnv { D(){} O{} m }
    { \dez__dec_box:nnnN {#1} {#2} {#3} \RenewDocumentEnvironment } 


\NewDocumentCommand \NewExampleAdmonitionEnvs {}
{
    \RequirePackage {fontawesome5}
    \NewAdmonitionEnv ( shade=xkcd~darkish~blue,   header=\faInfoCircle )           {Comment}
    \NewAdmonitionEnv ( shade=xkcd~dark~turquoise, header=\faHandPointRight )       {Hint}
    \NewAdmonitionEnv ( shade=xkcd~sunflower,      header=\faQuestionCircle )       {Caution}
    \NewAdmonitionEnv ( shade=xkcd~darkish~red,    header=\faExclamationCircle )    {Warning}
    \NewAdmonitionEnv ( shade=xkcd~charcoal~grey,  header=\faExclamationTriangle )  {Discussion}
}



%======================================================================================================================
%                    source code
%======================================================================================================================

\NewDocumentCommand \DezRule {}
{
    \exp_args:Nne \rule {\linewidth} {\dim_use:N \g_dez_toprule_dim}
}

\dez_if_feat_enabled:nT {minted}
{
    \setminted
    {
        python3      = true ,
        frame        = lines ,
        framerule    = { \dim_use:N \g_dez_toprule_dim } ,
        framesep     = { \dim_use:N \g_dez_rule_pad_dim }  ,
        encoding     = UTF-8 ,
    }
}

% make line numbers big enough that they're readable
\RenewDocumentCommand \theFancyVerbLine {}
{
    \ttfamily
    % TODO: reset text color here
	\textiles_use:nn
		{code-line-num}
        { \oldstylenums{\arabic{FancyVerbLine}} }
}

\keys_define:nn { dez / source-code }
{
    at .tl_set:N                   = \l__placement_tl ,
    at .initial:n                  = {} ,
    at .value_required:n          = true ,
    lang .tl_set:N                 = \l__lang_tl ,
    lang .initial:n                = text ,
    lang .value_required:n         = true ,
    label .tl_set:N                = \l__label_tl ,
    label .default:n               = * ,
    label .initial:n               = {} ,
    entry .tl_set:N                = \l__entry_tl ,
    entry .default:n               = * ,
    entry .initial:n               = {} ,
    caption .tl_set:N              = \l__caption_tl ,
    caption .initial:n             = {} ,
    caption .value_required:n      = true ,
    options .tl_set:N              = \CurrentFloatOptions ,
    options .initial:n             = {} ,
    options .value_required:n     = true ,
}

\NewDocumentEnvironment {SourceCode} { O{} }
{
    \keys_set:nn {dez / source-code} {#1}
    \begin {listing}
    % minted's fontseries, fontweight, etc. allow 'auto', meaning current
    % but fontfamily doesn't; we'll assume it's always tt
    \dez__capkeyval:
    \dez_if_feat_enabled:nT {minted}
    {
        \textiles_run_nullary:n {code}
        \setminted { baselinestretch = \g_dez_stretch_code_tl }
    }
}
{
    \end{listing}
}

\NewDocumentEnvironment {MintedCode} { O{} }
{   \VerbatimEnvironment
    \begin {SourceCode} [#1]
    \dez_if_feat_enabled:nT {minted}
        { \begin_or:nVV {minted} \CurrentFloatOptions \l__lang_tl }
}
{
    \dez_if_feat_enabled:nT {minted}
        { \end {minted} }
    \end {SourceCode}
}

% Load minted code and put it in a sourcecode environment.
%                    == ARGS ==                                       %
%  #      R? arg     description                                      %
% [ #1 ]  N  main    key-value args to \capkeyval / \begin{SourceCode}[]
% ( #2 )  N  MINTED  key-value args to \begin{minted}[]
% { #4 }  Y  FILE    Path to file (e.g. cows.java)
%
\NewDocumentCommand \LoadSourceCode { O{} D(){} m }
{
    \begin {SourceCode} [#1]
    \dez__capkeyval:
    \dez_if_feat_enabled:nT {minted}
        { \inputminted [#2] {\l__lang_tl} {#3} }
    \end {SourceCode}
}



%======================================================================================================================
%                               new user float types
%======================================================================================================================


\keys_define:nn { dez / float }
{
    %at .tl_set:N          = \l__placement_tl ,
    %at .initial:n         = {} ,
    label .tl_set:N            = \l__label_tl ,
    label .default:n           = * ,
    label .initial:n           = {} ,
    entry .tl_set:N            = \l__entry_tl ,
    entry .default:n           = * ,
    entry .initial:n           = {} ,
    caption .tl_set:N          = \l__caption_tl ,
    caption .initial:n         = {} ,
    caption .value_required:n  = true ,
    caption+ .tl_set:N         = \l__caption_plus_tl ,
    caption+ .default:n        = {} ,
    caption+ .initial:n        = {!!!!!} ,
    options .tl_set:N          = \CurrentFloatOptions ,
    options .initial:n         = {} ,
    options .value_required:n  = true ,
}

\cs_new:Npn \dez_declare_float_type:ncc #1#2#3
{
    \dez__new_float:n {idez#1}
    \NewDocumentEnvironment {#1} { O{} }
    {
        \keys_set:nn {dez / float} {##1}
        \begin {Dez#1}
        #2
    }
    {
        \dez__capkeyval:
        #3
        \end {idez#1}
    }
}

\NewDocumentCommand \DeclareDezFloat { m D\^\^{prg_do_nothing:} D\$\${prg_do_nothing:} }
{
    \dez_declare_float_type:nnn {#1} {#2} {#3}
}


%======================================================================================================================
%                    quotations
%======================================================================================================================

\exp_args:Ne \SetBlockThreshold { \int_use:N \g_dez_typo_display_quote_lines_int }

% not supporting hyphenation; use otherlanguage* instead
\keys_define:nn { dez / quote }
{
    style .choices:nn            = { block, text, display }
                                   { \@str_to \l_style_str \l_keys_choice_tl } ,
    style .initial:n             = block ,
    style .value_required:n      = true ,
    lang .tl_set:N               = \l_lang_tl ,
    lang .initial:n              = {} ,
    lang .value_required:n       = true ,
    pre .tl_set:N                = \l_pre_tl ,
    pre .initial:n               = {} ,
    pre .value_required:n        = true ,
    post .tl_set:N               = \l_post_tl ,
    post .initial:n              = {} ,
    post .value_required:n       = true ,
    cite .tl_set:N               = \l_cite_tl ,
    cite .initial:n              = {} ,
    cite .value_required:n       = true ,
    punct .tl_set:N              = \l_punct_tl ,
    punct .initial:n             = {} ,
    punct .value_required:n      = true ,
}

\cs_new_protected:Npn \dez__blockquote:Vn #1#2
{
    \tl_if_empty:nTF {#1}
        { \blockquote []      {#2} }
        { \blockquote [] [#1] {#2} }
}

\cs_new_protected:Npn \dez__blockcquote:VVVVn #1#2#3#4#5
{
    \tl_if_empty:nTF {#4}
        { \blockcquote [#1] [#2] {#3}      {#5} }
        { \blockcquote [#1] [#2] {#3} [#4] {#5} }
}

\NewDocumentCommand \Quote { O{} m }
{
    \group_begin: \group_begin:   % TWICE! Needed for \selectlanguage
    \keys_set:nn {dez / quote} {#1}
    \tl_if_blank:VF \l_lang_tl
        { \selectlanguage {\l_lang_tl} }
    \tl_if_eq:NnT \l_style_str {text}
        { \SetBlockThreshold {1000000} }
    \tl_if_eq:NnT \l_style_str {display}
        { \SetBlockThreshold {-1} }
    \tl_if_blank:VTF \l_cite_tl
        { \dez__blockquote:Vn                                     \l_punct_tl {#2} }
        { \dez__blockcquote:VVVVn \l_pre_tl \l_post_tl \l_cite_tl \l_punct_tl {#2} }
    \group_end: \group_end:      % TWICE! Needed for \selectlanguage
}

\NewDocumentEnvironment {Quotation} { O{} +b }
    { \Quote [ style=display, #1 ] {#2} }
    { }


% use \textelp, \textelp*, \textins, and \textins*
% \newcommand{\mktextelp}{[\textellipsis\unkern]}
% \newcommand{\mktextelpins}[1]{[\textellipsis\unkern]␣[#1]}
% \newcommand{\mktextinselp}[1]{[#1]␣[\textellipsis\unkern]}
% \newcommand{\mktextins}[1]{[#1]}
% \newcommand{\mktextmod}[1]{[#1]}



%======================================================================================================================
%                    fonts
%======================================================================================================================

\unimathsetup
{
    colon       = literal ,  % NOT default but recommended
    %mathrm      = sym ,      % NOT default:
    %mathit      = sym ,
    %mathsf      = sym ,
    %mathbf      = sym ,
    %mathtt      = sym ,
    math-style  = ISO ,      % NOT default but recommended
    bold-style  = ISO ,      % NOT default but recommended
}

% https://www.overleaf.com/learn/latex/Questions/Which_OTF_or_TTF_fonts_are_supported_via_fontspec%3F
% Fira has too few glyphs (~1k), and XITS is archived
\prop_const_from_keyval:Nn \c_dez_mathfont_prop
{
    Noto             = NotoSansMath-Regular.ttf ,
    LatinModern      = Latin Modern Math ,
    STIX             = STIX Two Math ,
    Bonum            = TeX Gyre Bonum Math ,
    Pagella          = TeX Gyre Pagella Math ,
    Schola           = TeX Gyre Schola Math ,
    Termes           = TeX Gyre Termes Math ,
    DejaVu           = TeX Gyre DejaVu Math ,
    Asana            = Asana Math ,
}
\prop_get:NVN \c_dez_mathfont_prop \g_dez_font_math_str \l_tmpa_tl
\exp_args:Ne \setmathfont { \prop_item:NV \c_dez_mathfont_prop \g_dez_font_math_str }

\str_if_eq:VnT \g_dez_font_serif_str {LatinModern}
    { \setmainfont {Latin Modern Roman}     [\c_textiles_lmroman_help_tl]       }
\str_if_eq:VnT \g_dez_font_serif_str {STIX}
    { \setmainfont  {STIX Two Text}                                             }
\str_if_eq:VnT \g_dez_font_serif_str {SourcePro}
    { \setmainfont  {Source Serif Pro}      [\c_textiles_source_pro_help_tl]    }
\str_if_eq:VnT \g_dez_font_serif_str {Noto}
    { \setmainfont  {Noto Serif}            [\c_textiles_noto_help_tl]          }
\str_if_eq:VnT \g_dez_font_serif_str {Plex}
    { \setmainfont  {IBM Plex Serif}                                            }

\str_if_eq:VnT \g_dez_font_sans_str {LatinModern}
    { \setsansfont  {Latin Modern Sans}                                         }
\str_if_eq:VnT \g_dez_font_sans_str {SourcePro}
    { \setsansfont  {Source Sans Pro}       [\c_textiles_source_pro_help_tl]    }
\str_if_eq:VnT \g_dez_font_sans_str {Noto}
    { \setsansfont  {Noto Sans}             [\c_textiles_noto_help_tl]          }
\str_if_eq:VnT \g_dez_font_serif_str {Plex}
    { \setsansfont  {IBM Plex Sans}                                             }

% Cascadia Mono is just Cascadia Code without ligatures; use Code and we can disable ligatures if wanted
\str_if_eq:VnT \g_dez_font_mono_str {LatinModern}
    { \setmonofont  {Latin Modern Mono}     [\c_textiles_lmmono_help_tl]        }
\str_if_eq:VnT \g_dez_font_mono_str {SourcePro}
    { \setmonofont  {Source Code Pro}       [\c_textiles_source_pro_help_tl]    }
\str_if_eq:VnT \g_dez_font_mono_str {Noto}
    { \setmonofont  {Noto Sans Mono}        [\c_textiles_noto_mono_help_tl]     }
\str_if_eq:VnT \g_dez_font_mono_str {Noto/roman}  % fewer glyphs
    { \setmonofont  {Noto Mono}             [\c_textiles_noto_mono_help_tl]     }
\str_if_eq:VnT \g_dez_font_mono_str {Noto/sans}
    { \setmonofont  {Noto Sans Mono}        [\c_textiles_noto_mono_help_tl]     }
\str_if_eq:VnT \g_dez_font_mono_str {Cascadia}
    { \setmonofont  {Cascadia Code}                                             }
\str_if_eq:VnT \g_dez_font_serif_str {Plex}
    { \setmonofont  {IBM Plex Mono}                                             }
 


%======================================================================================================================
%                    character fallbacks
%======================================================================================================================

 \NewDocumentCommand \DeclareCharFallback { m m }
{
    \newunicodechar {#1}
    {
        \iffontchar \font`#1
        \relax #1
        \else { { #2 } }
        \fi
    }
}


% we can use Noto fonts to get just about everything
% However, only the math font has a minus sign
\NewDocumentCommand \UseNotoFallbacks {}
{
    %\providefontfamily \NotoEmoji {Noto Emoji}
    \def \textminus { $−$ }
    \setfontfamily \NotoSansSymbol {Noto Sans Symbols 2}
    \def \textvisiblespace { { \NotoSansSymbol ␣ } }
    \DeclareCharFallback {−} { $-$ }
    \DeclareCharFallback {␣} { { \NotoSansSymbol ␣ } }
}

\str_if_eq:VnT \g_dez_font_serif_str {Noto}
    { \UseNotoFallbacks }
\str_if_eq:VnT \g_dez_font_sans_str {Noto}
    { \UseNotoFallbacks }
\str_if_eq:VnT \g_dez_font_math_str {Noto}
    { \UseNotoFallbacks }



%======================================================================================================================
%                    siunitx
%======================================================================================================================

% Really none of these should be changed, EXCEPT
% group-digits group-minimum-digits, and maybe group-separator.
% If in a US university: group-separator={,},group-digits=integer
\sisetup
{
    retain-explicit-plus            = true ,       % +1 stays +1, not 1
    retain-zero-uncertainty         = true ,       % \pm 0 still shown
    group-minimum-digits            = 3 ,          % starting at this number (1 000)
    group-separator                 = \thinspace ,
    propagate-math-font             = true ,       % unimportant with unicode-math ?
    reset-text-family               = false ,      % these retain the current font in text mode:
    reset-text-series               = false ,
    reset-text-shape                = false ,
}
\exp_args:Ne \sisetup { group-digits = \g_dez_typo_siunitx_group_str }

% Noto text fonts lack ANY math symbols, including a minus sign
% Consequently, siunitx \qty, etc. will show tofu when called in text mode
% https://github.com/googlefonts/noto-fonts/issues/1013

\bool_if:NTF \g_dez_typo_siunitx_match_bool
{
    \sisetup
    {
        mode                      = match ,      % stay in the current mode (all?)
        unit-mode                 = match ,      %
        number-mode               = match ,      %
    }
}
{
    \sisetup
    {
        mode                      = math ,
        unit-mode                 = math ,      %
        number-mode               = math ,      %
        text-family-to-math       = true ,
        text-series-to-math       = true ,
    }
}

% add a few important units to siunitx
\DeclareSIUnit \angstrom       {\text{Å}}
\DeclareSIUnit \hour           {hr}
\DeclareSIUnit \minute         {min}
\DeclareSIUnit \Molar          {\textsc{m}}   % siunitx recommends small-caps



%======================================================================================================================
%                    misc typography
%======================================================================================================================

% because we're using Babel and requiring a full dialect,
% regional is a good choice
\DTMsetregional

\cs_if_exist:NT \tikzset
{
    \tikzset
    {
        every~picture/.style =
        {
            /utils/exec = { \textiles_run_nullary:n{tikz} }
        }
    }
}

\dez_if_feat_enabled:nT {tikz-cd}
{
    \tikzcdset{
        arrow~style                  = tikz ,  % math-font looks terrible
        every~label/.append~style    = { font = \textiles_run_nullary:n{tikz} } ,
    }
}

\dez_if_feat_enabled:nT {chemfig}
{
    \RenewDocumentCommand \printatom {m}
    {
        \textiles_run_nullary:n{tikz}
        \ensuremath { \use:c{\g_dez_sty_chemfig_tl} #1 }
    }
}



%======================================================================================================================
%                    kantlipsum
%======================================================================================================================


\dez_if_feat_enabled:nT {kantlipsum}
{
    \int_const:Nn \c_dez_max_kant_int {164}
    % Get kant paragraphs sequentially;
    % Increment this counter each time a paragraph is used
    \int_gzero_new:N \g__dez_ikant_int
    
    \NewDocumentCommand \NextKant { O{3} }
    {
        \int_compare:nNnTF {\g__dez_ikant_int} > {\c_dez_max_kant_int-1}
            { \int_gset:Nn \g__dez_ikant_int {1} }
            { \int_gincr:N \g__dez_ikant_int }
        \use:e
        {
            \kant [\g__dez_ikant_int] {1--#1}
        }
    }
    
    % This command instead chooses random paragraphs
    \NewDocumentCommand \RandKant { O{3} }
    {
        \use:e
        {
            \kant
                [ \int_rand:nn {1} {\c_dez_max_kant_int} ]
                { 1--#1 }
        }
    }
}




%======================================================================================================================
%                front, main, back matter commands
%======================================================================================================================

\NewDocumentCommand \DezInternalPrintBib {O{}}
{
    \hook_use:n { dez / show-bib / before }
    \group_begin:
    \exp_args:NV \setstretch \g_dez_stretch_refs_tl
    \exp_args:NNe \setlength \bibitemsep { \skip_use:N \g_dez_btw_refs_skip }
    \setlength \bibnamesep {0pc}  % between different authors
    \setlength \bibinitsep {0pc}  % between authors with different initials (first letter)
    \hook_use:n { dez / show-bib / pre }
    \printbibliography [#1]
    \hook_use:n { dez / show-bib / post }
    \group_end:
    \hook_use:n { dez / show-bib / after }
}

% Shows the bibliography at the end of the chapter, if \g_dez_bib_per_chap_bool
\NewDocumentCommand \ShowSubBib {}
{
    \bool_if:NT \g_dez_bib_per_chap_bool
        { \DezInternalPrintBib [heading=subbibintoc] }
}

\NewDocumentCommand \ShowEndnotes {}
{
    \hook_use:n { dez / show-endnotes / before }
    \group_begin:
    \hook_use:n { dez / show-endnotes / pre }
    \printendnotes  % does nothing if there are no endnotes
    \hook_use:n { dez / show-endnotes / post }
    \group_end:
    \hook_use:n { dez / show-endnotes / after }
}

% Shows the bibliography at the end of the document
\NewDocumentCommand \ShowFullBib {}
{
    \bool_if:NF \g_dez_bib_per_chap_bool
        { \DezInternalPrintBib }
}

\cs_new_protected:Npn \dez__chap_num:N #1
{
    \renewcommand \thechapter { #1{chapter} }
}

\NewDocumentCommand \StartFrontMatter {}
{
    \hook_use:n { dez / front-matter / early }
    \dez__one_col:
    \exp_args:Nc
        \dez__chap_num:N
        \g_dez_n_front_chp_str
    \dez__front_page_style:
    \pagenumbering {\g_dez_n_front_str}
    \setcounter {page} {1}
    \hook_use:n { dez / front-matter / late }
}

\hook_gput_code:nnn
    {begindocument}
    {dez/start-front-matter}
    {\StartFrontMatter}

\NewDocumentCommand \StartMainMatter {}
{
    \hook_use:n { dez / main-matter / early }
    \dez__restore_col:
    \DezChapterPageCmd  % clear page BEFORE changing the page numbering!
    \dez__main_page_style:
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
    \hook_use:n { dez / main-matter / late }
}

\NewDocumentCommand \StartBackMatter {}
{
    \hook_use:n { dez / back-matter / early }
    \DezChapterPageCmd  % clear page BEFORE changing the page numbering!
    \dez__back_page_style:
    \str_if_eq:VVF \g_dez_n_main_str \g_dez_n_back_str
        {
            \pagenumbering {\g_dez_n_back_str}
            \setcounter {page} {1}
        }
    \exp_args:Nc
        \dez__chap_num:N
        \g_dez_n_back_chp_str
    \setcounter {chapter} {0}
    \hook_use:n { dez / back-matter / late }
}




%======================================================================================================================
%                     setup commands
%======================================================================================================================

% We're just aliasing to make them consistent.
% Setup commands should end with 'Setup' and be camel-case.

\NewDocumentCommand \BibSetup {m}
    { \bibsetup {#1} }
\NewDocumentCommand \CiteSetup {m}
    { \citesetup {#1} }

\NewDocumentCommand \UnimathSetup {m}
    { \unimathsetup {#1} }

\NewDocumentCommand \MicrotypeSetup {m}
    { \microtypesetup {#1} }

\NewDocumentCommand \SiSetup {m}
    { \sisetup {#1} }

\NewDocumentCommand \HyperSetup {m}
    { \hypersetup {#1} }

\NewDocumentCommand \AcroSetup {m}
    { \acsetup {#1} }

\NewDocumentCommand \DtmSetup {m}
    { \DTMsetup {#1} }

\NewDocumentCommand \CaptionSetup { o m }
    { \captionsetup [#1] {#2} }

\NewDocumentCommand \GeometrySetup {m}
    { \geometry {#1} }

\NewDocumentCommand \FnpctSetup {m}
    { \setfnpct {#1} }

\NewDocumentCommand \LwcSetup {m}
    { \lwcsetup {#1} }

\NewDocumentCommand \ListSetup { o m }
    { \setlist [#1] {#2} }  % enumitem
    
% for optional features, allow setup without complaining

\NewDocumentCommand \KnowledgeSetup {m}
{
    \dez_if_feat_enabled:nTF {knowledge}
        { \knowledgeconfigure {#1} }
        { \dez__warn_cmdneedspkg:nn {KnowledgeSetup} {knowledge} }
}

\NewDocumentCommand \MintedSetup {m}
{
    \dez_if_feat_enabled:nTF {minted}
        { \setminted {#1} }
        { \dez__warn_cmdneedspkg:nn {MintedSetup} {minted} }
}

\NewDocumentCommand \TikzSetup {m}
{
    \dez_if_feat_enabled:nTF {tikz}
        { \tikzset {#1} }
        { \dez__warn_cmdneedspkg:nn {tikz} {TikzSetup} }
}

\NewDocumentCommand \CircuitzSetup {m}
{
    \dez_if_feat_enabled:nTF {circuitikz}
        { \ctikzset {#1} }
        { \dez__warn_cmdneedspkg:nn {CircuitzSetup} {circuitikz} }
}

\NewDocumentCommand \ChemformulaSetup {m}
{
    \dez_if_feat_enabled:nTF {chemformula}
        { \setchemformula {#1} }
        { \dez__warn_cmdneedspkg:nn {ChemformulaSetup} {chemformula} }
}

\NewDocumentCommand \ChemSetup { o m }
{
    \dez_if_feat_enabled:nTF {chemmacros}
        { \chemsetup [#1] {#2} }
        { \dez__warn_cmdneedspkg:nn {ChemSetup} {chemmacros} }
}


\NewDocumentCommand \ChemfigSetup { m }
{
    \dez_if_feat_enabled:nTF {chemfig}
        { \setchemfig{#1} }
        { \dez__warn_cmdneedspkg:nn {ChemfigSetup} {chemfig} }
}



%======================================================================================================================
%                     more aliases for consistency
%======================================================================================================================


% camel-case aliases of "document-wide" commands
% datetime2 uses capitalized variants, so leave those alone

% packages
% UseTikzLibrary and \UseGdLibrary were defined intelligently at the top
\let \UsePackage          \usepackage
% fonts
\let \FontSpec            \fontspec
\let \SetMainFont         \setmainfont
\let \SetSansFont         \setsansfont
\let \SetMonoFont         \setmonofont
\let \SetMathFont         \setmathfont
% counters
\let \NewCounter          \newcounter
\let \DefCounter          \defcounter
\let \SetCounter          \setcounter
\let \AddToCounter        \addtocounter
\let \StepCounter         \stepcounter
\let \RefStepCounter      \refstepcounter
% and SetCounterWithin
% babel
\let \SelectLanguage      \selectlanguage
\let \ForeignLanguage     \foreignlanguage
\let \BabelProvide        \babelprovide
\let \BabelFont           \babelfont
\let \BabelTags           \babeltags
% pages
\let \PageStyle           \pagestyle
\let \AssignPageStyle     \assignpagestyle
\let \NewPage             \newpage
\let \ClearPage           \clearpage
\let \ClearDoublePage     \cleardoublepage
% misc
\let \SetQuoteStyle       \setquotestyle
\let \ReverseMarginPar    \reversemarginpar
\let \NormalMarginPar     \normalmarginpar
% leave \marginpar


\NewDocumentEnvironment {TikzPicture} { }
    { \begin {tikzpicture} }
    { \end   {tikzpicture} }

\NewDocumentEnvironment {Proof} { o }
    { \begin {proof} [#1] }  % arg is proof name
    { \end   {proof} }

\NewDocumentEnvironment {OtherLanguage} { s m }
    {
    \bool_if:nTF {#1}
        { \begin {otherlanguage*} {#2} }
        { \begin {otherlanguage}  {#2} }
    }
    { \end{otherlanguage} }

\NewDocumentEnvironment {OtherLanguage*} { m }
    { \begin {otherlanguage*} {#1} }
    { \end   {otherlanguage*} }

\NewDocumentEnvironment {Landscape} {}
    { \begin {landscape} }
    { \end   {landscape} }

\NewDocumentCommand \NewMintedEnv { m m }
{
    \dez_if_feat_enabled:nTF {minted}
        { \newminted [#1] {#2} }
        { \dez__warn_cmdneedspkg:nn {MintedSetup} {minted} }
}



%======================================================================================================================
%                    input and subfile wrapper commands
%======================================================================================================================

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




%======================================================================================================================
%                    final things
%======================================================================================================================

% Nomenclature!
\dez_if_feat_enabled:nT {noms}
    { \makenomenclature }

% Run \makeindex
\dez_if_feat_enabled:nT {imakeidx}
{
    \bool_if:NTF \g_dez_toc_index_bool
        { \tl_set:Nn \l_tmpa_tl {intoc} }
        { \tl_set:Nn \l_tmpa_tl {}      }
    \exp_last_unbraced:Ne
        \makeindex
        { [
            \l_tmpa_tl ,
            columns    = { \int_use:N \g_dez_lay_index_cols_int } ,
            columnsep  = { \dim_use:N \g_dez_lay_index_col_sep_dim } ,
        ] }
}


% We pass the author, etc., at the preamble end, after the user set it.
\hypersetup
{
    breaklinks        = true ,
    final             = true ,  % ignore global settings
    draft             = false ,
    linktoc           = all ,
    colorlinks        = true ,
    linkcolor         = ref ,
    citecolor         = cite ,
    urlcolor          = url ,
    filecolor         = file ,
    runcolor          = run ,
}
\bool_if:NTF \g_dez_color_no_bool
    { \hypersetup { colorlinks = false } }
    {
      \hypersetup
      {
          colorlinks        = true ,
          linkcolor         = ref ,
          citecolor         = cite ,
          urlcolor          = url ,
          filecolor         = file ,
          runcolor          = run ,
      }
    }


\hook_gput_code:nnn
    { begindocument/before }
    { dez/add-pdf-hyperxmp-data }
    { \AddPdfHyperxmpData } % from info.sty

\g_dez__end_tl  % internal
\hook_use:n { dez / after }    % external
