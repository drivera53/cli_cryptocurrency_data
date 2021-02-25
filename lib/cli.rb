class FINDCRYPTO::CLI
    def initialize
        FINDCRYPTO::API.new.get_top_20_cryptocurrencies 
        puts "-----------------------$------------------------"
        puts "  Crypto Is Everywhere, But Should You Invest?  "
        puts "-----------------------$------------------------"
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
        puts "-----------------------$------------------------"
        puts "  Top 20 Cryptocurrency Prices by Market Cap:   "
        puts "-----------------------$------------------------"
        display_top_20_cryptocurrencies
        input = gets.strip
        if input.downcase == 'more'
            display_search_option
            display_search_input = gets.strip
            if display_search_input.downcase == 'show full list'
                display_all_cryptocurrencies_names_and_ids
            end
            #display_new_crypto Just for testing
        end
        FINDCRYPTO::Cryptocurrency.all[input.to_i - 1].get_full_data
        puts "\n"
        puts "Very interesting, right?"
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

    def display_new_crypto # (input)
        input = 'dash'
        FINDCRYPTO::API.new.get_data_from_new_crypto(input)
        #puts FINDCRYPTO::Cryptocurrency.all.count
    end

    def display_top_20_cryptocurrencies
        puts "#  COIN:                   PRICE:             DATE:"
        FINDCRYPTO::Cryptocurrency.all.each.with_index(1) do |cryptocurrency, index|
            puts "#{index}. #{cryptocurrency.name}              $#{cryptocurrency.current_price}                #{convert_to_local_time(cryptocurrency.last_updated)}"
        end
        puts "What crypto would you like more information on? Type a number: (e.g. 1 for Bitcoin)"
        puts "Can't find your favorite crypto? Type 'more' to search:"
        #FINDCRYPTO::API.new.get_data_from_new_crypto('dash')
    end

    def display_search_option
        puts "-----------------------$------------------------"
        FINDCRYPTO::API.new.get_all_cryptocurrencies_names_and_ids
        puts "There are exactly #{FINDCRYPTO::Cryptocurrency_lookup.all.count} cryptocurrencies at the time of writing."
        puts "Please type an opcion from bellow:"
        puts "|Show full list|     |Type a crypto|     |Go back|"
    end

    def display_all_cryptocurrencies_names_and_ids
        puts "#  COIN:"
        FINDCRYPTO::Cryptocurrency_lookup.all.each.with_index(1) do |cryptocurrency, index|
            puts "#{index}. #{cryptocurrency.name}(#{cryptocurrency.symbol.upcase})"
        end
    end


    private
    def convert_to_local_time(utc_time) # convert_to_local_time(hash[0]["last_updated"])
        utc_parsed = Time.parse(utc_time)
        utc_parsed.localtime
    end

end