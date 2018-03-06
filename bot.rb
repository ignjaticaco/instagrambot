require 'sinatra'


get'/' do

'<!DOCTYPE html>
<html lang="en">
<head>
	<title>InstaBot</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>

	<div class="bg-contact3" style="background-color: green;">
		<div class="container-contact3">
			<div class="wrap-contact3">
				<form class="contact3-form validate-form" action="program" method="post">
					<span class="contact3-form-title">
						INSTAGRAM BOT 
					</span>

					<div class="wrap-contact3-form-radio">
						<div class="contact3-form-radio m-r-42">
							<input class="input-radio3" id="radio1" type="radio" name="choice" value="liker">
							<label class="label-radio3" for="radio1">
								AUTO LIKER
							</label>
						</div>

						<div class="contact3-form-radio">
							<input class="input-radio3" id="radio2" type="radio" name="choice2" value="get-quote">
							<label class="label-radio3" for="radio2">
								FOLLOW / UNFOLLOW
							</label>
						</div>
					</div>

					<div class="wrap-input3 validate-input" data-validate="Name is required">
						<input class="input3" type="text" name="user" placeholder="Vaše instagram uporabniško ime">
						<span class="focus-input3"></span>
					</div>

					<div class="wrap-input3 validate-input" data-validate = "Password is required">
						<input class="input3" type="password" name="user2" placeholder="Vaše instagram geslo">
						<span class="focus-input3"></span>
					</div>



					<div class="wrap-input3 validate-input" data-validate = "Password is required">
						<input class="input3" type="text" name="user3" placeholder="Instagram račun katere sledilce želite slediti (Samo za Follow/Unfolllow)">
						<span class="focus-input3"></span>
					</div>

					<div class="container-contact3-form-btn">
						<button class="contact3-form-btn">
							Submit
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<div id="dropDownSelect1"></div>

<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<script>
		$(".selection-2").select2({
			minimumResultsForSearch: 20,
			dropdownParent: $("#dropDownSelect1")
		});
	</script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

	<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag("js", new Date());

  gtag("config", "UA-23581568-13");
</script>

</body>
</html>'
end

post '/program' do

if params[:choice] == 'liker'
#post '/auto_liker' do
require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print' # Console output
require_relative 'credentials' # Pulls in login credentials from credentials.rb


username = @data = params[:user]
password = @data = params[:user2]
like_counter = 0
num_of_rounds = 0
MAX_LIKES = 1500

# Open Browser, Navigate to Login page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

# Navigate to Username and Password fields, inject info
puts "Logging in..."
browser.text_field(:name => "username").set "#{username}"
browser.text_field(:name => "password").set "#{password}"

# Click Login Button
browser.button(:class => '_qv64e _gexxb _4tgw8 _njrw0').click
sleep(2)
puts "We're in #DatCrawlLifeDoe"

# Continuous loop to break upon reaching the max likes
loop do
  # Scroll to bottom of window 3 times to load more results (20 per page)
  3.times do |i|
    browser.driver.execute_script("window.scrollBy(0,document.body.scrollHeight)")
    sleep(1)
  end

  # Call all unliked like buttons on page and click each one.
  if browser.a(:class => "coreSpriteGlyphBlack").exists?
    browser.as(:class => "coreSpriteGlyphBlack").each { |val|
    sleep(5)
      val.click
      like_counter += 1
    }
    ap "Photos liked: #{like_counter}"
  else
    ap "No media to like rn, yo. Sorry homie, we tried."
  end
  num_of_rounds += 1
  puts "--------- #{like_counter / num_of_rounds} likes per round (on average) ----------"
  break if like_counter >= MAX_LIKES
  sleep(30) # Return to top of loop after this many seconds to check for new photos
end

# Leave this in to use the REPL at end of program
# Otherwise, take it out and program will just end
Pry.start(binding)
#end


else

#post '/auto_follow' do
require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print' # Console output
require_relative 'credentials' # Pulls in login credentials from credentials.rb

username = @data = params[:user]
password = @data = params[:user2]
users = @data = params[:user3]
follow_counter = 0
unfollow_counter = 0
MAX_UNFOLLOWS = 200
start_time = Time.now

# Open Browser, Navigate to Login page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

# Navigate to Username and Password fields, inject info
puts "Logging in..."
browser.text_field(:name => "username").set "#{username}"
browser.text_field(:name => "password").set "#{password}"

# Click Login Button
browser.button(:class => '_qv64e _gexxb _4tgw8 _njrw0').click
sleep(2)
puts "We're in #hackerman"

# Continuous loop to run until you've unfollowed the max people for the day
#loop do
 # users.each { |val|
    # Navigate to user's page
    browser.goto "instagram.com/barbrothersgo/"

    browser.a(:class => '_t98z6').click
    loop do
    	sleep(4)
    if browser.button(:class => '_qv64e _gexxb _4tgw8 _njrw0').exists?
    	browser.button(:class => '_qv64e _gexxb _4tgw8 _njrw0').click
    	follow_counter += 1 
    elsif browser.button(:class => '_qv64e _t78yp _4tgw8 _njrw0').exists?
      browser.button(:class => '_qv64e _t78yp _4tgw8 _njrw0').click
      unfollow_counter += 1
    end
    sleep(1.0/2.0)



    # If not following then follow
    #if browser.button(:class => '_qv64e _gexxb _r9b8f _njrw0').exists?
    #  ap "Following #{val}"
    #  browser.button(:class => '_qv64e _gexxb _r9b8f _njrw0').click
    #  follow_counter += 1
    #elsif browser.button(:class => '_qv64e _t78yp _r9b8f _njrw0').exists?
    #  ap "Unfollowing #{val}"
    #  browser.button(:class => '_qv64e _t78yp _r9b8f _njrw0').click
    #  unfollow_counter += 1
    #end
    #sleep(1.0/2.0) # Sleep half a second to not get tripped up when un/following many users at once
  #}
  puts "--------- #{Time.now} ----------"
  break if unfollow_counter >= MAX_UNFOLLOWS
  sleep(30) # Sleep 1 hour (3600 seconds)
end

ap "Followed #{follow_counter} users and unfollowed #{unfollow_counter} in #{((Time.now - start_time)/60).round(2)} minutes"

# Leave this in to use the REPL at end of program
# Otherwise, take it out and program will just end
Pry.start(binding)

# Top 100 users on Instagram
# users = ['instagram', 'selenagomez', 'arianagrande', 'taylorswift', 'beyonce', 'kimkardashian', 'cristiano', 'kyliejenner', 'justinbieber', 'kendalljenner', 'nickiminaj', 'natgeo', 'neymarjr', 'nike', 'leomessi','khloekardashian', 'mileycyrus', 'katyperry', 'jlo', 'ddlovato', 'kourtneykardash', 'victoriasecret', 'badgalriri', 'fcbarcelona', 'realmadrid', 'theellenshow', 'justintimberlake', 'zendaya' 'caradelevingne', '9gag', 'chrisbrownofficial', 'vindiesel', 'champagnepapi', 'davidbeckham', 'shakira', 'gigihadid', 'emmawatson', 'jamesrodiguez10', 'kingjames', 'garethbale11', 'nikefootball', 'adele', 'zacefron', 'vanessahudgens', 'ladygaga', 'maluma', 'nba', 'nasa', 'rondaldinho', 'luissuarez9', 'zayn', 'shawnmendes', 'adidasfootball', 'brumarquezine', 'hm', 'harrystyles','chanelofficial', 'ayutingting92', 'letthelordbewithyou', 'niallhoran', 'anitta', 'hudabeauty', 'camerondallas', 'adidasoriginals', 'marinaruybarbosa', 'lucyhale', 'karimbenzema', 'princessyahrini', 'zara', 'nickyjampr', 'onedirection', 'andresiniesta8', 'raffinagita1717', 'krisjenner', 'manchesterunited', 'natgeotravel', 'marcelottwelve', 'deepikapadukone', 'snoopdogg', 'davidluiz_4', 'kalbiminrozeti', 'priyankachopra', 'ashleybenson', 'shaym', 'lelepons', 'prillylatuconsina96','louisvuitton','britneyspears', 'sr4official', 'jbalvin', 'laudyacynthiabella', 'ciara', 'stephencurry30', 'instagrambrasil']
#end
end
end