
Udiddit, a social news aggregator
Joe Karl Magnussen 
Udacity SQL Nanodegree Notes:
____________________________________________

Part I: 

Bad_posts table needs a foreign key link to bad_comments (post_id) to enable link from comment to associated pos, this will also allow for comments to be deleted upon the deletion of a post through a foreign key cascade.  In addition, ‘username’ in bad_posts should be placed in a separate table and upvotes/downvotes should be set as different data type (numerical/ Boolean), this would enable for votes to be associated with usernames and reflected on a post, furthermore if a user is deleted, the vote would also be through the aforementioned foreign key cascade. Creating a view of the post table with the joins of foreign keys for upvotes, downvotes and comment counts to make future queries easier to develop. 
____________________________________________


Part II: Create the DDL for your new schema
Having done this initial investigation and assessment, your next goal is to dive deep into the heart of the problem and create a new schema for Udiddit. Your new schema should at least reflect fixes to the shortcomings you pointed to in the previous exercise. To help you create the new schema, a few guidelines are provided to you:

1. Guideline #1: here is a list of features and specifications that Udiddit needs in order to support its website and administrative interface:
       a. Allow new users to register:

              i. Each username has to be unique
              ii. Usernames can be composed of at most 25 characters
              iii. Usernames can’t be empty
              iv. We won’t worry about user passwords for this project

       b. Allow registered users to create new topics:

              i. Topic names have to be unique.
              ii. The topic’s name is at most 30 characters
              iii. The topic’s name can’t be empty
              iv. Topics can have an optional description of at most 500 characters.

       c. Allow registered users to create new posts on existing topics:

              i. Posts have a required title of at most 100 characters
              ii. The title of a post can’t be empty.
              iii. Posts should contain either a URL or a text content, but not both.
              iv. If a topic gets deleted, all the posts associated with it should be automatically deleted too.
              v. If the user who created the post gets deleted, then the post will remain, but it will become dissociated from that user.

_ _ _ _ COMPLETED_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ COMPLETED_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ COMPLETED

       d. Allow registered users to comment on existing posts:

              i. A comment’s text content can’t be empty.
              ii. Contrary to the current linear comments, the new structure should allow comment threads at arbitrary levels.
              iii. If a post gets deleted, all comments associated with it should be automatically deleted too.
              iv. If the user who created the comment gets deleted, then the comment will remain, but it will become dissociated from that user.
              v. If a comment gets deleted, then all its descendants in the thread structure should be automatically deleted too.

       e. Make sure that a given user can only vote once on a given post:

              i. Hint: you can store the (up/down) value of the vote as the values 1 and -1 respectively.
              ii. If the user who cast a vote gets deleted, then all their votes will remain, but will become dissociated from the user.
              iii. If a post gets deleted, then all the votes for that post should be automatically deleted too.


2. Guideline #2: here is a list of queries that Udiddit needs in order to support its website and administrative interface. Note that you don’t need to produce the DQL for those queries: they are only provided to guide the design of your new database schema.
       a. List all users who haven’t logged in in the last year.
       b. List all users who haven’t created any post.
       c. Find a user by their username.
       d. List all topics that don’t have any posts.
       e. Find a topic by its name.
       f. List the latest 20 posts for a given topic.
       g. List the latest 20 posts made by a given user.
       h. Find all posts that link to a specific URL, for moderation purposes. 
       i. List all the top-level comments (those that don’t have a parent comment) for a given post.
       j. List all the direct children of a parent comment.
       k. List the latest 20 comments made by a given user.
       l. Compute the score of a post, defined as the difference between the number of upvotes and the number of downvotes

3. Guideline #3: you’ll need to use normalization, various constraints, as well as indexes in your new database schema. You should use named constraints and indexes to make your schema cleaner.

4. Guideline #4: your new database schema will be composed of five (5) tables that should have an auto-incrementing id as their primary key.


_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
PART I - BAD/ OLD DDL SCHEMA: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

CREATE TABLE bad_posts (
	id SERIAL PRIMARY KEY,
	topic VARCHAR(50),
	username VARCHAR(50),
	title VARCHAR(150),
	url VARCHAR(4000) DEFAULT NULL,
	text_content TEXT DEFAULT NULL,
	upvotes TEXT,
	downvotes TEXT
);

CREATE TABLE bad_comments (
	id SERIAL PRIMARY KEY,
	username VARCHAR(50),
	post_id BIGINT,
	text_content TEXT
);

_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
PART II - DDL FOR NEW SCHEMA: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

CREATE TABLE users (
       id SERIAL PRIMARY KEY,
       username VARCHAR(25) NOT NULL UNIQUE, 
       post_id INT FOREIGN KEY(post.id)
)

CREATE TABLE posts (
       id SERIAL PRIMARY KEY
       topic VARCHAR(30) NOT NULL UNIQUE, 
       topic_description VARCHAR(500),
       title  VARCHAR(100) NOT NULL, 
       url VARCHAR(4000) DEFAULT '', 
       text_content TEXT DEFAULT '',
       user_id INT, 
       FOREIGN KEY(user_id) REFERENCES users (id),
       CONSTRAINT onlyUrlOrText CHECK ((NULLIF (url, '') IS NULL OR NULLIF (text_content, '') is NULL) AND NOT (NULLIF(url, '') IS NULL AND NULLIF(text_content, '' ) IS NULL))

);

CREATE TABLE comment_content (
       id SERIAL PRIMARY KEY 
       text TEXT NOT NULL, 
);

CREATE TABLE comment_link (
       id SERIAL PRIMARY KEY 
       assoc_post INT,
       FOREIGN KEY(assoc_post) REFERENCES posts (id) ON DELETE CASCADE,
       assoc_comment INT,
       FOREIGN KEY (assoc_comment) REFERENCES comment_content (id) ON DELETE CASCADE,
       assoc_user INT, 
       FOREIGN KEY (assoc_user) REFERENCES users (id),

);

THOUGHTS: 
trying to create some kind of junction point so that a table can hold comment relations 
so that sub comment levels are possible. 

CREATE TABLE vote ( 
       id SERIAL PRIMARY KEY
       up_down_vote INT,
       voted_post INT
       FOREIGN KEY (voted_post) REFERENCES posts (id) ON DELETE CASCADE,
       user_vote 
       FOREIGN KEY (user_vote) REFERENCES users (id),
);


_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
PART III - DDL FOR NEW SCHEMA: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

