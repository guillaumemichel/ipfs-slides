% Protocol Labs brand sheet: https://www.figma.com/proto/THTVAOvZFNI4BoopQQtGn9/PL-brand-sheet?node-id=9%3A307

% TODOs
% - set correct font (Aileron) downloaded
% - gradient background
% - make title parameters optional
% - different color themes

\LoadClass[aspectratio=169]{beamer}

\RequirePackage{svg}
\RequirePackage{tikz}

% Adjust image position
\usepackage[export]{adjustbox}
\usepackage{wrapfig}
\usepackage{ifthen}

\usepackage{pgfplots}
\usepgfplotslibrary{units}

% help creating custom symbols
\usepackage{scalerel}


%\DeclareRobustCommand{\yellowcube}{%
%	\scalerel*{\includegraphics{pl-resources/yellow-cube.png}}{X}
%}
\def\yellowcube{\scalerel*{\includegraphics{../pl-resources/yellow-cube.png}}{X}}
\def\greencube{\scalerel*{\includegraphics{../pl-resources/green-cube.png}}{X}}
\def\dotcube{\scalerel*{\includegraphics{../pl-resources/dot-cube.png}}{X}}


\newcommand\itemy{\item[\yellowcube]}
\newcommand\itemg{\item[\greencube]}

%%%%%%%%%% THEMES DEFINITION %%%%%%%%%%

% Set the slides theme
\def\themeipfsthing2022{ipfs-thing-2022}
\def\themeipfscamp2022{ipfs-camp-2022}
\def\themeneutral2022{neutral-2022}
\def\themeipfsthingtwentythree{ipfs-thing-2023}

\newcommand\setdefaultcolors{
		\definecolor{background-color}{HTML}{000000}
		\definecolor{text-color}{HTML}{ffffff}
		\definecolor{accent}{HTML}{00ff00}
}

\newcommand\definethemecolors{	
	% switch on the theme and define the colors
    \ifthenelse{\equal{\@theme}{\themeipfsthing2022}}{
		% ipfs-thing-2022 theme
		\definecolor{background-color}{HTML}{002256}
		\definecolor{accent}{HTML}{a20000}
		\definecolor{text-color}{HTML}{f5f6f7}
    }{ \ifthenelse{\equal{\@theme}{\themeipfscamp2022}\OR\equal{\@theme}{\themeneutral2022}}{
    		% ipfs-camp-2022 themedefault:\quad
    		\definecolor{background-color}{HTML}{022232}
		\definecolor{text-color}{HTML}{f5f6f7}
		\definecolor{accent}{HTML}{f28600}
	}{ \ifthenelse{\equal{\@theme}{\themeipfsthingtwentythree}} {
		\definecolor{background-color}{HTML}{06263d}
		\definecolor{text-color}{HTML}{f5f6f7}
		\definecolor{accent}{HTML}{f28600}
	}{
		% default theme
		\setdefaultcolors
	}}}
}

\newcommand\setslidetheme{
	% Set font color
	\setbeamercolor{normal text}{fg=text-color}

	% Background
	\setbeamercolor{background canvas}{bg=background-color}

	% Customize frame title
	\setbeamercolor{frametitle}{fg=text-color}
}


% Possible themes are: ipfs-thing-2022, ipfs-camp-2022
\newcommand{\settheme}[1]{
	\def\@theme{#1}
	
	\definethemecolors
	\setslidetheme
}

% initialize the theme
\newcommand\themeinit{
	% if theme is undefined set it to "default"
	\ifdefined \@theme \else \def\@theme{default} \fi

	\definethemecolors
	\setslidetheme
}

%%%%%%%%%% --- %%%%%%%%%%

\themeinit

% Disable navigation symbols 
\setbeamertemplate{navigation symbols}{}

% Set the font
% Official fonts are: Aileron, Source Serif Pro, Source Code Pro
% Aileron: https://tipotype.com/underground/aileron/
% Using open font "Source Sans Pro"
\usepackage[default]{sourcesanspro}
\usepackage[T1]{fontenc}

%%%%%%%%%% TITLE SLIDE PARAMETERS %%%%%%%%%%
    
\newcommand{\avatar}[1]{\def\@avatar{#1}}
\newcommand{\handle}[1]{\def\@handle{#1}}
\newcommand{\group}[1]{\def\@group{#1}}
\newcommand{\event}[1]{\def\@event{#1}}


% Customize title page style
\setbeamercolor*{title}{fg=text-color}
\setbeamerfont*{title}{size={\fontsize{30}{36}}, series=\fontseries{b}, shape=\fontshape{n}}
\setbeamercolor*{subtitle}{fg=text-color}
\setbeamerfont*{subtitle}{size={\fontsize{16}{14}}, series=\fontseries{b}, shape=\fontshape{it}}
\setbeamercolor*{author}{fg=text-color}
\setbeamerfont*{author}{size={\fontsize{11}{14}}, series=\fontseries{b}, shape=\fontshape{n}}

\newcommand\simpletitlepage{
\defbeamertemplate*{title page}{customized}[1][]
	{
	    \usebeamerfont{title}\usebeamercolor[fg]{title}
	    \inserttitle\par
	    \bigskip
	    \usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}
	    \insertsubtitle\par
	    
	    \begin{wrapfigure}{r}{0.4\textwidth}
	  		\begin{center}
	    			\includesvg[width=.3\paperwidth,keepaspectratio]{../pl-resources/PL-logo-2lines.svg}
	  		\end{center}
		\end{wrapfigure}		
	
	    \vspace{4ex}
	    \usebeamerfont{author}\usebeamercolor[fg]{author}
	    \insertauthor\newline\textit{\@handle}\par
	    \vspace{2.5ex}
	    \@group ,\newline\insertinstitute\par
	    \vspace{2.5ex}
		\@event\newline\insertdate\par
	}
}

\newcommand\titlepagewithavatar{
\defbeamertemplate*{title page}{customized}[1][]
{
	% define columns width
	\def\widthfirstcol{0.66\linewidth}
	\def\widthsecondcol{\linewidth - \widthfirstcol - .01\linewidth}
	
	\begin{minipage}{\linewidth}
		% this is the top rectangle containing title and avatar
		\begin{minipage}{\widthfirstcol}
			% title
			\raggedright
	    		\usebeamerfont{title}\usebeamercolor[fg]{title}
	    		\inserttitle\par
		\end{minipage}%
		\begin{minipage}{\widthsecondcol}
			% avatar
			\raggedleft
			\tikz\node [circle, minimum width = .6\linewidth,
    				path picture = {
      			\node [] at (path picture bounding box.center) {
      				\ifdefined\@avatar{
        					\includegraphics[width=.6\linewidth]{\@avatar}
        				} \fi
        			};
    			}] {};
    			
    			% shift avatar left
    			%\hspace{1em}
    			
    			% minimum vertical space before the next box, overwritten if title has 3 lines
    			\vspace{1em}
		\end{minipage}
	\end{minipage}
	\begin{minipage}{\linewidth}
		% lower box
		\def\textheight{4cm}
		\begin{minipage}[t][\textheight]{\widthfirstcol}
			% subtitle + logos
			\raggedright
	    		\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}
	    		\insertsubtitle\par
			\vspace{\fill}
			\ifthenelse{\equal{\@theme}{\themeipfscamp2022}}
			{
			    \includegraphics[height=2em,keepaspectratio]{../pl-resources/ipfs-camp-logo.png}
			    \hspace{1em}\vline\hspace{1em}
			}{\ifthenelse{\equal{\@theme}{\themeipfsthingtwentythree}}{
				\includegraphics[height=2.5em,keepaspectratio]{../pl-resources/thing-logo.png}
			    \hspace{1em}\vline\hspace{1em}
			}{}
			}
	    		\includesvg[height=2em,keepaspectratio]{../pl-resources/PL-logo-2lines.svg}
		\end{minipage}%
		\begin{minipage}[t][\textheight]{\widthsecondcol}
			% author + affiliation + date
			\raggedleft
	    		\usebeamerfont{author}\usebeamercolor[fg]{author}
	    		\insertauthor\par\textit{\@handle}\par
	    		\vspace{\fill}
			\@group ,\par\insertinstitute\par
			\vspace{\fill}
			\@event\par\insertdate\par
			

		\end{minipage}
	\end{minipage}
}
}


\titlepagewithavatar

% Customize frame title
\setbeamercolor{frametitle}{fg=text-color}
\newlength{\titlevspace}
\setlength{\titlevspace}{\dimexpr.10\paperheight}
\setbeamertemplate{frametitle}{\vspace*{\titlevspace}
    \fontsize{17}{20}\fontseries{b}\selectfont\insertframetitle}


% Customize enumerate style
\setbeamerfont*{enumerate item}{series=\fontseries{b}}
\setbeamerfont*{enumerate subitem}{series=\fontseries{b}}
\setbeamerfont*{enumerate subsubitem}{series=\fontseries{b}}
\setbeamercolor*{enumerate item}{fg=text-color}
\setbeamercolor*{enumerate subitem}{fg=text-color}
\setbeamercolor*{enumerate subsubitem}{fg=text-color}

% Customize itemize style
\setbeamertemplate{itemize item}[arrow]
\setbeamercolor*{itemize item}{fg=text-color}
\setbeamercolor*{itemize subitem}{fg=text-color}
\setbeamercolor*{itemize subsubitem}{fg=text-color}

% fix for not being able to change itemize item to \yellowcube
\newcommand\itemc{
    \ifthenelse{\equal{\@theme}{\themeipfscamp2022}\OR\equal{\@theme}{\themeneutral2022}\OR\equal{\@theme}{\themeipfsthingtwentythree}}{
		\item[\yellowcube]
	}{
		\item[\arrow]
	}
}

