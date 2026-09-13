--- ** Regular Expression Operations ** ---
--- PostgreSQL provides a robust set of built-in features for pattern matching using POSIX regular expressions.
-- Unlike standard SQL LIKE operations, POSIX regular expressions allow you to search, extract, split, and replace complex string patterns.

--  (~) -> Case-Sensitive
--  (~*) -> Case-Insensitive
--  (!~) -> Not Case-sensitive
--  (!~*) -> Not Case-Insensitive

-- 1. Find users with email end with .com or .org (case-insensitive)

SELECT username, email
from users
where email ~* '\.(com|org)$';


-- 2. Core Regex functions - When you need to modify, extract, or split string data rather than just filter it, 
-- PostgreSQL offers four primary regular expression functions.

-- a) REGEXP_LIKE(): Behaves exactly as 'LIKE'.

SELECT REGEXP_LIKE('John Doe', '^john', 'i');


-- b) REGEX_MATCH() or MATCHES() - Extract substrings and return them inside a text array

-- single extraction (extract an area code from a phone number)
SELECT REGEXP_MATCH('(555) 019-2834', '\((\d{3})\)') -- returns {555}

--multi extraction (extracts all words starting with 's' from a sentence)
SELECT REGEXP_MATCHES('she sells sea shells', '\bs\w++', 'g') -- returns 3 rows {sells}, {sea}, {shells}



-- c) REGEXP_REPLACE() - Finds substrings that match a pattern and replaces them with new text

SELECT REGEXP_REPLACE('1234567890', '(\d{3})(\d{3})(\d{4})', '(\1) \2-\3')
--returns "(123) 456-7890"


-- d) REGEXP_SPLIT_TO_ARRAY() and REGEXP_SPLIT_TO_TABLE() - Splits a single string into pieces using a regular expression as the delimiter

-- REGEXP_SPLIT_TO_ARRAY(): Packs the split chunks into a single string array item.
-- REGEXP_SPLIT_TO_TABLE(): Explodes the split chunks out into distinct rows.

SELECT REGEXP_SPLIT_TO_TABLE('apple, banana; orange grape', '[,\s;]+') As fruit
/* Returns 4 rows:
   apple
   banana
   orange
   grape 
*/



-- 3. Performance best practise: avoid 'greedy' traps

/*
    By default, quantifiers like * and + are greedy—they match as much text as possible. If you are scraping or parsing data, 
    you often want them to be lazy (non-greedy) by adding a ? modifier.For example, parsing HTML tags:Greedy: '<a>foo</a> <b>bar</b>' ~ '<.*>'
    matches the entire string <a>foo</a> <b>bar</b>.Lazy: '<a>foo</a> <b>bar</b>' ~ '<.*?>' correctly stops at the first closing bracket,
    matching just <a>.
*/


--- SOME MORE EXAMPLES ---
SELECT *
from users
where mail ~ '^[a-zA-Z]+[a-zA-Z0-9_.-]*@leetcode.com$'
