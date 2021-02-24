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

    def get_name
        self.name
    end

end