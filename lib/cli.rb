class FINDCRYPTO::CLI
    def initialize
        FINDCRYPTO::API.new.get_top_20_cryptocurrencies
    end

    def run
        greeting
    end

    def greeting
        puts "This is the greeting method"
        puts "CLI FILE CONNECTED"
        puts "Grabbing Data.... Loading...."
    end

    def menu
        puts "Pick something from menu"
    end
end