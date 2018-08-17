%%============================================================================
%% AUTHOR: Clark Burton Chambers
%% CLIENT: Professor Lukins, CS424-01
%% DATE: September 28, 2017
%% DESCRIPTION: 
%% 		This program takes a subsection of the CLite programming language,
%% 		in he form of a file, parses it into a list and determines whether
%% 		or not it is in the subset of the CLite grammar subsection. If it is
%%		this proram returns true, otherwise it returns false. Uses DCG 
%% 		declarations because they are fantastic when defining BNF grammars. 
%%============================================================================


%% NOTE(clark): Thank you, professor, for this parsing magic. 

%% This just opens the file and parases out whitespace for list storage. 
parse_program(File) :- open(File, read, Fd),
	read_string(Fd, "", "", End, Str),
	split_string(Str, " \n\t", "\s\n\t", L),
	phrase(program, L).

%% Grammar declarations!
%% ===========================================================================
%% NOTE(clark): Things HAVE to be right-associative. Learned that the hard way. 
%% NOTE(clark): It took me a while to realize that Prolog is just really slow at
%%				computing answers. I thought it crashed after not finishing its 
%%				process in roughly a second or two. 
program  --> ["int"], ["main"], ["("], [")"], ["{"], declarations, statements, ["}"].

declarations --> declaration.
declarations --> declarations, declaration.

%% There's not much here to say, I think. It's really just a 
%%		1:1 with the BNF grammar of the problem statement. 
declaration --> type, identifier, [";"].
declaration --> type, identifier, [";"], ["["], digit, ["]"].

statements --> statement.
statements --> statement, statements.

%% NOTE(clark): Many alternatives for statement!
statement --> [";"].
statement --> block.
statement --> assignment.
statement --> if_statement.
statement --> while_statement.

block --> ["{"], statements, ["}"].

assignment --> identifier, ["="], expression, [";"].
assignment --> identifier, ["["], digit, ["]"], ["="], expression, [";"].

if_statement --> ["if"], ["("], expression, [")"], statement.

while_statement --> ["while"], ["("], expression, [")"], statement.

%% recursive, right-associative
expression --> conjunction.
expression --> conjunction, ["||"], expression.

%% recursive, right-associative
conjunction --> equality.
conjunction --> equality, ["&&"], conjunction.

equality --> relation. 
equality --> relation, equ_op, relation.

relation --> addition.
relation --> addition, rel_op, addition.

%% recursive, right-associative
addition --> term.
addition --> term, add_op, addition.

%% recursive, right-associative
term --> factor.
term --> factor, mul_op, term.

factor --> primary.
factor --> unary_op, primary.

%% NOTE(clark): Many alternatives for statement!
primary --> identifier.
primary --> identifier, ["["], digit, ["]"].
primary --> literal.
primary --> ["("], expression, [")"].
primary --> type, ["("], expression, [")"].

literal --> digit.
literal --> boolean.

%% Operator definitions
%% =====================================================================
rel_op --> ["<"].
rel_op --> ["<="].
rel_op --> [">"].
rel_op --> [">="].

add_op --> ["+"].
add_op --> ["-"].

equ_op --> ["=="].
equ_op --> ["!="].

mul_op --> ["*"].
mul_op --> ["/"].
mul_op --> ["%"].

unary_op --> ["-"].
unary_op --> ["!"].

%% upper and lowercase identifiers. This would be way more tedious if I wasn't using Sublime B). 
identifier --> ["A"].
identifier --> ["B"].
identifier --> ["C"].
identifier --> ["D"].
identifier --> ["E"].
identifier --> ["F"].
identifier --> ["G"].
identifier --> ["H"].
identifier --> ["I"].
identifier --> ["J"].
identifier --> ["K"].
identifier --> ["L"].
identifier --> ["M"].
identifier --> ["N"].
identifier --> ["O"].
identifier --> ["P"].
identifier --> ["Q"].
identifier --> ["R"].
identifier --> ["S"].
identifier --> ["T"].
identifier --> ["U"].
identifier --> ["V"].
identifier --> ["W"].
identifier --> ["X"].
identifier --> ["Y"].
identifier --> ["Z"].

%% Man. This is why I love multiple-line editing. 
identifier --> ["a"].
identifier --> ["b"].
identifier --> ["c"].
identifier --> ["d"].
identifier --> ["e"].
identifier --> ["f"].
identifier --> ["g"].
identifier --> ["h"].
identifier --> ["i"].
identifier --> ["j"].
identifier --> ["k"].
identifier --> ["l"].
identifier --> ["m"].
identifier --> ["n"].
identifier --> ["o"].
identifier --> ["p"].
identifier --> ["q"].
identifier --> ["r"].
identifier --> ["s"].
identifier --> ["t"].
identifier --> ["u"].
identifier --> ["v"].
identifier --> ["w"].
identifier --> ["x"].
identifier --> ["y"].
identifier --> ["z"].

%% types
type --> ["int"].
type --> ["bool"].
type --> ["float"].
type --> ["char"].

%% bools
boolean --> ["true"].
boolean --> ["false"].

%% Sublime, pulling its weight real hard. 
digit --> ["0"].
digit --> ["1"].
digit --> ["2"].
digit --> ["3"].
digit --> ["4"].
digit --> ["5"].
digit --> ["6"].
digit --> ["7"].
digit --> ["8"].
digit --> ["9"].

