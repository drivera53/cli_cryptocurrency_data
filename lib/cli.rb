class FINDCRYPTO::CLI
    def initialize
        puts "\n"
        puts "-----------------------$------------------------"
        puts "  Crypto Is Everywhere, But Should You Invest?  "
        puts "-----------------------$------------------------"
        puts "\n"
        FINDCRYPTO::API.new.get_top_20_cryptocurrencies 
        FINDCRYPTO::API.new.get_all_cryptocurrencies_names_and_ids
    end

    def run
        greeting
        menu
    end

    def greeting
        puts "There are exactly #{FINDCRYPTO::Cryptocurrency_lookup.all.count} cryptocurrencies at the time of this writing."
        puts "Some experts have suggested that Bitcoin could be worth as much as $100,000 one day!"
        puts "But, not everyone thinks investing in cryptocurrency is a good idea."
        puts "Check the following valuable data and make your own conclusions:"
    end

    def menu
        puts "-----------------------$------------------------"
        puts "  Top 20 Cryptocurrency Prices by Market Cap:   "
        puts "-----------------------$------------------------"
        display_top_20_cryptocurrencies
        input = gets.strip
        if input.to_i > 0 && input.to_i <= FINDCRYPTO::Cryptocurrency.all.count
            number = input.to_i
            display_crypto(number)
            display_cryto_footer_menu

        elsif input.downcase == 'search more'
            display_search_option
            display_search_input = gets.strip
            if display_search_input.downcase == 'show full list'
                display_all_cryptocurrencies_names_and_ids
                display_cryto_footer_menu
            elsif display_search_input.downcase == 'go back'
                menu
            elsif display_search_input.downcase == 'search a crypto'
                display_new_crypto
            else
                invalid_input_try_again
            end

        elsif input.downcase == 'exit'
            exit_cli

        else
            invalid_input_try_again
        end   
    end



    def invalid_input_try_again
        puts "Invalid input. Please try again"
        sleep(1.5)
        menu
    end

    def exit_cli
        puts "If you don’t believe it or don’t get it, I don’t have the time to try to convince you, sorry."
        puts "– Satoshi Nakamoto"
        exit
    end

    def display_cryto_footer_menu
        puts "\n"
        puts "Very interesting, right?"
        puts "Would you like to see data of another cryptocurrency?"
        puts "Please type an option from bellow:"
        puts "|Yes|     |Exit|"
        back_to_menu_input = gets.strip.downcase
        if back_to_menu_input == "yes"
            menu
        elsif back_to_menu_input == "exit"
            exit_cli
        else 
            invalid_input_try_again
        end
    end

    def display_new_crypto    
        puts "Please type a Cryptocurrency name or 'exit_now' to exit:"
        input = gets.strip
        if input.downcase == "exit_now"
            exit_cli
        end

        FINDCRYPTO::Cryptocurrency.all.each.with_index(1) do |cryptocurrency, index| 
            if cryptocurrency.name.downcase == input.downcase
                crypto_id = cryptocurrency.id
                puts "Oops! #{cryptocurrency.name}'s price is already displayed in main menu."
                puts "Do you want to see updated data?"
                puts "|Yes|     |Show me old data|"
                upadated_data_menu_input = gets.strip.downcase
                if upadated_data_menu_input == "yes"
                    FINDCRYPTO::API.new.get_data_from_new_crypto(crypto_id)
                    number = FINDCRYPTO::Cryptocurrency.all.count
                    display_crypto(number)
                    display_cryto_footer_menu
                elsif upadated_data_menu_input == "show me old data"
                    display_crypto(index)
                    display_cryto_footer_menu
                else 
                    invalid_input_try_again
                end
            end
        end
        ### Iterate over all 6000+ cryptos to confirm name
        FINDCRYPTO::Cryptocurrency_lookup.all.each do |cryptocurrency|
            if cryptocurrency.name.downcase == input.downcase
                crypto_id = cryptocurrency.id
                FINDCRYPTO::API.new.get_data_from_new_crypto(crypto_id)
                number = FINDCRYPTO::Cryptocurrency.all.count
                display_crypto(number)
                display_cryto_footer_menu
           end
        end

        puts "Oops!"
        puts "Sorry! I just iterated over #{FINDCRYPTO::Cryptocurrency_lookup.all.count} cryptocurrencies and I couldn't find '#{input}'"
        puts "Double check its name and try again"
        puts "\n"
        sleep(1)
        display_new_crypto
    end

    def display_crypto(number)
        index_number = number -1
        crypto = FINDCRYPTO::Cryptocurrency.all[index_number]
        puts "--------------------$ #{crypto.name.upcase} $--------------------"
        puts "#{crypto.name}(#{crypto.symbol.upcase}) can be purchased on peer-to-peer networks"
        puts "and cryptocurrency exchanges, just like buying stocks."
        puts "-----------------------$ DATA $------------------------"
        puts "*** This data is valid as #{convert_to_local_time(crypto.last_updated)} ***"
        puts "#{crypto.symbol.upcase} price: $#{crypto.current_price}"
        puts "Price Change 24 Hours: $#{crypto.price_change_24h} or #{sprintf('%+.2f', crypto.price_change_percentage_24h)}%" 
        puts "Price Change  1 Hour: $#{sprintf('%.2f', ((crypto.price_change_percentage_1h_in_currency * crypto.current_price)/100))} or #{sprintf('%+.2f', crypto.price_change_percentage_1h_in_currency)}%"
        puts "24 Hour High: $#{crypto.high_24h}       24 Hour Low: $#{crypto.low_24h}"
        puts "Trading Volume 24 Hours: $#{crypto.total_volume}"
        puts "Market Cap: $#{crypto.market_cap}       Market Cap Rank: ##{crypto.market_cap_rank}"
        puts "Circulating Supply: $#{crypto.circulating_supply}"
        puts "Logo link: #{crypto.image}"
        puts "-----------------------$------------------------"

    end

    def display_top_20_cryptocurrencies
        puts "#  COIN:                   PRICE:             DATE:"
        FINDCRYPTO::Cryptocurrency.all.each.with_index(1) do |cryptocurrency, index|
            puts "#{index}. #{cryptocurrency.name}              $#{cryptocurrency.current_price}                #{convert_to_local_time(cryptocurrency.last_updated)}"
        end
        puts "-----------------------$------------------------"
        puts "What crypto would you like more information on?"
        puts "Please type an option from bellow:"
        puts "|Type a number e.g. 1 for Bitcoin|     |Search more|     |Exit|"
        #FINDCRYPTO::API.new.get_data_from_new_crypto('dash')
    end

    def display_search_option
        puts "-----------------------$------------------------"
        puts "Can't find your favorite crypto?"
        #puts "There are exactly #{FINDCRYPTO::Cryptocurrency_lookup.all.count} cryptocurrencies at the time of this writing."
        puts "Please type an option from bellow:"
        puts "|Show full list|     |Search a crypto|     |Go back|"
    end

    def display_all_cryptocurrencies_names_and_ids
        puts "***This is a LOOOOOOOOOONG list! I'm warning you!***"
        sleep(1.5)
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