% Protocol Labs brand sheet: https://www.figma.com/proto/THTVAOvZFNI4BoopQQtGn9/PL-brand-sheet?node-id=9%3A307

% TODOs
% - set correct font (Aileron) downloaded
% - gradient background
% - make title parameters optional
% - different color themes

\LoadClass[aspectratio=169]{beamer}

\RequirePackage{svg}

% Adjust image position
\usepackage[export]{adjustbox}
\usepackage{wrapfig}

% Define colors
\definecolor{deepblue}{HTML}{002256}
\definecolor{graylight}{HTML}{f5f6f7}

% Disable navigation symbols 
\setbeamertemplate{navigation symbols}{}

% Set the font
% Official fonts are: Aileron, Source Serif Pro, Source Code Pro
% Aileron: https://tipotype.com/underground/aileron/
% Using open font "Source Sans Pro"
\usepackage[default]{sourcesanspro}
\usepackage[T1]{fontenc}

% Set font color
\setbeamercolor{normal text}{fg=graylight}

% Background
\setbeamercolor{background canvas}{bg=deepblue}

% Customize frame title
\setbeamercolor{frametitle}{fg=graylight}
    
    
\newcommand{\handle}[1]{\def\@handle{#1}}
\newcommand{\group}[1]{\def\@group{#1}}
\newcommand{\event}[1]{\def\@event{#1}}


% Customize title page style
\setbeamercolor*{title}{fg=graylight}
\setbeamerfont*{title}{size={\fontsize{30}{36}}, series=\fontseries{b}, shape=\fontshape{it}}
\setbeamercolor*{subtitle}{fg=graylight}
\setbeamerfont*{subtitle}{size={\fontsize{16}{14}}, series=\fontseries{b}, shape=\fontshape{it}}
\setbeamercolor*{author}{fg=graylight}
\setbeamerfont*{author}{size={\fontsize{11}{14}}, series=\fontseries{b}, shape=\fontshape{n}}
\defbeamertemplate*{title page}{customized}[1][]
{
    \usebeamerfont{title}\usebeamercolor[fg]{title}
    \inserttitle\par
    \bigskip
    \usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}
    \insertsubtitle\par
    
    \begin{wrapfigure}{r}{0.4\textwidth}
  		\begin{center}
    			\includesvg[width=.3\paperwidth,keepaspectratio]{logos/PL-logo-2lines.svg}
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

% Customize frame title
\setbeamercolor{frametitle}{fg=graylight}
\newlength{\titlevspace}
\setlength{\titlevspace}{\dimexpr.10\paperheight}
\setbeamertemplate{frametitle}{\vspace*{\titlevspace}
    \fontsize{17}{20}\fontseries{b}\selectfont\insertframetitle}


% Customize enumerate style
\setbeamerfont*{enumerate item}{series=\fontseries{b}}
\setbeamerfont*{enumerate subitem}{series=\fontseries{b}}
\setbeamerfont*{enumerate subsubitem}{series=\fontseries{b}}
\setbeamercolor*{enumerate item}{fg=graylight}
\setbeamercolor*{enumerate subitem}{fg=graylight}
\setbeamercolor*{enumerate subsubitem}{fg=graylight}

% Customize itemize style
\setbeamertemplate{itemize item}[arrow]
\setbeamercolor*{itemize item}{fg=graylight}
\setbeamercolor*{itemize subitem}{fg=graylight}
\setbeamercolor*{itemize subsubitem}{fg=graylight}




