%%%%%%%%%%%%%%%%%
%% NextCV - v1.0.1 - Naveen Dharmathunga (dasheenaveen@outlook.com)
%% This is an upgraded version of altacv.cls (v1.7.1) written by LianTze Lim.
%% ================================================================================
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%% ================================================================================
%% Additionally, this derived work is licensed under the MIT License.
%% See LICENSE file in the root directory for more information.
%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nextcv}[2024/07/29 NextCV v1.0.1, The template class for a next generation resume/curriculum vitae.]

%% Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
%% load hyperref for clickable hyperlinks
\newif\if@withhyper
\DeclareOption{withhyper}{\@withhypertrue}
\ProcessOptions\relax

\LoadClass{extarticle}
%% file more 'friendly' with copy-paste etc
\RequirePackage{etoolbox}
\RequirePackage{accsupp}
\RequirePackage[margin=2cm]{geometry}
%% added fontawesome6 for more icons
\RequirePackage{fontawesome/6}
\RequirePackage{ifxetex,ifluatex}
% \RequirePackage{scrlfile}
\RequirePackage{xparse}
\RequirePackage{hyperref}
%% Load fontspec (only works with xelatex or lualatex)
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}


\if@raggedtwoe
  \RequirePackage[newcommands]{ragged2e}
\fi

\if@withhyper
  \AtBeginDocument{%
    \hypersetup{hidelinks}
    \urlstyle{same}
  }
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{emphasis}{black}
\colorlet{heading}{black}
\colorlet{headingrule}{black}
\colorlet{subheading}{emphasis}
\colorlet{body}{black!80!white}
\colorlet{name}{heading}
\colorlet{tagline}{accent}
\newcommand{\cvItemMarker}{{\small\textbullet}}
\newcommand{\cvRatingMarker}{\large\textbf{\faIcon{circle}}}
\let\itemmarker\cvItemMarker      % for backward compatibility
\let\ratingmarker\cvRatingMarker  % for backward compatibility
\newcommand{\cvDateMarker}{\faIcon{calendar}}
\newcommand{\cvLocationMarker}{\textbf{\faIcon{location-dot}}}
\newcommand{\cvCertificateMarker}{\textbf{\faIcon{certificate}}}
\newcommand{\cvProjectLinkMarker}{\faIcon{github}}
\newcommand{\locationname}{Location}
\newcommand{\datename}{Date}
\newcommand{\projectlink}{Project Link}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[inline]{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}
\setlist[itemize]{label=\cvItemMarker}
% \RequirePackage{graphicx}
\RequirePackage{trimclip}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
    {\end{adjustwidth}}

%% \detokenize will break UTF-8 in pdflatex
%% Using alternative from https://tex.stackexchange.com/a/530911/226
\newcommand{\utffriendlydetokenize}[1]{%
  \scantokens{%
    \catcode`\_=12%
    %   \catcode`\^=12%
    %   \catcode`\{=12%
    %   \catcode`\}=12%
    \catcode`\&=12%
    \catcode`\$=12%
    \catcode`\#=12%
    \catcode`\~=12%
    %   \catcode`\\=12%
    {#1}%
  }%
}

\ExplSyntaxOn
%% The PDF/A standard requires that document metadata be added
%% Define a command to set PDF metadata including keywords as a list
\NewDocumentCommand{\setpdfmetadata}{m m m m}{%
  \AtBeginDocument{%
    \hypersetup{%
      pdfauthor={#1},%
      pdftitle={#2},%
      pdfsubject={#3},%
      pdfkeywords={#4}%
    }%
  }%
}

%% Helper function to format each keyword (removes leading/trailing spaces)
\newcommand{\FormatKeyword}[1]{%
  \pdfstringdefDisableCommands{\def\Temp{#1}}%
  \Temp%
}

%% Usage example:
% \setpdfmetadata{me}{mytitle}{subject}{Green Networking, Mobile Cloud, Network Coding, Energy}

%% Incorporating hyperlinks
%% using \unfriendlydetokenize to avoid breaking unicode
%% Use accsupp so that when copying/pasting the icon from PDF to a text file, the icon name is pasted
\NewDocumentCommand{\printinfo}{m m o}{%
  \IfNoValueTF{#3}{%
    \mbox{\textcolor{accent}%
      {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
      ~\hspace{0.3em}\utffriendlydetokenize{#2}\hspace{2em}}%
  }{%
    \if@withhyper%
      \mbox{\textcolor{accent}%
        {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
        ~\hspace{0.3em}\href{#3}{\utffriendlydetokenize{#2}}\hspace{2em}}
    \else%
      \ClassWarning{Please specify [withhyper] option to enable hyperlinks. Printing out full hyperlink prefix #1 for now.}%
      \mbox{\textcolor{accent}
      {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
      ~\hspace{0.3em}{\utffriendlydetokenize{#3#2}}\hspace{2em}}%
    \fi%
  }%
}%

%% Exploring convenient creation of fields
%% Added starred mode to create \printinfo with full URL
%% You can debug by uncommenting the \typeout
\NewDocumentCommand{\NewInfoField}{s m m o}{%
  % \typeout{#1,#2,#3,#4}
  % If the star argument is not present
  \IfBooleanF{#1}{
    \IfNoValueF{#4}{\csdef{#2 hyperprefix}{#4}}%
  }
  \csdef{#2 symbol}{#3}%
  % If the star argument is present
  \IfBooleanTF{#1}
  {
    \csdef{#2}##1##2{%
      \if@withhyper
        \IfNoValueTF {##2}
        { % If the second argument is not provided, print the info with the symbol
          \printinfo{\csuse{#2 symbol}}{##1}%
        }%
        { % Otherwise, print the info with the symbol and the second argument
          \printinfo{\csuse{#2 symbol}}{##1}[##2]%
        }%
      \else
        % If @withhyper is not set, print the info with the symbol
        \printinfo{\csuse{#2 symbol}}{##1}%
      \fi%
    }%
  }
  { % If the star argument is not present, define a command that takes one argument
    \csdef{#2}##1{%
      \if@withhyper
        \IfNoValueTF {#4}
        { % If the fourth argument is not provided, print the info with the symbol
          \printinfo{\csuse{#2 symbol}}{##1}}%
        { % Otherwise, print the info with the symbol and hyperprefix
          \printinfo{\csuse{#2 symbol}}{##1}[\csuse{#2 hyperprefix}##1]}%
      \else
        % If @withhyper is not set, print the info with the symbol
        \printinfo{\csuse{#2 symbol}}{##1}%
      \fi%
    }%
  }
}
\ExplSyntaxOff

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}
\NewInfoField{email}{\faIcon{at}}[mailto:]
\NewInfoField{mailaddress}{\faIcon{envelope}}
\NewInfoField{phone}{\textbf{\faIcon{phone}}}[tel:]
\NewInfoField{homepage}{\textbf{\faIcon{globe}}}[https://]
\NewInfoField{twitter}{\faIcon{twitter}}[https://twitter.com/]
\NewInfoField{linkedin}{\faIcon{linkedin}}[https://linkedin.com/in/]
\NewInfoField{github}{\faIcon{github}}[https://github.com/]
\NewInfoField{orcid}{\faIcon{orcid}}[https://orcid.org/]
\NewInfoField{location}{\cvLocationMarker}

% Support for multiple photos
\newlength{\nextcv@photos@width}
\newlength{\nextcv@photo@diam@left}
\newlength{\nextcv@photo@diam@right}
\def\nextcv@left@photos{}
\def\nextcv@right@photos{}

\newcommand{\@makeaphoto}[2]{%
  \begin{minipage}{#1}%
    \if@normalphoto
      \includegraphics[width=\linewidth]{#2}
    \else
      \tikz\path[fill overzoom image={#2}]circle[radius=0.5\linewidth];
    \fi%
  \end{minipage}%
}

\newcommand{\nextcv@add@photo@left}[1]{%
  \appto{\nextcv@left@photos}{%
    \@makeaphoto{\nextcv@photo@diam@left}{#1}\hspace{1ex}%
  }%
  \addtolength{\nextcv@photos@width}{\nextcv@photo@diam@left}%
  \addtolength{\nextcv@photos@width}{1ex}%
}
\newcommand{\nextcv@add@photo@right}[1]{%
  \appto{\nextcv@right@photos}{%
    \@makeaphoto{\nextcv@photo@diam@right}{#1}\hspace{1ex}%
  }%
  \addtolength{\nextcv@photos@width}{\nextcv@photo@diam@right}%
  \addtolength{\nextcv@photos@width}{1ex}%
}
\newcommand{\photoL}[2]{%
  \setlength{\nextcv@photo@diam@left}{#1}%
  \forcsvlist{\nextcv@add@photo@left}{#2}%
}
\newcommand{\photoR}[2]{%
  \setlength{\nextcv@photo@diam@right}{#1}%
  \forcsvlist{\nextcv@add@photo@right}{#2}%
}
\let\photo\photoR

\newcommand{\namefont}{\Huge\bfseries}
\newcommand{\taglinefont}{\large\bfseries}
\newcommand{\personalinfofont}{\footnotesize\bfseries}
\newcommand{\cvsectionfont}{\LARGE\bfseries}
\newcommand{\cvsubsectionfont}{\large\bfseries}

\newcommand{\makecvheader}{%
  \begingroup
  \nextcv@left@photos\hfill%
  \begin{minipage}{\dimexpr\linewidth-\nextcv@photos@width}%
    \raggedright%
    {\namefont\color{name}\MakeUppercase{\@name}\par}
    \medskip
    {\taglinefont\color{tagline}\@tagline\par}
    \medskip
    {\personalinfofont\@personalinfo\par}
  \end{minipage}\hfill%
  \nextcv@right@photos\par%
  \endgroup\medskip
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvsection}[2][]{%
\nointerlineskip\bigskip%  %% bugfix in v1.6.2
\ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
{\color{heading}\cvsectionfont\MakeUppercase{#2}}\\[-1ex]%
{\color{headingrule}\rule{\linewidth}{2pt}\par}\medskip
}

\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{subheading}\cvsubsectionfont{#1}\par}\medskip
}

\newcommand{\cvevent}[4]{%
  {\large\color{emphasis}#1\par}
  \smallskip\normalsize
  \ifstrequal{#2}{}{}{
    \textbf{\color{accent}#2}\par
    \smallskip}
  \ifstrequal{#3}{}{}{%
    {\small\makebox[0.5\linewidth][l]%
        {\BeginAccSupp{method=pdfstringdef,ActualText={\datename:}}\cvDateMarker\EndAccSupp{}%
          ~\normalfont#3}%
      }}%
  \ifstrequal{#4}{}{}{%
    {\small\makebox[0.5\linewidth][l]%
        {\BeginAccSupp{method=pdfstringdef,ActualText={\locationname:}}\cvLocationMarker\EndAccSupp{}%
          ~\normalfont#4}%
      }}\par
  \medskip\normalsize
}

\RequirePackage{listofitems} % String splitter
\newcommand{\cvproject}[4]{%
  {
    \setsepchar{,}%  
    \readlist*\titlelist{#1}%
    \begin{tabularx}{\columnwidth}{@{}l | >{\raggedright\arraybackslash}X@{}}
      \large\textcolor{emphasis}{\textbf{\titlelist[1]}} & \textcolor{emphasis}{\titlelist[2]} \\
    \end{tabularx}\par
    \smallskip\normalsize
    \let\titlelist\relax
  }
  \ifstrequal{#2}{}{}{
    \textbf{\color{accent}\detokenize{[ #2 ]}}\par
    \smallskip
  }
  \ifstrequal{#3}{}{}{%
    {\small\makebox[0.5\linewidth][l]%
      {\BeginAccSupp{method=pdfstringdef,ActualText={\datename:}}\cvDateMarker\EndAccSupp{}%
      ~\normalfont#3}%
    }%
  }%
  \ifstrequal{#4}{}{}{%
    % The parsing-separator⟨delimiter⟩“/” is reserved by default for nested lists
    %  To set “/” as the ⟨parsing-separator⟩ for a simple list, it is necessary, using the optional argument
    \setsepchar[,]{/}%
    \readlist*\urllist{#4}%
    {\small\makebox[0.5\linewidth][l]%
        {\BeginAccSupp{method=pdfstringdef,ActualText={\projectlink:}}\cvProjectLinkMarker\EndAccSupp{}%
          ~\normalfont\href{#4}{GitHub: \urllist[-1]}}%
    }%
    \let\urllist\relax
  }\par
  \medskip\normalsize
}

% adds accsupp for the icon as well
\newcommand{\cvcert}[3]{%
  \begin{tabularx}{\columnwidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
    \multirow{2}{*}{\Large\color{accent}\BeginAccSupp{method=escape,ActualText={\detokenize{\cvCertificateMarker}: }}\cvCertificateMarker\EndAccSupp{}} & \bfseries\href{#2}{\textcolor{emphasis}{#1}} \\
    & \small{#3}
  \end{tabularx}%
  \smallskip
}

\newcommand{\cvachievement}[3]{%
  \begin{tabularx}{\columnwidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
    \multirow{2}{*}{\Large\color{accent}\BeginAccSupp{method=escape,ActualText={\detokenize{#1}: }}#1\EndAccSupp{}} & \bfseries\textcolor{emphasis}{#2} \\
    & #3
  \end{tabularx}%
  \smallskip
}

\newcommand{\cvtagheader}[1]{
  \large\textcolor{emphasis}{\bfseries#1}\par
  \medskip%
}

\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

% Use accsupp so that the actual numeric value is copied/pasted
%       and also support 0.5, 1.5, 2.5, 3.5, 4.5
\newcommand{\cvskill}[2]{%
{#1}\hfill
\BeginAccSupp{method=plain,ActualText={#2}}
\foreach \x in {1,...,5}{%
  \ifdimequal{\x pt - #2 pt}{0.5pt}%
  %% if true, then print half-filled marker
  {\clipbox*{0pt -0.25ex {.5\width} {\totalheight}}{\color{accent}{\cvRatingMarker}}%
   \clipbox*{{.5\width} -0.25ex {\width} {\totalheight}}{\color{body!30}{\cvRatingMarker}}%
  }%
  %% if false, then print marker filled according to rating
  {\ifdimgreater{\x bp}{#2 bp}{\color{body!30}}{\color{accent}}{\cvRatingMarker}}%
  \hspace{1em}% Add space between markers (adjust the value as needed)
}%
\EndAccSupp{}\par%
}

\newcommand{\cvref}[3]{%
  \smallskip
  \textcolor{emphasis}{\textbf{#1}}\par
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.35em,align=left]
    \item[\small\normalfont\emailsymbol] #2
    \item[\small\normalfont\mailaddresssymbol] #3
  \end{description}
  %   \medskip
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}

% Move biblatex-related code to separate .cfg file
% so that it's easier to change and customise the style for
% publication lists

% make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
    \ifstrequal{#1}{}{}{\vspace*{#1}}%
    \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

% But provide for ability to highlight names in publication list
\RequirePackage{pgffor}
\def\my@namelist{}
\newcommand{\mynames}[1]{\def\my@namelist{#1}}
\newtoggle{boldname}
\AddToHook{package/biblatex/after}{
  \renewcommand*{\mkbibnamefamily}[1]{%
    \global\togglefalse{boldname}%
    \foreach \my@fname / \my@gname in \my@namelist {%
      \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
        and
        test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
      {\global\toggletrue{boldname}}{}%
    }%
    \iftoggle{boldname}{\textbf{#1}}{#1}%
  }

  \renewcommand*{\mkbibnamegiven}[1]{%
    \global\togglefalse{boldname}%
    \foreach \my@fname / \my@gname in \my@namelist{%
      \ifboolexpr{ test {\ifdefstrequal{\namepartfamily}{\my@fname}}
        and
        test {\ifdefstrequal{\namepartgiven}{\my@gname}}}
      {\global\toggletrue{boldname}\breakforeach}{}%
    }%
    \iftoggle{boldname}{\textbf{#1}}{#1}%
  }
}

\AddToHook{begindocument/before}{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}
