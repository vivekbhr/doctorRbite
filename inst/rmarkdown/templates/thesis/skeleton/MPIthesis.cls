%
% This file is copyright (C) 2003 Sam Noble. It may be modified so long
% as my name is not removed and the modifier adds his name to the file.
% Redistribution permitted.
%
% 27 Jan 2004	Sam Noble	Removed tocbibind dependency.
% 04 Dec 2001 	Sam Noble	Class file
% 03 Sep 1995	David Perkinson	Title Page
% Acknowledgements Page, David Perkinson & Sam Noble
% May 2005 Patrick Carlisle Table of contents chapter definition
% 2004-2005 Ben Salzberg (BTS) a variety of tweaks here and in the template
% 2015 Chester Ismay (CII) modified to create R Markdown template
% 2018 Vivek Bhardwaj (VB) modified to fit MPI-IE cumulative thesis style
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MPIthesis}[2004/01/27 The MPI-IE cumulative thesis class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass{book}
\RequirePackage{fancyhdr}
% Added by CII to produce nice looking code in BeginVerbatimEnvironment
\RequirePackage{fancyvrb}

% Added by CII
\usepackage{ifxetex,ifluatex}
\usepackage{fixltx2e} % provides \textsubscript
\ifnum 0\ifxetex 1\fi\ifluatex 1\fi=0 % if pdftex
  \usepackage[T1]{fontenc}
  \usepackage[utf8]{inputenc}
\else % if luatex or xelatex
  \ifxetex
    \usepackage{mathspec}
    \usepackage{xltxtra,xunicode}
  \else
    \usepackage{fontspec}
  \fi
  \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
  \newcommand{\euro}{€}
\fi
% use upquote if available, for straight quotes in verbatim environments
\IfFileExists{upquote.sty}{\usepackage{upquote}}{}
% use microtype if available
\IfFileExists{microtype.sty}{%
\usepackage{microtype}
\UseMicrotypeSet[protrusion]{basicmath} % disable protrusion for tt fonts
}{}
\usepackage{xcolor}
%\newcommand{\VerbBar}{|}
%\newcommand{\VERB}{\Verb[commandchars=\\\{\}]}
\DefineVerbatimEnvironment{verbatim}{Verbatim}{xleftmargin=-1em}
\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\{\}}
% Add ',fontsize=\small' for more characters per line
\usepackage{framed}
\definecolor{shadecolor}{RGB}{248,248,248}
\setlength{\emergencystretch}{3em}  % prevent overfull lines
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
% End of CII add

% This gives us rules below the headers
\AtBeginDocument{%
  \fancyhf{}
  \fancyhead[LE,RO]{\thepage}
%  \fancyhead[RE]{\slshape \leftmark}
%  \fancyhead[LO]{\slshape \rightmark}
%	The above makes your headers in all caps. If you would like different headers, choose one of the following options (be sure to remove the % symbol from both the right and left headers):
	 \fancyhead[RE]{\slshape \nouppercase \leftmark} % This makes the headers on the RIGHT side pages be italic and use lowercase With Capitals When Specified.
	\fancyhead[LO]{\slshape \nouppercase \rightmark} % This does the same thing to the LEFT side pages
%	or
%	\fancyhead[RE]{\scshape \leftmark} % The RIGHT headers will be in small caps.
%	\fancyhead[LO]{\scshape \rightmark} %  And so will the LEFT headers
  \pagestyle{fancy}

% Psych majors: You do not need the following six lines, as it conflicts with apacite, so comment them out.
  \let\oldthebibliography=\thebibliography
  \let\endoldthebibliography=\endthebibliography
  \renewenvironment{thebibliography}[1]{
    \oldthebibliography{#1}
    \addcontentsline{toc}{chapter}{\bibname}
  }{\endoldthebibliography}
 %%%%%% end of things for psych majors to comment out

  \let\oldtheindex=\theindex
  \let\endoldtheindex=\endtheindex
  \renewenvironment{theindex}{
    \oldtheindex
    \addcontentsline{toc}{chapter}{\indexname}
  }{\endoldtheindex}
}

% Stolen from book.cls and modified
\let\RToldchapter\chapter
\renewcommand{\chapter}{\if@openright\RTcleardoublepage
		    \else\clearpage\fi
		    \thispagestyle{empty}%
		    \global\@topnum\z@
		    \@afterindentfalse
		    \secdef\@chapter\@schapter}

% Stolen from book.cls PBC 5/12/05

\newcommand{\RTcleardoublepage}{
	\clearpage\if@twoside \ifodd\c@page\else
	\thispagestyle{empty}\hbox{}\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\let\RToldcleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{\RTcleardoublepage}

% adjust margins for binding  (changed 2007-04-24 tgp)
\setlength{\oddsidemargin}{.5in}
\setlength{\evensidemargin}{0in}
\setlength{\textwidth}{6.0in}
\setlength{\textheight}{9.0in}
\setlength\topmargin{0in}
\addtolength\topmargin{-\headheight}
\addtolength\topmargin{-\headsep}

%%% BUNCH OF DEFINITIONS USED FROM RMD
\def\degree#1{\gdef \@degree{#1}}
\def\@degree{\@latex@warning@no@line{No \noexpand\degree given}}
\def\institution#1{\gdef \@institution{#1}}
\def\@institution{\@latex@warning@no@line{No \noexpand\institution given}}
\def\department#1{\gdef \@department{#1}}
\def\@department{\@latex@warning@no@line{No \noexpand\department given}}

\def\advisor#1{\gdef \@advisor{#1}}
\def\@advisor{\@latex@warning@no@line{No \noexpand\advisor given}}
\def\altadvisor#1{\gdef \@altadvisor{#1} \@altadvisortrue}
\global\let\@altadvisor\@empty
\newif\if@altadvisor
\@altadvisorfalse

% VB : removing "Chapter" from Chapter header
%% -- COMMENT OUT THESE LINES AND UNCOMMENT THE FOLLOWING LINES TO KEEP CHAPTER NAMES IN PAGES
\makeatletter
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        %\huge\bfseries \@chapapp\space \thechapter
        \Huge\bfseries \thechapter.\space%
        %\par\nobreak
        %\vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }}

%\renewcommand\l@chapter[2]{%
%  \ifnum \c@tocdepth >\m@ne
%    \addpenalty{-\@highpenalty}%
%    \vskip 1.0em \@plus\p@
%    \setlength\@tempdima{1.5em}%
%    \begingroup
%      \parindent \z@ \rightskip \@pnumwidth
%      \parfillskip -\@pnumwidth
%      \leavevmode \bfseries
%      \advance\leftskip\@tempdima
%      \hskip -\leftskip
%      #1\nobreak\normalfont
%      \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
%      \nobreak\hb@xt@\@pnumwidth{\bfseries \hss #2}\par
%      \penalty\@highpenalty
%    \endgroup
%  \fi}

%% END OF MOD BY VB

%%% Added by CII
\newenvironment{acknowledgements}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{Acknowledgements}
  \fontsize{12}{14}\selectfont
}{\clearpage \if@restonecol\twocolumn\fi}%
% End of CII add

\newenvironment{abstract}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{Abstract}
  \fontsize{12}{14}\selectfont
}{\clearpage \if@restonecol\twocolumn\fi}%

\ifx\@pdfoutput\@undefined
  \newcommand{\RTpercent}{\@percentchar\space}
  \AtBeginDvi{\special{!\RTpercent MPI-IE cumulative thesis class}}
  \AtBeginDvi{\special{rawpostscript \RTpercent MPI-IE cumulative thesis class}}
\else
  \AtEndDocument{\pdfinfo{/Creator	(Vivek Bhardwaj)}}
\fi

% VB -- I painfully created this fancy title page

\renewcommand{\maketitle}{%
  {
  \begin{titlepage}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}} % Defines a new command for the horizontal lines, change thickness here
\definecolor{carmine}{rgb}{0.59, 0.0, 0.09} %% new color for highlights
\center % Center everything on the page

%%heading
\vspace*{.06\textheight}
{\color{carmine}
{\LARGE \@institution}\\[1.5cm] % Name of your university/college
}

{\color{black!80} %% set default color for the rest of the title page
%%title
\HRule \\[0.4cm]
{ \huge \bfseries \@title\par}\vspace{0.4cm} % Title of your document
\HRule \\[1.5cm]
\textsc{\LARGE Inaugural-Dissertation}\\[1cm]
%%author section
\begin{minipage}{0.4\textwidth}
\begin{flushleft} \large
\emph{Author:}\\
\textcolor{carmine}{\@author} % Your name
\end{flushleft}
\end{minipage}
~
\begin{minipage}{0.4\textwidth}
\begin{flushright} \large
\emph{Supervisor:} \\
\textcolor{carmine}{\@advisor} % Supervisor's Name
\end{flushright}
\end{minipage}\\[2cm]

 %%logo
\includegraphics[width=0.3\textwidth]{figures/uni_logo.png}\\[0.3cm] % Include a department/university logo - this will require the graphicx package
\large \textit{to obtain the Doctoral Degree at the}\\[0.3cm] % University requirement text
{\color{carmine}
\textsc{\large Faculty of Biology}\\[0.5cm] % Major heading such as course name
\textsc{\Large Albert-Ludwigs-Universität Freiburg im Breisgau}\\[0.5cm] % Minor heading such as course title
}
%% end of black 50
}
%%date
{\large \@date}\\[2cm] % Date, change the \today to a set date if you want to be precise
%----------------------------------------------------------------------------------------

\vfill % Fill the rest of the page with whitespace

\end{titlepage}
  }
}

%%% END OF MOD BY VB

% From JSS
% Added by CII
\renewcommand{\title}[1]{\def\@title{#1}}
\newcommand{\Plainauthor}[1]{\def\@Plainauthor{#1}}
\newcommand{\Abstract}[1]{\def\@Abstract{#1}}
\newcommand{\Acknowledgements}[1]{\def\@Acknowledgements{#1}}
% End of CII add
