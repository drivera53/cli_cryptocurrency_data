class FINDCRYPTO::API

    def initialize
        @url_top_20 = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2C%20ethereum%2C%20binancecoin%2C%20tether%2C%20polkadot%2C%20cardano%2C%20ripple%2C%20litecoin%2C%20chainlink%2C%20bitcoin-cash%2C%20stellar%2C%20usd-coin%2C%20uniswap%2C%20dogecoin%2C%20wrapped-bitcoin%2C%20okb%2C%20aave%2C%20cosmos%2C%20nem%2C%20solana%20%20&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h"
    end

    def get_top_20_cryptocurrencies
        request = URI.parse(@url_top_20)
        response = Net::HTTP.get_response(request)
        crypto_hash = JSON.parse(response.body)
        #binding.pry
        self.create_cryptocurrency_objects(crypto_hash)
    end 

    def create_cryptocurrency_objects(crypto_hash)
        crypto_hash.each do |crypto_object|
            FINDCRYPTO::Cryptocurrency.new(crypto_object)
        end
    end

    def get_data_from_new_crypto(crypto_id)
        url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=#{crypto_id}&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h"
        request = URI.parse(url)
        response = Net::HTTP.get_response(request)
        crypto_hash = JSON.parse(response.body)
        self.create_cryptocurrency_objects(crypto_hash)
    end

    def get_all_cryptocurrencies_names_and_ids
        url = "https://api.coingecko.com/api/v3/coins/list?include_platform=false"
        request = URI.parse(url)
        response = Net::HTTP.get_response(request)
        crypto_hash = JSON.parse(response.body)
        self.create_cryptocurrency_names_and_ids_objects(crypto_hash)
    end

    def create_cryptocurrency_names_and_ids_objects(crypto_hash)
        crypto_hash.each do |crypto_object|
            FINDCRYPTO::Cryptocurrency_lookup.new(crypto_object)
        end
    end


end

# CoinGecko rocks! https://www.coingecko.com/en
