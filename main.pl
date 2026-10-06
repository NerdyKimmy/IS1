class(entity).
class(bible_book).
class(author).
class(testament).
class(canon_status).
class(language).
class(biblical_figure).

subclass(ot_book, bible_book). % Старий Завіт
subclass(nt_book, bible_book). % Новий Завіт

subclass(pentateuch, ot_book).    % П'ятикнижжя 
subclass(historical_ot, ot_book). % Історичні книги
subclass(wisdom, ot_book).        % Книги мудрості 
subclass(major_prophets, ot_book).% Великі пророки
subclass(minor_prophets, ot_book).% Малі пророки

subclass(gospel, nt_book).        % Євангелія
subclass(historical_nt, nt_book). % Історичні 
subclass(pauline_epistle, nt_book).% Послання Павла
subclass(general_epistle, nt_book).% Соборні послання
subclass(apocalyptic, nt_book).   % Апокаліптичні

instance(genesis, pentateuch).
instance(exodus, pentateuch).
instance(leviticus, pentateuch).
instance(numbers, pentateuch).
instance(deuteronomy, pentateuch).

instance(joshua, historical_ot).
instance(judges, historical_ot).
instance(ruth, historical_ot).
instance(samuel_1, historical_ot).
instance(samuel_2, historical_ot).
instance(kings_1, historical_ot).
instance(kings_2, historical_ot).
instance(ezra, historical_ot).
instance(nehemiah, historical_ot).
instance(esther, historical_ot).

instance(job, wisdom).
instance(psalms, wisdom).
instance(proverbs, wisdom).
instance(ecclesiastes, wisdom).
instance(song_of_songs, wisdom).

instance(isaiah, major_prophets).
instance(jeremiah, major_prophets).
instance(lamentations, major_prophets).
instance(ezekiel, major_prophets).
instance(daniel, major_prophets).

instance(hosea, minor_prophets).
instance(joel, minor_prophets).
instance(amos, minor_prophets).
instance(obadiah, minor_prophets).
instance(jonah, minor_prophets).
instance(micah, minor_prophets).
instance(nahum, minor_prophets).
instance(habakkuk, minor_prophets).
instance(zephaniah, minor_prophets).
instance(haggai, minor_prophets).
instance(zechariah, minor_prophets).
instance(malachi, minor_prophets).

instance(tobit, historical_ot).
instance(judith, historical_ot).
instance(maccabees_1, historical_ot).
instance(maccabees_2, historical_ot).
instance(wisdom_of_solomon, wisdom).
instance(sirach, wisdom).
instance(baruch, major_prophets).

instance(matthew, gospel).
instance(mark, gospel).
instance(luke, gospel).
instance(john, gospel).

instance(acts, historical_nt).

instance(romans, pauline_epistle).
instance(corinthians_1, pauline_epistle).
instance(corinthians_2, pauline_epistle).
instance(galatians, pauline_epistle).
instance(ephesians, pauline_epistle).
instance(philippians, pauline_epistle).
instance(colossians, pauline_epistle).
instance(thessalonians_1, pauline_epistle).
instance(thessalonians_2, pauline_epistle).
instance(timothy_1, pauline_epistle).
instance(timothy_2, pauline_epistle).
instance(titus, pauline_epistle).
instance(philemon, pauline_epistle).
instance(hebrews, pauline_epistle).

instance(james, general_epistle).
instance(peter_1, general_epistle).
instance(peter_2, general_epistle).
instance(john_1, general_epistle).
instance(john_2, general_epistle).
instance(john_3, general_epistle).
instance(jude, general_epistle).

instance(revelation, apocalyptic).

instance(moses, author).
instance(joshua_person, author).
instance(samuel_person, author).
instance(david, author).
instance(solomon, author).
instance(isaiah_prophet, author).
instance(jeremiah_prophet, author).
instance(ezekiel_prophet, author).
instance(daniel_prophet, author).
instance(matthew_apostle, author).
instance(mark_evangelist, author).
instance(luke_evangelist, author).
instance(john_apostle, author).
instance(paul_apostle, author).
instance(james_apostle, author).
instance(peter_apostle, author).
instance(jude_apostle, author).
instance(unknown_author, author).

instance(old_testament, testament).
instance(new_testament, testament).

instance(protocanonical, canon_status).
instance(deuterocanonical, canon_status).

instance(hebrew, language).
instance(aramaic, language).
instance(greek, language).

instance(jesus_christ, biblical_figure).
instance(abraham, biblical_figure).
instance(moses_figure, biblical_figure).
instance(david_figure, biblical_figure).
instance(adam, biblical_figure).
instance(noah, biblical_figure).

has_attribute(genesis, chapters, 50).
has_attribute(exodus, chapters, 40).
has_attribute(leviticus, chapters, 27).
has_attribute(numbers, chapters, 36).
has_attribute(deuteronomy, chapters, 34).
has_attribute(joshua, chapters, 24).
has_attribute(judges, chapters, 21).
has_attribute(ruth, chapters, 4).
has_attribute(samuel_1, chapters, 31).
has_attribute(samuel_2, chapters, 24).
has_attribute(kings_1, chapters, 22).
has_attribute(kings_2, chapters, 25).
has_attribute(job, chapters, 42).
has_attribute(psalms, chapters, 150).
has_attribute(proverbs, chapters, 31).
has_attribute(ecclesiastes, chapters, 12).
has_attribute(song_of_songs, chapters, 8).
has_attribute(isaiah, chapters, 66).
has_attribute(jeremiah, chapters, 52).
has_attribute(lamentations, chapters, 5).
has_attribute(ezekiel, chapters, 48).
has_attribute(daniel, chapters, 12).
has_attribute(jonah, chapters, 4).
has_attribute(maccabees_1, chapters, 16).
has_attribute(maccabees_2, chapters, 15).
has_attribute(tobit, chapters, 14).
has_attribute(wisdom_of_solomon, chapters, 19).
has_attribute(sirach, chapters, 51).
has_attribute(matthew, chapters, 28).
has_attribute(mark, chapters, 16).
has_attribute(luke, chapters, 24).
has_attribute(john, chapters, 21).
has_attribute(acts, chapters, 28).
has_attribute(romans, chapters, 16).
has_attribute(corinthians_1, chapters, 16).
has_attribute(corinthians_2, chapters, 13).
has_attribute(galatians, chapters, 6).
has_attribute(revelation, chapters, 22).

has_attribute(genesis, century_written, -15).
has_attribute(exodus, century_written, -15).
has_attribute(psalms, century_written, -10).
has_attribute(proverbs, century_written, -950).
has_attribute(isaiah, century_written, -8).
has_attribute(daniel, century_written, -6).
has_attribute(maccabees_1, century_written, -2).
has_attribute(wisdom_of_solomon, century_written, -1).
has_attribute(matthew, century_written, 1).
has_attribute(mark, century_written, 1).
has_attribute(luke, century_written, 1).
has_attribute(john, century_written, 1).
has_attribute(romans, century_written, 1).
has_attribute(revelation, century_written, 1).

written_by(genesis, moses).
written_by(exodus, moses).
written_by(leviticus, moses).
written_by(numbers, moses).
written_by(deuteronomy, moses).
written_by(joshua, joshua_person).
written_by(judges, samuel_person).
written_by(ruth, samuel_person).
written_by(psalms, david).
written_by(proverbs, solomon).
written_by(ecclesiastes, solomon).
written_by(song_of_songs, solomon).
written_by(wisdom_of_solomon, unknown_author).
written_by(isaiah, isaiah_prophet).
written_by(jeremiah, jeremiah_prophet).
written_by(lamentations, jeremiah_prophet).
written_by(ezekiel, ezekiel_prophet).
written_by(daniel, daniel_prophet).
written_by(jonah, unknown_author).
written_by(maccabees_1, unknown_author).
written_by(maccabees_2, unknown_author).
written_by(tobit, unknown_author).
written_by(matthew, matthew_apostle).
written_by(mark, mark_evangelist).
written_by(luke, luke_evangelist).
written_by(john, john_apostle).
written_by(revelation, john_apostle).
written_by(acts, luke_evangelist).
written_by(romans, paul_apostle).
written_by(corinthians_1, paul_apostle).
written_by(corinthians_2, paul_apostle).
written_by(galatians, paul_apostle).
written_by(ephesians, paul_apostle).
written_by(philippians, paul_apostle).
written_by(colossians, paul_apostle).
written_by(thessalonians_1, paul_apostle).
written_by(thessalonians_2, paul_apostle).
written_by(timothy_1, paul_apostle).
written_by(timothy_2, paul_apostle).
written_by(titus, paul_apostle).
written_by(philemon, paul_apostle).
written_by(hebrews, unknown_author).
written_by(james, james_apostle).
written_by(peter_1, peter_apostle).
written_by(peter_2, peter_apostle).
written_by(john_1, john_apostle).
written_by(john_2, john_apostle).
written_by(john_3, john_apostle).
written_by(jude, jude_apostle).

belongs_to_testament(genesis, old_testament).
belongs_to_testament(exodus, old_testament).
belongs_to_testament(leviticus, old_testament).
belongs_to_testament(numbers, old_testament).
belongs_to_testament(deuteronomy, old_testament).
belongs_to_testament(joshua, old_testament).
belongs_to_testament(judges, old_testament).
belongs_to_testament(ruth, old_testament).
belongs_to_testament(samuel_1, old_testament).
belongs_to_testament(samuel_2, old_testament).
belongs_to_testament(kings_1, old_testament).
belongs_to_testament(kings_2, old_testament).
belongs_to_testament(ezra, old_testament).
belongs_to_testament(nehemiah, old_testament).
belongs_to_testament(esther, old_testament).
belongs_to_testament(job, old_testament).
belongs_to_testament(psalms, old_testament).
belongs_to_testament(proverbs, old_testament).
belongs_to_testament(ecclesiastes, old_testament).
belongs_to_testament(song_of_songs, old_testament).
belongs_to_testament(isaiah, old_testament).
belongs_to_testament(jeremiah, old_testament).
belongs_to_testament(lamentations, old_testament).
belongs_to_testament(ezekiel, old_testament).
belongs_to_testament(daniel, old_testament).
belongs_to_testament(jonah, old_testament).
belongs_to_testament(maccabees_1, old_testament).
belongs_to_testament(maccabees_2, old_testament).
belongs_to_testament(tobit, old_testament).
belongs_to_testament(wisdom_of_solomon, old_testament).
belongs_to_testament(sirach, old_testament).
belongs_to_testament(baruch, old_testament).

belongs_to_testament(matthew, new_testament).
belongs_to_testament(mark, new_testament).
belongs_to_testament(luke, new_testament).
belongs_to_testament(john, new_testament).
belongs_to_testament(acts, new_testament).
belongs_to_testament(romans, new_testament).
belongs_to_testament(corinthians_1, new_testament).
belongs_to_testament(corinthians_2, new_testament).
belongs_to_testament(galatians, new_testament).
belongs_to_testament(ephesians, new_testament).
belongs_to_testament(philippians, new_testament).
belongs_to_testament(colossians, new_testament).
belongs_to_testament(thessalonians_1, new_testament).
belongs_to_testament(thessalonians_2, new_testament).
belongs_to_testament(timothy_1, new_testament).
belongs_to_testament(timothy_2, new_testament).
belongs_to_testament(titus, new_testament).
belongs_to_testament(philemon, new_testament).
belongs_to_testament(hebrews, new_testament).
belongs_to_testament(james, new_testament).
belongs_to_testament(peter_1, new_testament).
belongs_to_testament(peter_2, new_testament).
belongs_to_testament(john_1, new_testament).
belongs_to_testament(john_2, new_testament).
belongs_to_testament(john_3, new_testament).
belongs_to_testament(jude, new_testament).
belongs_to_testament(revelation, new_testament).

written_in_language(genesis, hebrew).
written_in_language(exodus, hebrew).
written_in_language(leviticus, hebrew).
written_in_language(numbers, hebrew).
written_in_language(deuteronomy, hebrew).
written_in_language(psalms, hebrew).
written_in_language(isaiah, hebrew).
written_in_language(daniel, hebrew).
written_in_language(daniel, aramaic).
written_in_language(maccabees_1, hebrew).
written_in_language(maccabees_2, greek).
written_in_language(wisdom_of_solomon, greek).
written_in_language(matthew, greek).
written_in_language(mark, greek).
written_in_language(luke, greek).
written_in_language(john, greek).
written_in_language(acts, greek).
written_in_language(romans, greek).
written_in_language(corinthians_1, greek).
written_in_language(revelation, greek).

mentions_figure(genesis, adam).
mentions_figure(genesis, noah).
mentions_figure(genesis, abraham).
mentions_figure(exodus, moses_figure).
mentions_figure(psalms, david_figure).
mentions_figure(matthew, jesus_christ).
mentions_figure(matthew, abraham).
mentions_figure(matthew, david_figure).
mentions_figure(mark, jesus_christ).
mentions_figure(luke, jesus_christ).
mentions_figure(john, jesus_christ).
mentions_figure(acts, jesus_christ).
mentions_figure(romans, jesus_christ).

has_canon_status(genesis, protocanonical).
has_canon_status(exodus, protocanonical).
has_canon_status(leviticus, protocanonical).
has_canon_status(numbers, protocanonical).
has_canon_status(deuteronomy, protocanonical).
has_canon_status(joshua, protocanonical).
has_canon_status(judges, protocanonical).
has_canon_status(ruth, protocanonical).
has_canon_status(samuel_1, protocanonical).
has_canon_status(samuel_2, protocanonical).
has_canon_status(job, protocanonical).
has_canon_status(psalms, protocanonical).
has_canon_status(proverbs, protocanonical).
has_canon_status(ecclesiastes, protocanonical).
has_canon_status(song_of_songs, protocanonical).
has_canon_status(isaiah, protocanonical).
has_canon_status(jeremiah, protocanonical).
has_canon_status(daniel, protocanonical).
has_canon_status(jonah, protocanonical).

has_canon_status(maccabees_1, deuterocanonical).
has_canon_status(maccabees_2, deuterocanonical).
has_canon_status(tobit, deuterocanonical).
has_canon_status(wisdom_of_solomon, deuterocanonical).
has_canon_status(sirach, deuterocanonical).
has_canon_status(baruch, deuterocanonical).

has_canon_status(matthew, protocanonical).
has_canon_status(mark, protocanonical).
has_canon_status(luke, protocanonical).
has_canon_status(john, protocanonical).
has_canon_status(acts, protocanonical).
has_canon_status(romans, protocanonical).
has_canon_status(corinthians_1, protocanonical).
has_canon_status(revelation, protocanonical).

subclass_transitive(Sub, Super) :-
    subclass(Sub, Super).
subclass_transitive(Sub, Super) :-
    subclass(Sub, Intermediate),
    subclass_transitive(Intermediate, Super).

is_a(Entity, Class) :-
    instance(Entity, Class).
is_a(Entity, Superclass) :-
    instance(Entity, DirectClass),
    subclass_transitive(DirectClass, Superclass).

is_pauline_epistle(Book) :-
    is_a(Book, pauline_epistle),
    written_by(Book, paul_apostle).

mentions_jesus(Book) :-
    is_a(Book, bible_book),
    mentions_figure(Book, jesus_christ).

multilingual_book(Book) :-
    written_in_language(Book, Lang1),
    written_in_language(Book, Lang2),
    Lang1 \= Lang2.

is_long_book(Book) :-
    is_a(Book, bible_book),
    has_attribute(Book, chapters, Count),
    Count >= 40.

same_author(Book1, Book2) :-
    written_by(Book1, Author),
    written_by(Book2, Author),
    Book1 \= Book2.

protestant_canon_book(Book) :-
    is_a(Book, bible_book),
    has_canon_status(Book, protocanonical).

catholic_canon_book(Book) :-
    is_a(Book, bible_book),
    (has_canon_status(Book, protocanonical) ; has_canon_status(Book, deuterocanonical)).

greek_nt_book(Book) :-
    is_a(Book, nt_book),
    written_in_language(Book, greek).


hierarchy_cycle(A, B) :-
    subclass_transitive(A, B),
    subclass_transitive(B, A).

invalid_author_relation(Book, Author) :-
    written_by(Book, Author),
    (   \+ is_a(Book, bible_book)
    ;   \+ instance(Author, author)
    ).

invalid_chapter_count(Book, Count) :-
    has_attribute(Book, chapters, Count),
    (   Count < 1
    ;   Count > 150
    ).

contradictory_canon_status(Book) :-
    has_canon_status(Book, protocanonical),
    has_canon_status(Book, deuterocanonical).

invalid_nt_language(Book) :-
    is_a(Book, nt_book),
    written_in_language(Book, hebrew).

consistent_model :-
    \+ hierarchy_cycle(_, _),
    \+ invalid_author_relation(_, _),
    \+ invalid_chapter_count(_, _),
    \+ contradictory_canon_status(_),
    \+ invalid_nt_language(_).
