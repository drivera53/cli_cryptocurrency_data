### CLI -> Shows inputs or data in terminal
### API -> Get data
### STORE DATA -> Objects -> CRYPTOCURRENCY

###### BUILD A PROJECT #####



###### Project Requirements #####
1. We need a CLI
bla bla bla
<!-- Your CLI application (Links to an external site.) must provide access to data from a web page.
The data provided must go at least one level deep. A "level" is where a user can make a choice and then get detailed information about their choice. Some examples are below:
Movies opening soon - Enter your zip code and receive a list of movies and their details.
Libraries near you - Enter your zip code and receive a list of libraries and their details.
Programming meetups near you - Choose from an events list and receive details.
News reader - List articles and read an article of your choosing.
Your CLI application should not be too similar to the Ruby final projects (Music Library CLI, Tic-Tac-Toe with AI, Student Scraper). Also, please refrain from using Kickstarter (Links to an external site.) as that was used for the scraping 'code along'.
Use good OO design patterns. You should be creating a collection of objects, not hashes, to store your data. Pro Tip: Avoid scraping data more than once per web page - utilize objects you have already created. It will speed up your program! -->


### FLOW
- Find an API
    - Coin Gecko
    - https://www.coingecko.com/en/api
- Base URL: api.coingecko.com/api/v3
- https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2C%20ethereum%2C%20binancecoin%2C%20tether%2C%20polkadot%2C%20cardano%2C%20ripple%2C%20litecoin%2C%20chainlink%2C%20bitcoin-cash%2C%20stellar%2C%20usd-coin%2C%20uniswap%2C%20dogecoin%2C%20wrapped-bitcoin%2C%20okb%2C%20aave%2C%20cosmos%2C%20nem%2C%20solana%20%20&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h # List of 20 most traded cryptocurrencies