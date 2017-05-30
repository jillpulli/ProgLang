%checks if a element occurs in the list
member(Item, [Item|_]).
member(Item, [_|T]) :- member(Item, T).

%No duplicates if it is an empty list,
%recursively checks if the head of the
%list occurs in tail.
no_dub([]).
no_dub([H|T]):- \+ member(H,T), no_dub(T).

%Searches for the name of the employee in the
%employee list. Then returns the three digit
%skill set.
get_employee_info(Name,[[Name|Skills]|_],Skills).
get_employee_info(Name,[_|T],Skills):-
        get_employee_info(Name,T,Skills).

%checks if the skill set has a 1 in the first position
phone_skills([1,_,_]).

%checks if the skill set has a 1 in the second position
computer_skills([_,1,_]).

%checks if the skill set has a 1 in the third position
network_skills([_,_,1]).

%In one 4 person shift, will check if the employees have
%the skill to fit their shift. Calls get employee info
%on each person in the shift and checks phone skills,
%computer skills, and network skills.
shift_ok([A,B,C,D],Employ):-
        get_employee_info(A,Employ,E),
        phone_skills(E),
        get_employee_info(B,Employ,F),
        phone_skills(F),
        get_employee_info(C,Employ,G),
        computer_skills(G),
        get_employee_info(D,Employ,H),
        network_skills(H).

%Checks if each assignment for each shift is ok.
%Calls shifts okay on the head and recursively calls
%it on the tail.
assignments_ok([],_).
assignments_ok([CurrentShift|OtherShifts],Employ):-
        shift_ok(CurrentShift,Employ),
        assignments_ok(OtherShifts,Employ).
                                                        
%flattens the assignments list
%first checks if there are no duplicate assignments
%then calls assignments_ok on Assignments with Employees
%list.
jobs_ok(Assignments,Employees):-
        flatten(Assignments,A),
        no_dub(A),
        assignments_ok(Assignments,Employees).
        
