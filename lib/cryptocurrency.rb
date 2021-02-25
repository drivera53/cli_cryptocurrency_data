class FINDCRYPTO::Cryptocurrency
    @@all = []

    def initialize(crypto_hash)
        crypto_hash.each do |key, value|
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def get_full_data
        puts "--------------------$ #{self.name.upcase} $--------------------"
        puts "#{self.name} can be purchased on peer-to-peer networks"
        puts "and cryptocurrency exchanges, just like buying stocks"
        puts "-----------------------$ DATA $------------------------"
        puts "*** This data is valid as #{convert_to_local_time(self.last_updated)} ***"
        puts "Price as date above: $#{self.current_price}"
        puts "24 Hour High: $#{self.high_24h}       24 Hour Low: $#{self.low_24h}"
        puts "Market Cap: $#{self.market_cap}       Market Cap Rank: ##{self.market_cap_rank}"

    end

    private
    def convert_to_local_time(utc_time) # convert_to_local_time(hash[0]["last_updated"])
        utc_parsed = Time.parse(utc_time)
        utc_parsed.localtime
    end

end

#convert_to_local_time(self.last_updated)