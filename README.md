# Latex Template for master/phd @ York University
York University, Toronto, Canada

This is a Latex class file that satisifies the organization and technical Requirements of a [masters/phd](http://gradstudies.yorku.ca/current-students/thesis-dissertation/organization/) thesis set out by Faculty of Graduate Studies, York University. This is not officially endorsed by York University or FGS. I will likely not be maintaining this when I graduate (October 2019). PRs are always welcome. Alternatively, fork it and make your own. 

## Instructions 

### Download
Download the `.cls` file in the same folder you are working in (or install it system-wide if you have the technical skills to do so). 
See the `thesis.tex` file for a minimal working example. 

#### Before we begin, if you are running TexLive 2018 on Mac/Linux, make sure to update.
`sudo tlmgr update --self` followed by `sudo tlmgr update --all`. I did this and it fixed quite a few bugs for me. 

### Settings

**Information**
```
\title{Your thesis title}       
\author{Your name}   % this is your name exactly as you want it to appear everywhere in your work.
\department{Mathematics and Statistics}   % this is the name of the programme in which you are attempting your degree
\masterof{Science}        % this is the type of Master's degree you are attempting. If the boolean masters is false, this has no effect.
\degreename{Doctor}       % put the actual name of the degree you are attempting {Doctor or Masters}
\date{September 2018}     % this is the month and year of defence
```

**Front Matter Files**
Specify the path to your front matter files.  Comment line if you don't need it. 
```
\abstractfile{abstract.tex}
\dedicationfile{dedication.tex}
\acknowledgementsfile{acknowledgements.tex}
\prefacefile{preface.tex}
\abbreviationsfile{abbreviations.tex}
```

**Figures and Tables**
```
\setboolean{masters}{false}    % set true for a Master's thesis; % false for a PhD dissertation
\setboolean{hasfigures}{true}  % set true if you have figures
\setboolean{hastables}{true}   % set true of you have tables
```

**Committee Members**
```
\committeememberslist{
  \begin{enumerate}
    \item Member A
    \item Member B
    \item Member C
  \end{enumerate}
}
```

### Options
The class file is inherited from the document class `report`. Any options/packages that work for `report` will work for this class. Two particular pre-set options are defined for you. 

Option: `draft` (i.e. `\documentclass[draft]{york-thesis-modified}`) is equivalent to the `report` class with the options:

```
letterpaper,12pt,oneside,onecolumn,draft,openany
```

Option: `final` (i.e. `\documentclass{york-thesis-modified}` or `\documentclass[final]{york-thesis-modified}`) is equivalent to the `report` class with the options:

```
letterpaper,12pt,oneside,onecolumn,final,openany
```
These options are propagated through the rest of packages. 


