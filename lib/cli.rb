class FINDCRYPTO::CLI
    def initialize
        FINDCRYPTO::API.new.get_top_20_cryptocurrencies 
        puts "Crypto Is Everywhere, But Should You Invest?"
    end

    def run
        greeting
        enter_key = gets.strip
        if enter_key == ''
            menu
        end
        #menu
    end

    def greeting
        puts "Some experts have suggested that Bitcoin could be worth as much as $100,000 one day!"
        puts "But, not everyone thinks investing in cryptocurrency is a good idea."
        puts "Press enter to see valuable data and make your own conclusions:"
    end

    def menu
        # until input == "exit"
        puts "Top 20 Cryptocurrency Prices by Market Cap:"
        display_top_20_cryptocurrencies
        input = gets
        FINDCRYPTO::Cryptocurrency.all[input.to_i - 1].get_full_data
        puts "Would you like to see data of another cryptocurrency? Enter Yes or No"
        back_to_menu_input = gets.strip.downcase
        if back_to_menu_input == "yes"
            menu
        #elsif back_to_menu_input == "no"
            #puts "If you don’t believe it or don’t get it, I don’t have the time to try to convince you, sorry."
            #puts "– Satoshi Nakamoto"
        else
            puts "If you don’t believe it or don’t get it, I don’t have the time to try to convince you, sorry."
            puts "– Satoshi Nakamoto"
            exit
        end    
    end

    def display_top_20_cryptocurrencies
        puts "#  COIN:                   PRICE:"
        FINDCRYPTO::Cryptocurrency.all.each.with_index(1) do |cryptocurrency, index|
            puts "#{index}. #{cryptocurrency.name}              Price: $#{cryptocurrency.current_price}"
        end
        puts "What crypto would you like more information on? (e.g. 1 for Bitcoin)"
    end

end