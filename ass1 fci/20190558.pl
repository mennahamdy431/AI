
:-['students_courses.pl'].

mmbr(Obj,[Obj|_]).
mmbr(Obj,[_|Tail]):-mmbr(Obj,Tail).

add_Lst([],Stud,Stud).
add_Lst([H|T1],TmpStud,[H|T2]):-add_Lst(T1,TmpStud,T2).


% problem1


studentsInCourse(CourseName,Stud):- studentsInCourse(CourseName,[],Stud).
studentsInCourse(CourseName,TmpStud,Stud):- student(ID,CourseName,Grade),
                                                     not(mmbr([ID,Grade],TmpStud)),!,
                                                     add_Lst(TmpStud,[[ID,Grade]],NewStud),
                                                     studentsInCourse(CourseName,NewStud,Stud).
studentsInCourse(_,Stud,Stud).



/*___________________________________________________________________________________*/
% problem2


numStudents(CourseName,Num):- 
numStudents(CourseName,[],0,Num).

numStudents(CourseName,TmpLst,Cnt,Num):- 
	student(ID, CourseName, _),
	not(mmbr(ID,TmpLst)),!,
	add_Lst([ID],TmpLst,NewLst),
	NewCnt is Cnt+1,
	numStudents(CourseName,NewLst,NewCnt,Num).

numStudents(_,_,Num,Num).


/*___________________________________________________________________________________*/
% problem3


maxStudentGrade(A,List):-
    maxStudentGrade(A,[], List).

maxStudentGrade(A,Tmplist, List):-
    student(A,_,Y),
    not(mmbr(Y, Tmplist)), !,
    add_Lst([Y], Tmplist, Newtemplist),
    maxStudentGrade(A,Newtemplist, List).

maxStudentGrade(_,List, M):-
    max_list(List,M).

/*___________________________________________________________________________________*/


% problem4

num(0,zero).
num(1,one).
num(2,two).
num(3,three).
num(4,four).
num(5,five).
num(6,six).
num(7,seven).
num(8,eight).
num(9,nine).
gradeInWords(Stud, Course, Diglst):-
		student(Stud, Course, Grade),
		grade(Grade, [], Diglst),!.
mod_ten(0, Ans, Ans).
mod_ten(Grade, _, Ans):-
		Tmpgrade is Grade-((Grade//10)*10),
		mod_ten(0, Tmpgrade, Ans).

grade(0,Ans,Ans):-!.

grade(Grade,Tmplst,Diglst):-
		mod_ten(Grade,0,Ans),
		num(Ans, Digit),
		add_Lst([Digit], Tmplst,Newtmplst),
		Newgrade is Grade//10,
		grade(Newgrade, Newtmplst, Diglst).
/*___________________________________________________________________________________*/
% problem5

mainPrerequisite(X, Y):-
    prerequisite(X, Y).

mainPrerequisite(X, Y):-
    prerequisite(X, Z),
    mainPrerequisite(Z, Y).

coursesToTarget(X, L):-
    findall(S,mainPrerequisite(S,X),L).