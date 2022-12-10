% Abhimanyu Gupta - 2019226
% CSE643 - Artificial Intelligence - Assignment 1

adviseElectiveCourses :-
	clear_all,

	get_facts,

	forall(interested(X), check_available_electives(X)),
	recommend_courses(Courses),
	(
		is_empty(Courses) -> write('Sorry, nothing to recommend at the moment\n');
		format('Suitable Elective(s) for you:\n'), show_list(Courses)
	).

:- dynamic interested/1, course_done/1, course_not_done/1, is_empty/1, recommend_course/1.

clear_all :-
	retractall(interested(_)),
	retractall(course_done(_)),
	retractall(course_not_done(_)),
	retractall(recommend_course(_)).

get_facts :-
	open('facts.txt', read, File),
	read_file(File, Lines),
	close(File),
	create_facts(Lines).


read_file(Stream, [X | L]) :-
	\+ at_end_of_stream(Stream),
	read(Stream, X),
	read_file(Stream, L).

read_file(Stream,[]) :-
	at_end_of_stream(Stream).


create_facts([Head|Tail]):-
	(
		(Head == end_of_file) -> create_facts(Tail);
		assert(Head),
		create_facts(Tail)
	).

create_facts([]).

recommend_courses([Head | Tail]) :-
	retract(recommend_course(Head)), recommend_courses(Tail).
recommend_courses([]).

show_list([Head | Tail]) :-
	format('~w~n', [Head]), show_list(Tail).
show_list([]).

isempty([]).


check_course(Q) :-
	(
		course_done(Q) -> true;
		(
			course_not_done(Q) -> !;
			ask_question_to_check(Q)
		)
	).

ask_question_to_check(Q) :-
	format('Have you completed ~w course (y/n)?\n', [Q]),
	read(A),
	(
		(A = 'y') -> assert(course_done(Q));
		assert(course_not_done(Q))
	).

check_available_electives(security) :-

	check_course('cn'),
	(
		course_not_done('cn') -> assert(recommend_course('cn'));
		(
			check_course('fcs'),
			(
				course_not_done('fcs') -> assert(recommend_course('fcs'));
				!
			)
		)
	),

	check_course('cn'),
	(
		course_not_done('cn') -> assert(recommend_course('cn'));
		(
			check_course('ns'),
			(
				course_not_done('ns') -> assert(recommend_course('ns'));
				!
			)
		)
	),

	check_course('fcs'),
	(
		course_not_done('fcs') -> assert(recommend_course('fcs'));
		(
			check_course('se'),
			(
				course_not_done('se') -> assert(recommend_course('se'));
				!
			)
		)
	).

check_available_electives(artificial) :-

	check_course('ai'),
	(
		course_not_done('ai') -> assert(recommend_course('ai'));
		!
	),

	check_course('ml'),
	(
		course_not_done('ml') -> assert(recommend_course('ml'));
		(
			check_course('dl'),
			(
				course_not_done('dl') -> assert(recommend_course('dl'));
				!
			)
		)
	),

	check_course('sml'),
	(
		course_not_done('sml') -> assert(recommend_course('sml'));
		!
	).


check_available_electives(algorithm) :-

	check_course('ada'),
	(
		course_not_done('ada') -> assert(recommend_course('ada'));
		(
			check_course('mad'),
			(
				course_not_done('mad') -> assert(recommend_course('mad'));
				!
			)
		)
	),

	check_course('ada'),
	(
		course_not_done('ada') -> assert(recommend_course('ada'));
		(
			check_course('ra'),
			(
				course_not_done('ra') -> assert(recommend_course('ra'));
				!
			)
		)
	),

	check_course('ada'),
	(
		course_not_done('ada') -> assert(recommend_course('ada'));
		(
			check_course('ga'),
			(
				course_not_done('ga') -> assert(recommend_course('ga'));
				!
			)
		)
	).


check_available_electives(pm) :-

	check_course('ra1'),
	(
		course_not_done('ra1') -> assert(recommend_course('ra1'));
		(
			check_course('ra2'),
			(
				course_not_done('ra2') -> assert(recommend_course('ra2'));
				!
			)
		)
	),

	check_course('aa1'),
	(
		course_not_done('aa1') -> assert(recommend_course('aa1'));
		(
			check_course('aa2'),
			(
				course_not_done('aa2') -> assert(recommend_course('aa2'));
				!
			)
		)
	),

	check_course('dm'),
	(
		course_not_done('dm') -> assert(recommend_course('dm'));
		(
			check_course('gt'),
			(
				course_not_done('gt') -> assert(recommend_course('gt'));
				!
			)
		)
	).

check_available_electives(optimization) :-

	check_course('lo'),
	(
		course_not_done('lo') -> assert(recommend_course('lo'));
		!
	),

	check_course('m4'),
	(
		course_not_done('m4') -> assert(recommend_course('m4'));
		(
			check_course('co'),
			(
				course_not_done('co') -> assert(recommend_course('co'));
				!
			)
		)
	),

	check_course('gt'),
	(
		course_not_done('gt') -> assert(recommend_course('gt'));
		!
	).

check_available_electives(ps) :-

	check_course('pns'),
	(
		course_not_done('pns') -> assert(recommend_course('pns'));
		(
			check_course('spa'),
			(
				course_not_done('spa') -> assert(recommend_course('spa'));
				!
			)
		)
	),

	check_course('pns'),
	(
		course_not_done('pns') -> assert(recommend_course('pns'));
		(
			check_course('si'),
			(
				course_not_done('si') -> assert(recommend_course('si'));
				!
			)
		)
	).


check_available_electives(X) :-
	true.

