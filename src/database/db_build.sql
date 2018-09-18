BEGIN;

DROP TABLE IF EXISTS resource CASCADE;
DROP TABLE IF EXISTS demographic_tag CASCADE;
DROP TABLE IF EXISTS demographic_resource_link CASCADE;

DROP TYPE IF EXISTS e_resource_type CASCADE;
DROP TYPE IF EXISTS e_demographic_tag_name CASCADE;
DROP TYPE IF EXISTS e_relevance CASCADE;

CREATE TYPE e_resource_type AS ENUM ('meetup', 'online course', 'article', 'classroom course' );

CREATE TABLE resource (
  resource_id SERIAL PRIMARY KEY,
  resource_name TEXT NOT NULL,
  url TEXT NOT NULL,
  resource_description TEXT NOT NULL,
  resource_type e_resource_type,
  country VARCHAR(100) DEFAULT NULL,
  city VARCHAR(100) DEFAULT NULL

);

INSERT INTO resource (resource_name, url, resource_description, resource_type, country, city) VALUES
('Codebar meetup', 'https://codebar.io/events', 'The goal is to enable underrepresented people to learn programming in a safe and collaborative environment and expand their career opportunities.', 'meetup', 'UK', NULL),
('Founders and Coders meetup', 'https://www.meetup.com/founderscoders/','Founders & Coders runs a full-time no-fee coding bootcamp. We run meetups for the general public, but we run even more meetups and workshops for applicants to our programme. ', 'meetup', 'UK', 'London' ), 
('Tania Rascia', 'https://www.taniarascia.com/how-i-made-a-career-change-into-web-development/', 'I made a career change into web development in 2015. Before that, I worked as a chef.', 'article', NULL, NULL),
('Free code camp: stories from 300 developers who got their first tech job in their 30s 40s and 50s', 'https://medium.freecodecamp.org/stories-from-300-developers-who-got-their-first-tech-job-in-their-30s-40s-and-50s-64306eb6bb27', 'people of all ages who are worried that they’re “too old” to learn to code and get hired as a developer', 'article', NULL, NULL),
('Free Code Camp', 'https://www.freecodecamp.org/', 'Our mission: to help people learn to code for free. We accomplish this by creating thousands of videos, articles, and interactive coding lessons - all freely available to the public. We also have thousands of freeCodeCamp study groups around the world.', 'online course', NULL, NULL ),
('Dyslexia and learning computer programming', 'https://www.tandfonline.com/doi/full/10.11120/ital.2004.03020005', 'This paper explores some of the issues associated with teaching computer science to students with dyslexia. Issues associated with both student learning generally and computer science specifically are considered. The accessibility of teaching materials made available through virtual learning environments (VLEs) is addressed.', 'article', NULL, NULL),
('Including students with disabilities in computer science courses', 'http://specialedtech.net/2016/12/02/including-students-disabilities-computer-science-courses/', 'If we want upcoming software programs to serve diverse needs, we need to teach computer science to diverse people, including students with disabilities. Opening this door will do much to help all our students succeed in life.', 'online course', NULL, NULL),
('Front-end web developer career for person with a disability?', 'https://ask.metafilter.com/293961/Front-end-web-developer-career-for-person-with-a-disability', '[forum thread]', 'article', 'U.S.', NULL),
('Evenbreak', 'https://www.evenbreak.co.uk/', 'Helping talented disabled candidates and inclusive employers to find each other', '[recruitment]', 'UK'),
('Blu Digital', 'http://www.blu-digital.co.uk/jobs/web-development-jobs/', 'Blu Digital offer technical recruitment services which cover web development, mobile development and software development positions, covering technologies such as HTML, CSS, Javascript, React.js, Angular, Node.js, Python C#, C++, .NET, Ruby, Golang, PHP and Unity.', 'UK', NULL),
('Job Hunting Tricks for Older Tech Workers', 'https://insights.dice.com/2014/01/02/job-hunting-tricks-older-tech-workers/', '[career advice]', 'article', 'U.S.', NULL),
('Computer Skills for People with Disabilities', 'http://www.forsythcomputertraining.org/ComputerSkillsForTheDisabled.aspx', 'This course will analyze currently available technologies for learning. Areas addressed include: learning management systems, intelligent tutors, computer adaptive testing, gamification, simulations, learning in and through social media and peer interaction, universal design for learning, differentiated instruction systems, big data and learning analytics, attention monitoring, and affect-aware systems.', 'online course', NULL, NULL),
('City Lit - Web design & development', 'https://www.citylit.ac.uk/courses/technology-science-and-business/web-design-and-development', 'Learn to design and develop website for your business or as a career, and learn new programming techniques.', 'classroom course', 'UK', 'London'),
('Free coding workshop for women', 'https://www.wegotcoders.com/courses/free-coding-workshop-for-women', 'Learn to code with like-minded people in comfortable surroundings on our free coding workshops', 'meetup', 'UK', 'Yewlands Hoddesdon Hertfordshire'),
('Code Your Future', 'https://codeyourfuture.io/', 'We are a non-profit organisation supporting refugees with the dream of becoming developers. In their journey of interrupted lives, unfinished studies and integration challenges, many asylum seekers and refugees yearn to update their tech skills, but lack learning opportunities. We want to change this.', 'classroom course', 'UK', NULL)
;
 

CREATE TYPE e_demographic_tag_name AS ENUM ('age', 'ethnicity', 'disability', 'mental health', 'contacts in industry', 'caring responsibilities', 'education', 'socioeconomic', 'language', 'gender', 'sexuality', 'refugee', 'other');

CREATE TABLE demographic_tag (
  demographic_tag_id SERIAL PRIMARY KEY, 
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
  link_resource_id INTEGER REFERENCES resource(resource_id) NOT NULL,
  link_demographic_tag_id INTEGER REFERENCES demographic_tag(demographic_tag_id) NOT NULL,
  relevance e_relevance
);

INSERT INTO demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) VALUES
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