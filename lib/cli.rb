class FINDCRYPTO::CLI
    def initialize
        puts "\n"
        puts "--------------------------------$--------------------------------"
        crypt_is_everywhere = "Crypto Is Everywhere, But Should You Invest?"
        puts "           #{crypt_is_everywhere.colorize(:green)}          "
        puts "--------------------------------$--------------------------------"
        puts "\n"
        FINDCRYPTO::API.new.get_top_20_cryptocurrencies 
        FINDCRYPTO::API.new.get_all_cryptocurrencies_names_and_ids
        @prompt = TTY::Prompt.new(help_color: :cyan)
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
        puts "\n"
    end

    def menu
        puts "--------------------------------$--------------------------------"
        top_20_crypt_prices = "Top 20 Cryptocurrency Prices by Market Cap:"
        puts "            #{top_20_crypt_prices.colorize(:green)}          "
        puts "--------------------------------$--------------------------------"
        display_top_20_cryptocurrencies
        puts "--------------------------------$--------------------------------"
        input = @prompt.select("Would you like more information?") do |menu|
            menu.choice "Yes, let me choose a cryptocurrency from the list above"
            menu.choice "Yes, but let me search for a different cryptocurrency"
            menu.choice "Nope! Please exit now."
        end

        if input == 'Yes, let me choose a cryptocurrency from the list above'
            input_number = @prompt.ask("Type its number please:", default: "e.g. 1 for Bitcoin")
        # if input.to_i > 0 && input.to_i <= FINDCRYPTO::Cryptocurrency.all.count
            number = input_number.to_i
            if number > FINDCRYPTO::Cryptocurrency.all.count || number == 0
                invalid_input_try_again
            else
                display_crypto(number)
                display_cryto_footer_menu
            end

        elsif input == 'Yes, but let me search for a different cryptocurrency'
            puts "-----------------------$------------------------"
            puts "Can't find your favorite crypto?"
            display_search_input = @prompt.select("Choose an option:") do |menu|
                menu.choice "Search a cryptocurrency"
                menu.choice "Show full list of cryptocurrencies"
                menu.choice "Go back"
                menu.choice "Exit"
            end
            if display_search_input == 'Show full list of cryptocurrencies'
                display_all_cryptocurrencies_names_and_ids
                display_cryto_footer_menu
            elsif display_search_input == 'Go back'
                menu
            elsif display_search_input == 'Search a cryptocurrency'
                display_new_crypto
            elsif display_search_input == 'Exit'
                exit_cli
            end

        elsif input == 'Nope! Please exit now.'
            exit_cli
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
        back_to_menu_input = @prompt.select("Would you like to see data of another cryptocurrency?", %w(Yes Exit))
        if back_to_menu_input == "Yes"
            menu
        elsif back_to_menu_input == "Exit"
            exit_cli
        end
    end

    def display_new_crypto    
        input = @prompt.ask("Please type a Cryptocurrency name:", default: "e.g. Terra")

        FINDCRYPTO::Cryptocurrency.all.each.with_index(1) do |cryptocurrency, index| 
            if cryptocurrency.name.downcase == input.downcase
                crypto_id = cryptocurrency.id
                puts "Oops! #{cryptocurrency.name}'s price is already displayed in main menu."
                upadated_data_menu_input = @prompt.select("Do you want to see updated data?") do |menu|
                    menu.choice "Yes"
                    menu.choice "No. I love old news! Show me old data!"
                end
                #upadated_data_menu_input = gets.strip.downcase
                if upadated_data_menu_input == "Yes"
                    FINDCRYPTO::API.new.get_data_from_new_crypto(crypto_id)
                    number = FINDCRYPTO::Cryptocurrency.all.count
                    display_crypto(number)
                    display_cryto_footer_menu
                else upadated_data_menu_input == "No. I love old news! Show me old data!"
                    display_crypto(index)
                    display_cryto_footer_menu
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
        puts "Double check its name and try again!"
        sleep(1)
        display_new_crypto
    end

    def display_crypto(number)
        dollar_sign = '$'
        index_number = number -1
        crypto = FINDCRYPTO::Cryptocurrency.all[index_number]
        bar_left = "--------------------$"
        bar_right = "$--------------------"
        puts "#{bar_left.ljust(24)} #{crypto.name.upcase.ljust(10).colorize(:green)} #{bar_right}"
        puts "#{crypto.name}(#{crypto.symbol.upcase}) can be purchased on peer-to-peer networks"
        puts "and cryptocurrency exchanges, just like buying stocks."
        puts "-----------------------$ DATA $-----------------------"
        puts "*** This data is valid as #{convert_to_local_time(crypto.last_updated)} ***"
        coin_symbol_and_price = crypto.symbol.upcase + " price:"                  
        puts "#{coin_symbol_and_price.ljust(25)} #{dollar_sign.colorize(:green)}#{crypto.current_price.to_s.colorize(:green)}"
        pc24h = "Price Change 24 Hours:"
        puts "#{pc24h.ljust(25)} #{dollar_sign.colorize(:green)}#{crypto.price_change_24h.to_s.colorize(:green)} or #{sprintf('%+.2f', crypto.price_change_percentage_24h)}%"
        pc1h = "Price Change  1 Hour:"
        puts "#{pc1h.ljust(25)} #{dollar_sign.colorize(:green)}#{sprintf('%.2f', ((crypto.price_change_percentage_1h_in_currency * crypto.current_price)/100)).to_s.colorize(:green)} or #{sprintf('%+.2f', crypto.price_change_percentage_1h_in_currency)}%"
        hh24 = "24 Hour High:"
        puts "#{hh24.ljust(25)} #{dollar_sign.colorize(:green)}#{crypto.high_24h.to_s.colorize(:green)}"
        hl24 = "24 Hour Low:"
        puts "#{hl24.ljust(25)} #{dollar_sign.colorize(:green)}#{crypto.low_24h.to_s.colorize(:green)}"
        tv24 = "Trading Volume 24 Hours:"
        puts "#{tv24.ljust(25)} #{dollar_sign.colorize(:green)}#{crypto.total_volume.to_s.colorize(:green)}"
        mc = "Market Cap:"
        puts "#{mc.ljust(25)} #{dollar_sign.colorize(:green)}#{crypto.market_cap.to_s.colorize(:green)}"       
        mcr = "Market Cap Rank:"
        hash_sign = '#'
        puts "#{mcr.ljust(25)} #{hash_sign.colorize(:green)}#{crypto.market_cap_rank.to_s.colorize(:green)}"
        cs = "Circulating Supply:"
        puts "#{cs.ljust(25)} #{dollar_sign.colorize(:green)}#{crypto.circulating_supply.to_s.colorize(:green)}"
        #puts "Logo link: #{crypto.image}"
        puts "--------------------------$---------------------------"
        puts "Showing you #{crypto.name}'s logo in your browser!"
        sleep(1)
        Launchy.open(crypto.image)
    end

    def display_top_20_cryptocurrencies
        dollar_sign = '$'
        dot = '.'
        price_string = 'PRICE:'
        puts "#   COIN:                #{price_string.colorize(:green)}              DATE:"
        FINDCRYPTO::Cryptocurrency.all.each.with_index(1) do |cryptocurrency, index|
            puts "#{index.to_s.ljust(3)} #{cryptocurrency.name.ljust(20)} #{dollar_sign.colorize(:green)}#{cryptocurrency.current_price.to_s.ljust(18).colorize(:green)} #{convert_to_local_time(cryptocurrency.last_updated)}"
        end
    end

    def display_all_cryptocurrencies_names_and_ids
        puts "***This is a LOOOOOOOOOONG list! I'm warning you!***"
        sleep(1)
        puts "#  COIN:"
        FINDCRYPTO::Cryptocurrency_lookup.all.each.with_index(1) do |cryptocurrency, index|
            puts "#{index}. #{cryptocurrency.name}(#{cryptocurrency.symbol.upcase})"
        end
    end

    private
    def convert_to_local_time(utc_time) 
        utc_parsed = Time.parse(utc_time)
        utc_parsed.localtime
    end

end