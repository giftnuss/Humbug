
\ProvidesClass{autofibel}[2016/05/05 version 0.001 autofibel]
\NeedsTeXFormat{LaTeX2e}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{lulubook}}

\ExecuteOptions{11pt,Carre}
\ProcessOptions\relax


\RequirePackage[svgnames]{xcolor}
\RequirePackage{graphicx}


% Lineaturen:
\RequirePackage{schulschriften_lin}
% LaTeX-Anpassung, Umschaltung, Unterstreichen:
\RequirePackage{schulschriften_ltx}


\LoadClass{lulubook}

\newcommand*{\rotrt}[1]{\rotatebox{90}{#1}}
\newcommand*{\rotlft}[1]{\rotatebox{-90}{#1}}

\newcommand{\Title}[1]{
  \renewcommand{\title}{#1}
}

\endinput
