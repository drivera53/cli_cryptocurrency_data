class FINDCRYPTO::CLI
    def run
        greeting
        #FINDCRYPTO::API.new
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