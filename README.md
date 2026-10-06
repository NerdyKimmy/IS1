# Лабораторна робота №1

## Подання знань і бази знань на Пролозі

Венц Ю. В.  
група ТТП-42  

### Тема

Подання знань і бази знань на Пролозі.

### Мета роботи

Ознайомитися з основними принципами логічного програмування в середовищі Пролог та набути практичних навичок побудови бази знань предметної області на основі фактів, правил і запитів. Навчитися формалізувати знання у вигляді предикатів, перевіряти істинність тверджень за допомогою запитів і аналізувати результати логічного виведення.

### Завдання роботи

Необхідно розробити базу знань на Пролозі для заданої предметної області. У межах роботи необхідно:

- виділити поняття-класи та підкласи;
- відокремити екземпляри від класів;
- розрізняти ієрархічні, атрибутивні й асоціативні зв'язки;
- реалізувати правило успадкування або інший приклад неявного висновку;
- передбачити перевірки узгодженості моделі;
- сформулювати запити до бази знань і проаналізувати результати їх виконання.

---

# 1. Короткі теоретичні відомості

## 1.1. Пролог і логічне програмування

Пролог є мовою логічного програмування, у якій програма розглядається як сукупність фактів і правил. Основною одиницею подання знань є предикат, що описує об'єкт, його властивість або відношення між об'єктами.

На відміну від процедурного підходу, у Пролозі програміст переважно задає логічну модель предметної області, а не послідовність команд. Механізм логічного виведення використовує уніфікацію, резолюцію та повернення назад (backtracking) для пошуку доведення поставленої цілі.

## 1.2. Факти

Факт у Пролозі задає твердження, яке вважається істинним у межах бази знань.

У розробленій базі знань прикладами фактів є:

```prolog
class(bible_book).
instance(genesis, pentateuch).
has_attribute(genesis, chapters, 50).
written_by(genesis, moses).
```

Факти є базовими знаннями, тобто вони безпосередньо задані програмою і не потребують попереднього логічного виведення.

## 1.3. Правила

Правило задає залежність між твердженнями та дозволяє виводити нові знання. Загальна форма правила:

```prolog
висновок :- умова1, умова2, ..., умоваN.
```

Наприклад, у даній роботі основним правилом успадкування є:

```prolog
subclass_transitive(Sub, Super) :-
    subclass(Sub, Super).

subclass_transitive(Sub, Super) :-
    subclass(Sub, Intermediate),
    subclass_transitive(Intermediate, Super).
```

Воно дозволяє отримувати не тільки безпосереднього батька класу, а й усі класи вище за ієрархією.

## 1.4. Запити

Запит є зверненням до бази знань із метою перевірити, чи можна довести певне твердження.

Якщо твердження можна вивести з наявних фактів і правил, Пролог повертає `true`, інакше — `false`. Якщо у запиті є змінні, Пролог може повертати конкретні значення, для яких твердження доводиться.

## 1.5. Заперечення як невдача

У SWI-Prolog оператор `\+` означає не класичне логічне заперечення, а твердження, що відповідну ціль не вдається довести. Його рекомендується застосовувати після того, як змінні, від яких залежить перевірка, уже конкретизовані.

Це використовується, зокрема, у перевірках узгодженості та в правилі `consistent_model/0`.

---

# 2. Опис предметної області

Предметною областю є **структура біблійного канону та пов'язані історико-текстологічні сутності**.

База знань описує книги Старого та Нового Завіту, їхні жанрові групи, авторів, мови оригіналу, канонічні статуси та згадуваних біблійних постатей. Для кожної книги задано кількість розділів та приблизне століття написання.

Основними групами понять є:

- **біблійні книги** — конкретні тексти канону та їхні класи за літературним жанром;
- **жанри** — Тора (П'ятикнижжя), історичні книги, книги мудрості, пророчі книги, Євангелія, послання та апокаліптика;
- **автори** — пророки, апостоли, царі та укладачі книг;
- **завіти** — Старий та Новий Завіти;
- **канонічний статус** — протоканонічні (визнані всіма основними конфесіями) та девтероканонічні (другоканонічні, визнані католицькою та православною традиціями);
- **мови оригіналу** — гебрейська, арамейська та давньогрецька (коїне);
- **біблійні постаті** — ключові персонажі та фігури, що згадуються в текстах.

---

# 3. Структура бази знань

## 3.1. Класи

У базі знань визначено такі основні класи:

```prolog
class(entity).
class(bible_book).
class(author).
class(testament).
class(canon_status).
class(language).
class(biblical_figure).
```

Клас `entity` використовується як коренева загальна категорія. `bible_book` описує книги. Інші класи описують відповідні сутності предметної області.

## 3.2. Ієрархія класів

Безпосередня ієрархія жанрових класів книг:

```text
bible_book
├── ot_book
│   ├── pentateuch
│   ├── historical_ot
│   ├── wisdom
│   ├── major_prophets
│   └── minor_prophets
└── nt_book
    ├── gospel
    ├── historical_nt
    ├── pauline_epistle
    ├── general_epistle
    └── apocalyptic
```

Таким чином, наприклад, `pentateuch` є підкласом `ot_book`, а `ot_book` — підкласом `bible_book`. Аналогічно `gospel` є підкласом `nt_book`, а той — підкласом `bible_book`.

## 3.3. Екземпляри

Екземпляри класів задаються предикатом `instance/2`.

Наприклад:

```prolog
instance(genesis, pentateuch).
instance(psalms, wisdom).
instance(isaiah, major_prophets).
instance(matthew, gospel).
instance(romans, pauline_epistle).
```

Це означає, що конкретна книга є екземпляром відповідного вузького жанрового класу.

Аналогічно визначені екземпляри авторів (`moses`, `david`, `paul_apostle`), завітів (`old_testament`, `new_testament`), мов (`hebrew`, `greek`, `aramaic`) та статусів (`protocanonical`, `deuterocanonical`).

## 3.4. Атрибути

Атрибути задаються предикатом:

```prolog
has_attribute(Entity, Attribute, Value).
```

У роботі використовуються такі атрибути:

- `chapters` — кількість розділів у книзі;
- `century_written` — століття написання (від'ємні числа — до н.е., додатні — н.е.).

Наприклад:

```prolog
has_attribute(genesis, chapters, 50).
has_attribute(psalms, chapters, 150).
has_attribute(matthew, chapters, 28).
has_attribute(genesis, century_written, -15).
has_attribute(matthew, century_written, 1).
```

## 3.5. Ієрархічні зв'язки

Ієрархічний зв'язок задається фактами:

```prolog
subclass(Sub, Super).
```

Наприклад:

```prolog
subclass(pentateuch, ot_book).
subclass(ot_book, bible_book).
```

Через правило `subclass_transitive/2` з цих фактів автоматично формується ланцюжок:

```text
pentateuch -> ot_book -> bible_book
```

Тому для книги `genesis`, яка є екземпляром `pentateuch`, можна логічно вивести її належність як до `ot_book`, так і до `bible_book`.

## 3.6. Асоціативні зв'язки

| Предикат | Призначення |
|---|---|
| `written_by/2` | зв'язок книги з автором |
| `belongs_to_testament/2` | зв'язок книги з відповідним Завітом |
| `written_in_language/2` | мова, якою написаний оригінал книги |
| `mentions_figure/2` | згадка біблійної постаті у тексті книги |
| `has_canon_status/2` | канонічний статус книги (прото- чи девтероканонічна) |

Наприклад:

```prolog
written_by(genesis, moses).
belongs_to_testament(genesis, old_testament).
written_in_language(genesis, hebrew).
mentions_figure(genesis, abraham).
has_canon_status(genesis, protocanonical).
```

---

# 4. Перелік використаних предикатів

## 4.1. Предикати структури моделі

| Предикат | Арність | Призначення |
|---|---|---|
| `class/1` | 1 | задає клас предметної області |
| `subclass/2` | 2 | задає відношення підклас—надклас |
| `instance/2` | 2 | задає належність екземпляра до класу |
| `has_attribute/3` | 3 | задає атрибут об'єкта та його значення |

## 4.2. Предикати предметної області

| Предикат | Арність | Призначення |
|---|---|---|
| `written_by/2` | 2 | автор книги |
| `belongs_to_testament/2` | 2 | завіт, до якого належить книга |
| `written_in_language/2` | 2 | мова оригіналу книги |
| `mentions_figure/2` | 2 | біблійна постать, що згадується у книзі |
| `has_canon_status/2` | 2 | канонічний статус книги |

## 4.3. Предикати логічного виведення

| Предикат | Призначення |
|---|---|
| `subclass_transitive/2` | транзитивне проходження ієрархії класів |
| `is_a/2` | визначення належності об'єкта до класу з урахуванням успадкування |
| `is_pauline_epistle/1` | визначення послання апостола Павла |
| `mentions_jesus/1` | пошук книг, де згадується Ісус Христос |
| `multilingual_book/1` | визначення книг, складених кількома мовами оригіналу |
| `is_long_book/1` | виділення великих книг (кількість розділів $\ge 40$) |
| `same_author/2` | перевірка наявності спільного автора у двох різних книг |
| `protestant_canon_book/1` | виведення книг Протестантського канону |
| `catholic_canon_book/1` | виведення книг Католицького канону |
| `greek_nt_book/1` | визначення грекомовних книг Нового Завіту |

## 4.4. Предикати перевірки узгодженості

| Предикат | Призначення |
|---|---|
| `hierarchy_cycle/2` | пошук циклів у ієрархії класів |
| `invalid_author_relation/2` | перевірка коректності типу суб'єкта авторства |
| `invalid_chapter_count/2` | виявлення некоректної кількості розділів |
| `contradictory_canon_status/1` | пошук книг із суперечливим канонічним статусом |
| `invalid_nt_language/1` | перевірка мовного анахронізму для Нового Завіту |
| `consistent_model/0` | комплексна перевірка узгодженості всієї бази знань |

---

# 5. Базові та похідні знання

## 5.1. Базові факти

Базовими є знання, які явно записані у програмі як факти. До них належать:

- класи `class/1`;
- прямі зв'язки ієрархії `subclass/2`;
- належність екземплярів до класів `instance/2`;
- атрибути `has_attribute/3`;
- зв'язки з авторами `written_by/2`;
- зв'язки із завітами `belongs_to_testament/2`;
- зв'язки з мовами `written_in_language/2`;
- зв'язки з постатями `mentions_figure/2`;
- статуси канону `has_canon_status/2`.

Наприклад:

```prolog
instance(matthew, gospel).
subclass(gospel, nt_book).
subclass(nt_book, bible_book).
```

є базовими фактами.

## 5.2. Знання, які отримуються лише через правила

До похідних знань належать твердження, які не записані безпосередньо, а виводяться механізмом логічного виведення Прологу.

Наприклад, для фактів:

```prolog
instance(matthew, gospel).
subclass(gospel, nt_book).
subclass(nt_book, bible_book).
```

запит:

```prolog
?- is_a(matthew, bible_book).
```

виводиться через правило `is_a/2` та рекурсивне правило `subclass_transitive/2`, хоча прямого факту `instance(matthew, bible_book)` у програмі немає.

Іншими похідними знаннями є:

- визначення книг канонів конкретних конфесій (`protestant_canon_book/1`, `catholic_canon_book/1`);
- виділення книг зі спільним автором (`same_author/2`);
- класифікація за обсягом розділів (`is_long_book/1`);
- перевірка наявності багатомовності в оригіналі (`multilingual_book/1`);
- результат загальної перевірки узгодженості (`consistent_model/0`).

---

# 6. Приклади похідних знань

## 6.1. Успадкування класів

Для книги `genesis` задано:

```prolog
instance(genesis, pentateuch).
subclass(pentateuch, ot_book).
subclass(ot_book, bible_book).
```

Правило:

```prolog
is_a(Entity, Superclass) :-
    instance(Entity, DirectClass),
    subclass_transitive(DirectClass, Superclass).
```

дозволяє логічно довести:

```text
genesis -> pentateuch
genesis -> ot_book
genesis -> bible_book
```

Це приклад неявного знання, отриманого за правилом транзитивного успадкування.

## 6.2. Визначення конфесійних канонів

Правило Католицького канону:

```prolog
catholic_canon_book(Book) :-
    is_a(Book, bible_book),
    (has_canon_status(Book, protocanonical) ; has_canon_status(Book, deuterocanonical)).
```

виводить повний перелік книг, визнаних Католицькою церквою (включаючи `tobit`, `judith`, `maccabees_1`, `sirach`). Натомість правило `protestant_canon_book/1` виводить лише книги з протоканонічним статусом.

## 6.3. Виявлення багатомовних книг

Правило:

```prolog
multilingual_book(Book) :-
    written_in_language(Book, Lang1),
    written_in_language(Book, Lang2),
    Lang1 \= Lang2.
```

виводить книги, оригінальний текст яких складається з частин різними мовами. Завдяки наявним фактам Пролог виводить для книги пророка Даниїла (`daniel`) успішний результат, оскільки вона містить блоки як гебрейською, так і арамейською мовами.

---

# 7. Перевірка узгодженості моделі

Для контролю коректності онтології реалізовано набір правил перевірки згідно з концепцією закритого світу.

## 7.1. Перевірка циклів ієрархії

```prolog
hierarchy_cycle(A, B) :-
    subclass_transitive(A, B),
    subclass_transitive(B, A).
```

Виявляє циклічні залежності між класами. Якщо клас $A$ є предком $B$, а $B$ є предком $A$, модель є суперечливою. У розробленій базі знань такі цикли відсутні.

## 7.2. Перевірка коректності авторства

```prolog
invalid_author_relation(Book, Author) :-
    written_by(Book, Author),
    (   \+ is_a(Book, bible_book)
    ;   \+ instance(Author, author)
    ).
```

Правило перевіряє домен та область значень відношення: суб'єкт повинен бути біблійною книгою, а об'єкт — екземпляром класу `author`.

## 7.3. Перевірка діапазону розділів

```prolog
invalid_chapter_count(Book, Count) :-
    has_attribute(Book, chapters, Count),
    (   Count < 1
    ;   Count > 150
    ).
```

Контролює коректність числових атрибутів: жодна книга не може містити менше ніж 1 розділ або більше ніж 150 (найбільшою книгою є Псалтир — 150 розділів).

## 7.4. Перевірка несумісності канонічних статусів

```prolog
contradictory_canon_status(Book) :-
    has_canon_status(Book, protocanonical),
    has_canon_status(Book, deuterocanonical).
```

Книга не може одночасно мати взаємовиключні статуси першоканонічної та другоканонічної.

## 7.5. Перевірка мовного анахронізму

```prolog
invalid_nt_language(Book) :-
    is_a(Book, nt_book),
    written_in_language(Book, hebrew).
```

Контролює історичну достовірність: жодна канонічна книга Нового Завіту не писалася давньогебрейською мовою в оригіналі.

## 7.6. Загальна перевірка узгодженості

```prolog
consistent_model :-
    \+ hierarchy_cycle(_, _),
    \+ invalid_author_relation(_, _),
    \+ invalid_chapter_count(_, _),
    \+ contradictory_canon_status(_),
    \+ invalid_nt_language(_).
```

Усі перевірки заперечуються через `\+`. Якщо жодна помилка не виводиться, модель вважається узгодженою.

---

# 8. Приклади запитів до бази знань

## Запит 1 — успадкування класу

```prolog
?- is_a(genesis, ot_book).
```

**Результат:**
```prolog
true.
```

**Аналіз:** запит підтверджує похідну належність книги Буття до Старого Завіту через ланцюжок `pentateuch -> ot_book`.

## Запит 2 — пошук усіх книг певного жанру (Євангелія)

```prolog
?- is_a(Book, gospel).
```

**Результат:**
```prolog
Book = matthew ;
Book = mark ;
Book = luke ;
Book = john.
```

**Аналіз:** Пролог успішно знаходить усі 4 екземпляри класу `gospel` за допомогою механізму повернення назад (backtracking).

## Запит 3 — виведення послань апостола Павла

```prolog
?- is_pauline_epistle(Book).
```

**Результат:**
```prolog
Book = romans ;
Book = corinthians_1 ;
Book = corinthians_2 ;
Book = galatians ;
Book = ephesians ;
Book = philippians ;
Book = colossians ;
Book = thessalonians_1 ;
Book = thessalonians_2 ;
Book = timothy_1 ;
Book = timothy_2 ;
Book = titus ;
Book = philemon.
```

**Аналіз:** правило перевіряє одночасно належність до класу `pauline_epistle` та авторство `written_by(Book, paul_apostle)`. Книга до Євреїв (`hebrews`) сюди не увійшла, оскільки в базі її автором зазначено `unknown_author`.

## Запит 4 — пошук багатомовних книг оригіналу

```prolog
?- multilingual_book(Book).
```

**Результат:**
```prolog
Book = daniel ;
Book = daniel ;
false.
```

**Аналіз:** для книги пророка Даниїла задані факти написання двома мовами (`hebrew` та `aramaic`), тому правило знаходить її для обох перестановок мовних аргументів.

## Запит 5 — пошук книг, де згадується Ісус Христос

```prolog
?- mentions_jesus(Book).
```

**Результат:**
```prolog
Book = matthew ;
Book = mark ;
Book = luke ;
Book = john ;
Book = acts ;
Book = romans.
```

**Аналіз:** запит виводить книги, що містять асоціативний факт `mentions_figure(Book, jesus_christ)`.

## Запит 6 — перевірка приналежності до Протестантського канону

```prolog
?- protestant_canon_book(wisdom_of_solomon).
```

**Результат:**
```prolog
false.
```

**Аналіз:** Книга Мудрості Соломона має факт `has_canon_status(wisdom_of_solomon, deuterocanonical)`, тому запит щодо протестантського канону коректно повертає `false`.

## Запит 7 — перевірка приналежності до Католицького канону

```prolog
?- catholic_canon_book(maccabees_1).
```

**Результат:**
```prolog
true.
```

**Аналіз:** 1-а Книга Маккавеїв є девтероканонічною, тому вона успішно задовольняє диз'юнкцію в правилі `catholic_canon_book/1`.

## Запит 8 — пошук книг одного автора (спільне авторство)

```prolog
?- same_author(luke, OtherBook).
```

**Результат:**
```prolog
OtherBook = acts ;
false.
```

**Аналіз:** знайдено книгу Дії Апостолів (`acts`), яка має того самого автора (`luke_evangelist`), при цьому виключено симетричне самопорівняння `Book1 \= Book2`.

## Запит 9 — перевірка великих за обсягом книг

```prolog
?- is_long_book(Book).
```

**Результат:**
```prolog
Book = genesis ;
Book = exodus ;
Book = job ;
Book = psalms ;
Book = isaiah ;
Book = jeremiah ;
Book = ezekiel ;
Book = sirach.
```

**Аналіз:** правило порівнює числовий атрибут `chapters` із порогом 40 і виводить усі відповідні книги.

## Запит 10 — загальна перевірка узгодженості моделі

```prolog
?- consistent_model.
```

**Результат:**
```prolog
true.
```

**Аналіз:** усі правила пошуку суперечностей завершилися невдачею, тому заперечення `\+` забезпечило загальний успіх перевірки моделі.

---

# 9. Помилки під час розроблення та їх усунення

## 9.1. Неправильне використання оператора заперечення

У початковому варіанті правил замість вбудованого предикату SWI-Prolog для заперечення як невдачі було використано звичайний знак плюс або некоректний префікс:

```prolog
% Неправильно:
+ invalid_author_relation(_, _)
```

У SWI-Prolog оператор заперечення як невдачі позначається як `\+ Goal`.

Виправлений варіант:

```prolog
consistent_model :-
    \+ hierarchy_cycle(_, _),
    \+ invalid_author_relation(_, _),
    \+ invalid_chapter_count(_, _),
    \+ contradictory_canon_status(_),
    \+ invalid_nt_language(_).
```

## 9.2. Самопорівняння об'єктів у правилі `same_author/2`

Початковий варіант правила мав вигляд:

```prolog
% Неправильно:
same_author(Book1, Book2) :-
    written_by(Book1, Author),
    written_by(Book2, Author).
```

Через це запит `?- same_author(genesis, X).` повертав `X = genesis`, оскільки книга формально має того самого автора, що й вона сама.

Для виправлення додано умову нерівності термів:

```prolog
same_author(Book1, Book2) :-
    written_by(Book1, Author),
    written_by(Book2, Author),
    Book1 \= Book2.
```

## 9.3. Помилка самопорівняння у `multilingual_book/1`

Аналогічно, у правилі перевірки багатомовності книги обов'язково необхідно вимагати, щоб знайдені мови відрізнялися між собою:

```prolog
multilingual_book(Book) :-
    written_in_language(Book, Lang1),
    written_in_language(Book, Lang2),
    Lang1 \= Lang2.
```

Без умови `Lang1 \= Lang2` будь-яка книга з однією мовою уніфікувала б `Lang1` та `Lang2` з одним і тим самим значенням (наприклад, `hebrew = hebrew`) і вважалася б багатомовною.

---

# 10. Повний текст програми на Пролозі (main2.pl)

```prolog
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
```

---

# 11. Аналіз отриманих результатів

Розроблена база знань демонструє два рівні роботи з інформацією.

Перший рівень — **явно задані факти**. Вони безпосередньо описують предметну область: класи, екземпляри, атрибути (розділи, століття), авторів, мови оригіналу, завіти та канонічний статус.

Другий рівень — **похідні знання**. Вони не зберігаються явно, а отримуються за допомогою логічних правил. Ключовим є транзитивне успадкування класів: завдяки правилу `subclass_transitive/2` система самостійно встановлює повний ланцюжок ієрархії для будь-якої книги без необхідності дублювання зв'язків.

Інші правила комбінують різні предикати для класифікації книг за конфесійними канонами, мовами, авторами та обсягом тексту.

Таким чином, розроблена система є повноцінною декларативною моделлю знань, здатною генерувати нові логічні висновки на основі структурованих фактів.

---

# 12. Коректність побудованої бази знань

База знань містить:

- явно визначені класи та підкласи;
- екземпляри та атрибути;
- ієрархічні зв'язки;
- асоціативні зв'язки кількох типів;
- транзитивні правила успадкування;
- правила логічного виведення;
- правила перевірки узгодженості.

Перевірка узгодженості контролює циклічні залежності в таксономії, коректність типів аргументів для авторства, межі числових атрибутів та відсутність історичних чи догматичних суперечностей.

Коректність роботи системи забезпечується строгою відповідністю правилам синтаксису мови Пролог та парадигмі закритого світу.

---

# 13. Особливості логічного виведення

Головною особливістю бази знань є те, що знання формуються динамічно під час виконання запитів через уніфікацію та механізм повернення назад (backtracking).

Наприклад, для:

```prolog
instance(genesis, pentateuch).
subclass(pentateuch, ot_book).
subclass(ot_book, bible_book).
```

немає потреби зберігати окремий факт `instance(genesis, bible_book)` — Пролог сам будує шлях доведення через предикат `is_a/2`.

При запитах зі змінними (наприклад, `?- is_pauline_epistle(Book).`) інтерпретатор автоматично перебирає всі альтернативні гілки пошуку, повертаючи повний список рішень, які відповідають умовам правила.

---

# 14. Висновки

У ході виконання лабораторної роботи було розроблено базу знань мовою Пролог для предметної області «Канон Біблії».

Було виділено класи, підкласи, екземпляри, атрибути, ієрархічні та асоціативні зв'язки. Для реалізації механізму успадкування створено правила `subclass_transitive/2` та `is_a/2`.

Реалізовано правила виведення похідних знань для визначення послань Павла, багатомовних книг, книг різних канонів, перевірки спільного авторства та фільтрації за кількістю розділів.

Для забезпечення цілісності моделі реалізовано предикати виявлення циклів ієрархії, порушень типів авторства, неприпустимих значень розділів та суперечливих статусів із загальною перевіркою `consistent_model/0`.

Робота демонструє всі ключові концепції логічного програмування: декларативне подання знань, побудову онтологій, використання уніфікації та бектрекінгу, а також перевірку узгодженості за принципом закритого світу.
