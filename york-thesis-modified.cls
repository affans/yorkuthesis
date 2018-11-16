%%
%% This is file `york-thesis.cls',
%% Original Credit to 2011 by Diane Gall <gall@spookyhill.net>
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{york-thesis-modified}
[2018/11/11 v1.0 York University (Toronto, Canada) thesis class]
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{makeidx}
\RequirePackage{fancyhdr}
%% for class options, see https://texblog.org/2013/02/13/latex-documentclass-options-illustrated/
%% how to create a class https://www.overleaf.com/learn/latex/Writing_your_own_class
\DeclareOption{draft}{
  \PassOptionsToClass{letterpaper,12pt,oneside,onecolumn,draft,openany}{report}}
\DeclareOption{final}{
  \PassOptionsToClass{letterpaper,12pt,oneside,onecolumn,final,openany}{report}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{draft}  %% set a defaul option of draft ie. \documentclass{york-thesis-modified} == \documentclass[draft]{...}. 
\ProcessOptions
\LoadClass{report}

%% some redefinitions of margins 
%% see https://tex.stackexchange.com/questions/99172/what-would-the-equivalent-setlength-commands-be-for-letter-and-a4-paper for detail
%% or https://en.wikibooks.org/wiki/LaTeX/Page_Layout
%% the default report class has textwidth and textheight to be really small. 
\setlength {\textwidth}{\paperwidth-2in} %% one inch margins on each side = 2 inches total removed
\setlength {\topmargin}{0.0in}
\setlength {\textheight}{\paperheight-2.5in}
\setlength {\oddsidemargin}{0.0in}
\setlength {\evensidemargin}{0.0in}

%% redefinitions of basic commands
\let\oldquote\quote \let\oldendquote\endquote
\let\oldquotation\quotation \let\oldendquotation\endquotation
\let\oldverse\verse \let\oldendverse\endverse
\let\oldbibliography\bibliography
\let\oldendbibliography\endbibliography
\let\oldprintindex\printindex

%% Title Page Variables
\newboolean{hasfigures}\setboolean{hasfigures}{false}
\newboolean{hastables}\setboolean{hastables}{false}
\newboolean{masters}\setboolean{masters}{false}

%% Page titles for front matter
\renewcommand\contentsname{Table of Contents}
\renewcommand\listfigurename{List of Figures}
\renewcommand\listtablename{List of Tables}
\renewcommand\bibname{Bibliography}

%% general functions "commands" I use in this class
%% function hugeskip required to make the FGS regulated titlepage
\newcommand{\spacingmod}[1]{\renewcommand{\baselinestretch}{#1}%
  \large\normalsize}
\def\hugeskip{\vskip 24pt plus 8pt minus 8pt} 
\def\@ifdefined#1#2{\@ifundefined{#1}{}{#2}}

%% footnote options... 
%% defines /removefromreset{1}{2} which dosn't reset the footnote counter as you go from chapter to chapter.
%% you can set it to "section" rather than chapter, so means it resets after each section. 
%% also defines a command /resetfootnote which resets the counter of footnotes back to 0.
\def\@removefromreset#1#2{\let\@tempb\@elt
  \expandafter\let\expandafter\@tempa\csname c@#1\endcsname
  \def\@elt##1{\expandafter\ifx\csname c@##1\endcsname\@tempa\else
    \noexpand\@elt{##1}\fi}%
  \expandafter\edef\csname cl@#2\endcsname{\csname cl@#2\endcsname}%
  \let\@elt\@tempb}
\@removefromreset{footnote}{chapter}
\def\resetfootnote{\setcounter{footnote}{0}} 



    
%% options for different departments/types of degrees/committee members and so on... 
\def\department#1{\gdef\@department{#1}}
\def\masterof#1{\gdef\@masterof{#1}}
\def\abstractfile#1{\gdef\@abstractfile{#1}}
\def\dedicationfile#1{\gdef\@dedicationfile{#1}}
\def\acknowledgementsfile#1{\gdef\@acknowledgementsfile{#1}}
\def\prefacefile#1{\gdef\@prefacefile{#1}}
\def\abbreviationsfile#1{\gdef\@abbreviationsfile{#1}}
\def\committeememberslist#1{\gdef\@committeememberslist{#1}}
\def\degreename#1{\gdef\@degreename{#1}}
\gdef\@author{YOUR FULL NAME} 
\gdef\@title{{\bf THE TITLE OF YOUR WORK}} 
\gdef\@date{\number\year} 
\gdef\@department{PHILOSOPHY}
\gdef\@masterof{Arts} 
\gdef\@committeememberslist{%
  \begin{enumerate}%
  \item Joanne Examiner%
  \item Fred P. Questioner%
  \end{enumerate}}
\ifthenelse{\boolean{masters}}{\gdef\@degreename{MASTER}}%
  {\gdef\@degreename{DOCTOR}}

\renewcommand\contentsname{Table of Contents}
\renewcommand\listfigurename{List of Figures} 
\renewcommand\listtablename{List of Tables}
\renewcommand\bibname{Bibliography}
\newcommand{\contentsheader}[2] { \addtocontents{#1} {
  \centerline{\underline{#2}\protect\hfill%
  \underline{Page}}}}

\renewcommand\tableofcontents { \chapter*{\contentsname}
\addcontentsline {toc}{chapter}{Table of Contents}
\@starttoc{toc}}
  
\renewcommand\listoffigures { \chapter*{\listfigurename}
\addcontentsline {toc}{chapter}{List of Figures}
\@starttoc{lof}}
  
\renewcommand\listoftables { \chapter*{\listtablename}
\addcontentsline{toc}{chapter}{List of Tables}
\@starttoc{lot}}

%% command for making the title page
\def\makefrontmatter{%
  \pagestyle {empty}
  \pagenumbering {roman}
  \setcounter {page} {1}
  \maketitlepage
  %%\pagestyle {empty}  \makecopyrightpage
  %%\pagestyle {empty}  \makeauthenticitypage  
  \@ifdefined {@abstractfile}{\makeabstract}
  \pagestyle {fancy}
  \@ifdefined {@dedicationfile}{\makededication}
  \@ifdefined {@acknowledgementsfile}{\makeacknowledgements}
  \tableofcontents
  \clearpage
  \ifthenelse{\boolean{hastables}}{\listoftables}{}
  \clearpage
  \ifthenelse{\boolean{hasfigures}}{\listoffigures}{}
  \@ifdefined{@prefacefile}{\makepreface}
  \@ifdefined{@abbreviationsfile}{\makeabbreviations}
  \newpage
  \pagenumbering {arabic}
  \setcounter {page}{1}}

%% function for making the title page
\def\maketitlepage{
  \vspace*{.85in}
  \begin{center}
    \spacingmod{1}
    \textbf{\MakeUppercase{\@title}}
    \hugeskip
    \hugeskip
    \hugeskip
    {\bigskip \MakeUppercase{\@author}}
  \end{center}
  \hugeskip \hugeskip \hugeskip 
  {\spacingmod{1}
    \begin{center}
      \ifmasters A THESIS \else A DISSERTATION \fi
      SUBMITTED TO THE FACULTY OF GRADUATE STUDIES \\
      IN PARTIAL FULFILMENT OF THE REQUIREMENTS \\
      FOR THE DEGREE OF \\      
      \ifmasters \MakeUppercase{\@degreename} OF
      \MakeUppercase{\@masterof}
      \else
      \MakeUppercase{\@degreename} OF PHILOSOPHY \fi \\
      \hugeskip \hugeskip   
      \hugeskip    
      GRADUATE PROGRAM IN \MakeUppercase{\@department} \\
      YORK UNIVERSITY \\
      TORONTO, ONTARIO \\
      \hugeskip \hugeskip 
      \MakeUppercase{\@date}\\
      \hugeskip \hugeskip \hugeskip
       $\copyright$\ AFFAN SHOUKAT, 2015
      %\MakeUppercase{\@date}
    \end{center}}
  \newpage }

%% functions to bring in the file contents.
\def\makeabstract{%
  \chapter*{Abstract}
  \addcontentsline {toc}{chapter}{Abstract}
  \noindent
  \@input{\@abstractfile}}
\def\makededication{%
  \newpage
  \@input{\@dedicationfile}}
\def\makepreface{%
  \chapter*{Preface}
  \addcontentsline {toc}{chapter}{Preface}
  \noindent
  \@input{\@prefacefile}}
\def\makeabbreviations{%
  \chapter*{Abbreviations}
  \addcontentsline{toc}{chapter}{Abbreviations}
  \noindent
  \@input{\@abbreviationsfile}}
\def\makeacknowledgements{%
  \chapter*{Acknowledgements}
  \addcontentsline{toc}{chapter}{Acknowledgements}
  \noindent
  \@input{\@acknowledgementsfile}}


%% function for making the copyright page, not really needed but FGS may bring it back
\def\makecopyrightpage{%
  \begin{center}
    \setlength{\fboxrule}{.004in} \setlength{\fboxsep}{2cm}
    \mbox{}
    \par\vspace*{\stretch{1}}
    \fbox{\parbox{4in}{%
      \spacingmod{1}
      \begin{center}
        \textbf{\MakeUppercase{\@title}}
      \end{center} by
      \textbf{\@author}

      \bigskip
      a \ifmasters thesis \else dissertation \fi submitted to the
      Faculty of Graduate Studies of York University in partial
      fulfilment of the requirements for the degree of
      \begin{center}
        \ifmasters \textbf{\MakeUppercase{\@degreename} OF
          \MakeUppercase{\@masterof}}
        \else
          \textbf{\MakeUppercase{\@degreename} OF PHILOSOPHY} \fi \\
                   $\copyright$\ \number\year \\
      \end{center}

      Permission has been granted to: a) YORK UNIVERSITY LIBRARIES
      to lend or sell copies of this dissertation in paper,
      microform or electronic formats, and b) LIBRARY AND ARCHIVES
      CANADA to reproduce, lend, distribute, or sell copies of this
      \ifmasters thesis \else dissertation \fi anywhere in the world
      in microform, paper or electronic formats \textit{and} to
      authorise or procure the reproduction, loan, distribution or
      sale of copies of this \ifmasters thesis \else dissertation
      \fi anywhere in the world in microform, paper or electronic
      formats.

      \bigskip The author reserves other publication rights, and
      neither the \ifmasters thesis \else dissertation \fi nor
      extensive extracts for it may be printed or otherwise
      reproduced without the author's written permission.}}
  \vspace*{\stretch{1}}
\end{center}
\newpage}

%% function for making the authenticity page, not really needed but FGS may bring it back
\def\makeauthenticitypage{%
  \par\vfill
  {\spacingmod{1}
    \begin{center}
      \textbf{\MakeUppercase{\@title}} \hugeskip\hugeskip by
      \textbf{\@author}
    \end{center}
    \hugeskip\noindent By virtue of submitting this document
    electronically, the author certifies that this is a true
    electronic equivalent of the copy of the \ifmasters thesis \else
    dissertation \fi approved by York University for the award of
    the degree. No alteration of the content has occurred and if
    there are any minor variations in formatting, they are as a
    result of the coversion to Adobe Acrobat format (or similar
    software application).  \hugeskip
    \begin{flushright}
      \begin{minipage}[t]{4in}
        Examination Committee Members: \@committeememberslist
      \end{minipage}
    \end{flushright}}}


%% End of file `york-thesis.cls'.
