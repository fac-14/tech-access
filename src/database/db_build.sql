BEGIN;

DROP TABLE IF EXISTS resource CASCADE;
DROP TABLE IF EXISTS demographic_tag CASCADE;
DROP TABLE IF EXISTS demographic_resource_link CASCADE;

DROP TYPE IF EXISTS e_resource_type CASCADE;
DROP TYPE IF EXISTS e_demographic_tag_name CASCADE;
DROP TYPE IF EXISTS e_relevance CASCADE;

CREATE TYPE e_resource_type AS ENUM ('meetup', 'online course', 'article', 'classroom course' );

CREATE TABLE resource (
  id SERIAL PRIMARY KEY,
  resource_name TEXT NOT NULL,
  link TEXT NOT NULL,
  resource_description TEXT NOT NULL,
  resource_type e_resource_type,
  country VARCHAR(100) DEFAULT NULL,
  city VARCHAR(100) DEFAULT NULL

);

INSERT INTO resource (resource_name, link, resource_description, resource_type, country, city) VALUES
('Codebar meetup', 'https://codebar.io/events', 'goal is to enable underrepresented people to learn programming in a safe and collaborative environment and expand their career opportunities..', 'meetup', 'UK', NULL),
('Founders and Coders meetup', 'https://www.meetup.com/founderscoders/','Founders & Coders runs a full-time no-fee coding bootcamp. We run meetups for the general public, but we run even more meetups and workshops for applicants to our programme. ', 'meetup', 'UK', 'london' ), 
('Tania Rascia', 'https://www.taniarascia.com/how-i-made-a-career-change-into-web-development/', 'I made a career change into web development in 2015. Before that, I worked as a chef.', 'article', NULL, NULL),
('Free code camp: stories from 300 developers who got their first tech job in their 30s 40s and 50s', 'https://medium.freecodecamp.org/stories-from-300-developers-who-got-their-first-tech-job-in-their-30s-40s-and-50s-64306eb6bb27', 'people of all ages who are worried that they’re “too old” to learn to code and get hired as a developer', 'article', NULL, NULL),
('Free Code Camp', 'https://www.freecodecamp.org/', 'Our mission: to help people learn to code for free. We accomplish this by creating thousands of videos, articles, and interactive coding lessons - all freely available to the public. We also have thousands of freeCodeCamp study groups around the world.', 'online course', NULL, NULL );
 

CREATE TYPE e_demographic_tag_name AS ENUM ('age', 'ethnicity', 'disability', 'mental health', 'contacts in industry', 'caring responsibilities', 'education', 'socioeconomic', 'language', 'gender', 'sexuality', 'refugee', 'other');

CREATE TABLE demographic_tag (
  id SERIAL PRIMARY KEY, 
  tag_name e_demographic_tag_name NOT NULL,
  demographic_description TEXT 
  );

INSERT INTO demographic_tag (tag_name, demographic_description) VALUES
('age', 'age'), /* 1 */
('ethnicity', 'ethnicity'), /* 2 */
('disability', 'disability'), /* 3 */
('mental health', 'mental health'), /* 4 */
('contacts in industry', 'contacts in industry'), /* 5 */
('caring responsibilities', 'caring responsibilities'), /* 6 */
('education', 'education'), /* 7 */
('socioeconomic', 'socioeconomic'), /* 8 */
('language', 'language'), /* 9 */
('gender', 'female woman girl'), /* 10 */
('sexuality', 'lesbian gay bisexual trans queer'), /* 11*/
('refugee', 'refugee'), /* 12 */
('other', 'other'); /* 13 */


CREATE TYPE e_relevance AS ENUM ('direct', 'indirect');
CREATE TABLE demographic_resource_link(
  resource_id INTEGER REFERENCES resource(id) NOT NULL,
  demographic_tag_id INTEGER REFERENCES demographic_tag(id) NOT NULL,
  relevance e_relevance
);

INSERT INTO demographic_resource_link (resource_id, demographic_tag_id, relevance) VALUES
(1, 1, 'direct'),
(1, 2, 'direct'),
(1, 3, 'indirect'),
(1, 4, 'direct'),
(1, 5, 'direct'),
(1, 6, 'direct'),
(1, 7, 'direct'),
(1, 8, 'direct'),
(1, 9, 'direct'),
(1, 10, 'direct'),
(1, 11, 'direct'),
(1, 12, 'direct'),
(2, 1, 'direct'),
(2, 2, 'direct'),
(2, 5, 'indirect'),
(2, 7, 'direct'),
(2, 8, 'indirect'),
(2, 9, 'indirect'),
(2, 10, 'direct'),
(2, 11, 'direct'),
(2, 12, 'indirect'),
(3, 1, 'indirect'),
(3, 7, 'direct'),
(3, 10, 'direct'),
(4, 1, 'direct'),
(4, 7, 'indirect'),
(5, 1, 'indirect'),
(5, 2, 'indirect'),
(5, 3, 'indirect'),
(5, 4, 'indirect'),
(5, 5, 'indirect'),
(5, 6, 'indirect'),
(5, 7, 'indirect'),
(5, 8, 'indirect'),
(5, 9, 'indirect'),
(5, 10, 'indirect'),
(5, 11, 'indirect'),
(5, 12, 'indirect');


COMMIT;