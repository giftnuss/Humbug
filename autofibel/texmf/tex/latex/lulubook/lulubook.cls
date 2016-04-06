

\ProvidesClass{lulubook}[2016/04/06 version 0.001 lulubook]
\NeedsTeXFormat{LaTeX2e}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

\newcommand\BookType{Roman}
\newlength\PaperWidth
\newlength\PaperHeight
\newlength\BindingOffset

% http://connect.lulu.com/t5/Publizierungsvorgang-Knowledge/Wie-kann-ich-bis-ganz-an-den-Seitenrand-drucken-Anschnitt/ta-p/33303
% http://connect.lulu.com/t5/Mise-en-page-du-corpus/Comment-faire-pour-que-mon-contenu-s-%C3%A9tale-jusqu-aux-bords-de-la/ta-p/33461
% http://connect.lulu.com/t5/ISBN-Vertrieb-Knowledge-Base/Welche-B%C3%BCcher-eignen-sich-f%C3%BCr-den-Vertrieb/ta-p/32016

% Livre de Poche
% 10,79 x 17,46 cm  --> 11,43 x 18,09 cm
% ou 4,25 x 6,87"   --> ou 4,5 x 7,12"
\DeclareOption{LivreDePoche}{%

}

% Digest
% 13,97 x 21,59 cm  --> 14,61 x 22,225 cm
% ou 5,5 x, 8,5"    --> ou 5,75 x 8,75"	
\DeclareOption{Digest}{%

}

% A5
% 14,81 x 20,99 cm  --> 15,44 x 21,62 cm
% ou 5,83 x 8,26"   --> ou 6,08 x 8,51"
\DeclareOption{A5}{%

}

% Roman (US-Trade)
% 15,24 x 22,86 cm  --> 15,87 x 23,49 cm
% ou 6 x 9"         --> ou 6,25 x 9,25"
\DeclareOption{Roman}{%
  \renewcommand\BookType{Roman}%
  \setlength\PaperWidth{15.87cm}%
  \setlength\PaperHeight{23.49cm}%
  \setlength\BindingOffset{0.8cm}
}

% Carré
% 21,59 x 21,59 cm  --> 22,22 x 22,22 cm
% ou 8,5 x 8,5"     --> ou 8,75 x 8,75"
\DeclareOption{Carre}{%
  \renewcommand\BookType{Carre}
  \setlength\PaperWidth{22.22cm}%
  \setlength\PaperHeight{22.22cm}%
  \setlength\BindingOffset{1cm}%
}

% Royal
% 15,59 x 23,38 cm   --> 16,22 x 24,02 cm
% ou 6,13 x 9,21"    --> ou 6,38 x 9,46"

% Comic / BD U.S.
% 16,83 x 26,04 cm   --> 17,47 x 26,67 cm
% ou 6,625 x 10,25"  --> ou 6,875 x 10,50"


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% Load possible options from file named NAME.min
%\DeclareOption*{\InputIfFileExists{\CurrentOption.min}{}{%
%\PassOptionsToClass{\CurrentOption}{article}}}

% here BookType should stil have the default value
\ExecuteOptions{11pt,\BookType}
\ProcessOptions\relax

\RequirePackage[a4paper,includehead,includefoot]{geometry}
% resets pagesize - so options needs to reset
\LoadClass{book}

\setlength{\paperwidth}{\the\PaperWidth}
\setlength{\paperheight}{\the\PaperHeight}

% some debug noise
\message{book type: \BookType}
\message{paperheight: \the\paperheight}
\message{paperwidth: \the\paperwidth}

\geometry{%
paperwidth=\the\paperwidth,
paperheight=\the\paperheight,
left=0.3175cm,
right=0.3175cm,
top=0.3175cm,
bottom=0.3175cm,
bindingoffset=\the\BindingOffset
}

\endinput



	
% Crown Quarto
	

18,90 x 24,58 cm
ou 7,44 x 9,68"
	

19,54 x 25,22 cm
ou 7,69 x 9,93"

A4
	

20,98 x 29,69 cm
ou 8,26 x 11,69"
	

21,62 x 30,33 cm
ou 8,51 x 11,94"

Lettre U.S.
	

21,59 x 27,94 cm
ou 8,5 x 11"
	

22,22 x 28,57 cm
ou 8,75 x 11,25"

Lettre Casewrap U.S.
	

20,95 x 27,31 cm
ou 8,25 x 10,75"
	

21,59 x 27,94 cm
ou 8,50 x 11"

Paysage
	

22,86 x 17,78 cm
ou 9 x 7"
	

23,49 x 18,41 cm
ou 9,25x 7,25"

Grand Paysage
	

32,39 x 27,31 cm
ou 12,75 x 10,75"
	

33,02 x 27,94 cm
ou 13 x 11"

Petit Carré
	

19,05 x 19,05 cm
ou 7,5 x 7,5"
	

19,69 x, 19,69 cm
ou 7,75 x 7,75"

Carré
	

21,59 x 21,59 cm
ou 8,5 x 8,5"
	

22,22 x 22,22 cm
ou 8,75 x 8,75"

Grand Carré
	

30,48 x 30,48 cm
ou 12 x 12"
	

31,12 x 31,12 cm
ou 12,25 x 12,25"
 

 

 
