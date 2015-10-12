# Url Shortener

## setup

(these assume that you have ruby and bundler installed on your computer)

1.  clone this repo onto your computer. once you copy the link on the right, you can open up your terminal app and move ('cd') into a directory where you want the app to live then clone it with:

    `$ git clone https://github.com/arosswilson/urlshortener.git`

2.  open your terminal and move ('cd') into the urlshortener directory and run 'bundle install'

    `$ bundle install`
    
3.  create, migrate and seed the database. run this:

    `$ bundle exec rake db:create db:migrate`
    
4.  start your server. Warning, this will run a server on port 9393 by default.

    `$ bundle exec shotgun`
    
5.  now open up a browser (preferably chrome) and go to this link: [http://localhost:9393/](http://localhost:9393/)
6.  From here you can create shortened urls (you don't need to be signed in to do this).
7.  You can also create an account under the sign up link and keep track of the shortened urls you create

## challenges

1. The biggest challenge I had was determining when to stop adding features. Eventually I had to write down everything I wanted to add and prioritize the list. I told myself that I wouldn't add any new features after Sunday at noon.
2. I chose to use Sinatra (I'll get into the why later), and it's simplicity is a gift and curse. I struggled because there are a many things that rails just gives you like flash notifications and a more rspec methods. I searched for a gem that would cover flash notifications and researched what others do to test certain scenarios.
3. I also ran into a lot of issues with sinatra configuration. My skeleton wasn't configured for testing (wasn't creating testing databases), and the spec helper wasn't very good. Here I also researched ways to fix it online and compared it to other skeleton's I have used in the past.

## Reasoning behind design decisions
1. I chose to use sinatra, because this app didn't seem like a massive app. Additionally, there aren't a lot of forms for people to fill out, so I didn't need tons or form helpers. I think sinatra was the right move, but as stated in the section above, it presented some issues. If there were a lot more things to crud then rails would probably make more sense
2. Originally I just had a url model. I decided to add a user model later, because I thought it would be nice for users to be able to track the urls they create. That said, you don't have to be logged in to create a url. I did this on purpose - some people may just want to quickly get a shortened url, so this caters to their need.
3. I kept the url creator and top 100 urls on the same page, because these two things are the bulk of the requirements. That way the user can benefit from the main features of the site right on the first page.
4. Because there are not a ton of requirements, I really wanted to keep the site simple. I have ajaxed the url creation if javascript is on in your browser, so the user can quickly/easily create new urls and see the top 100.


## How did I come up with Short URL scheme

I'm currently using at 62 character key (lowercase letters, numbers, and capital letters) and I'll create the url object before I create the short url. Once it is create, I take the id of that object, take the modulo of the id (with 62 since the key is 62 characters long), assign a letter for the shortcode based on the modulus (I use the modulus as the index of the character key to get a specific letter), then divide the url id by 62 and repeat until the url id is zero. I could potentially make the short code smaller by adding some characters to the key (maybe '-' or '_'). Also, there are concerns about some letters I've left in - some ids will generate explicit words, so I would likely need to remove vowels from the key.

## future improvements

1. I would add more information to the User and URL models. Currently I you can't update Users or Urls, which is OK now because there aren't really many things that you could update. In the future, it would be cool to get the users email and maybe more info. Additionally, it'd be nice to get more stats about the url: what browsers are people using, where is the click coming from(twitter? a blog?) etc.
2. I'd also want to update the styling a lot. There's not a unique feel or brand associated with the site yet.
3. I'd want to spend more time in the testing suite and make sure the tests are thorough and coprehensive.


