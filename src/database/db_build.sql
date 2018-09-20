BEGIN;

DROP TABLE IF EXISTS resource CASCADE;
DROP TABLE IF EXISTS demographic_tag CASCADE;
DROP TABLE IF EXISTS demographic_resource_link CASCADE;

DROP TYPE IF EXISTS e_resource_type CASCADE;
DROP TYPE IF EXISTS e_demographic_tag_name CASCADE;
DROP TYPE IF EXISTS e_relevance CASCADE;

CREATE TYPE e_resource_type AS ENUM ('meetup', 'online course', 'article', 'classroom course', 'mentor', 'others');

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
('Free code camp: stories from 300 developers who got their first tech job in their 30s 40s and 50s', 'https://medium.freecodecamp.org/stories-from-300-developers-who-got-their-first-tech-job-in-their-30s-40s-and-50s-64306eb6bb27', '[For] people of all ages who are worried that they’re “too old” to learn to code and get hired as a developer', 'article', NULL, NULL),
('Free Code Camp', 'https://www.freecodecamp.org/', 'Our mission: to help people learn to code for free. We accomplish this by creating thousands of videos, articles, and interactive coding lessons - all freely available to the public. We also have thousands of freeCodeCamp study groups around the world.', 'online course', NULL, NULL ),
('Dyslexia and learning computer programming', 'https://www.tandfonline.com/doi/full/10.11120/ital.2004.03020005', 'This paper explores some of the issues associated with teaching computer science to students with dyslexia. Issues associated with both student learning generally and computer science specifically are considered. The accessibility of teaching materials made available through virtual learning environments (VLEs) is addressed.', 'article', NULL, NULL),
('Including students with disabilities in computer science courses', 'http://specialedtech.net/2016/12/02/including-students-disabilities-computer-science-courses/', 'If we want upcoming software programs to serve diverse needs, we need to teach computer science to diverse people, including students with disabilities. Opening this door will do much to help all our students succeed in life.', 'online course', NULL, NULL),
('Front-end web developer career for person with a disability?', 'https://ask.metafilter.com/293961/Front-end-web-developer-career-for-person-with-a-disability', '[forum thread]', 'others', 'U.S.', NULL),
('Evenbreak', 'https://www.evenbreak.co.uk/', 'Helping talented disabled candidates and inclusive employers to find each other [recruitment agency]', 'others', 'UK', NULL),
('Blu Digital', 'http://www.blu-digital.co.uk/jobs/web-development-jobs/', 'Blu Digital offer technical recruitment services which cover web development, mobile development and software development positions, covering technologies such as HTML, CSS, Javascript, React.js, Angular, Node.js, Python C#, C++, .NET, Ruby, Golang, PHP and Unity. [recruitment]', 'others', 'UK', NULL),
('Job Hunting Tricks for Older Tech Workers', 'https://insights.dice.com/2014/01/02/job-hunting-tricks-older-tech-workers/', 'Career advice for older tech workers', 'article', 'U.S.', NULL),
('Computer Skills for People with Disabilities', 'http://www.forsythcomputertraining.org/ComputerSkillsForTheDisabled.aspx', 'This course will analyze currently available technologies for learning. Areas addressed include: learning management systems, intelligent tutors, computer adaptive testing, gamification, simulations, learning in and through social media and peer interaction, universal design for learning, differentiated instruction systems, big data and learning analytics, attention monitoring, and affect-aware systems.', 'online course', NULL, NULL),
('City Lit - Web design & development', 'https://www.citylit.ac.uk/courses/technology-science-and-business/web-design-and-development', 'Learn to design and develop website for your business or as a career, and learn new programming techniques.', 'classroom course', 'UK', 'London'),
('Free coding workshop for women', 'https://www.wegotcoders.com/courses/free-coding-workshop-for-women', 'Learn to code with like-minded people in comfortable surroundings on our free coding workshops', 'meetup', 'UK', 'Yewlands Hoddesdon Hertfordshire'),
('Code Your Future', 'https://codeyourfuture.io/', 'We are a non-profit organisation supporting refugees with the dream of becoming developers. In their journey of interrupted lives, unfinished studies and integration challenges, many asylum seekers and refugees yearn to update their tech skills, but lack learning opportunities. We want to change this.', 'classroom course', 'UK', NULL),
('Front-end London', 'https://www.frontendlondon.co.uk/', 'Front-end London is a free monthly meetup about front-end development & design.', 'meetup', 'UK', 'London'),
('PHP Hampshire', 'https://www.phphants.co.uk/meetups', 'PHP Hampshire is a PHP User Group aiming to help people learn, share our knowledge and support the PHP community in Hampshire.', 'meetup', 'UK', 'Portsmouth' )
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
(5, 12, 'indirect'),
(6, 3, 'direct'),
(6, 7, 'direct'),
(7, 3, 'direct'),
(7, 7, 'direct'),
(8, 3, 'direct'),
(8, 5, 'direct'),
(8, 13, 'direct'),
(9, 3, 'direct'),
(9, 13, 'direct'),
(10, 13, 'direct'),
(11, 1, 'direct'),
(11, 13, 'direct'),
(12, 3, 'direct'),
(12, 7, 'direct'),
(13, 7, 'direct'),
(14, 10, 'direct'),
(14, 7, 'direct'),
(15, 12, 'direct'),
(15, 7, 'indirect'),
(16, 7, 'indirect'),
(17, 7, 'indirect');





COMMIT;


-- Additions from Artemis
BEGIN;

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Software developer CV template', 'https://www.fish4.co.uk/career-advice/software-developer-cv-template-2/', 'If you are looking to apply for a range of software developer roles, we can help get your CV ready with our software developer CV template. Simply download our template and follow the examples provided', 'others', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='contacts in industry'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('15 Female Web Developers To Follow On Instagram', 'https://blog.vanila.io/15-female-web-developers-to-follow-on-instagram-15d7927824e5', 'One of the best ways to get your motivation to work is to connect on social media with people of same passion. If you are interested in the web or mobile development, you will find these girls and their work very inspiring. Follow these 15 female web developers on Instagram for daily inspiration, good advice, and coding tips & tricks.', 'article', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='contacts in industry'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('3 Entrepreneurs Share Advice for Women in Tech', 'https://www.startupinstitute.com/blog/2016-08-23-entrepreneurs-advice-women-in-tech', 'In 2011, the Level Playing Field Institute published a study that revealed women in tech (especially women of color) had more negative work experiences than their male counterparts, which in turn led to high turnover rates and contributed to job dissatisfaction overall. Women in tech, according to the numbers, are in the shadow of men; women make up a mere 11% of executives at Fortune 500 companies and only 5% of startups are owned by women. In search of inspiration, I spoke with three female influencers from Startup Institute''s community, all of whom are founders, to hear more about their experiences being a motivating force in this up-and-coming ecosystem.', 'article', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='contacts in industry'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('15 Women Web Designers Who Made A Mark In 2018 ', 'https://www.designhill.com/design-blog/top-women-web-designers-made-mark/', 'While men dominate the world of web design, their Women counterparts too are gradually making their presence felt. In fact, we can now list women web designers who are known for high quality standards of web designing. They are rated higher for creativity, innovation, new ideas and techniques of designing websites. So, we decided to prepare an article featuring top 15 women web designers giving their expert advice for young web designers.', 'article', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Women in tech: from flight attendant to web developer', 'https://blog.learningpeople.co.uk/women-in-tech-from-flight-attendant-to-web-developer', 'If there is one sure fire way to motivate a woman who dreams of a career in tech it is reading about other inspiring women who are paving the way. So, if you are an aspiring coding newbie stuck in a yawn-inducing job and dreaming of a career change, then we have got a treat for you.', 'article', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Inclusive Boards', 'http://www.inclusiveboards.co.uk/diversity-in-tech-landscape/', 'As part of Inclusive Boards increasing work within the UK Tech sector we are releasing a briefing about the current landscape. We have found that there is a distinct lack of available data in regards to BAME diversity in tech. Whilst data in relation to gender diversity in tech is more readily available, the figures and experiences make for depressing reading. [more]', 'article', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Is “Culture Fit” Eliminating Your Best Tech Candidates?', 'https://www.creativequills.co.uk/is-culture-fit-eliminating-your-best-tech-candidates/', '[cultural bias in the tech industry]', 'article', 'UK', NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='disability'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='mental health'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='caring responsibilities'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='socioeconomic'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('ACHIEVING DIVERSITY IN THE TECHNOLOGY INDUSTRY', 'http://www.achievingdiversityin.tech/', 'A monthly meetup to discuss improving diversity in the technology industry', 'meetup', 'UK', 'London') returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='disability'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='mental health'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='caring responsibilities'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='education'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='socioeconomic'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'indirect');

COMMIT;


-- additions from Dom
BEGIN;

-- Dom's initial database additions

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Node Girls workshops', 'http://nodegirls.com', 'Free programming (JavaScript and Node.js) workshops for women, non-binary and trans folk around the world.', 'meetup', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'direct');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Node Girls online resources', 'http://nodegirls.com/resources.html', 'Free online programming (JavaScript and Node.js) resources that anyone can use. See their in-person meetups if you identify as a woman, non-binary or trans.', 'online course', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='disability'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='mental health'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='contacts in industry'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='caring responsibilities'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='education'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='socioeconomic'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='language'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='refugee'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('C4Q NYC', 'https://www.c4q.nyc/', 'C4Q teaches coding and professional skills to talented adults from diverse and low-income backgrounds. The course is run in New York City.', 'classroom course', 'USA', 'New York') returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='education'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='socioeconomic'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='disability'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='contacts in industry'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='caring responsibilities'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='language'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='refugee'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Video: do you need to be good at maths to be a software engineer?', 'https://www.youtube.com/watch?v=HWAHs003-hU', 'Mayuko - a successful developer - talks about how you can succeed without a strong maths background', 'article', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='education'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='disability'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='socioeconomic'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Black Girls Code', 'http://www.blackgirlscode.com/programsevents.html', 'Workshops across the USA. Black Girls CODE has set out to prove to the world that girls of every color have the skills to become the programmers of tomorrow.', 'meetup', 'USA', NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='education'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='socioeconomic'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='contacts in industry'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='refugee'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('SheCanCode', 'https://shecancode.io/', 'Introducing the world''s first on-demand career advisory service for women in tech. The site also provides links to meetups and tools, resources and role models for women in tech!', 'others', 'Worldwide', NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='contacts in industry'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('200 black women in tech to follow on Twitter', 'http://blackwomentech.com/', 'This list was initially created to combat the virtual absence of the acknowledgement of the fact that there is an ample number of Black Women working in tech. Like other social demographics in the tech space who are regularly celebrated and recognised, Black Women too are doing amazing and phenomenal things.', 'others', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'indirect'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='other'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Learning to code at 56 years old', 'https://medium.freecodecamp.org/yes-im-56-and-learning-to-code-f33abea6fd4c', 'I''m learning to code at 56. Here''s an epic beat-down of my critical inner self.', 'article', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='education'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Ladies of Code London', 'https://www.meetup.com/Ladies-of-Code-UK/', 'Are you a lady? Do you code? Are you searching for a similar bunch of ladies to discuss code with? You’ve come to the right place. We meet monthly to hear talks from leaders in the field and hack whilst developing our code-fu in the process.', 'meetup', 'UK', 'London') returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'direct');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Women Who Code, London', 'https://www.meetup.com/Women-Who-Code-London/', 'Women Who Code is the largest and most active community of engineers dedicated to inspiring women to excel in technology careers. We envision a world where women are representative as technical executives, founders, VCs, board members, and software engineers. Our programs are designed to get you there.', 'meetup', 'UK', 'London') returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='socioeconomic'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Ada''s List', 'http://adaslist.co/', 'Ada''s List is an email community for those who broadly identify as women in tech. It was launched on Ada Lovelace Day 2013 in London and now has over 6000 members globally. ', 'others', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'direct');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Coders of Colour Twitter', 'https://twitter.com/codersofcolour', 'Inspiring underrepresented teens of colour to pursue a career in Computing. ', 'others', NULL, NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='age'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='ethnicity'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'indirect');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Code First Girls', 'https://www.codefirstgirls.org.uk/', 'Working hard to get more women into tech and entrepreneurship. ', 'others', 'UK', NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'direct');

with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('Geek Girl Meetup UK', 'http://www.geekgirlmeetup.co.uk/', 'A global community for women interested in tech, code, startups and design. We''re aiming to create new rolemodels, networks and active knowledge exchange', 'meetup', 'UK', NULL) returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='gender'), 'direct'), ((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='sexuality'), 'indirect');

COMMIT;